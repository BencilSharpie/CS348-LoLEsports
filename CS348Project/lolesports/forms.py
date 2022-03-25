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
