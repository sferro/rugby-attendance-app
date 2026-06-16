from django.urls import path

from apps.attendance import views

app_name = "attendance"

urlpatterns = [
    path(
        "",
        views.attendance_home,
        name="attendance_home",
    ),
    path(
        "session/<int:session_id>/load/",
        views.load_attendance,
        name="load_attendance",
    ),
    path(
        "session/<int:session_id>/player/<int:player_team_id>/record/<int:status_id>/",
        views.record_player_attendance,
        name="record_player_attendance",
    ),
    path(
        "session/<int:session_id>/staff/<int:team_coach_id>/record/<int:status_id>/",
        views.record_staff_attendance,
        name="record_staff_attendance",
    ),
    path(
        "session/create/",
        views.create_training_session,
        name="create_training_session",
    ),
    path(
        "session/<int:session_id>/review/",
        views.attendance_review,
        name="attendance_review",
    ),    
    path(
        "session/<int:session_id>/player-record/<int:record_id>/update/<int:status_id>/",
        views.update_player_attendance,
        name="update_player_attendance",
    ),
]