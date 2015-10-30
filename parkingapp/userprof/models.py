from django.db import models
from django.dispatch import receiver
from django.contrib.gis.db import models
from allauth.account.signals import user_signed_up
from django.contrib.auth.models import User
from localflavor.us.forms import USPhoneNumberField



class AdminUser(models.Model):
  registered = models.BooleanField(default=False)


class ExtendedUser(models.Model):
  main_user = models.OneToOneField(User, primary_key=True)
  admin_user = models.ForeignKey(AdminUser, null=True, blank=True)
  phone_number = USPhoneNumberField()

  def __str__(self):
    return self.main_user.username


@receiver(user_signed_up)
def do_stuff_after_sign_up(sender, **kwargs):
  try:
    user = kwargs['user']
    new_user = ExtendedUser.objects.create(main_user=user)
    new_user.save()
    user.save()
  except KeyError:
    pass
