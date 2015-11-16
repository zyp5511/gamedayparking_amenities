from django.shortcuts import render
from django.shortcuts import redirect
from parkingspot.models import ParkingSpot
from django.contrib.auth.models import User
from userprof.models import ExtendedUser, AdminUser
from message.models import Message, ResMessage
from django.shortcuts import get_object_or_404
import datetime



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
    message = request.session.pop('message', None)
    message_type = request.session.pop('message_type', None)
    if not request.user.is_authenticated():
        return redirect('/home')

    current_user = request.user
    m_user = get_object_or_404(ExtendedUser, main_user=current_user)
    try:
        a_user = get_object_or_404(AdminUser, extended_user=m_user)
        parking_spots = ParkingSpot.objects.filter(owner=a_user)
        incoming_requests = ResMessage.objects.filter(message__receiver=current_user).order_by('res_date')
        print "Incoming Requests: {}".format(incoming_requests)
    except:
        print "Exception: Not admin user, no incoming requests"
        parking_spots = []
        incoming_requests = []

    messages = Message.objects.filter(receiver=current_user, is_reservation=False).order_by('date')
    outgoing_requests = ResMessage.objects.filter(message__sender=current_user).order_by('res_date')
    print "Messages: {}".format(messages)
    print "Outgoing Requests: {}".format(outgoing_requests)
    context = {
        "message" : message,
        "message_type" : message_type,
        "incoming requests" : incoming_requests,
        "outgoing_requests" : outgoing_requests,
        "messages"  : messages
    }
    return render(request, "userInfo.html", context)
def reservations(request):
    message = request.session.pop('message', None)
    message_type = request.session.pop('message_type', None)
    current_user = request.user
    m_user = get_object_or_404(ExtendedUser, main_user=current_user)
    try:
      a_user = get_object_or_404(AdminUser, extended_user=m_user)
      admin_user = True
    except:
      admin_user = False
    now = datetime.datetime.now()
    outgoing_requests = ResMessage.objects.filter(message__sender=current_user, res_date__gte = now).order_by('res_date')
    incoming_requests = ResMessage.objects.filter(message__receiver=current_user, has_responded=False).order_by('res_date')
    history = ResMessage.objects.filter(message__sender=current_user, res_date__lte = now, is_approved=True).order_by('res_date')
    return render(request, 'reservations.html', {"admin_user": admin_user, "incoming_requests": incoming_requests, "message": message, "message_type": message_type, "outgoing_requests":outgoing_requests, "history":history})

def review(request):
  if request.method == 'POST':
    value = request.POST.get("review")
    res_msg = ResMessage.objects.get(id=value)
    return render(request, "add_review.html", {"res": res_msg})

def request_response(request):
  if request.method == 'POST':
    if request.POST.get("confirm"):
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
        msg = "Parking spot approved successfully."
        success = True
      else:
        msg = "You've overbooked for that date, or you haven't opened that date for booking.  You can increase your number of spots available."
        success = False
      request.session['message'] = msg
      request.session['message_type'] = success
      return redirect('/reservations')
    elif request.POST.get("deny"):
      value = request.POST['deny']
      res_msg = ResMessage.objects.get(id=value)
      date = res_msg.res_date
      res_msg.is_approved = False
      res_msg.has_responded = True
      pspot = res_msg.parkingspot
      subject = "Your request for a parking spot could not be fulfilled."
      message = "We're sorry.  We were unable to book a parking spot at %s %s, %s for the date: %s." % (pspot.street_address, pspot.city, pspot.state, date)
      messageO = Message.objects.create(message=message, subject=subject, is_reservation=False, sender=res_msg.message.receiver, receiver=res_msg.message.sender)
      messageO.save()
      res_msg.save()
      msg = "You've successfully denied a parking request."
      success = True
      request.session['message'] = msg
      request.session['message_type'] = success
      return redirect('/reservations')


def cancel_reservation(request):
  if request.method == 'POST':
    value = request.POST.get("cancel")
    res_msg = ResMessage.objects.get(id=value)
    message = res_msg.message
    res_msg.delete()
    message.delete()
    msg = "Reservation Cancelled Successfully"
    success = True
    request.session['message'] = msg
    request.session['message_type'] = success
    return redirect('/reservations')



def reply(request):
    if not request.user.is_authenticated():
        return redirect('/home')
    sender = request.user
    pid = request.POST.get('pid', None)
    receiver = Users.objects.get(id=pid)
    subject = request.POST.get('subject', None)
    text = request.POST.get('text', None)
    reply = Message(sender=sender, receiver=receiver, subject=subject, mesasge=text)
    reply.save()
    request.session['message'] = "Message Sent Successfully"
    request.session['message_type'] = True
    return redirect(profile)
