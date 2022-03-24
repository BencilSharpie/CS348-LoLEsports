from django.urls import path
from . import views
urlpatterns = [
    path('', views.home, name='home'),
    path('schedule', views.schedule, name='schedule'),
    path('team', views.team, name='team'),
    path('player', views.player, name='player'),
    path('match', views.match, name='match'),
    path('team/<teamName>', views.teamName, name='teamName'),
    path('player/<playerName>', views.playerName, name='playerName'),
]