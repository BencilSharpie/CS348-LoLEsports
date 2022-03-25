from django.db import models
# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Champion(models.Model):
    name = models.TextField(primary_key=True)  # This field type is a guess.
    pick_rate = models.FloatField(blank=True, null=True)  # This field type is a guess.
    ban_rate = models.FloatField(blank=True, null=True)  # This field type is a guess.
    win_rate = models.FloatField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        db_table = 'champion'


class Match(models.Model):
    match_id = models.IntegerField(primary_key=True)
    match_date = models.TextField(blank=True, null=True)
    team1_name = models.TextField(blank=True, null=True)  # This field type is a guess.
    team2_name = models.TextField(blank=True, null=True)  # This field type is a guess.
    outcome = models.TextField(blank=True, null=True)  # This field type is a guess.
    team1_kills = models.IntegerField(blank=True, null=True)
    team2_kills = models.IntegerField(blank=True, null=True)
    team1_gold = models.IntegerField(blank=True, null=True)
    team2_gold = models.IntegerField(blank=True, null=True)
    match_length = models.TimeField(blank=True, null=True)
    mvp = models.TextField(blank=True, null=True)  # This field type is a guess.
    patch = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        db_table = 'match'


class PickBan(models.Model):
    match = models.ForeignKey(Match, on_delete=models.CASCADE)
    team_name = models.TextField(blank=True, null=True)  # This field type is a guess.
    pick_or_ban = models.TextField(blank=True, null=True)  # This field type is a guess.
    champion1 = models.TextField(blank=True, null=True)  # This field type is a guess.
    champion2 = models.TextField(blank=True, null=True)  # This field type is a guess.
    champion3 = models.TextField(blank=True, null=True)  # This field type is a guess.
    champion4 = models.TextField(blank=True, null=True)  # This field type is a guess.
    champion5 = models.TextField(blank=True, null=True)  # This field type is a guess.

    class Meta:
        db_table = 'pick_ban'


class Player(models.Model):
    ign = models.TextField(primary_key=True)
    name = models.TextField(blank=True, null=True)  # This field type is a guess.
    country = models.TextField(blank=True, null=True)  # This field type is a guess.
    role = models.TextField(blank=True, null=True)
    kda_avg = models.FloatField(blank=True, null=True)  # This field type is a guess.
    cs_avg = models.FloatField(blank=True, null=True)  # This field type is a guess.
    salary = models.FloatField(blank=True, null=True)  # This field type is a guess.
    team = models.TextField(blank=True, null=True)
    mvp_count = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'player'


class Team(models.Model):
    team_name = models.TextField(primary_key=True)  # This field type is a guess.
    num_win = models.IntegerField(blank=True, null=True)
    num_loss = models.IntegerField(blank=True, null=True)
    lcs_rank = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'team'

