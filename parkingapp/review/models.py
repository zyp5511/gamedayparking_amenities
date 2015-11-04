from django.db import models
from parkingspot.models import ParkingSpot
from userprof.models import AdminUser, ExtendedUser

# Create your models here.
class Review(models.Model):
    name = models.CharField(max_length=80)
    parkingspot = models.ForeignKey(ParkingSpot, default=None)
    reviewer = models.ForeignKey(ExtendedUser, default=None)
    headline = models.CharField(max_length=40, blank=True)
    review_text = models.CharField(max_length=400, blank=True)
    rating = models.IntegerField(default=5)
