from django.contrib import admin

from .models import Match, MatchPlayerRecord, MatchType


@admin.register(MatchType)
class MatchTypeAdmin(admin.ModelAdmin):
    list_display = ("description", "code", "active")
    search_fields = ("description", "code")
    list_filter = ("active",)


@admin.register(Match)
class MatchAdmin(admin.ModelAdmin):
    list_display = (
        "match_date",
        "squad",
        "opponent_name",
        "home_away",
        "score_for",
        "score_against",
    )
    search_fields = (
        "opponent_name",
        "location",
    )
    list_filter = (
        "team",
        "squad",
        "match_type",
        "match_date",
        "home_away",
    )


@admin.register(MatchPlayerRecord)
class MatchPlayerRecordAdmin(admin.ModelAdmin):
    list_display = (
        "match",
        "player_team",
        "player_position",
        "starter",
        "captain",
        "jersey_number",
    )
    search_fields = (
        "player_team__player__first_name",
        "player_team__player__last_name",
        "match__opponent_name",
    )
    list_filter = (
        "match",
        "player_position",
        "starter",
        "captain",
    )