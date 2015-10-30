from django.db import models
from django.contrib.postgres.fields import ArrayField
from django.contrib.gis.db import models
from django.contrib.gis.geos import Point
from localflavor.us.us_states import STATE_CHOICES
from userprof.models import AdminUser
from geopy.geocoders import GoogleV3
from django.conf import settings
from jsonfield import JSONField

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
    default_num_spots = models.IntegerField(default=0)
    parking_spot_avail = JSONField(default='{"dates":{}}')
    objects = models.GeoManager()
    distance = None

    """Opens a date and makes it available for users to get parking"""
    def open_date(self, date):
        try:
            self.parking_spot_avail["dates"][date]
            return -1
        except KeyError:
            self.parking_spot_avail["dates"][date] = {"max" : self.default_num_spots, "res": []}
            self.save()
            return 0      


    """Gets number of spots reserved"""
    def get_num_spots_reserved(self, date):
        return len(self.parking_spot_avail["dates"][date]["res"])

    """Gets number of spots remaining"""
    def get_num_spots(self, date):
        try:
            maxp = self.parking_spot_avail["dates"][date]["max"]
            booked = self.get_num_spots_reserved(date)
            return maxp-booked
        except KeyError:
            return -1

    """Allows a user to reserve a spot"""
    def reserve_spot(self, user, date):
        try:
            if self.get_num_spots(date) > 0:
                self.parking_spot_avail["dates"][date]["res"].append(user)
                self.save()
                return 0
            else:
                return -1
        except KeyError:
            return -1


    """Cancels a user's reservation"""
    def cancel_reservation(self, user, date):
        self.parking_spot_avail["dates"][date]["res"].remove(user)
        self.save()


    """Allows user to alter max spots available on a certain day"""
    def alter_max_spots(self, date, number):
        try:
            if self.get_num_spots_reserved(date) > number:
                return -1
            else:
                self.parking_spot_avail["dates"][date]["max"] = number
                self.save()
        except KeyError:
            return -1



    # override save method to interpret location field base on address
    def save(self, *args, **kwargs):
        g = GoogleV3()
        p = g.geocode("{}, {}, {} {}".format(self.street_address, self.city, self.state, self.zipcode))
        self.location = Point(p.longitude, p.latitude)
        super(ParkingSpot, self).save(*args, **kwargs)


    def __str__(self):
        return self.street_address
            




















