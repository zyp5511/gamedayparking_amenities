from django.db import models
from userprof.models import ExtendedUser

# Create your models here.

class Message(models.Model):
  sender = models.ForeignKey(ExtendedUser, related_name = 'sender')
  receiver = models.ForeignKey(ExtendedUser, related_name='receiver')
  subject = models.CharField(max_length=80, blank=True)
  message = models.CharField(max_length=1000, blank=True)
  read = models.BooleanField(default=False)