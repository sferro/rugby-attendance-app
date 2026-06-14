from django.contrib import admin
from .models import Club, Season


@admin.register(Club)
class ClubAdmin(admin.ModelAdmin):
    list_display = ("name", "short_name", "active")
    search_fields = ("name", "short_name")
    list_filter = ("active",)


@admin.register(Season)
class SeasonAdmin(admin.ModelAdmin):
    list_display = ("year", "description", "active")
    search_fields = ("description",)
    list_filter = ("active",)