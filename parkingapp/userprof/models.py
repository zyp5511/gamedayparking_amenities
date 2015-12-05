from django.db import models
from django.dispatch import receiver
from django.contrib.gis.db import models
from allauth.account.signals import user_signed_up
from django.contrib.auth.models import User
from django.contrib.postgres.fields import ArrayField
from localflavor.us.forms import USPhoneNumberField


class ExtendedUser(models.Model):
  main_user = models.OneToOneField(User, primary_key=True)
  phone_number = USPhoneNumberField()
  stripe_id = models.CharField(default=None, max_length=255, blank=True, null=True)
  def __str__(self):
    return self.main_user.username


class AdminUser(models.Model):
  registered = models.BooleanField(default=False)
  extended_user = models.OneToOneField(ExtendedUser, primary_key=True)

  def __str__(self):
    return self.extended_user.main_user.username

  def get_allauth_user(self):
    return self.extended_user.main_user

@receiver(user_signed_up)
def do_stuff_after_sign_up(sender, **kwargs):
  try:
    kwargs['sociallogin']
    request = kwargs['request']
    user = kwargs['user']
    new_user = ExtendedUser.objects.create(main_user=user)
    new_user.save()
    user.save()
  except KeyError:
    try:
      user = kwargs['user']
      new_user = ExtendedUser.objects.create(main_user=user)
      new_user.save()
      user.save()
    except KeyError:
      pass 
