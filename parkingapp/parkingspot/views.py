from django.shortcuts import render, redirect
from django.shortcuts import render_to_response
from parkingspot.models import ParkingSpot

# Create your views here.
def home(request):
    context = { 'parkingspots' : ParkingSpot.objects.all() }
    return render(request, 'base.html', context)
