from django.db import models
from parkingspot.models import ParkingSpot
from django.contrib.auth.models import User


# Create your models here.
class Review(models.Model):
    parkingspot = models.ForeignKey(ParkingSpot, default=None)
    reviewer = models.ForeignKey(User, default=None)
    headline = models.CharField(max_length=60, blank=True)
    review_text = models.CharField(max_length=4000, blank=True)
    rating = models.IntegerField(default=5)
