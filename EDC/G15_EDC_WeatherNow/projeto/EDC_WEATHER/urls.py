"""EDC_WEATHER URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from app import views
from django.urls import include

urlpatterns = [
	path('', views.index, name='index'),
    path('index/', views.index, name='index'),
    path('admin/', admin.site.urls, name='admin'),
    path('forecast_city/', views.forecast_city, name='forecast_city'),
    path('day/', views.day_card, name='weathercard'),
    path('waves/', views.waves_card, name='ondulacao'),
    path('favoritos/', views.favoritos, name='favoritos'),
    path('addComent/', views.addComent, name='addComent'),

    path('accounts/', include('django.contrib.auth.urls')),
    path('register/', views.signup, name='signup'),
    path('myaccount/', views.myaccount, name='conta'),
    path('submit_edit/', views.submitEmail, name='submit'),
    path('add_favorite/', views.add_favorite_citie, name='add_favorite'),
    path('remove_city/', views.remove_favorite_cities, name='remove_city')
]
