from django.db import models
from apps.clubs.models import Club, Season


class Team(models.Model):
    club = models.ForeignKey(
        Club,
        on_delete=models.CASCADE,
        related_name="teams",
    )
    season = models.ForeignKey(
        Season,
        on_delete=models.CASCADE,
        related_name="teams",
    )
    name = models.CharField(max_length=50)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "teams"

    def __str__(self):
        return f"{self.name} - {self.season.year}"


class Squad(models.Model):
    team = models.ForeignKey(
        Team,
        on_delete=models.CASCADE,
        related_name="squads",
    )
    code = models.CharField(max_length=20)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "squads"

    def __str__(self):
        return self.description