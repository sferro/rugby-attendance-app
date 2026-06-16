from django.views.decorators.http import require_POST
from django.shortcuts import get_object_or_404, redirect, render
from datetime import timedelta
from django.utils import timezone
from apps.teams.models import Team

from apps.attendance.models import (
    AttendanceRecord,
    AttendanceStatus,
    StaffAttendanceRecord,
    TrainingSession,
    TrainingSessionType,
)

from apps.people.models import PlayerTeam, TeamCoach

def attendance_home(request):
    latest_session = TrainingSession.objects.select_related(
        "team",
        "training_session_type",
    ).order_by(
        "-session_date",
        "-id",
    ).first()

    if latest_session:
        total_players = PlayerTeam.objects.filter(
            team=latest_session.team,
        ).count()

        completed_players = AttendanceRecord.objects.filter(
            training_session=latest_session,
        ).count()

        total_staff = TeamCoach.objects.filter(
            team=latest_session.team,
        ).count()

        completed_staff = StaffAttendanceRecord.objects.filter(
            training_session=latest_session,
        ).count()

        if completed_players < total_players or completed_staff < total_staff:
            return redirect(
                "attendance:load_attendance",
                session_id=latest_session.id,
            )

    player_summary = {
        "present": 0,
        "absent": 0,
        "injured": 0,
        "sick": 0,
    }

    staff_summary = {
        "present": 0,
        "absent": 0,
    }

    if latest_session:
        player_summary["present"] = AttendanceRecord.objects.filter(
            training_session=latest_session,
            attendance_status__code="present",
        ).count()

        player_summary["absent"] = AttendanceRecord.objects.filter(
            training_session=latest_session,
            attendance_status__code="absent",
        ).count()

        player_summary["injured"] = AttendanceRecord.objects.filter(
            training_session=latest_session,
            attendance_status__code="injured",
        ).count()

        player_summary["sick"] = AttendanceRecord.objects.filter(
            training_session=latest_session,
            attendance_status__code="sick",
        ).count()

        staff_summary["present"] = StaffAttendanceRecord.objects.filter(
            training_session=latest_session,
            attendance_status__code="present",
        ).count()

        staff_summary["absent"] = StaffAttendanceRecord.objects.filter(
            training_session=latest_session,
            attendance_status__code="absent",
        ).count()

    context = {
        "latest_session": latest_session,
        "player_summary": player_summary,
        "staff_summary": staff_summary,
    }

    return render(
        request,
        "attendance/home.html",
        context,
    )

def load_attendance(request, session_id):
    training_session = get_object_or_404(
        TrainingSession,
        id=session_id,
    )

    players_with_record = AttendanceRecord.objects.filter(
        training_session=training_session,
    ).values_list("player_team_id", flat=True)

    pending_players = PlayerTeam.objects.filter(
        team=training_session.team,
    ).exclude(
        id__in=players_with_record,
    ).select_related(
        "player",
        "primary_position",
        "alternative_position",
    ).order_by(
        "player__last_name",
        "player__first_name",
    )

    staff_with_record = StaffAttendanceRecord.objects.filter(
        training_session=training_session,
    ).values_list("team_coach_id", flat=True)

    pending_staff = TeamCoach.objects.filter(
        team=training_session.team,
    ).exclude(
        id__in=staff_with_record,
    ).select_related(
        "coach",
        "coach_role",
    ).order_by(
        "coach__last_name",
        "coach__first_name",
    )
    
    total_players = PlayerTeam.objects.filter(
        team=training_session.team,
    ).count()

    completed_players = AttendanceRecord.objects.filter(
        training_session=training_session,
    ).count()

    pending_players_count = pending_players.count()

    total_staff = TeamCoach.objects.filter(
        team=training_session.team,
    ).count()

    completed_staff = StaffAttendanceRecord.objects.filter(
        training_session=training_session,
    ).count()

    pending_staff_count = pending_staff.count()

    context = {
        "training_session": training_session,
        "pending_players": pending_players,
        "pending_staff": pending_staff,
        "total_players": total_players,
        "completed_players": completed_players,
        "pending_players_count": pending_players_count,
        "total_staff": total_staff,
        "completed_staff": completed_staff,
        "pending_staff_count": pending_staff_count,
    }

    return render(
        request,
        "attendance/load_attendance.html",
        context,
    )

def create_training_session(request):
    team = get_current_team(request)

    if request.method == "POST":
        date_offset = int(request.POST.get("date_offset", 0))
        session_type_code = request.POST.get("session_type", "training")

        session_date = timezone.localdate() + timedelta(days=date_offset)

        session_type = get_object_or_404(
            TrainingSessionType,
            code=session_type_code,
        )

        training_session, created = TrainingSession.objects.get_or_create(
            team=team,
            training_session_type=session_type,
            session_date=session_date,
            defaults={
                "description": session_type.description,
                "created_by": "web",
            },
        )

        return redirect(
            "attendance:load_attendance",
            session_id=training_session.id,
        )

    context = {
        "team": team,
    }

    return render(
        request,
        "attendance/create_training_session.html",
        context,
    )

def get_current_team(request):
    return get_object_or_404(
        Team,
        name="M13",
    )

def attendance_review(request, session_id):
    training_session = get_object_or_404(
        TrainingSession,
        id=session_id,
    )

    present_records = AttendanceRecord.objects.filter(
        training_session=training_session,
        attendance_status__code="present",
    ).select_related(
        "player_team__player",
    )

    absent_records = AttendanceRecord.objects.filter(
        training_session=training_session,
        attendance_status__code="absent",
    ).select_related(
        "player_team__player",
    )

    injured_records = AttendanceRecord.objects.filter(
        training_session=training_session,
        attendance_status__code="injured",
    ).select_related(
        "player_team__player",
    )

    sick_records = AttendanceRecord.objects.filter(
        training_session=training_session,
        attendance_status__code="sick",
    ).select_related(
        "player_team__player",
    ).order_by(
        "attendance_status__description",
        "player_team__player__last_name",
        "player_team__player__first_name",
    )

    context = {
        "training_session": training_session,
        "present_records": present_records,
        "absent_records": absent_records,
        "injured_records": injured_records,
        "sick_records": sick_records,
    }

    return render(
        request,
        "attendance/review.html",
        context,
    )

@require_POST
def update_player_attendance(request, session_id, record_id, status_id):
    training_session = get_object_or_404(
        TrainingSession,
        id=session_id,
    )

    record = get_object_or_404(
        AttendanceRecord,
        id=record_id,
        training_session=training_session,
    )

    attendance_status = get_object_or_404(
        AttendanceStatus,
        id=status_id,
    )

    record.attendance_status = attendance_status
    record.updated_by = "web"
    record.save()

    return redirect(
        "attendance:attendance_review",
        session_id=training_session.id,
    )

@require_POST
def record_player_attendance(request, session_id, player_team_id, status_id):
    training_session = get_object_or_404(
        TrainingSession,
        id=session_id,
    )

    player_team = get_object_or_404(
        PlayerTeam,
        id=player_team_id,
        team=training_session.team,
    )

    attendance_status = get_object_or_404(
        AttendanceStatus,
        id=status_id,
    )

    AttendanceRecord.objects.update_or_create(
        player_team=player_team,
        training_session=training_session,
        defaults={
            "attendance_status": attendance_status,
            "updated_by": "web",
        },
    )

    return redirect(
        "attendance:load_attendance",
        session_id=training_session.id,
    )

@require_POST
def record_staff_attendance(request, session_id, team_coach_id, status_id):
    training_session = get_object_or_404(
        TrainingSession,
        id=session_id,
    )

    team_coach = get_object_or_404(
        TeamCoach,
        id=team_coach_id,
        team=training_session.team,
    )

    attendance_status = get_object_or_404(
        AttendanceStatus,
        id=status_id,
    )

    StaffAttendanceRecord.objects.update_or_create(
        team_coach=team_coach,
        training_session=training_session,
        defaults={
            "attendance_status": attendance_status,
            "updated_by": "web",
        },
    )

    return redirect(
        "attendance:load_attendance",
        session_id=training_session.id,
    )