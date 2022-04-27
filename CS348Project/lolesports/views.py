from django.shortcuts import render
import logging
from .models import Match, Champion, Team, Player
from django.db.models import Q, Max
from .forms import DateTimeForm, MatchForm
from django.db import connection

from django.http import HttpResponse
from django.contrib import messages
import datetime

def home(request):
    top5Matches = Match.objects.exclude(outcome__isnull=True).values_list('team1_name', 'team2_name',
                                                                          'outcome', 'team1_kills', 'team2_kills',
                                                                          'mvp').order_by('match_date')[:5]
    return render(request, 'index.html', {'top5Matches': top5Matches})


def schedule(request):
    if request.method == 'POST':

        # create a form instance and populate it with data from the request:
        form = DateTimeForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            data = form.cleaned_data
            dt = datetime.datetime.combine(data.get('date_field'), data.get('time_field'))
            cursor = connection.cursor()
            args = [dt, data.get('team1_name'), data.get('team2_name'), 0]
            cursor.callproc('insertBlankMatch', args)
            cursor.execute('SELECT @_insertBlankMatch_3')
            result = cursor.fetchall()
            response = result[0][0]
            cursor.close()
            if response == -1 or response == -2:
                messages.success(request, 'Invalid team name selection!')
            elif response == -3:
                messages.success(request, 'Match time conflict!')

        schedule_list = Match.objects.all().exclude(outcome__isnull=False)
    else:
        schedule_list = Match.objects.all().exclude(outcome__isnull=False)
        form = DateTimeForm()
    return render(request, 'schedule.html', {'form': form, 'scheduleList': schedule_list})


def team(request):
    teamList = Team.objects.all()
    return render(request, 'team.html', {'teamList': teamList})


def player(request):
    playerList = Player.objects.all()
    return render(request, 'player.html', {'playerList': playerList})


def match(request):
    matchList = Match.objects.all().exclude(outcome__isnull=True)
    return render(request, 'match.html', {'matchList' : matchList})

def playerName(request, playerName):
    # playerName = {
    #    "name": playerName
    # }
    playerInfo = Player.objects.filter(ign=playerName)
    return render(request, 'player_page.html', {'playerInfo': playerInfo})

def teamName(request, teamName):
    #teamName = {
    #    "name": teamName
    #}
    teamInfo = Team.objects.filter(team_name=teamName)
    logging.basicConfig(level=logging.INFO) # Here
    logging.info(teamInfo)
    teamPlayers = Player.objects.filter(team=teamName)
    teamMatches= Match.objects.filter(Q(team1_name = teamName) | Q(team2_name = teamName)).exclude(outcome__isnull=True)
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

def matchEdit(request, matchID):
    match = Match.objects.filter(match_id=matchID)
    if request.method == 'POST':
        form = MatchForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            cursor = connection.cursor()
            args = [match[0].match_id, data.get('winner_field'), data.get('team1_kills'), data.get('team2_kills'),
                    data.get('team1_gold'), data.get('team2_gold'), data.get('match_time'), data.get('match_mvp'),
                    data.get('match_patch'), data.get('team1_ban1'), data.get('team1_ban2'), data.get('team1_ban3'),
                    data.get('team1_ban4'), data.get('team1_ban5'), data.get('team2_ban1'), data.get('team2_ban2'),
                    data.get('team2_ban3'), data.get('team2_ban4'), data.get('team2_ban5'), data.get('team1_pick1'),
                    data.get('team1_pick2'), data.get('team1_pick3'), data.get('team1_pick4'), data.get('team1_pick5'),
                    data.get('team2_pick1'), data.get('team2_pick2'), data.get('team2_pick3'), data.get('team2_pick4'),
                    data.get('team2_pick5'), 0]
            cursor.callproc('updateMatchInfo', args)
            cursor.execute('SELECT @_updateMatchInfo_29')
            result = cursor.fetchall()
            response = result[0][0]
            cursor.close()
            if response == -1:
                messages.success(request, 'Invalid match ID, this entry may have been deleted!')
            elif response == -2:
                messages.success(request, 'Invalid MVP name!')
            elif response == -3:
                messages.success(request, 'The name of the winner is invalid!')
            elif response == -4:
                messages.success(request, 'The winner is not one of the participating teams!')
            else:
                matchList = Match.objects.all().exclude(outcome__isnull=True)
                return render(request, 'match.html', {'matchList' : matchList})
            return render(request, 'match_edit.html', {'form': form, 'match': match[0]})
        else:
            return render(request, 'match_edit.html', {'form': form, 'match': match[0]})
    else:
        form = MatchForm()
        return render(request, 'match_edit.html', {'form': form, 'match': match[0]})