from django.conf.urls import include, url
from django.contrib import admin

urlpatterns = [
    url(r'^adminprofile/', 'userprof.views.admin_page'),
    url(r'^profile/', 'userprof.views.profile'),
    url(r'^$', 'userprof.views.profile'),

]