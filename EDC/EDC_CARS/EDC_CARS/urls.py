from django.contrib import admin
from django.urls import path
from app import views

urlpatterns = [
    path('', views.main, name='main'),
    path('car', views.car, name='car'),
    path('add_car', views.add_car, name='add_car'),
    path('submit_car', views.submit_car, name='submit_car'),

    path('edit_car', views.edit_car, name='edit_car'),
    path('submit_edit_car', views.submit_edit_car, name='submit_edit_car'),

    path('brands', views.brands, name='brands'),
    path('brandDetail/<str:name>', views.brandDetail, name='brandDetail'),


    path('load_cars', views.load_cars, name='load_cars'),
    path('load_cars_inference', views.load_cars_inference, name='load_cars_inference'),
]
