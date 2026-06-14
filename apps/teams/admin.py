from django.contrib import admin
from .models import Team, Squad


@admin.register(Team)
class TeamAdmin(admin.ModelAdmin):
    list_display = ("name", "club", "season", "active")
    search_fields = ("name", "club__name")
    list_filter = ("season", "active")


@admin.register(Squad)
class SquadAdmin(admin.ModelAdmin):
    list_display = ("description", "code", "team", "active")
    search_fields = ("description", "code", "team__name")
    list_filter = ("team", "active")