from django.shortcuts import render
from .models import Match, Champion

from django.http import HttpResponse


def home(request):
    top5Matches = Match.objects.exclude(outcome__isnull=True).values_list('team1_name', 'team2_name',
                                                                          'outcome', 'team1_kills', 'team2_kills',
                                                                          'mvp').order_by('match_date')[:5]
    return render(request, 'index.html', {'top5Matches': top5Matches})


def schedule(request):
    return render(request, 'schedule.html')


def team(request):
    teams = {
        #hit the database here? get the list of teams, pass in?
        "data" : ["Cloud9", "TSM", "Team_Liquid", "EG"],
    }
    return render(request, 'team.html', teams)


def player(request):
    return render(request, 'player.html')


def match(request):
    return render(request, 'match.html')

def playerName(request, playerName):
    return HttpResponse(f'The player is {playerName}')

def teamName(request, teamName):
    teamName = {
        "name": teamName
    }
    return render(request, 'team_page.html', teamName)

def champion(request):
    order_by = request.GET.get('order_by', '-win_rate')
    champs = Champion.objects.all().order_by(order_by)
    return render(request, 'champ.html', {'champs': champs})
