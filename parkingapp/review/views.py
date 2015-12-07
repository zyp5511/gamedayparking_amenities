from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from review.models import Review
from message.models import ResMessage


@login_required
def submit_review(request):
  if request.method == 'POST':
    value = request.POST['reviewButton']
    res_msg = ResMessage.objects.get(id=value)
    reviewer = request.user
    headline = request.POST['reviewTitle']
    review_text = request.POST['reviewmessage']
    rating = request.POST['ratingSelector']
    rev = Review.objects.create(reviewer=reviewer, headline=headline, review_text=review_text, rating=rating, parkingspot=res_msg.parkingspot)
    res_msg.reviewed = rev
    res_msg.save()
    request.session['message'] = 'Review Added Successfully'
    request.session['message_type'] = True
    return redirect('/profile')


