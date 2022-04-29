from django.shortcuts import render
import logging
from .models import Match, Champion, Team, Player, PickBan
from django.db.models import Q, Max
from .forms import DateTimeForm, MatchForm, DeleteConfirmForm
from django.db import connection

from .forms import TeamsForm

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


def customTeam(request):
    teamList = Team.objects.all()
    print("test1")
    # if this is a POST request we need to process the form data
    logging.debug("test")
    if request.method == 'POST':
        # create a form instance and populate it with data from the request:
        logging.basicConfig(level=logging.INFO)
        logging.info("test")
        print("request is post")
        form = TeamsForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            data = form.cleaned_data
            context = {
                "minKDA": data.get('min_KDA'),
                "maxKDA": data.get('max_KDA'),
                "minSalary": data.get('min_salary'),
                "maxSalary": data.get('max_salary')
            }
            print("data is valid")
            print(data.get('min_kda'))
            # redirect to a new URL:
            return render(request, 'customTeamResult.html', {"context": context})
    # if a GET (or any other method) we'll create a blank form
    else:
        form = TeamsForm()
    return render(request, 'customTeam.html', {'teamList': teamList, 'form': form})

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
    playerInfo = Player.objects.filter(ign=playerName)
    if playerInfo.count() == 0:
        messages.success(request, 'Invalid player name, this entry may have been deleted!')
        matchList = Match.objects.all().exclude(outcome__isnull=True)
        return render(request, 'match.html', {'matchList' : matchList})
    return render(request, 'player_page.html', {'playerInfo': playerInfo})

def teamName(request, teamName):
    teamInfo = Team.objects.filter(team_name=teamName)
    if teamInfo.count() == 0:
        messages.success(request, 'Invalid team name, this entry may have been deleted!')
        matchList = Match.objects.all().exclude(outcome__isnull=True)
        return render(request, 'match.html', {'matchList' : matchList})
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
    if match.count() == 0:
        messages.success(request, 'Invalid match ID, this entry may have been deleted!')
        matchList = Match.objects.all().exclude(outcome__isnull=True)
        return render(request, 'match.html', {'matchList' : matchList})
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
        if ( match[0].outcome is None ):
            form = MatchForm()
        else:
            t1bans = PickBan.objects.filter(match__match_id=matchID, team_name=match[0].team1_name, pick_or_ban='ban')
            t2bans = PickBan.objects.filter(match__match_id=matchID, team_name=match[0].team2_name, pick_or_ban='ban')
            t1picks = PickBan.objects.filter(match__match_id=matchID, team_name=match[0].team1_name, pick_or_ban='pick')
            t2picks = PickBan.objects.filter(match__match_id=matchID, team_name=match[0].team2_name, pick_or_ban='pick')
            form = MatchForm({'winner_field': match[0].outcome, 'team1_kills': match[0].team1_kills,
                              'team2_kills': match[0].team2_kills, 'team1_gold': match[0].team1_gold, 'team2_gold': match[0].team2_gold,
                              'match_time': match[0].match_length, 'match_mvp': match[0].mvp, 'match_patch': match[0].patch,
                              'team1_ban1': t1bans[0].champion1, 'team1_ban2': t1bans[0].champion2, 'team1_ban3': t1bans[0].champion3,
                              'team1_ban4': t1bans[0].champion4, 'team1_ban5': t1bans[0].champion5, 'team2_ban1': t2bans[0].champion1,
                              'team2_ban2': t2bans[0].champion2, 'team2_ban3': t2bans[0].champion3, 'team2_ban4': t2bans[0].champion4,
                              'team2_ban5': t2bans[0].champion5, 'team1_pick1': t1picks[0].champion1, 'team1_pick2': t1picks[0].champion2,
                              'team1_pick3': t1picks[0].champion3, 'team1_pick4': t1picks[0].champion4, 'team1_pick5': t1picks[0].champion5,
                              'team2_pick1': t2picks[0].champion1, 'team2_pick2': t2picks[0].champion2, 'team2_pick3': t2picks[0].champion3,
                              'team2_pick4': t2picks[0].champion4, 'team2_pick5': t2picks[0].champion5})

        return render(request, 'match_edit.html', {'form': form, 'match': match[0]})

def deleteMatch(request, matchID):
    match = Match.objects.filter(match_id=matchID)
    if match.count() == 0:
        messages.success(request, 'Invalid match ID, this entry may have been deleted!')
        matchList = Match.objects.all().exclude(outcome__isnull=True)
        return render(request, 'match.html', {'matchList' : matchList})
    if request.method == 'POST':
        form = DeleteConfirmForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            data = form.cleaned_data
            if data.get('match_id') != int(matchID):
                messages.success(request, 'The entered match ID is incorrect, please try again!')
            else:
                cursor = connection.cursor()
                args = [data.get('match_id'), 0]
                cursor.callproc('deleteMatch', args)
                cursor.execute('SELECT @_insertBlankMatch_1')
                result = cursor.fetchall()
                response = result[0][0]
                cursor.close()
                if response == -1:
                    messages.success(request, 'Invalid match ID, this entry may have already been deleted!')
                else:
                    matchList = Match.objects.all().exclude(outcome__isnull=True)
                    return render(request, 'match.html', {'matchList' : matchList})
        return render(request, 'delete_match.html', {'form': form, 'match': match[0]})
    else:
        form = DeleteConfirmForm()
        return render(request, 'delete_match.html', {'form': form, 'match': match[0]})

def rescheduleMatch(request, matchID):
    match = Match.objects.filter(match_id=matchID)
    if match.count() == 0:
        messages.success(request, 'Invalid match ID, this entry may have been deleted!')
        matchList = Match.objects.all().exclude(outcome__isnull=True)
        return render(request, 'match.html', {'matchList' : matchList})
    if match[0].outcome is not None:
        messages.success(request, 'Completed matches cannot be rescheduled!')
        schedule_list = Match.objects.all().exclude(outcome__isnull=False)
        form = DateTimeForm()
        return render(request, 'schedule.html', {'form': form, 'scheduleList': schedule_list})
    else:
        if request.method == 'POST':
            form = DateTimeForm(request.POST)
            if form.is_valid():
                data = form.cleaned_data
                dt = datetime.datetime.combine(data.get('date_field'), data.get('time_field'))
                cursor = connection.cursor()
                args = [match[0].match_id, dt, data.get('team1_name'), data.get('team2_name'), 0]
                cursor.callproc('rescheduleMatch', args)
                cursor.execute('SELECT @_rescheduleMatch_4')
                result = cursor.fetchall()
                response = result[0][0]
                cursor.close()
                if response == -1:
                    messages.success(request, 'Invalid match ID, this entry may have already been deleted!')
                elif response == -2:
                    messages.success(request, 'Completed matches cannot be rescheduled!')
                elif response == -3 or response == -4:
                    messages.success(request, 'Invalid team name selection!')
                elif response == -5:
                    messages.success(request, 'Match time conflict!')
                else:
                    form = DateTimeForm()
                    schedule_list = Match.objects.all().exclude(outcome__isnull=False)
                    return render(request, 'schedule.html', {'form': form, 'scheduleList': schedule_list})
                return render(request, 'reschedule_match.html', {'form': form, 'match': match[0]})

        else:
            dt = match[0].match_date
            print( dt )
            form = DateTimeForm({'date_field': dt.date(), 'time_field': dt.time(), 'team1_name': match[0].team1_name,
                 'team2_name': match[0].team2_name})
            return render(request, 'reschedule_match.html', {'form': form, 'match': match[0]})