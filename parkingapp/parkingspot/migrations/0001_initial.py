# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import django.contrib.postgres.fields
import django.contrib.gis.db.models.fields


class Migration(migrations.Migration):

    dependencies = [
        ('userprof', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='ParkingSpot',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('street_address', models.CharField(max_length=80, blank=True)),
                ('city', models.CharField(max_length=30, blank=True)),
                ('state', models.CharField(max_length=2, blank=True)),
                ('zipcode', models.IntegerField(blank=True)),
                ('location', django.contrib.gis.db.models.fields.PointField(srid=4326, null=True, blank=True)),
                ('description', models.CharField(max_length=256)),
                ('amenities', django.contrib.postgres.fields.ArrayField(size=7, null=True, base_field=models.CharField(max_length=80, blank=True), blank=True)),
                ('photos', models.ImageField(default=b'/media//default.png', upload_to=b'')),
                ('reviews', django.contrib.postgres.fields.ArrayField(size=None, null=True, base_field=models.CharField(max_length=80, blank=True), blank=True)),
                ('owner', models.ForeignKey(to='userprof.AdminUser')),
            ],
        ),
    ]
