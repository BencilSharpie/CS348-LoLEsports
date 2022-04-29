from django import forms

class DatePickerInput(forms.DateInput):
    input_type = 'date'

class TimePickerInput(forms.TimeInput):
    input_type = 'time'

class DateTimeForm(forms.Form):
    date_field = forms.DateField(widget=DatePickerInput)
    time_field = forms.TimeField(widget=TimePickerInput)
    team1_name = forms.CharField()
    team2_name = forms.CharField()

class MatchForm(forms.Form):
    winner_field = forms.CharField()
    team1_kills = forms.IntegerField()
    team2_kills = forms.IntegerField()
    team1_gold = forms.IntegerField()
    team2_gold = forms.IntegerField()
    match_time = forms.RegexField(regex = "[0-9][0-9]:[0-9][0-9]:[0-9][0-9]")
    match_mvp = forms.CharField()
    match_patch = forms.DecimalField()
    team1_ban1 = forms.CharField()
    team1_ban2 = forms.CharField()
    team1_ban3 = forms.CharField()
    team1_ban4 = forms.CharField()
    team1_ban5 = forms.CharField()
    team2_ban1 = forms.CharField()
    team2_ban2 = forms.CharField()
    team2_ban3 = forms.CharField()
    team2_ban4 = forms.CharField()
    team2_ban5 = forms.CharField()
    team1_pick1 = forms.CharField()
    team1_pick2 = forms.CharField()
    team1_pick3 = forms.CharField()
    team1_pick4 = forms.CharField()
    team1_pick5 = forms.CharField()
    team2_pick1 = forms.CharField()
    team2_pick2 = forms.CharField()
    team2_pick3 = forms.CharField()
    team2_pick4 = forms.CharField()
    team2_pick5 = forms.CharField()

class TeamsForm(forms.Form):
    min_salary = forms.IntegerField(required=False)
    max_salary = forms.IntegerField(required=False)
    min_KDA = forms.IntegerField(required=False)
    max_KDA = forms.IntegerField(required=False)

class DeleteConfirmForm(forms.Form):
    match_id = forms.IntegerField()