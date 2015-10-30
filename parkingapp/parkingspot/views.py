from django.core import serializers
from django.shortcuts import render, redirect
from django.shortcuts import render_to_response
from django.contrib.gis.measure import D
from django.contrib.gis.geos import Point
from django.contrib.gis.geoip import GeoIP
from geopy.geocoders import GoogleV3
from parkingspot.models import ParkingSpot

# Create your views here.
def home(request):

    # get Point from request IP address
    g = GeoIP()
    ip = request.META.get('REMOTE_ADDR', None)
    print(ip)
    if ip:
        point = g.geos(ip)
        # if ip can't be mapped to location (e.g. 127.0.0.*), use default camp randall
        if not point:
            point = Point(-89.411784,43.069817)
    else:
        point = Point(-89.411784,43.069817)

    # translate point to city name
    locator = GoogleV3()
    location = locator.reverse((point.coords[1], point.coords[0]), exactly_one=True)
    if not location:
        city = "Madison"
        state = "WI"
    else:
        address = location.address.split(',')
        try:
            city = address[1].strip()
            state = address[2].strip().split(' ')[0]
        except IndexError:
            city = "Madison"
            state = "WI"

    context = {
        'location' : "{}, {}".format(city, state),
    }
    return render(request, 'home.html', context)


# def test(request):
#   pspot = ParkingSpot.objects.get(id=1)
#   date = "12-03-2015"
#   pspot.open_date(date)
#   user = 1234
#   print "GOT HERE"
#   suc = pspot.reserve_spot(user, date)
#   if suc == 0:
#     "RESERVED"
#   else:
#     "nah"
#   print pspot.parking_spot_avail

def search(request):
    location = request.GET['location']
    g = GoogleV3()
    p = g.geocode(location)
    point = Point(p.longitude, p.latitude)
    # get point based on IP if location GET not valid
    if not point:
        g = GeoIP()
        ip = request.META.get('REMOTE_ADDR', None)
        if ip:
            point = g.geos(ip)
            # if ip can't be mapped to location (e.g. 127.0.0.*), use default camp randall
            if not point:
                point = Point(-89.411784,43.069817)
        else:
            point = Point(-89.411784,43.069817)
        point = Point(-89.411784,43.069817)

    # query database for parkign spots within 50 miles of user
    parkingspots = ParkingSpot.objects.filter(location__distance_lte=(point, D(mi=50)))
    json_parkingspots = serializers.serialize("json", parkingspots)
    context = {
        'parkingspots' : parkingspots,
        'json_parkingspots' : json_parkingspots
    }
    return render(request, 'test_base.html', context)
