from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required
from review.models import Review
from message.models import ResMessage


@login_required
def submit_review(request):
  if request.method == 'POST':
    value = request.POST.get("review")
    res_msg = ResMessage.objects.get(id=value)
    reviewer = request.user
    headline = request.POST['headline']
    review_text = request.POST['review_text']
    rating = request.POST['rating']
    rev = Review.objects.create(reviewer=reviewer, headline=headline, review_text=review_text, rating=rating, parkingspot=res_msg.parkingspot)
    res_msg.reviewed = rev
    res_msg.save()
    request.session['message'] = 'Review Added Successfully'
    request.session['message_type'] = True
    return redirect('/reservations')


