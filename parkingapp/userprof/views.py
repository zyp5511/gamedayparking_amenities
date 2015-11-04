from django.shortcuts import render
from django.shortcuts import redirect
from parkingspot.models import ParkingSpot
from django.contrib.auth.models import User
from userprof.models import ExtendedUser, AdminUser
from message.models import Message, ResMessage
from django.shortcuts import get_object_or_404



def admin_page(request):
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
  if not request.user.is_authenticated():
    return redirect('/home')
  current_user = request.user
  messages = Message.objects.filter(receiver=current_user, is_reservation=False).order_by('date')
  incoming_requests = ResMessage.objects.filter(receiver=current_user)
  outgoing_requests = ResMessage.objects.filter(sender=current_user)

def approve_request(request):
  #TODO when i get to lab
  return redirect('/home')