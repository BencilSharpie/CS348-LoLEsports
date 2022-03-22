from django.shortcuts import render


from django.http import HttpResponse


def home(request):
    return render(request, 'index.html')

def schedule(request):
    return render(request, 'schedule.html')

def team(request):
    return render(request, 'team.html')

def player(request):
    return render(request, 'player.html')

def match(request):
    return render(request, 'match.html')
