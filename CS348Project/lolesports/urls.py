from django.urls import path
from . import views
urlpatterns = [
    path('', views.home),
    path('advanced_search', views.advancedSearch),
    path('schedule', views.schedule),
    path('team', views.team),
    path('player', views.player),
    path('match', views.match),
    path('champion', views.champion),
    path('team/<teamName>', views.teamName, name='teamName'),
    # path('customPlayer', views.customPlayer, name='customPlayer'),
    path('customTeam', views.customTeam),
    path('customTeamResult', views.customTeam),
    path('player_search', views.playerSearch),
    path('champion_search', views.champSearch),
    path('player/<playerName>', views.playerName, name='playerName'),
    path('match/edit/<matchID>', views.matchEdit, name='matchID'),
    path('delete/<matchID>', views.deleteMatch, name='matchID'),
    path('reschedule/<matchID>', views.rescheduleMatch, name='matchID')

]