import time
import json

from selenium.webdriver.firefox.webdriver import WebDriver
from django.contrib.staticfiles.testing import StaticLiveServerTestCase

from django.core.files import File
from django.test import TestCase
from parkingspot.models import ParkingSpot
from django.contrib.gis.geos import Point
from django.contrib.gis.measure import D
from geopy.geocoders import GoogleV3

from django.contrib.auth.models import User
from userprof.models import AdminUser, ExtendedUser
from userprof.tests import create_allauth_user

from jsonfield import JSONField

class ParkingSpotTests(TestCase):

    def setUp(self):
        user = User.objects.create()
        user.save()
        #allauth_user = create_allauth_user("rschaefer@wisc.edu")
        extended_user = ExtendedUser.objects.create(
            main_user = user,
        )
        extended_user.save()
        admin_user = AdminUser.objects.create(
            extended_user = extended_user
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


    def test_review(self):
        time.sleep(2)

class SeleniumTests(StaticLiveServerTestCase):

    @classmethod
    def setUpClass(cls):
        super(SeleniumTests, cls).setUpClass()
        cls.selenium = WebDriver()

    def setUp(self):
        user = User.objects.create()
        user.save()
        #allauth_user = create_allauth_user("rschaefer@wisc.edu")
        extended_user = ExtendedUser.objects.create(
            main_user = user,
        )
        extended_user.save()
        admin_user = AdminUser.objects.create(
            extended_user = extended_user
        )
        admin_user.save()

        #should not be returned when searching around madison
        self.test_spot1 = ParkingSpot.objects.create(
            street_address = "400 Morning Oaks Ct",
            city = "Ellisville",
            state = "MO",
            zipcode = 63021,
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
            cost = 5,
            owner = admin_user,
            description = "has grill, middle cost",
            amenities = '{"bathroom":false,"yard":false,"grill":true,"table":false,"electricity":false}'
        )
        self.test_spot2.save()


        self.test_spot3 = ParkingSpot.objects.create(
            street_address = "Engineering Hall",
            city = "Madison",
            state = "WI",
            zipcode = 53703,
            cost = 10,
            owner = admin_user,
            description = "has bathroom, highest cost",
            amenities = '{"bathroom":true,"yard":false,"grill":true,"table":false,"electricity":false}'
        )
        self.test_spot3.save()


        self.test_spot4 = ParkingSpot.objects.create(
            street_address = "633 N Henry Street",
            city = "Madison",
            state = "WI",
            zipcode = 53703,
            cost = 0,
            owner = admin_user,
            description = "has yard, lowest cost",
            amenities = '{"bathroom":false,"yard":true,"grill":true,"table":false,"electricity":false}'
        )
        self.test_spot4.save()

        self.madison_spots = [self.test_spot2, self.test_spot3, self.test_spot4]


    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(SeleniumTests, cls).tearDownClass()


    def test_home_nav_bar(self):
        # test brand link
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        self.selenium.find_element_by_link_text("Game Day Parking").click()
        title = self.selenium.find_element_by_tag_name("h1")
        self.assertEqual(title.text, u'Gameday Amenities Finder')
        # test home link
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        self.selenium.find_element_by_link_text("Home").click()
        title = self.selenium.find_element_by_tag_name("h1")
        self.assertEqual(title.text, u'Gameday Amenities Finder')
        # test test about us link
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        self.selenium.find_element_by_link_text("About Us").click()
        title = self.selenium.find_element_by_tag_name("h2")
        self.assertEqual(title.text, u'What does Gameday Parking do?')
        # test contact us link
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        self.selenium.find_element_by_link_text("Contact Us").click()
        title = self.selenium.find_element_by_tag_name("h2")
        self.assertEqual(title.text, u'Computer Science 506 Game Day Parking and Amenities Finder Team')


    def test_home_search(self):
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        search_input =  self.selenium.find_element_by_name("location")
        search_input.clear()
        search_input.send_keys("Camp Randall")
        search_input.submit()
        # verify three madison parkingspots appear
        spots = [x.text for x in self.selenium.find_elements_by_tag_name("h4")]
        test_spots = [x.street_address for x in self.madison_spots]
        self.assertTrue(all(x in spots for x in test_spots))


    def test_search_nav_bar(self):
        # test brand link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison%2C+WI'))
        self.selenium.find_element_by_link_text("Game Day Parking").click()
        title = self.selenium.find_element_by_tag_name("h1")
        self.assertEqual(title.text, u'Gameday Amenities Finder')
        # test home link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison%2C+WI'))
        self.selenium.find_element_by_link_text("Home").click()
        title = self.selenium.find_element_by_tag_name("h1")
        self.assertEqual(title.text, u'Gameday Amenities Finder')
        # test test about us link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison%2C+WI'))
        self.selenium.find_element_by_link_text("About Us").click()
        title = self.selenium.find_element_by_tag_name("h2")
        self.assertEqual(title.text, u'What does Gameday Parking do?')
        # test contact us link
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        self.selenium.find_element_by_link_text("Contact Us").click()
        title = self.selenium.find_element_by_tag_name("h2")
        self.assertEqual(title.text, u'Computer Science 506 Game Day Parking and Amenities Finder Team')


    # not working with ameniteies JSONField. Somehow view isn't passing correct JSON and
    # is escaping quotes? Can see problem by viewing source of page during test
    def test_search_filter(self):
        # test filtering by bathroom
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison%2C+WI'))

        bathroom_filtered = [x.street_address for x in self.madison_spots if json.loads(x.amenities)['bathroom']]
        grill_filtered = [x.street_address for x in self.madison_spots if json.loads(x.amenities)['grill']]
        yard_filtered = [x for x in self.madison_spots if json.loads(x.amenities)['yard']]
        electricity_filtered = [x for x in self.madison_spots if json.loads(x.amenities)['electricity']]
        table_filtered = [x for x in self.madison_spots if json.loads(x.amenities)['table']]

        # filter buttons
        self.selenium.find_element_by_id("filter_grill").click()
        displayed = [x.text for x in self.selenium.find_elements_by_tag_name("h4")]

        # assert all displayed. order doesn't matter
        self.assertTrue(all(x in displayed for x in grill_filtered))

    def test_search_sort(self):
        # test sorting cost low to high
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Camp+Randall'))

        # test sorting cost low to high
        self.selenium.find_element_by_id("cost_low").click()
        sorted_low_to_high = sorted(self.madison_spots, key=lambda x: x.cost)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddressHeader")]
        for i in range(len(sorted_low_to_high)):
            self.assertEqual(spots[i], sorted_low_to_high[i].street_address)

        # test sorting cost high to low
        self.selenium.find_element_by_id("cost_high").click()
        sorted_high_to_low = sorted(self.madison_spots, key=lambda x: x.cost, reverse=True)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddressHeader")]
        for i in range(len(sorted_high_to_low)):
            self.assertEqual(spots[i], sorted_high_to_low[i].street_address)

        # view calculates distance, do same calcultion for test spots
        point = Point(-89.412613, 43.069722) #Camp Randall
        for x in self.madison_spots:
            x.distance =  x.location.distance(point)
        # test sorting distance low to high
        self.selenium.find_element_by_id("dist_low").click()
        sorted_low_to_high = sorted(self.madison_spots, key=lambda x: x.distance)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddressHeader")]
        for i in range(len(sorted_low_to_high)):
            self.assertEqual(spots[i], sorted_low_to_high[i].street_address)

        # test sorting distance high to low
        self.selenium.find_element_by_id("dist_high").click()
        sorted_high_to_low = sorted(self.madison_spots, key=lambda x: x.distance, reverse=True)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddressHeader")]
        for i in range(len(sorted_high_to_low)):
            self.assertEqual(spots[i], sorted_high_to_low[i].street_address)

    def test_search_filter_and_sort(self):
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Camp+Randall'))

        # sort by cost low to high for predictable outpu
        self.selenium.find_element_by_id("cost_low").click()
        sorted_low_to_high = sorted(self.madison_spots, key=lambda x: x.cost)

        # test filtering results
