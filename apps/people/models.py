from django.db import models

from apps.teams.models import Team


class Player(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    birth_date = models.DateField(blank=True, null=True)
    document_number = models.CharField(max_length=50, blank=True, null=True)
    email = models.EmailField(max_length=150, blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "players"

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class Coach(models.Model):
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    birth_date = models.DateField(blank=True, null=True)
    document_number = models.CharField(max_length=50, blank=True, null=True)
    email = models.EmailField(max_length=150, blank=True, null=True)
    phone = models.CharField(max_length=50, blank=True, null=True)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "coaches"

    def __str__(self):
        return f"{self.first_name} {self.last_name}"


class PlayerPosition(models.Model):
    player_position_number = models.IntegerField(blank=True, null=True)
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    position_group = models.CharField(max_length=30)
    position_sub_group = models.CharField(max_length=50)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "player_positions"

    def __str__(self):
        return self.description


class CoachRole(models.Model):
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "coach_roles"

    def __str__(self):
        return self.description


class PlayerTeam(models.Model):
    player = models.ForeignKey(
        Player,
        on_delete=models.CASCADE,
        related_name="player_teams",
    )
    team = models.ForeignKey(
        Team,
        on_delete=models.CASCADE,
        related_name="player_teams",
    )
    primary_position = models.ForeignKey(
        PlayerPosition,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="primary_player_teams",
    )
    alternative_position = models.ForeignKey(
        PlayerPosition,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="alternative_player_teams",
    )
    active = models.BooleanField(default=True)
    joined_at = models.DateField(blank=True, null=True)
    left_at = models.DateField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "player_teams"

    def __str__(self):
        return f"{self.player} - {self.team}"


class TeamCoach(models.Model):
    team = models.ForeignKey(
        Team,
        on_delete=models.CASCADE,
        related_name="team_coaches",
    )
    coach = models.ForeignKey(
        Coach,
        on_delete=models.CASCADE,
        related_name="team_coaches",
    )
    coach_role = models.ForeignKey(
        CoachRole,
        on_delete=models.CASCADE,
        related_name="team_coaches",
    )
    priority = models.IntegerField(default=1)
    active = models.BooleanField(default=True)
    joined_at = models.DateField(blank=True, null=True)
    left_at = models.DateField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "team_coaches"

    def __str__(self):
        return f"{self.coach} - {self.team} - {self.coach_role}"