from django.db import models
from userprof.models import ExtendedUser
from parkingspot.models import ParkingSpot
from django.contrib.auth.models import User
from review.models import Review

# Create your models here.

class Message(models.Model):
  sender = models.ForeignKey(User, related_name = 'sender')
  receiver = models.ForeignKey(User, related_name='receiver')
  subject = models.CharField(max_length=80, blank=True)
  message = models.CharField(max_length=1000, blank=True)
  read = models.BooleanField(default=False)
  date = models.DateTimeField(auto_now_add=True, auto_now=False, blank=True, null=True)
  is_reservation = models.BooleanField(default=False)

  def __str__(self):
    return "%s -> %s" % (self.sender, self.receiver)


class ResMessage(models.Model):
  message = models.ForeignKey(Message)
  parkingspot = models.ForeignKey(ParkingSpot)
  res_date = models.DateTimeField(blank=True, null=True)
  is_approved = models.BooleanField(default=False)
  has_responded = models.BooleanField(default=False)
  reviewed = models.ForeignKey(Review, null=True, blank=True)
  transaction_id = models.CharField(max_length=255, null=True, blank=True)

  def __str__(self):
    return "%s -> %s, %s" % (self.message.sender, self.message.receiver, self.parkingspot)
