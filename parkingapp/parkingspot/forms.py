from django import forms
from parkingspot.models import ParkingSpot


class ParkingSpotEdit(forms.ModelForm):

  class Meta:
    model = ParkingSpot
    exclude = ['location', 'amenities', 'parking_spot_avail', 'owner']
class ImageUploadForm(forms.Form):
    """Image upload form."""
    image = forms.ImageField()

class ParkingSpotAdd(forms.ModelForm):
  class Meta:
    model = ParkingSpot
    exclude = ['location', 'amenities', 'parking_spot_avail', 'owner']
class ImageUploadForm(forms.Form):
    """Image upload form."""
    image = forms.ImageField()
