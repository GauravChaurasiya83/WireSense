# Generated by Django 5.1.3 on 2024-12-11 11:48

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('Prediction', '0014_prediction_percent_al_prediction_percent_cu_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='prediction',
            name='Percent_CU',
        ),
        migrations.RemoveField(
            model_name='prediction',
            name='Percent_MN',
        ),
    ]
