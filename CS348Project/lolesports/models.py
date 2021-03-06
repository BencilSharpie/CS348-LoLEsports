# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
# via https://docs.djangoproject.com/en/4.0/howto/legacy-databases/
from django.db import models


class Champion(models.Model):
    name = models.CharField(primary_key=True, max_length=64)
    pick_rate = models.DecimalField(max_digits=8, decimal_places=5, blank=True, null=True)
    ban_rate = models.DecimalField(max_digits=8, decimal_places=5, blank=True, null=True)
    win_rate = models.DecimalField(max_digits=8, decimal_places=5, blank=True, null=True)

    class Meta:
        db_table = 'champion'


class Match(models.Model):
    match_id = models.IntegerField(primary_key=True)
    match_date = models.DateTimeField(blank=True, null=True)
    team1_name = models.CharField(max_length=64, blank=True, null=True)
    team2_name = models.CharField(max_length=64, blank=True, null=True)
    outcome = models.CharField(max_length=64, blank=True, null=True)
    team1_kills = models.IntegerField(blank=True, null=True)
    team2_kills = models.IntegerField(blank=True, null=True)
    team1_gold = models.IntegerField(blank=True, null=True)
    team2_gold = models.IntegerField(blank=True, null=True)
    match_length = models.CharField(max_length=64, blank=True, null=True)
    mvp = models.CharField(max_length=64, blank=True, null=True)
    patch = models.DecimalField(max_digits=3, decimal_places=1, blank=True, null=True)

    class Meta:
        db_table = 'match'


class PickBan(models.Model):
    match = models.OneToOneField(Match, models.DO_NOTHING, primary_key=True)
    team_name = models.CharField(max_length=64)
    pick_or_ban = models.CharField(max_length=64)
    champion1 = models.CharField(max_length=64, blank=True, null=True)
    champion2 = models.CharField(max_length=64, blank=True, null=True)
    champion3 = models.CharField(max_length=64, blank=True, null=True)
    champion4 = models.CharField(max_length=64, blank=True, null=True)
    champion5 = models.CharField(max_length=64, blank=True, null=True)

    class Meta:
        db_table = 'pick_ban'
        unique_together = (('match', 'team_name', 'pick_or_ban'),)


class Player(models.Model):
    ign = models.CharField(primary_key=True, max_length=64)
    name = models.CharField(max_length=64, blank=True, null=True)
    country = models.CharField(max_length=64, blank=True, null=True)
    role = models.CharField(max_length=7, blank=True, null=True)
    kda_avg = models.DecimalField(max_digits=2, decimal_places=1, blank=True, null=True)
    cs_avg = models.DecimalField(max_digits=2, decimal_places=1, blank=True, null=True)
    salary = models.DecimalField(max_digits=7, decimal_places=2, blank=True, null=True)
    team = models.CharField(max_length=64, blank=True, null=True)
    mvp_count = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'player'


class Team(models.Model):
    team_name = models.CharField(primary_key=True, max_length=64)
    num_win = models.IntegerField(blank=True, null=True)
    num_loss = models.IntegerField(blank=True, null=True)
    lcs_rank = models.IntegerField(blank=True, null=True)

    class Meta:
        db_table = 'team'
