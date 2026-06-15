from django.contrib import admin

from .models import (
    AttendanceRecord,
    AttendanceStatus,
    StaffAttendanceRecord,
    TrainingSession,
    TrainingSessionType,
)


@admin.register(TrainingSessionType)
class TrainingSessionTypeAdmin(admin.ModelAdmin):
    list_display = ("description", "code", "active")
    search_fields = ("description", "code")
    list_filter = ("active",)


@admin.register(AttendanceStatus)
class AttendanceStatusAdmin(admin.ModelAdmin):
    list_display = ("description", "code", "active")
    search_fields = ("description", "code")
    list_filter = ("active",)


@admin.register(TrainingSession)
class TrainingSessionAdmin(admin.ModelAdmin):
    list_display = (
        "team",
        "training_session_type",
        "session_date",
        "location",
    )
    search_fields = (
        "team__name",
        "description",
        "location",
    )
    list_filter = (
        "team",
        "training_session_type",
        "session_date",
    )


@admin.register(AttendanceRecord)
class AttendanceRecordAdmin(admin.ModelAdmin):
    list_display = (
        "player_team",
        "training_session",
        "attendance_status",
    )
    search_fields = (
        "player_team__player__first_name",
        "player_team__player__last_name",
    )
    list_filter = (
        "attendance_status",
        "training_session__team",
        "training_session__session_date",
    )


@admin.register(StaffAttendanceRecord)
class StaffAttendanceRecordAdmin(admin.ModelAdmin):
    list_display = (
        "team_coach",
        "training_session",
        "attendance_status",
    )
    search_fields = (
        "team_coach__coach__first_name",
        "team_coach__coach__last_name",
    )
    list_filter = (
        "attendance_status",
        "training_session__team",
        "training_session__session_date",
    )