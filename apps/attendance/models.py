from django.db import models

from apps.people.models import PlayerTeam, TeamCoach
from apps.teams.models import Team


class TrainingSessionType(models.Model):
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "training_session_types"

    def __str__(self):
        return self.description


class AttendanceStatus(models.Model):
    code = models.CharField(max_length=50)
    description = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "attendance_statuses"

    def __str__(self):
        return self.description


class TrainingSession(models.Model):
    team = models.ForeignKey(
        Team,
        on_delete=models.CASCADE,
        related_name="training_sessions",
    )
    training_session_type = models.ForeignKey(
        TrainingSessionType,
        on_delete=models.CASCADE,
        related_name="training_sessions",
    )
    session_date = models.DateField()
    start_time = models.TimeField(blank=True, null=True)
    end_time = models.TimeField(blank=True, null=True)
    location = models.CharField(max_length=150, blank=True, null=True)
    description = models.CharField(max_length=250, blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "training_sessions"

    def __str__(self):
        return f"{self.team} - {self.session_date}"


class AttendanceRecord(models.Model):
    player_team = models.ForeignKey(
        PlayerTeam,
        on_delete=models.CASCADE,
        related_name="attendance_records",
    )
    training_session = models.ForeignKey(
        TrainingSession,
        on_delete=models.CASCADE,
        related_name="attendance_records",
    )
    attendance_status = models.ForeignKey(
        AttendanceStatus,
        on_delete=models.CASCADE,
        related_name="attendance_records",
    )
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "attendance_records"

    def __str__(self):
        return f"{self.player_team} - {self.training_session} - {self.attendance_status}"


class StaffAttendanceRecord(models.Model):
    team_coach = models.ForeignKey(
        TeamCoach,
        on_delete=models.CASCADE,
        related_name="staff_attendance_records",
    )
    training_session = models.ForeignKey(
        TrainingSession,
        on_delete=models.CASCADE,
        related_name="staff_attendance_records",
    )
    attendance_status = models.ForeignKey(
        AttendanceStatus,
        on_delete=models.CASCADE,
        related_name="staff_attendance_records",
    )
    notes = models.TextField(blank=True, null=True)
    created_by = models.CharField(max_length=100, blank=True, null=True)
    updated_by = models.CharField(max_length=100, blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        db_table = "staff_attendance_records"

    def __str__(self):
        return f"{self.team_coach} - {self.training_session} - {self.attendance_status}"