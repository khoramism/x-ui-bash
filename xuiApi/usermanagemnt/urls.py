from django.urls import  path

from . import views
urlpatterns = [
    path('geturi/',views.geturi,name='geturi'),

]