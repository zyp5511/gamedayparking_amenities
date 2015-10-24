from django.db import models
from django.contrib.postgres.fields import ArrayField
from django.contrib.gis.db import models
from userprof.models import AdminUser
from review.models import Review
from django.conf import settings
# Create your models here.

class ParkingSpot(models.Model):
  street_address = models.CharField(max_length=80, blank=True)
  city = models.CharField(max_length = 30, blank = True)
  state = models.CharField(max_length = 2, blank = True)
  zipcode = models.IntegerField(blank=True)
  location = models.PointField(null=True,blank=True)
  owner = models.ForeignKey(AdminUser)
  description = models.CharField(max_length=256)
  amenities = ArrayField(models.CharField(max_length=80, blank=True), blank=True, null=True, size=7)
  photos = models.ImageField(default='%s/default.png' % settings.MEDIA_URL)
  reviews = ArrayField(models.CharField(max_length=80,blank=True), blank=True, null=True)
  objects = models.GeoManager()






















