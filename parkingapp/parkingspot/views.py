from django.shortcuts import render, redirect
from django.shortcuts import render_to_response

# Create your views here.

def home(request):
  array = ['My', 'name', 'is', 'matt']
  return redirect('accounts/login/')