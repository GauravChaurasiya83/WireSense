from Prediction.views import *
from django.contrib import admin
from django.urls import path
from django.urls import path


urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/predict/', predictProp),
    path('api/reverse_predict/', reverse_predict_api),
    path('api/predict_with_inputs/', predict_with_inputs_api),
    path('api/employee_login/', employee_login),    
    path('api/manual_predict/', manual_prediction),
    path('api/suggestion_api/', suggestion_api),
    
]