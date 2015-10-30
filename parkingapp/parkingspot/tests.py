
from django.core.files import File
from django.test import TestCase
from parkingspot.models import ParkingSpot
from django.contrib.gis.geos import Point
from django.contrib.gis.measure import D
from geopy.geocoders import GoogleV3
from userprof.models import AdminUser

class ParkingSpotTests(TestCase):

    def setUp(self):
        self.user = AdminUser.objects.create(name="Ryan")

        self.test_spot1 = ParkingSpot.objects.create(
            street_address = "400 Morning Oaks Ct",
            city = "Ellisville",
            state = "MO",
            zipcode = 63021,
            location = Point(-90.586876, 38.592703),
            owner = self.user,
            description = "Missouri Parking Spot",
            amenities =(["test1", "test2", "test3"]),
        )


        self.test_spot2 = ParkingSpot.objects.create(
            street_address = "1440 Monroe Street",
            city = "Madison",
            state = "WI",
            zipcode = 53703,
            owner = self.user,
            description = "Madison Parking Spot. Location Field should be automatically populated",
            amenities =(["test1", "test2", "test3"]),
        )

    def test_city_filter(self):
        """Filters Based On City"""
        spot = ParkingSpot.objects.filter(city="Ellisville")
        self.assertEqual(len(spot), 1)
        self.assertEqual(spot[0].pk, self.test_spot1.pk)

    def test_geos(self):
        """Tests the auto fill of location parking spot field
        and the filtering of objects close to camp randall"""
        point = Point(-89.412613, 43.069722) #Camp Randall
        spots = ParkingSpot.objects.filter(location__distance_lte=(point, D(mi=10)))
        self.assertEqual(len(spots), 1)
        self.assertEqual(spots[0].pk, self.test_spot2.pk)




    def test_review(self):
        pass
