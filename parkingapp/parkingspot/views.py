import json
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
    parkingspots = ParkingSpot.objects.values().filter(location__distance_lte=(point, D(mi=50)))
    for parkingspot in parkingspots:
        distance = parkingspot['location'].distance(point)
        parkingspot.update({'distance': distance})
        location = {'latitude': parkingspot['location'].coords[0], 'longitude':parkingspot['location'].coords[1]}
        parkingspot.update({'location': location})
        amenities = json.loads(parkingspot['amenities'])
        parkingspot.update({'amenities': amenities})

    json_parkingspots = json.dumps(list(parkingspots)) 
    context = {
        'parkingspots' : parkingspots,
        'json_parkingspots' : json_parkingspots,
        'center_lat' : point.coords[0],
        'center_lon' : point.coords[1]
    }
    return render(request, 'search.html', context)

def about(request):
    return render(request, 'about_us.html')
