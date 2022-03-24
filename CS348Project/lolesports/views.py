from django.shortcuts import render


from django.http import HttpResponse


def home(request):
    return render(request, 'index.html')

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
    
def playerName(request, playerName):
    return HttpResponse(f'The player is {playerName}')

def match(request):
    return render(request, 'match.html')

def teamName(request, teamName):
    return HttpResponse(f'The team is {teamName}')
