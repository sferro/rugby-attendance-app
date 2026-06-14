-- M13 2026 - Staff attendance seed
-- Source mapping:
-- p = present
-- a = absent
-- blank = no record
-- Staff alias: Lula -> Lucia Ludueña

CREATE TEMP TABLE temp_staff_attendance (
    staff_name VARCHAR(150),
    session_date DATE,
    attendance_status_code VARCHAR(50)
);

INSERT INTO temp_staff_attendance (
    staff_name,
    session_date,
    attendance_status_code
)
VALUES
('Sebastian Ferro', '2026-02-18', 'present'),
('Sebastian Ferro', '2026-02-20', 'present'),
('Sebastian Ferro', '2026-02-23', 'present'),
('Sebastian Ferro', '2026-02-25', 'present'),
('Sebastian Ferro', '2026-02-28', 'present'),
('Sebastian Ferro', '2026-03-02', 'present'),
('Sebastian Ferro', '2026-03-04', 'present'),
('Sebastian Ferro', '2026-03-07', 'present'),
('Sebastian Ferro', '2026-03-09', 'present'),
('Sebastian Ferro', '2026-03-11', 'absent'),
('Sebastian Ferro', '2026-03-14', 'present'),
('Sebastian Ferro', '2026-03-16', 'present'),
('Sebastian Ferro', '2026-03-18', 'present'),
('Sebastian Ferro', '2026-03-21', 'present'),
('Sebastian Ferro', '2026-04-13', 'present'),
('Sebastian Ferro', '2026-04-15', 'present'),
('Sebastian Ferro', '2026-04-18', 'present'),
('Sebastian Ferro', '2026-04-22', 'present'),
('Sebastian Ferro', '2026-04-24', 'present'),
('Sebastian Ferro', '2026-04-27', 'present'),
('Sebastian Ferro', '2026-04-29', 'present'),
('Sebastian Ferro', '2026-05-04', 'present'),
('Sebastian Ferro', '2026-05-06', 'present'),
('Sebastian Ferro', '2026-05-08', 'present'),
('Sebastian Ferro', '2026-05-09', 'present'),
('Sebastian Ferro', '2026-05-10', 'present'),
('Sebastian Ferro', '2026-05-13', 'present'),
('Sebastian Ferro', '2026-05-16', 'present'),
('Sebastian Ferro', '2026-05-17', 'present'),
('Sebastian Ferro', '2026-05-20', 'present'),
('Sebastian Ferro', '2026-05-27', 'present'),
('Sebastian Ferro', '2026-05-30', 'present'),
('Sebastian Ferro', '2026-06-01', 'present'),
('Sebastian Ferro', '2026-06-03', 'present'),
('Sebastian Ferro', '2026-06-06', 'present'),
('Sebastian Ferro', '2026-06-08', 'present'),
('Sebastian Ferro', '2026-06-10', 'present'),
('Carlos Romero Victorica', '2026-02-18', 'present'),
('Carlos Romero Victorica', '2026-02-20', 'present'),
('Carlos Romero Victorica', '2026-02-23', 'present'),
('Carlos Romero Victorica', '2026-02-25', 'present'),
('Carlos Romero Victorica', '2026-02-28', 'present'),
('Carlos Romero Victorica', '2026-03-02', 'absent'),
('Carlos Romero Victorica', '2026-03-04', 'present'),
('Carlos Romero Victorica', '2026-03-07', 'present'),
('Carlos Romero Victorica', '2026-03-09', 'present'),
('Carlos Romero Victorica', '2026-03-11', 'present'),
('Carlos Romero Victorica', '2026-03-14', 'present'),
('Carlos Romero Victorica', '2026-03-16', 'present'),
('Carlos Romero Victorica', '2026-03-18', 'present'),
('Carlos Romero Victorica', '2026-03-21', 'present'),
('Carlos Romero Victorica', '2026-04-13', 'present'),
('Carlos Romero Victorica', '2026-04-15', 'present'),
('Carlos Romero Victorica', '2026-04-18', 'present'),
('Carlos Romero Victorica', '2026-04-22', 'present'),
('Carlos Romero Victorica', '2026-04-24', 'present'),
('Carlos Romero Victorica', '2026-04-27', 'present'),
('Carlos Romero Victorica', '2026-04-29', 'present'),
('Carlos Romero Victorica', '2026-05-04', 'present'),
('Carlos Romero Victorica', '2026-05-06', 'present'),
('Carlos Romero Victorica', '2026-05-08', 'present'),
('Carlos Romero Victorica', '2026-05-09', 'present'),
('Carlos Romero Victorica', '2026-05-10', 'present'),
('Carlos Romero Victorica', '2026-05-13', 'present'),
('Carlos Romero Victorica', '2026-05-16', 'present'),
('Carlos Romero Victorica', '2026-05-17', 'present'),
('Carlos Romero Victorica', '2026-05-20', 'present'),
('Carlos Romero Victorica', '2026-05-27', 'present'),
('Carlos Romero Victorica', '2026-05-30', 'present'),
('Carlos Romero Victorica', '2026-06-01', 'absent'),
('Carlos Romero Victorica', '2026-06-03', 'present'),
('Carlos Romero Victorica', '2026-06-06', 'present'),
('Carlos Romero Victorica', '2026-06-08', 'present'),
('Carlos Romero Victorica', '2026-06-10', 'present'),
('Raul Campos', '2026-02-18', 'present'),
('Raul Campos', '2026-02-20', 'present'),
('Raul Campos', '2026-02-23', 'present'),
('Raul Campos', '2026-02-25', 'present'),
('Raul Campos', '2026-02-28', 'absent'),
('Raul Campos', '2026-03-02', 'present'),
('Raul Campos', '2026-03-04', 'present'),
('Raul Campos', '2026-03-07', 'present'),
('Raul Campos', '2026-03-09', 'present'),
('Raul Campos', '2026-03-11', 'present'),
('Raul Campos', '2026-03-14', 'present'),
('Raul Campos', '2026-03-16', 'absent'),
('Raul Campos', '2026-03-18', 'present'),
('Raul Campos', '2026-03-21', 'present'),
('Raul Campos', '2026-04-13', 'present'),
('Raul Campos', '2026-04-15', 'present'),
('Raul Campos', '2026-04-18', 'present'),
('Raul Campos', '2026-04-22', 'present'),
('Raul Campos', '2026-04-24', 'present'),
('Raul Campos', '2026-04-27', 'present'),
('Raul Campos', '2026-04-29', 'absent'),
('Raul Campos', '2026-05-04', 'present'),
('Raul Campos', '2026-05-06', 'present'),
('Raul Campos', '2026-05-08', 'present'),
('Raul Campos', '2026-05-09', 'present'),
('Raul Campos', '2026-05-10', 'present'),
('Raul Campos', '2026-05-13', 'present'),
('Raul Campos', '2026-05-16', 'present'),
('Raul Campos', '2026-05-17', 'present'),
('Raul Campos', '2026-05-20', 'present'),
('Raul Campos', '2026-05-27', 'present'),
('Raul Campos', '2026-05-30', 'present'),
('Raul Campos', '2026-06-01', 'present'),
('Raul Campos', '2026-06-03', 'present'),
('Raul Campos', '2026-06-06', 'present'),
('Raul Campos', '2026-06-08', 'present'),
('Raul Campos', '2026-06-10', 'absent'),
('Nicolas Issaia', '2026-02-18', 'present'),
('Nicolas Issaia', '2026-02-20', 'present'),
('Nicolas Issaia', '2026-02-23', 'present'),
('Nicolas Issaia', '2026-02-25', 'present'),
('Nicolas Issaia', '2026-02-28', 'present'),
('Nicolas Issaia', '2026-03-02', 'present'),
('Nicolas Issaia', '2026-03-04', 'present'),
('Nicolas Issaia', '2026-03-07', 'present'),
('Nicolas Issaia', '2026-03-09', 'present'),
('Nicolas Issaia', '2026-03-11', 'present'),
('Nicolas Issaia', '2026-03-14', 'present'),
('Nicolas Issaia', '2026-03-16', 'present'),
('Nicolas Issaia', '2026-03-18', 'present'),
('Nicolas Issaia', '2026-03-21', 'present'),
('Nicolas Issaia', '2026-04-13', 'present'),
('Nicolas Issaia', '2026-04-15', 'present'),
('Nicolas Issaia', '2026-04-18', 'present'),
('Nicolas Issaia', '2026-04-22', 'present'),
('Nicolas Issaia', '2026-04-24', 'present'),
('Nicolas Issaia', '2026-04-27', 'present'),
('Nicolas Issaia', '2026-04-29', 'present'),
('Nicolas Issaia', '2026-05-04', 'present'),
('Nicolas Issaia', '2026-05-06', 'present'),
('Nicolas Issaia', '2026-05-08', 'present'),
('Nicolas Issaia', '2026-05-09', 'present'),
('Nicolas Issaia', '2026-05-10', 'present'),
('Nicolas Issaia', '2026-05-13', 'present'),
('Nicolas Issaia', '2026-05-16', 'present'),
('Nicolas Issaia', '2026-05-17', 'present'),
('Nicolas Issaia', '2026-05-20', 'present'),
('Nicolas Issaia', '2026-05-27', 'present'),
('Nicolas Issaia', '2026-05-30', 'present'),
('Nicolas Issaia', '2026-06-01', 'present'),
('Nicolas Issaia', '2026-06-03', 'present'),
('Nicolas Issaia', '2026-06-06', 'present'),
('Nicolas Issaia', '2026-06-08', 'present'),
('Nicolas Issaia', '2026-06-10', 'present'),
('Carlos Alvarez', '2026-02-18', 'present'),
('Carlos Alvarez', '2026-02-20', 'present'),
('Carlos Alvarez', '2026-02-23', 'present'),
('Carlos Alvarez', '2026-02-25', 'present'),
('Carlos Alvarez', '2026-02-28', 'present'),
('Carlos Alvarez', '2026-03-02', 'present'),
('Carlos Alvarez', '2026-03-04', 'absent'),
('Carlos Alvarez', '2026-03-07', 'absent'),
('Carlos Alvarez', '2026-03-09', 'present'),
('Carlos Alvarez', '2026-03-11', 'present'),
('Carlos Alvarez', '2026-03-14', 'present'),
('Carlos Alvarez', '2026-03-16', 'present'),
('Carlos Alvarez', '2026-03-18', 'present'),
('Carlos Alvarez', '2026-03-21', 'present'),
('Carlos Alvarez', '2026-04-13', 'present'),
('Carlos Alvarez', '2026-04-15', 'present'),
('Carlos Alvarez', '2026-04-18', 'present'),
('Carlos Alvarez', '2026-04-22', 'present'),
('Carlos Alvarez', '2026-04-24', 'present'),
('Carlos Alvarez', '2026-04-27', 'present'),
('Carlos Alvarez', '2026-04-29', 'present'),
('Carlos Alvarez', '2026-05-04', 'present'),
('Carlos Alvarez', '2026-05-06', 'present'),
('Carlos Alvarez', '2026-05-08', 'present'),
('Carlos Alvarez', '2026-05-09', 'present'),
('Carlos Alvarez', '2026-05-10', 'present'),
('Carlos Alvarez', '2026-05-13', 'absent'),
('Carlos Alvarez', '2026-05-16', 'absent'),
('Carlos Alvarez', '2026-05-17', 'absent'),
('Carlos Alvarez', '2026-05-20', 'absent'),
('Carlos Alvarez', '2026-05-27', 'present'),
('Carlos Alvarez', '2026-05-30', 'present'),
('Carlos Alvarez', '2026-06-01', 'absent'),
('Carlos Alvarez', '2026-06-03', 'present'),
('Carlos Alvarez', '2026-06-06', 'present'),
('Carlos Alvarez', '2026-06-08', 'present'),
('Carlos Alvarez', '2026-06-10', 'present'),
('Pablo Fernandez', '2026-06-01', 'present'),
('Pablo Fernandez', '2026-06-03', 'present'),
('Pablo Fernandez', '2026-06-06', 'present'),
('Pablo Fernandez', '2026-06-08', 'present'),
('Pablo Fernandez', '2026-06-10', 'present'),
('Alejo del Corro', '2026-02-25', 'present'),
('Alejo del Corro', '2026-02-28', 'present'),
('Alejo del Corro', '2026-03-02', 'present'),
('Alejo del Corro', '2026-03-04', 'present'),
('Alejo del Corro', '2026-03-07', 'absent'),
('Alejo del Corro', '2026-03-09', 'present'),
('Alejo del Corro', '2026-03-11', 'present'),
('Alejo del Corro', '2026-03-14', 'present'),
('Alejo del Corro', '2026-03-16', 'present'),
('Alejo del Corro', '2026-03-18', 'present'),
('Alejo del Corro', '2026-03-21', 'present'),
('Alejo del Corro', '2026-04-13', 'present'),
('Alejo del Corro', '2026-04-15', 'present'),
('Alejo del Corro', '2026-04-18', 'present'),
('Alejo del Corro', '2026-04-22', 'present'),
('Alejo del Corro', '2026-04-24', 'present'),
('Alejo del Corro', '2026-04-27', 'present'),
('Alejo del Corro', '2026-04-29', 'absent'),
('Alejo del Corro', '2026-05-04', 'absent'),
('Alejo del Corro', '2026-05-06', 'absent'),
('Alejo del Corro', '2026-05-08', 'absent'),
('Alejo del Corro', '2026-05-09', 'absent'),
('Alejo del Corro', '2026-05-10', 'absent'),
('Alejo del Corro', '2026-05-13', 'absent'),
('Alejo del Corro', '2026-05-16', 'absent'),
('Alejo del Corro', '2026-05-17', 'absent'),
('Alejo del Corro', '2026-05-20', 'absent'),
('Alejo del Corro', '2026-05-27', 'absent'),
('Alejo del Corro', '2026-05-30', 'absent'),
('Alejo del Corro', '2026-06-01', 'absent'),
('Alejo del Corro', '2026-06-03', 'absent'),
('Alejo del Corro', '2026-06-06', 'absent'),
('Alejo del Corro', '2026-06-08', 'absent'),
('Alejo del Corro', '2026-06-10', 'absent'),
('Eric Farias', '2026-03-07', 'present'),
('Eric Farias', '2026-03-09', 'present'),
('Eric Farias', '2026-03-11', 'present'),
('Eric Farias', '2026-03-14', 'present'),
('Eric Farias', '2026-03-16', 'present'),
('Eric Farias', '2026-03-18', 'present'),
('Eric Farias', '2026-03-21', 'present'),
('Eric Farias', '2026-04-13', 'present'),
('Eric Farias', '2026-04-15', 'absent'),
('Eric Farias', '2026-04-18', 'absent'),
('Eric Farias', '2026-04-22', 'present'),
('Eric Farias', '2026-04-24', 'present'),
('Eric Farias', '2026-04-27', 'present'),
('Eric Farias', '2026-04-29', 'present'),
('Eric Farias', '2026-05-04', 'present'),
('Eric Farias', '2026-05-06', 'present'),
('Eric Farias', '2026-05-08', 'absent'),
('Eric Farias', '2026-05-09', 'absent'),
('Eric Farias', '2026-05-10', 'absent'),
('Eric Farias', '2026-05-13', 'present'),
('Eric Farias', '2026-05-16', 'present'),
('Eric Farias', '2026-05-17', 'absent'),
('Eric Farias', '2026-05-20', 'present'),
('Eric Farias', '2026-05-27', 'present'),
('Eric Farias', '2026-05-30', 'absent'),
('Eric Farias', '2026-06-01', 'present'),
('Eric Farias', '2026-06-03', 'absent'),
('Eric Farias', '2026-06-06', 'present'),
('Eric Farias', '2026-06-08', 'present'),
('Eric Farias', '2026-06-10', 'present'),
('Lula', '2026-04-13', 'present'),
('Lula', '2026-04-15', 'present'),
('Lula', '2026-04-18', 'absent'),
('Lula', '2026-04-22', 'present'),
('Lula', '2026-04-24', 'absent'),
('Lula', '2026-04-27', 'present'),
('Lula', '2026-04-29', 'present'),
('Lula', '2026-05-04', 'present'),
('Lula', '2026-05-06', 'present'),
('Lula', '2026-05-08', 'absent'),
('Lula', '2026-05-09', 'absent'),
('Lula', '2026-05-10', 'absent'),
('Lula', '2026-05-13', 'present'),
('Lula', '2026-05-16', 'absent'),
('Lula', '2026-05-17', 'absent'),
('Lula', '2026-05-20', 'present'),
('Lula', '2026-05-27', 'present'),
('Lula', '2026-05-30', 'present'),
('Lula', '2026-06-01', 'present'),
('Lula', '2026-06-03', 'present'),
('Lula', '2026-06-06', 'present'),
('Lula', '2026-06-08', 'present'),
('Lula', '2026-06-10', 'present');

-- Ensure training sessions exist for all staff attendance dates
INSERT INTO training_sessions (
    team_id,
    training_session_type_id,
    session_date,
    description,
    created_by
)
SELECT
    t.id,
    tst.id,
    d.session_date,
    'Entrenamiento M13',
    'seed'
FROM (
    SELECT DISTINCT session_date
    FROM temp_staff_attendance
) d
JOIN teams t
    ON t.name = 'M13'
JOIN seasons s
    ON s.id = t.season_id
   AND s.year = 2026
JOIN training_session_types tst
    ON tst.code = 'training'
WHERE NOT EXISTS (
    SELECT 1
    FROM training_sessions ts
    WHERE ts.team_id = t.id
      AND ts.session_date = d.session_date
      AND ts.training_session_type_id = tst.id
);

-- Insert staff attendance
INSERT INTO staff_attendance_records (
    team_coach_id,
    training_session_id,
    attendance_status_id,
    created_by
)
SELECT
    tc.id,
    ts.id,
    ast.id,
    'seed'
FROM temp_staff_attendance tmp
JOIN teams t
    ON t.name = 'M13'
JOIN seasons s
    ON s.id = t.season_id
   AND s.year = 2026
JOIN training_session_types tst
    ON tst.code = 'training'
JOIN training_sessions ts
    ON ts.team_id = t.id
   AND ts.session_date = tmp.session_date
   AND ts.training_session_type_id = tst.id
JOIN attendance_statuses ast
    ON ast.code = tmp.attendance_status_code
JOIN coaches c
    ON (
        c.first_name || ' ' || c.last_name = tmp.staff_name
        OR (
            tmp.staff_name = 'Lula'
            AND c.first_name = 'Lucia'
            AND c.last_name = 'Ludueña'
        )
    )
JOIN team_coaches tc
    ON tc.coach_id = c.id
   AND tc.team_id = t.id
ON CONFLICT (team_coach_id, training_session_id) DO NOTHING;

-- Verification: staff names that did not match a coach
SELECT DISTINCT
    tmp.staff_name
FROM temp_staff_attendance tmp
LEFT JOIN coaches c
    ON (
        c.first_name || ' ' || c.last_name = tmp.staff_name
        OR (
            tmp.staff_name = 'Lula'
            AND c.first_name = 'Lucia'
            AND c.last_name = 'Ludueña'
        )
    )
WHERE c.id IS NULL
ORDER BY tmp.staff_name;

-- Verification: staff attendance summary
SELECT
    c.first_name || ' ' || c.last_name AS staff_name,
    cr.description AS role,
    SUM(CASE WHEN ast.code = 'present' THEN 1 ELSE 0 END) AS present_count,
    SUM(CASE WHEN ast.code = 'absent' THEN 1 ELSE 0 END) AS absent_count,
    COUNT(*) AS total_records,
    ROUND(
        100.0 * SUM(CASE WHEN ast.code = 'present' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS attendance_percentage
FROM staff_attendance_records sar
JOIN team_coaches tc
    ON tc.id = sar.team_coach_id
JOIN coaches c
    ON c.id = tc.coach_id
JOIN coach_roles cr
    ON cr.id = tc.coach_role_id
JOIN attendance_statuses ast
    ON ast.id = sar.attendance_status_id
JOIN teams t
    ON t.id = tc.team_id
JOIN seasons s
    ON s.id = t.season_id
WHERE t.name = 'M13'
  AND s.year = 2026
GROUP BY
    c.first_name,
    c.last_name,
    cr.description
ORDER BY
    attendance_percentage DESC,
    staff_name;
