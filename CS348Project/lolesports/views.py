from django.shortcuts import render
import logging
from .models import Match, Champion, Team, Player
from django.db.models import Q

from django.http import HttpResponse


def home(request):
    top5Matches = Match.objects.exclude(outcome__isnull=True).values_list('team1_name', 'team2_name',
                                                                          'outcome', 'team1_kills', 'team2_kills',
                                                                          'mvp').order_by('match_date')[:5]
    return render(request, 'index.html', {'top5Matches': top5Matches})


def schedule(request):
    return render(request, 'schedule.html')


def team(request):
    teamList = Team.objects.all()
    return render(request, 'team.html', {'teamList': teamList})


def player(request):
    return render(request, 'player.html')


def match(request):
    return render(request, 'match.html')

def playerName(request, playerName):
    return HttpResponse(f'The player is {playerName}')

def teamName(request, teamName):
    #teamName = {
    #    "name": teamName
    #}
    teamInfo = Team.objects.filter(team_name=teamName)
    logging.basicConfig(level=logging.INFO) # Here
    logging.info(teamInfo)
    teamPlayers = Player.objects.filter(team=teamName)
    teamMatches= Match.objects.filter(Q(team1_name = teamName) | Q(team2_name = teamName))
    teamPassInfo = {
        'teamInfo': teamInfo,
        'teamPlayers': teamPlayers,
        'teamMatches': teamMatches
    }
    
    return render(request, 'team_page.html', teamPassInfo)

def champion(request):
    order_by = request.GET.get('order_by', '-win_rate')
    champs = Champion.objects.all().order_by(order_by)
    return render(request, 'champ.html', {'champs': champs})
