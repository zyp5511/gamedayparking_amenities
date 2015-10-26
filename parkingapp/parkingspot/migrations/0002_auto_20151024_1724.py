# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('parkingspot', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='parkingspot',
            name='street_address',
            field=models.CharField(max_length=70, blank=True),
        ),
    ]
