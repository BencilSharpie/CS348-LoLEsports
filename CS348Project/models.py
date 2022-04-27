# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class AuthGroup(models.Model):
    name = models.CharField(unique=True, max_length=150)

    class Meta:
        managed = False
        db_table = 'auth_group'


class AuthGroupPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)
    permission = models.ForeignKey('AuthPermission', models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_group_permissions'
        unique_together = (('group', 'permission'),)


class AuthPermission(models.Model):
    name = models.CharField(max_length=255)
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING)
    codename = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'auth_permission'
        unique_together = (('content_type', 'codename'),)


class AuthUser(models.Model):
    password = models.CharField(max_length=128)
    last_login = models.DateTimeField(blank=True, null=True)
    is_superuser = models.IntegerField()
    username = models.CharField(unique=True, max_length=150)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    email = models.CharField(max_length=254)
    is_staff = models.IntegerField()
    is_active = models.IntegerField()
    date_joined = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'auth_user'


class AuthUserGroups(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    group = models.ForeignKey(AuthGroup, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_groups'
        unique_together = (('user', 'group'),)


class AuthUserUserPermissions(models.Model):
    id = models.BigAutoField(primary_key=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)
    permission = models.ForeignKey(AuthPermission, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'auth_user_user_permissions'
        unique_together = (('user', 'permission'),)


class Champion(models.Model):
    name = models.CharField(primary_key=True, max_length=64)
    pick_rate = models.DecimalField(max_digits=8, decimal_places=5, blank=True, null=True)
    ban_rate = models.DecimalField(max_digits=8, decimal_places=5, blank=True, null=True)
    win_rate = models.DecimalField(max_digits=8, decimal_places=5, blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'champion'


class DjangoAdminLog(models.Model):
    action_time = models.DateTimeField()
    object_id = models.TextField(blank=True, null=True)
    object_repr = models.CharField(max_length=200)
    action_flag = models.PositiveSmallIntegerField()
    change_message = models.TextField()
    content_type = models.ForeignKey('DjangoContentType', models.DO_NOTHING, blank=True, null=True)
    user = models.ForeignKey(AuthUser, models.DO_NOTHING)

    class Meta:
        managed = False
        db_table = 'django_admin_log'


class DjangoContentType(models.Model):
    app_label = models.CharField(max_length=100)
    model = models.CharField(max_length=100)

    class Meta:
        managed = False
        db_table = 'django_content_type'
        unique_together = (('app_label', 'model'),)


class DjangoMigrations(models.Model):
    id = models.BigAutoField(primary_key=True)
    app = models.CharField(max_length=255)
    name = models.CharField(max_length=255)
    applied = models.DateTimeField()

    class Meta:
        managed = False
        db_table = 'django_migrations'


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
        managed = False
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
        managed = False
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
        managed = False
        db_table = 'player'


class Team(models.Model):
    team_name = models.CharField(primary_key=True, max_length=64)
    num_win = models.IntegerField(blank=True, null=True)
    num_loss = models.IntegerField(blank=True, null=True)
    lcs_rank = models.IntegerField(blank=True, null=True)

    class Meta:
        managed = False
        db_table = 'team'
