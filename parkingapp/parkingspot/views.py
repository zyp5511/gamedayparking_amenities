from django.shortcuts import render
from django.shortcuts import render_to_response

# Create your views here.

def home(request):
  array = ['My', 'name', 'is', 'matt']
  return render(request, "index.html", {'message':'hi!!', 'array': array})