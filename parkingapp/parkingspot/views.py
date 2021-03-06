import json
import datetime
from userprof.views import profile
from django.shortcuts import render, redirect
from django.shortcuts import render_to_response, get_object_or_404
from django.contrib.gis.measure import D
from django.contrib.gis.geos import Point
from django.contrib.gis.geoip import GeoIP
from django.forms.models import model_to_dict
from geopy.geocoders import GoogleV3
from parkingspot.models import ParkingSpot
from message.models import Message, ResMessage
from userprof.models import ExtendedUser, AdminUser
from django.contrib.auth.models import User
from parkingspot.forms import ParkingSpotEdit, ParkingSpotAdd
import os
import json

from django.contrib.auth.decorators import login_required
from django.utils.six.moves.urllib.parse import urlparse

# Create your views here.
def home(request):
    # get Point from request IP address
    message = request.session.pop('message', None)
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
        "message": message
    }
    return render(request, 'home.html', context)


def search(request):
    try:
        location = request.GET['location']
        if not location:
            location = "Madison, WI"
    except:
        location = "Madison, WI" #DEV
    try:
        search_date = request.GET['parkingdate']
        if '-' in search_date:
            search_date = search_date.split('-')
            search_date =   "{}/{}/{}".format(search_date[1], search_date[2], search_date[0])
    except:
        today = datetime.datetime.now()
        search_date =   "{}/{}/{}".format(today.month, today.day, today.year)

    g = GoogleV3()
    p = g.geocode(location)
    message = None
    if p is None:
        message = "Unable to process search.  Try another query."
        request.session['message'] = message
        return redirect('/home')
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
        'prev_search' : request.GET['location'],
        'parkingspots' : parkingspots,
        'json_parkingspots' : json_parkingspots,
        'date'      :  search_date.split("/"),
        'center_lat' : point.coords[0],
        'center_lon' : point.coords[1]
    }
    return render(request, 'search.html', context)



def spotmodify(request):
    if not request.user.is_authenticated():
        return redirect('/accounts/login')
    current_user = request.user
    
    e_user = ExtendedUser.objects.get(main_user=current_user)
    try:
        a_user = get_object_or_404(AdminUser, extended_user=e_user)
    except:
        return redirect('/home')
    if a_user.registered is not True:
        return redirect('/home')
    if request.method == 'POST':
        pid = int(request.POST['send'])
        instance = get_object_or_404(ParkingSpot, id=pid) #TODO, switch to ID
        form = ParkingSpotEdit(request.POST, request.FILES, instance=instance)
        form.owner = a_user
        opend = []
        try:
            opend = request.POST['opendates']
            print opend
        except:
            print 'none found'
        opend = opend.split(', ')
        for date in opend:
            instance.open_date(date)
        dates = instance.get_date_array()
        dates = json.dumps(dates)
        if form.is_valid():
            form.photos = form.cleaned_data['photos']
            form.save()
            return render(request, "editspot.html", {'form': form, 'pid': pid, 'instance': instance, "dates": dates})
    elif request.method == 'GET':
        pid=int(request.GET['edit'])
        print pid
        instance = get_object_or_404(ParkingSpot, id=pid) #TODO, switch to ID
        dates = instance.get_date_array()
        dates = json.dumps(dates)
        form = ParkingSpotEdit(instance=instance)
    return render(request, "editspot.html", {'form': form, 'pid': pid, 'instance': instance, "dates": dates})


def newspot(request):
    if not request.user.is_authenticated():
        return redirect('/accounts/login')
    current_user = request.user
    e_user = ExtendedUser.objects.get(main_user=current_user)
    try:
        a_user = get_object_or_404(AdminUser, extended_user=e_user)
    except:
        return redirect('/home')
    if a_user.registered is not True:
        return redirect('/home')
    if request.method == 'POST':
        instance = ParkingSpot(owner=a_user)
        form = ParkingSpotAdd(request.POST, request.FILES, instance=instance)
        form.owner = a_user
        if form.is_valid():
            instance.save()
            instance.photos = form.cleaned_data['photos']
            instance.save()
            form.save()
            message_type = True
            message = "Parking spot created successfully."
            request.session['message'] = message
            request.session['message_type'] = message_type
            return redirect(profile)
    elif request.method == 'GET':
        form = ParkingSpotAdd()
    return render(request, "editspot.html", {'form': form})

@login_required
def reserve_request(request):
    if not request.user.is_authenticated():
        return redirect('/accounts/login')
    current_user = request.user
    try:
        parkingspot = ParkingSpot.objects.get(id=request.GET['reserve'])
    except:
        return redirect(request.META.get('HTTP_REFERER', '/'))
    message = request.session.pop('message', None)
    message_type = request.session.pop('message_type', None)
    date_list = parkingspot.get_all_spots_available()
    date_list.sort(key=lambda x: datetime.datetime.strptime(x[0], '%m/%d/%Y'))
    reviews = parkingspot.review_set.all()
    parkingspot.default_num_spots = parkingspot.get_num_spots(request.GET['date'])
    context = {"parkingspot": parkingspot,
                "date_list": date_list,
                "date": request.GET['date'].split("/"),
                "reviews" : reviews,
                "message": message,
                "message_type" : message_type
              }
    return render(request, 'reserve.html', context)


def finalize_reserve(request):
    parkingspot_id = int(request.POST.get('pid'))
    parkingspot = ParkingSpot.objects.get(id=parkingspot_id)
    date = request.POST.get('dp1')
    num_spots = request.POST.get('number_spots')
    avail_spots = parkingspot.get_num_spots(date)
    # check if spots available
    if avail_spots < int(num_spots):
        request.session['message'] = "Reservation Failed. Only {} available for that date".format(avail_spots)
        request.session['message_type'] = False
        return redirect(reserve_request)
    else:
        message = request.POST.get('message')
        date = date.split("/")
        date = "{}-{}-{}".format(date[2], date[0], date[1])
        subject = "Reservation Request"
        sender = request.user
        receiver = parkingspot.owner.extended_user.main_user
        message = Message.objects.create(message=message, subject=subject, is_reservation=True, sender=sender, receiver=receiver, date=datetime.datetime.now() )
        res_message = ResMessage.objects.create(message=message, parkingspot=parkingspot, res_date=date, num_spots=num_spots)
        msg = "Parking Request Sent"
        request.session['message'] = "Reservation Request Sent Successfully"
        request.session['message_type'] = True
        return redirect(reserve_request)

def AddReview(request):
    if not request.user.is_authenticated():
        return redirect('/accounts/login')
    current_user = request.user
    user_id = request.POST['sampleID']
    today = datetime.datetime.now()
    booking_history = ResMessage.objects.filter(sender=current_user, is_approved=True, res_date__lte=today).order_by('res_date')
    booking_history.reverse()
    context = {
        'booking_history' : booking_history
    }

    return render(request, 'add_review.html',context)

def about(request):
    return render(request, 'about_us.html')

def contact(request):
    return render(request, 'contact_us.html')

def userInfo(request):
    return render(request, 'userInfo.html' )
