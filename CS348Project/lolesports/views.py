from django.shortcuts import render
import logging
from .models import Match, Champion, Team, Player, PickBan
from django.db.models import Q, Max
from .forms import DateTimeForm, MatchForm, DeleteConfirmForm
from django.db import connection
from django.db.models import Func, F

from .forms import PlayerSearchForm, ChampSearchForm, MatchSearchForm

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

def matchSearch(request):
    match_list = Match.objects.none()
    if request.method == 'POST':
        form = MatchSearchForm(request.POST)
        if form.is_valid():
            data = form.clean()
            if data.get('include_upcoming'):
                match_list = Match.objects.all()
            else:
                match_list = Match.objects.all().exclude(outcome__isnull=True)
            match_list = match_list.annotate(killdiff=Func(F('team1_kills') - F('team2_kills'), function='ABS'))
            match_list = match_list.annotate(golddiff=Func(F('team1_gold') - F('team2_gold'), function='ABS'))
            teams = data.get('teams').split(',')
            for team in teams:
                if team != '':
                    match_list = match_list.filter(Q(team1_name=team) | Q(team2_name=team))
            if data.get('winner') != '':
                match_list = match_list.filter(outcome=data.get('winner'))
            if data.get('min_date_field') is not None:
                dt = datetime.datetime.combine(data.get('min_date_field'), data.get('min_time_field'))
                match_list = match_list.filter(match_date__gte=dt)
            if data.get('max_date_field') is not None:
                dt = datetime.datetime.combine(data.get('max_date_field'), data.get('max_time_field'))
                match_list = match_list.filter(match_date__lte=dt)
            if data.get('min_kill_diff') is not None:
                match_list = match_list.filter(killdiff__gte=data.get('min_kill_diff'))
            if data.get('max_kill_diff') is not None:
                match_list = match_list.filter(killdiff__lte=data.get('max_kill_diff'))
            if data.get('min_gold_diff') is not None:
                match_list = match_list.filter(golddiff__gte=data.get('min_gold_diff'))
            if data.get('max_gold_diff') is not None:
                match_list = match_list.filter(golddiff__lte=data.get('max_gold_diff'))
            if data.get('min_match_time') != '':
                match_list = match_list.filter(match_length__gte=data.get('min_match_time'))
            if data.get('max_match_time') != '':
                match_list = match_list.filter(match_length__lte=data.get('max_match_time'))
            if data.get('mvp') != '':
                match_list = match_list.filter(mvp=data.get('mvp'))
            if data.get('patch') is not None:
                match_list = match_list.filter(patch=data.get('patch'))
            if data.get('picked_champions') != '' or data.get('banned_champions') != '' or data.get('winning_champions') != '':
                match_ids = match_list.values_list('match_id', flat=True)
                match_ids = list(match_ids)
                pick_bans = PickBan.objects.all().filter(match_id__in=match_ids)
                if data.get('picked_champions') != '':
                    champs = data.get('picked_champions').split(',')
                    pick_bans_picks = pick_bans.filter(pick_or_ban='pick')
                    for champ in champs:
                        if champ != '':
                            pick_bans_picks = pick_bans_picks.filter(Q(champion1=champ) | Q(champion2=champ)
                                                                     | Q(champion3=champ) | Q(champion4=champ)
                                                                     | Q(champion5=champ))
                    match_ids = pick_bans_picks.values_list('match_id', flat=True).distinct()
                    match_ids = list(match_ids)
                    match_list = Match.objects.all().filter(match_id__in=match_ids)
                    pick_bans = PickBan.objects.all().filter(match_id__in=match_ids)
                if data.get('banned_champions') != '':
                    champs = data.get('banned_champions').split(',')
                    pick_bans_bans = pick_bans.filter(pick_or_ban='ban')
                    for champ in champs:
                        if champ != '':
                            pick_bans_bans = pick_bans_bans.filter(Q(champion1=champ) | Q(champion2=champ)
                                                                     | Q(champion3=champ) | Q(champion4=champ)
                                                                     | Q(champion5=champ))
                    match_ids = pick_bans_bans.values_list('match_id', flat=True).distinct()
                    match_ids = list(match_ids)
                    match_list = Match.objects.all().filter(match_id__in=match_ids)
                    pick_bans = PickBan.objects.all().filter(match_id__in=match_ids)
                if data.get('winning_champions') != '':
                    champs = data.get('winning_champions').split(',')
                    winning_teams = match_list.values_list('outcome', flat=True)
                    winning_teams = list(winning_teams)
                    pick_bans_winners = pick_bans.filter(pick_or_ban='pick', team_name__in=winning_teams)
                    for champ in champs:
                        if champ != '':
                            pick_bans_winners = pick_bans_winners.filter(Q(champion1=champ) | Q(champion2=champ)
                                                                       | Q(champion3=champ) | Q(champion4=champ)
                                                                       | Q(champion5=champ))
                    match_ids = pick_bans_winners.values_list('match_id', flat=True).distinct()
                    match_ids = list(match_ids)
                    match_list = Match.objects.all().filter(match_id__in=match_ids)
        return render(request, 'match_search.html', {'match_list': match_list, 'form': form})
    else:
        form = MatchSearchForm()
        return render(request, 'match_search.html', {'match_list': match_list, 'form': form})

def playerSearch(request):
    countries = Player.objects.values('country').distinct().order_by('country')
    roles = Player.objects.values('role').distinct().order_by('role')
    playerList = Player.objects.all()
    if request.method == 'POST':
        form = PlayerSearchForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            player_country = request.POST['player_country']
            if player_country != '0':
                playerList = playerList.filter(country=player_country)
            player_role = request.POST['player_role']
            if player_role != '0':
                playerList = playerList.filter(role=player_role)
            if data.get('min_salary') is not None:
                playerList = playerList.filter(salary__gte=data.get('min_salary'))
            if data.get('max_salary') is not None:
                playerList = playerList.filter(salary__lte=data.get('max_salary'))
            if data.get('min_KDA') is not None:
                playerList = playerList.filter(kda_avg__gte=data.get('min_KDA'))
            if data.get('max_KDA') is not None:
                playerList = playerList.filter(kda_avg__lte=data.get('max_KDA'))
            if data.get('min_CS_per_Min') is not None:
                playerList = playerList.filter(cs_avg__gte=data.get('min_CS_per_Min'))
            if data.get('max_CS_per_Min') is not None:
                playerList = playerList.filter(cs_avg__lte=data.get('max_CS_per_Min'))
            if data.get('min_mvp_count') is not None:
                playerList = playerList.filter(mvp_count__gte=data.get('min_mvp_count'))
            if data.get('max_mvp_count') is not None:
                playerList = playerList.filter(mvp_count__lte=data.get('max_mvp_count'))
        else:
            messages.success(request, 'Invalid form input!')
        return render(request, 'player_search.html', {'playerList': playerList, 'countries': countries, 'roles': roles, 'form': form})
    else:
        form = PlayerSearchForm()
        playerList = Player.objects.none()
        return render(request, 'player_search.html', {'playerList': playerList, 'countries': countries, 'roles': roles, 'form': form})

def champSearch(request):
    if request.method == 'POST':
        champList = Champion.objects.all()
        form = ChampSearchForm(request.POST)
        if form.is_valid():
            data = form.cleaned_data
            if data.get('min_pick_rate') is not None:
                champList = champList.filter(pick_rate__gte=data.get('min_pick_rate'))
            if data.get('max_pick_rate') is not None:
                champList = champList.filter(pick_rate__lte=data.get('max_pick_rate'))
            if data.get('min_ban_rate') is not None:
                champList = champList.filter(ban_rate__gte=data.get('min_ban_rate'))
            if data.get('max_ban_rate') is not None:
                champList = champList.filter(ban_rate__lte=data.get('max_ban_rate'))
            if data.get('min_win_rate') is not None:
                champList = champList.filter(win_rate__gte=data.get('min_win_rate'))
            if data.get('max_win_rate') is not None:
                champList = champList.filter(win_rate__lte=data.get('max_win_rate'))
        else:
            messages.success(request, 'Invalid form input!')
        return render(request, 'champ_search.html', {'champList': champList, 'form': form})
    else:
        form = ChampSearchForm()
        champList = Champion.objects.none()
        return render(request, 'champ_search.html', {'champList': champList, 'form': form})

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

def advancedSearch(request):
    return render(request, 'advanced_search.html')