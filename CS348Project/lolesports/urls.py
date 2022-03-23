from django.urls import path
from . import views
urlpatterns = [
    path('', views.home),
    path('schedule', views.schedule),
    path('team', views.team),
    path('player', views.player),
    path('match', views.match),
    path('champion', views.champion),
]