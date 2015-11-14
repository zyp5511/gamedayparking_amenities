from django.shortcuts import render
from django.shortcuts import redirect
from parkingspot.models import ParkingSpot
from django.contrib.auth.models import User
from userprof.models import ExtendedUser, AdminUser
from message.models import Message, ResMessage
from django.shortcuts import get_object_or_404



def admin_page(request, message=None, success=None):
  if not request.user.is_authenticated():
    return redirect('/home')
  current_user = request.user
  m_user = get_object_or_404(ExtendedUser, main_user=current_user)
  try:
    a_user = get_object_or_404(AdminUser, extended_user=m_user)
  except:
    return redirect('/home')
  parking_list = ParkingSpot.objects.filter(owner=a_user)
  print parking_list


def profile(request):
  message = None
  message_type = None
  try:
    message = request.session.pop('message')
  except:
    pass
  try:
    message_type = request.session.pop('message_type')
  except:
    pass
  print message
  if not request.user.is_authenticated():
    return redirect('/home')
  current_user = request.user
  m_user = get_object_or_404(ExtendedUser, main_user=current_user)
  try:
    a_user = get_object_or_404(AdminUser, extended_user=m_user)
    parking_spots = ParkingSpot.objects.filter(owner=a_user)
    incoming_requests = ResMessage.objects.filter(message__receiver=current_user).order_by('date')
  except:
    parking_spots=None
    incoming_requests=None
  messages = Message.objects.filter(receiver=current_user, is_reservation=False).order_by('date')
  outgoing_requests = ResMessage.objects.filter(message__sender=current_user).order_by('date')
  
  return render(request, "userInfo.html", {"message": message, "message_type":message_type, "incoming_requests": incoming_requests, "outgoing_requests": outgoing_requests, "messages": messages})

def approve_request(request):
  if request.method == 'POST':
    value = request.POST['confirm']
    res_msg = ResMessage.objects.get(id=value)

    date = res_msg.res_date
    pspot = res_msg.parkingspot
    if pspot.get_num_spots(date) > 0:
      res_msg.is_approved = True
      res_msg.has_responded = True
      pspot.reserve_spot(res_msg.message.sender,date)
      subject = "Congratulations!  Your parking spot request has been approved."
      message = "You've successfully booked a parking spot at %s %s, %s for the date: %s." % (pspot.street_address, pspot.city, pspot.state, date)
      messageO = Message.objects.create(message=message, subject=subject, is_reservation=False, sender=res_msg.message.receiver, receiver=res_msg.message.sender)
      messageO.save()
      res_msg.save()
      msg = "Parking spot approved"
      success = True
    else:
      msg = "You've overbooked for that date, or you haven't opened that date for booking.  You can increase your number of spots available."
      success = False
    return redirect('userprof.views.admin_page', message=msg, success=success)

def deny_request(request):
  if request.method == "POST":
    value = request.POST['deny']
    res_msg = ResMessage.objects.get(id=value)
    res_msg.is_approved = False
    res_msg.has_responded = True
    subject = "Your request for a parking spot could not be fulfilled."
    message = "We're sorry.  We were unable to book a parking spot at %s %s, %s for the date: %s." % (pspot.street_address, pspot.city, pspot.state, date)
    messageO = Message.objects.create(message=message, subject=subject, is_reservation=False, sender=res_msg.message.receiver, receiver=res_msg.message.sender)
    messageO.save()
    res_msg.save()
    msg = "Parking request denied."
    success = True
    return redirect('userprof.views.admin_page', message=msg, success=success)