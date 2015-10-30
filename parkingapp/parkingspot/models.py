from django.db import models
from django.contrib.postgres.fields import ArrayField
from django.contrib.gis.db import models
from django.contrib.gis.geos import Point
from localflavor.us.us_states import STATE_CHOICES
from userprof.models import AdminUser
from geopy.geocoders import GoogleV3
from django.conf import settings
# Create your models here.

class ParkingSpot(models.Model):
    street_address = models.CharField(max_length=70, blank=True)
    city = models.CharField(max_length = 30, blank = True)
    state = models.CharField(max_length = 2, choices=STATE_CHOICES, default="WI")
    zipcode = models.IntegerField(blank=True, null=True)
    location = models.PointField(null=True,blank=True)
    owner = models.ForeignKey(AdminUser)
    description = models.CharField(max_length=256)
    amenities = ArrayField(models.CharField(max_length=80, blank=True), blank=True, null=True, size=7)
    cost = models.IntegerField(blank=True, null=True, default=5)
    photos = models.ImageField(default='%s/default.png' % settings.MEDIA_URL)
    objects = models.GeoManager()


    # override save method to interpret location field base on address
    def save(self, *args, **kwargs):
        g = GoogleV3()
        p = g.geocode("{}, {}, {} {}".format(self.street_address, self.city, self.state, self.zipcode))
        self.location = Point(p.longitude, p.latitude)
        super(ParkingSpot, self).save(*args, **kwargs)


    def __str__(self):
        return self.street_address




















