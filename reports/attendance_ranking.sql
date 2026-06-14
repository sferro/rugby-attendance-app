SELECT
    p.first_name || ' ' || p.last_name AS player_name,
    SUM(CASE WHEN ast.code = 'present' THEN 1 ELSE 0 END) AS present_count,
    SUM(CASE WHEN ast.code = 'absent' THEN 1 ELSE 0 END) AS absent_count,
    SUM(CASE WHEN ast.code = 'injured' THEN 1 ELSE 0 END) AS injured_count,
    SUM(CASE WHEN ast.code = 'sick' THEN 1 ELSE 0 END) AS sick_count,
    COUNT(*) AS total_records,
    ROUND(
        100.0 * SUM(CASE WHEN ast.code = 'present' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attendance_percentage
FROM attendance_records ar
JOIN attendance_statuses ast ON ast.id = ar.attendance_status_id
JOIN player_teams pt ON pt.id = ar.player_team_id
JOIN players p ON p.id = pt.player_id
JOIN teams t ON t.id = pt.team_id
JOIN seasons s ON s.id = t.season_id
WHERE t.name = 'M13'
  AND s.year = 2026
GROUP BY p.first_name, p.last_name
ORDER BY attendance_percentage DESC, present_count DESC;