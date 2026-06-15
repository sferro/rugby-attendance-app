from django.db import models

from apps.people.models import PlayerPosition, PlayerTeam
from apps.teams.models import Squad, Team


class MatchType(models.Model):
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "match_types"

    def __str__(self):
        return self.description


class Match(models.Model):
    HOME = "home"
    AWAY = "away"
    NEUTRAL = "neutral"

    HOME_AWAY_CHOICES = [
        (HOME, "Local"),
        (AWAY, "Visitante"),
        (NEUTRAL, "Neutral"),
    ]

    team = models.ForeignKey(
        Team,
        on_delete=models.CASCADE,
        related_name="matches",
    )
    squad = models.ForeignKey(
        Squad,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="matches",
    )
    match_type = models.ForeignKey(
        MatchType,
        on_delete=models.CASCADE,
        related_name="matches",
    )
    match_date = models.DateField()
    opponent_name = models.CharField(max_length=100)
    location = models.CharField(max_length=150, blank=True, null=True)
    home_away = models.CharField(
        max_length=20,
        choices=HOME_AWAY_CHOICES,
        blank=True,
        null=True,
    )
    score_for = models.IntegerField(blank=True, null=True)
    score_against = models.IntegerField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "matches"

    def __str__(self):
        squad_label = self.squad.description if self.squad else self.team.name
        return f"{squad_label} vs {self.opponent_name} - {self.match_date}"


class MatchPlayerRecord(models.Model):
    match = models.ForeignKey(
        Match,
        on_delete=models.CASCADE,
        related_name="player_records",
    )
    player_team = models.ForeignKey(
        PlayerTeam,
        on_delete=models.CASCADE,
        related_name="match_player_records",
    )
    player_position = models.ForeignKey(
        PlayerPosition,
        on_delete=models.SET_NULL,
        blank=True,
        null=True,
        related_name="match_player_records",
    )
    starter = models.BooleanField(default=False)
    captain = models.BooleanField(default=False)
    minutes_played = models.IntegerField(blank=True, null=True)
    jersey_number = models.IntegerField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "match_player_records"

    def __str__(self):
        return f"{self.player_team} - {self.match}"