from django.core.files import File
from django.test import TestCase
from parkingspot.models import ParkingSpot
from django.contrib.gis.geos import Point
from django.contrib.gis.measure import D
from geopy.geocoders import GoogleV3

from django.contrib.auth.models import User
from userprof.models import AdminUser, ExtendedUser
from review.models import Review
from userprof.tests import create_allauth_user

from jsonfield import JSONField

class ParkingSpotTests(TestCase):

    def setUp(self):
        user = User.objects.create()
        user.save()
        #allauth_user = create_allauth_user("rschaefer@wisc.edu")
        self.extended_user = ExtendedUser.objects.create(
            main_user = user,
        )
        self.extended_user.save()
        admin_user = AdminUser.objects.create(
            extended_user = self.extended_user
        )
        admin_user.save()

        #should not be returned when searching around madison
        self.test_spot1 = ParkingSpot.objects.create(
            street_address = "400 Morning Oaks Ct",
            city = "Ellisville",
            state = "MO",
            zipcode = 63021,
            location = Point(-90.586876, 38.592703),
            owner = admin_user,
            description = "Missouri Parking Spot",
            amenities =(["test1", "test2", "test3"]),
        )
        self.test_spot1.save()


        self.test_spot2 = ParkingSpot.objects.create(
            street_address = "4 N Park Street",
            city = "Madison",
            state = "WI",
            zipcode = 53703,
            owner = admin_user,
            description = "Madison Parking Spot. Location Field should be automatically populated",
            amenities =(["test1", "test2", "test3"]),
        )
        self.test_spot2.save()

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



    def test_zero_ratings(self):
        rating = self.test_spot1.get_avg_rating()
        self.assertEqual(None, rating)


    def test_one_rating(self):
        review1 = Review(
                    rating = 5,
                    reviewer = self.extended_user,
                    parkingspot= self.test_spot1
                )
        review1.save()
        rating = self.test_spot1.get_avg_rating()
        self.assertEqual(5, rating)
        review1.delete()


    def test_multiple_ratings(self):
        review1 = Review(
                    rating = 5,
                    reviewer = self.extended_user,
                    parkingspot= self.test_spot1
                )
        review2 = Review(
                    rating = 4,
                    reviewer = self.extended_user,
                    parkingspot= self.test_spot1
                )
        review3 = Review(
                    rating = 3,
                    reviewer = self.extended_user,
                    parkingspot= self.test_spot1
                )
        review1.save()
        review2.save()
        review3.save()
        rating = self.test_spot1.get_avg_rating()
        self.assertEqual(4, rating)
        review1.delete()
        review2.delete()
        review3.delete()
