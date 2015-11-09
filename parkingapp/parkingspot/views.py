import json
import datetime
from django.shortcuts import render, redirect
from django.shortcuts import render_to_response
from django.contrib.gis.measure import D
from django.contrib.gis.geos import Point
from django.contrib.gis.geoip import GeoIP
from django.forms.models import model_to_dict
from geopy.geocoders import GoogleV3
from parkingspot.models import ParkingSpot
from message.models import Message, ResMessage
from userprof.models import ExtendedUser, AdminUser
from django.contrib.auth.models import User

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


def search(request, message=None):
    try:
        location = request.GET['location']
    except:
        location = "Madison, WI" #DEV
    try:
        search_date = request.GET['parkingdate'].split("-")
        search_date =   "{}/{}/{}".format(search_date[1], search_date[2], search_date[0])
    except:
        today = datetime.datetime.now()
        search_date =   "{}/{}/{}".format(today.month, today.day, today.year)

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

    # query database for parkign spots within 25 miles of search location
    parkingspots = ParkingSpot.objects.filter(location__distance_lte=(point, D(mi=25)))
    # filter by date availability
    parkingspots = [x for x in parkingspots if x.get_num_spots(search_date) >= 0]
    ret_list = []
    for index, x in enumerate(parkingspots):
        # some fields with object points need manual translation for json
        # also some additional fields are necessary.
        # moved to a method of the model?
        temp_dict = model_to_dict(x)
        temp_dict['distance'] = x.location.distance(point)
        temp_dict['rating'] = x.get_avg_rating()
        temp_dict['location'] = {'latitude':x.location.coords[0], 'longitude':x.location.coords[1]}
        temp_dict['amenities'] = parkingspots[index].amenities
        temp_dict['parking_spot_avail'] = parkingspots[index].parking_spot_avail
        temp_dict['photos'] = parkingspots[index].photos.url
        ret_list.append(temp_dict)

    json_parkingspots = json.dumps(ret_list)
    context = {
        'parkingspots' : parkingspots,
        'json_parkingspots' : json_parkingspots,
        'center_lat' : point.coords[0],
        'center_lon' : point.coords[1]
    }
    return render(request, 'search.html', context)


def reserve_request(request):
    if not request.user.is_authenticated():
        redirect('/accounts/login')
    current_user = request.user
    try:
        parkingspot = ParkingSpot.objects.get(id=request.GET['reserve'])
    except:
        return redirect('/search')
    parkingspot.open_date('12/01/2015') #DEV
    parkingspot.open_date('12/02/2015') #DEV
    parkingspot.open_date('12/03/2015') #DEV
    parkingspot.open_date('1/03/2090') #DEV
    date_list = parkingspot.get_all_spots_available()
    date_list.sort(key=lambda x: datetime.datetime.strptime(x[0], '%m/%d/%Y'))
    context = {"parkingspot": parkingspot,
                "date_list": date_list}
    return render(request, 'reserve.html', context)


def finalize_reserve(request):
    #date = request.POST['date']
    date = '12/02/2015' # Grab date
    message = "Hello!  I'd like to reserve a parking spot on %s." % date
    subject = "Reservation Request"
    sender = current_user
    receiver = parkingspot.owner.extended_user.main_user
    message = Message.objects.create(message=message, subject=subject, is_reservation=True, sender=sender, receiver=receiver)
    message.save()
    res_message = ResMessage.objects.create(message=message, parkingspot=parkingspot, res_date=date)
    res_message.save()
    msg = "Parking Request Sent"
    return redirect('parkingspot.views.search', message=msg)



def about(request):
    return render(request, 'about_us.html')

def contact(request):
    return render(request, 'contact_us.html')

def detail(request):
    return render(request, 'detail.html' )
