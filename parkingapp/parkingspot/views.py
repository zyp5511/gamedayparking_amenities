from django.core import serializers
from django.shortcuts import render, redirect
from django.shortcuts import render_to_response
from parkingspot.models import ParkingSpot

# Create your views here.
def home(request):
    parkingspots = ParkingSpot.objects.all()
    json_parkingspots = serializers.serialize("json", parkingspots)
    context = {
        'parkingspots' : parkingspots,
        'json_parkingspots' : json_parkingspots
    }
    return render(request, 'base.html', context)
