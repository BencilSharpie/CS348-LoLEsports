from django import forms
# from django.core.validators import EMPTY_VALUES
from .models import Match, Champion, Team, Player, PickBan

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
    match_time = forms.RegexField(regex="[0-9][0-9]:[0-9][0-9]:[0-9][0-9]", help_text='ex. 00:12:04')
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

class MatchSearchForm(forms.Form):
    teams = forms.CharField(required=False, help_text='Delimit with \",\" ex. team1,team2')
    winner = forms.CharField(required=False)
    min_date_field = forms.DateField(required=False, widget=DatePickerInput)
    min_time_field = forms.TimeField(required=False, widget=TimePickerInput)
    max_date_field = forms.DateField(required=False, widget=DatePickerInput)
    max_time_field = forms.TimeField(required=False, widget=TimePickerInput)
    min_kill_diff = forms.IntegerField(required=False)
    max_kill_diff = forms.IntegerField(required=False)
    min_gold_diff = forms.IntegerField(required=False)
    max_gold_diff = forms.IntegerField(required=False)
    min_match_time = forms.RegexField(regex="[0-9][0-9]:[0-9][0-9]:[0-9][0-9]", help_text='ex. 00:12:04', required=False)
    max_match_time = forms.RegexField(regex="[0-9][0-9]:[0-9][0-9]:[0-9][0-9]", help_text='ex. 00:12:04', required=False)
    mvp = forms.CharField(required=False)
    patch = forms.DecimalField(required=False)
    picked_champions = forms.CharField(required=False, help_text='Delimit with \",\" ex. champ1,champ2,champ3')
    banned_champions = forms.CharField(required=False, help_text='Delimit with \",\" ex. champ1,champ2,champ3')
    winning_champions = forms.CharField(required=False, help_text='Delimit with \",\" ex. champ1,champ2,champ3')
    include_upcoming = forms.BooleanField(required=False)

    def clean(self):
        min_date_field = self.cleaned_data.get('min_date_field')
        min_time_field = self.cleaned_data.get('min_time_field')
        if min_date_field is not None or min_time_field is not None:
            if min_date_field is None or min_time_field is None:
                if min_date_field is None:
                    self._errors['min_time_field'] = self.error_class(['Times must include a corresponding date!'])
                else:
                    self._errors['min_date_field'] = self.error_class(['If you search by date, you must include a time!'])
        max_date_field = self.cleaned_data.get('max_date_field')
        max_time_field = self.cleaned_data.get('max_time_field')
        if max_date_field is not None or max_time_field is not None:
            if max_date_field is None or max_time_field is None:
                if max_date_field is None:
                    self._errors['max_time_field'] = self.error_class(['Times must include a corresponding date!'])
                else:
                    self._errors['max_date_field'] = self.error_class(['If you search by date, you must include a time!'])
        return self.cleaned_data



class PlayerSearchForm(forms.Form):
    min_salary = forms.IntegerField(required=False)
    max_salary = forms.IntegerField(required=False)
    min_KDA = forms.DecimalField(required=False)
    max_KDA = forms.DecimalField(required=False)
    min_CS_per_Min = forms.DecimalField(required=False)
    max_CS_per_Min = forms.DecimalField(required=False)
    min_mvp_count = forms.IntegerField(required=False)
    max_mvp_count = forms.IntegerField(required=False)

class ChampSearchForm(forms.Form):
    min_pick_rate = forms.DecimalField(required=False)
    max_pick_rate = forms.DecimalField(required=False)
    min_ban_rate = forms.DecimalField(required=False)
    max_ban_rate = forms.DecimalField(required=False)
    min_win_rate = forms.DecimalField(required=False)
    max_win_rate = forms.DecimalField(required=False)

class DeleteConfirmForm(forms.Form):
    match_id = forms.IntegerField()