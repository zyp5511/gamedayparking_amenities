from django.test import TestCase

import random
import string
import time
import pickle

from django.conf import settings
from django.http import HttpRequest, QueryDict
from django.utils.importlib import import_module
from django.contrib.auth import get_user_model 

from django.test import Client

from allauth.account import app_settings, signals
from allauth.account.forms import SignupForm
from allauth.account.views import SignupView
from allauth.account.utils import setup_user_email, complete_signup

from selenium.webdriver.firefox.webdriver import WebDriver
from django.contrib.staticfiles.testing import StaticLiveServerTestCase
from selenium.common.exceptions import NoSuchElementException

def generate_password(chars=8):
    return ''.join(random.choice(string.ascii_uppercase + string.digits) for x in range(chars))


def get_post_dic(email):
    password = generate_password()
    #csrfmiddlewaretoken = #not necessary
    return {
            u'password1': password,
            #u'csrfmiddlewaretoken': #not necessary
            u'email': email,
            u'password2': password,
            u'confirmation_key': ""
    }


def get_signin_request(post_dic):
    signin_request = HttpRequest()

    query_dict = QueryDict("")
    query_dict_post = query_dict.copy() # Make it mutable
    query_dict_get = query_dict.copy() # Make it mutable

    query_dict_post.update(post_dic)

    signin_request.POST = query_dict_post
    signin_request.GET = query_dict_get

    # Set session (fails without)
    # http://stackoverflow.com/questions/16865947/django-httprequest-object-has-no-attribute-session
    engine = import_module(settings.SESSION_ENGINE)
    session_key = None
    signin_request.session = engine.SessionStore(session_key)

    signin_request.SERVER_NAME = ""

    return signin_request


def create_allauth_user(email):
    post_dic = get_post_dic(email)
    signin_request = get_signin_request(post_dic)

    signup_form_kwargs = {"files": {}, "initial": {},
                          "data": signin_request.POST}
    # From allauth.account.views.SignupView.form_valid
    signup_form = SignupForm(**signup_form_kwargs)
    signup_form.cleaned_data = post_dic # Csrf token not neccesary either
    user = signup_form.save(signin_request)

    # Sends sign up mail
    signals.user_signed_up.send(sender=user.__class__,
                                request=signin_request,
                                user=user,
                                signal_kwargs={})
    return user

# Create your tests here
class UserprofModelsTests(TestCase):

    def test_allauth_user_creation(self):
        user = create_allauth_user("test@test.com")
        self.assertEqual(user.email, "test@test.com")

    def test_destroy_user(self):
        pass

class UserprofSelenium(StaticLiveServerTestCase):
    
    client = Client()

    @classmethod
    def setUpClass(cls):
        super(UserprofSelenium, cls).setUpClass()
        cls.selenium = WebDriver()


    @classmethod
    def tearDownClass(cls):
        cls.selenium.quit()
        super(UserprofSelenium, cls).tearDownClass()


    def test_1_sign_up(self):
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        login = self.selenium.find_element_by_link_text("Login")
        login.click()
        sign_up = self.selenium.find_element_by_link_text("Sign Up")
        sign_up.click()
        username = self.selenium.find_element_by_id("id_username")
        email = self.selenium.find_element_by_id("id_email")
        pass1 = self.selenium.find_element_by_id("id_password1")
        pass2 = self.selenium.find_element_by_id("id_password2")
        submit = self.selenium.find_element_by_xpath("//button")
        username.send_keys("testuser")
        email.send_keys("test@test.com")
        pass1.send_keys("testpass")
        pass2.send_keys("testpass")
        submit.click()
        nav_bar_link = self.selenium.find_element_by_link_text("testuser")
        self.assertEqual("testuser", nav_bar_link.text)

    def test_2_sign_out(self):
        self.test_1_sign_up()
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        logout = self.selenium.find_element_by_link_text("Logout")
        logout.click()
        sign_out = self.selenium.find_element_by_link_text("Sign Out")
        sign_out.click()
        self.assertTrue(len(self.selenium.find_elements_by_link_text("testuser")) == 0 )

    def test_3_profile_messages(self):
        self.test_1_sign_up()
        self.selenium.get("{}{}".format(self.live_server_url, '/home/'))
        prof = self.selenium.find_element_by_link_text("testuser")
        prof.click()


    def login(self):
        username = 'testuser'
        password = 'testpass'
        User = get_user_model()
        user = User.objects.create_user(username, password=password)
        logged_in = self.client.login(username=username, password=password)
        self.assertTrue(logged_in)