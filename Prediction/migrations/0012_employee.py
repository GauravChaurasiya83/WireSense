# Generated by Django 5.1.3 on 2024-12-10 18:14

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Prediction', '0011_alter_prediction_ccw_level_val0'),
    ]

    operations = [
        migrations.CreateModel(
            name='Employee',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('employee_id', models.CharField(max_length=50, unique=True)),
                ('password', models.CharField(max_length=255)),
            ],
        ),
    ]
