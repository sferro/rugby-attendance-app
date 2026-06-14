from django.contrib import admin

from .models import (
    Coach,
    CoachRole,
    Player,
    PlayerPosition,
    PlayerTeam,
    TeamCoach,
)


@admin.register(Player)
class PlayerAdmin(admin.ModelAdmin):
    list_display = (
        "last_name",
        "first_name",
        "document_number",
        "active",
    )

    search_fields = (
        "first_name",
        "last_name",
        "document_number",
    )

    list_filter = ("active",)


@admin.register(Coach)
class CoachAdmin(admin.ModelAdmin):
    list_display = (
        "last_name",
        "first_name",
        "email",
        "active",
    )

    search_fields = (
        "first_name",
        "last_name",
        "email",
    )

    list_filter = ("active",)


@admin.register(PlayerPosition)
class PlayerPositionAdmin(admin.ModelAdmin):
    list_display = (
        "player_position_number",
        "description",
        "position_group",
        "position_sub_group",
        "active",
    )

    search_fields = (
        "code",
        "description",
    )

    list_filter = (
        "position_group",
        "position_sub_group",
        "active",
    )


@admin.register(CoachRole)
class CoachRoleAdmin(admin.ModelAdmin):
    list_display = (
        "description",
        "code",
        "active",
    )

    search_fields = (
        "description",
        "code",
    )

    list_filter = ("active",)


@admin.register(PlayerTeam)
class PlayerTeamAdmin(admin.ModelAdmin):
    list_display = (
        "player",
        "team",
        "primary_position",
        "alternative_position",
        "active",
    )

    search_fields = (
        "player__first_name",
        "player__last_name",
        "team__name",
    )

    list_filter = (
        "team",
        "active",
    )


@admin.register(TeamCoach)
class TeamCoachAdmin(admin.ModelAdmin):
    list_display = (
        "coach",
        "team",
        "coach_role",
        "priority",
        "active",
    )

    search_fields = (
        "coach__first_name",
        "coach__last_name",
        "team__name",
    )

    list_filter = (
        "coach_role",
        "team",
        "active",
    )