from django import forms
from review.models import Review


class ReviewSubmit(forms.ModelForm):

  class Meta:
    model = ParkingSpot
    exclude = ['location', 'amenities', 'parking_spot_avail', 'owner']