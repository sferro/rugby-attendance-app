WITH player_attendance AS (
    SELECT
        pt.id AS player_team_id,
        ast.code AS attendance_status,
        ROW_NUMBER() OVER (
            PARTITION BY pt.id
            ORDER BY ts.session_date DESC
        ) AS attendance_rank
    FROM attendance_records ar
    JOIN attendance_statuses ast ON ast.id = ar.attendance_status_id
    JOIN training_sessions ts ON ts.id = ar.training_session_id
    JOIN player_teams pt ON pt.id = ar.player_team_id
    JOIN teams t ON t.id = pt.team_id
    JOIN seasons s ON s.id = t.season_id
    WHERE t.name = 'M13'
      AND s.year = 2026
),
attendance_summary AS (
    SELECT
        player_team_id,
        ROUND(100.0 * SUM(CASE WHEN attendance_status = 'present' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS attendance_percentage,
        ROUND(100.0 * SUM(CASE WHEN attendance_rank <= 4 AND attendance_status = 'present' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN attendance_rank <= 4 THEN 1 ELSE 0 END), 0), 2) AS last_4_attendance_percentage,
        ROUND(100.0 * SUM(CASE WHEN attendance_rank <= 2 AND attendance_status = 'present' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN attendance_rank <= 2 THEN 1 ELSE 0 END), 0), 2) AS last_2_attendance_percentage
    FROM player_attendance
    GROUP BY player_team_id
),
latest_level AS (
    SELECT player_team_id, level_score
    FROM (
        SELECT
            player_team_id,
            level_score,
            ROW_NUMBER() OVER (
                PARTITION BY player_team_id
                ORDER BY evaluation_date DESC, id DESC
            ) AS rn
        FROM player_level_evaluations
    ) x
    WHERE rn = 1
)
SELECT
    p.first_name || ' ' || p.last_name AS player_name,
    pp.description AS primary_position,
    ap.description AS alternative_position,
    ll.level_score,
    a.attendance_percentage,
    a.last_4_attendance_percentage,
    a.last_2_attendance_percentage,
    ROUND(
        COALESCE(a.attendance_percentage, 0) * 0.4
        + COALESCE(a.last_4_attendance_percentage, 0) * 0.6,
        2
    ) AS availability_score
FROM player_teams pt
JOIN players p ON p.id = pt.player_id
JOIN teams t ON t.id = pt.team_id
JOIN seasons s ON s.id = t.season_id
LEFT JOIN player_positions pp ON pp.id = pt.primary_position_id
LEFT JOIN player_positions ap ON ap.id = pt.alternative_position_id
LEFT JOIN attendance_summary a ON a.player_team_id = pt.id
LEFT JOIN latest_level ll ON ll.player_team_id = pt.id
WHERE t.name = 'M13'
  AND s.year = 2026
ORDER BY availability_score DESC, ll.level_score DESC, p.last_name;