"""parkingapp URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add an import:  from blog import urls as blog_urls
    2. Add a URL to urlpatterns:  url(r'^blog/', include(blog_urls))
"""
from django.conf import settings
from django.conf.urls import include, url
from django.contrib import admin
from django.conf.urls.static import static

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/', include('allauth.urls')),
    url(r'^search/', 'parkingspot.views.search'),
   #url(r'^test/', 'parkingspot.views.test'),
    url(r'^home/', 'parkingspot.views.home'),
    url(r'^$', 'parkingspot.views.home'),
    url(r'^detail/', 'parkingspot.views.detail'),
    url(r'^about/', 'parkingspot.views.about'),
    url(r'^contact/', 'parkingspot.views.contact'),
    url(r'^reserve/', 'parkingspot.views.reserve_request'),
    url(r'^add_spot/', 'parkingspot.views.newspot'),
    url(r'^edit_spot/', 'parkingspot.views.spotmodify'),
    url(r'^profile/', 'userprof.views.profile'),
    url(r'^finalize_reservation/', 'parkingspot.views.finalize_reserve'),
    url(r'^add_review/', 'parkingspot.views.AddReview')
]

if settings.DEBUG:
    urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
