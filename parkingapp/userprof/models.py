from django.db import models

# Create your models here.
class AdminUser(models.Model):
  name = models.CharField(max_length = 80)