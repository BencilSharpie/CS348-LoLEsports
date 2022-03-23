from django.shortcuts import render
from .models import Match

from django.http import HttpResponse

def home(request):
    top5Matches = Match.objects.exclude(outcome__isnull=True).values_list('team1_name', 'team2_name', 'outcome',
                                                                          'team1_kills', 'team2_kills', 'mvp').order_by('match_date')[:5]
    return render(request, 'index.html', {'top5Matches': top5Matches})

def schedule(request):
    return render(request, 'schedule.html')

def team(request):
    return render(request, 'team.html')

def player(request):
    return render(request, 'player.html')

def match(request):
    return render(request, 'match.html')
