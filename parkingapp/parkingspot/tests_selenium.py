from selenium.webdriver.firefox.webdriver import WebDriver
from django.contrib.staticfiles.testing import StaticLiveServerTestCase

from django.contrib.gis.geos import Point
from django.contrib.gis.measure import D

from parkingspot.models import ParkingSpot
from django.contrib.auth.models import User
from userprof.models import AdminUser, ExtendedUser

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
            amenities = {"bathroom":False,"yard":False,"grill":True,"table":False,"electricity":False}
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
            amenities = {"bathroom":True,"yard":False,"grill":True,"table":False,"electricity":False}
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
            amenities = {"bathroom":False,"yard":True,"grill":True,"table":False,"electricity":False}
        )
        self.test_spot4.save()

        self.test_spot5 = ParkingSpot.objects.create(
            street_address = "124 Langdon Street",
            city = "Madison",
            state = "WI",
            zipcode = 53703,
            cost = 0,
            owner = admin_user,
            description = "has yard, lowest cost, not open on 12/03",
            amenities = {"bathroom":False,"yard":True,"grill":True,"table":False,"electricity":False}
        )
        self.test_spot5.save()


        self.all_spots = [self.test_spot1, self.test_spot2, self.test_spot3, self.test_spot4, self.test_spot5]
        self.madison_spots = [self.test_spot2, self.test_spot3, self.test_spot4]

        # open spots on 12/03/2015 for all but test_spot5
        for x in self.all_spots:
            x.default_num_spots = 5
            x.open_date("12/03/2015")
            x.save()
        self.test_spot5.parking_spot_avail = '{"dates":{}}'
        self.test_spot5.save()

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
        search_input.send_keys("Madison, WI")
        date_input = self.selenium.find_element_by_id("parkingday")
        date_input.send_keys("12/03/2015")
        search_input.submit()
        # verify three madison parkingspots appear
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        test_spots = [display_address(x) for x in self.madison_spots]
        self.assertEqual( len(test_spots), len(self.madison_spots))
        self.assertTrue(all(x in spots for x in test_spots))


    def test_search_nav_bar(self):
        # test brand link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison&parkingdate=12%2F03%2F2015'))
        self.selenium.find_element_by_link_text("Game Day Parking").click()
        title = self.selenium.find_element_by_tag_name("h1")
        self.assertEqual(title.text, u'Gameday Amenities Finder')
        # test home link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison&parkingdate=12%2F03%2F2015'))
        self.selenium.find_element_by_link_text("Home").click()
        title = self.selenium.find_element_by_tag_name("h1")
        self.assertEqual(title.text, u'Gameday Amenities Finder')
        # test test about us link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison&parkingdate=12%2F03%2F2015'))
        self.selenium.find_element_by_link_text("About Us").click()
        title = self.selenium.find_element_by_tag_name("h2")
        self.assertEqual(title.text, u'What does Gameday Parking do?')
        # test contact us link
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison&parkingdate=12%2F03%2F2015'))
        self.selenium.find_element_by_link_text("Contact Us").click()
        title = self.selenium.find_element_by_tag_name("h2")
        self.assertEqual(title.text, u'Computer Science 506 Game Day Parking and Amenities Finder Team')


    # not working with ameniteies JSONField. Somehow view isn't passing correct JSON and
    # is escaping quotes? Can see problem by viewing source of page during test
    def test_search_filter(self):
        # test filtering by bathroom
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison&parkingdate=12%2F03%2F2015'))

        madison_display = [display_address(x) for x in self.madison_spots]
        bathroom_filtered = [display_address(x) for x in self.madison_spots if x.amenities['bathroom']]
        grill_filtered = [display_address(x) for x in self.madison_spots if x.amenities['grill']]
        yard_filtered = [display_address(x) for x in self.madison_spots if x.amenities['yard']]
        electricity_filtered = [display_address(x) for x in self.madison_spots if x.amenities['electricity']]
        table_filtered = [display_address(x) for x in self.madison_spots if x.amenities['table']]

        # check yard filter
        self.selenium.find_element_by_id("filter_yard").click()
        displayed = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        for x in yard_filtered:
            self.assertTrue(x in displayed)

        self.assertTrue(all(x in displayed for x in yard_filtered))
        # check defilter
        self.selenium.find_element_by_id("filter_yard").click()
        displayed = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        for x in madison_display:
            self.assertTrue(x in displayed)

        # check grill filter
        self.selenium.find_element_by_id("filter_grill").click()
        displayed = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        self.assertTrue(all(x in displayed for x in yard_filtered))
        # check grill and bathroom filter
        self.selenium.find_element_by_id("filter_bathroom").click()
        grill_bathroom_filtered = [display_address(x) for x in self.madison_spots if x.amenities['bathroom'] and x.amenities['grill']]
        displayed = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        self.assertTrue(all(x in displayed for x in grill_bathroom_filtered))

        # check only deasserting one filter - now only bathroom displayed
        self.selenium.find_element_by_id("filter_grill").click()
        displayed = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        self.assertTrue(all(x in displayed for x in bathroom_filtered))
        self.selenium.find_element_by_id("filter_bathroom").click()

    def test_search_sort(self):
        # test sorting cost low to high
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Camp+randall%2C+madison&parkingdate=12%2F03%2F2015'))

        # test sorting cost low to high
        self.selenium.find_element_by_id("cost_low").click()
        sorted_low_to_high = sorted(self.madison_spots, key=lambda x: x.cost)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        for i in range(len(sorted_low_to_high)):
            self.assertEqual(spots[i], display_address(sorted_low_to_high[i]))

        # test sorting cost high to low
        self.selenium.find_element_by_id("cost_high").click()
        sorted_high_to_low = sorted(self.madison_spots, key=lambda x: x.cost, reverse=True)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        for i in range(len(sorted_high_to_low)):
            self.assertEqual(spots[i], display_address(sorted_high_to_low[i]))

        # view calculates distance, do same calcultion for test spots
        point = Point(-89.414861, 43.06986)
        for x in self.madison_spots:
            x.distance =  x.location.distance(point)

        # test sorting distance low to high
        self.selenium.find_element_by_id("dist_low").click()
        sorted_low_to_high = sorted(self.madison_spots, key=lambda x: x.distance)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        for i in range(len(sorted_low_to_high)):
            self.assertEqual(spots[i], display_address(sorted_low_to_high[i]))

        # test sorting distance high to low
        self.selenium.find_element_by_id("dist_high").click()
        sorted_high_to_low = sorted(self.madison_spots, key=lambda x: x.distance, reverse=True)
        spots = [x.text for x in self.selenium.find_elements_by_class_name("streetAddress")]
        for i in range(len(sorted_high_to_low)):
            self.assertEqual(spots[i], display_address(sorted_high_to_low[i]))

    def test_search_filter_and_sort(self):
        self.selenium.get("{}{}".format(self.live_server_url, '/search/?location=Madison&parkingdate=12%2F03%2F2015'))

        # sort by cost low to high for predictable outpu
        self.selenium.find_element_by_id("cost_low").click()
        sorted_low_to_high = sorted(self.madison_spots, key=lambda x: x.cost)

        # test filtering results


def display_address(spot):
    return  spot.street_address + ", " + spot.city + ", " + spot.state
