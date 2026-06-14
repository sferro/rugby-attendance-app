WITH last_match AS (
    SELECT
        m.id,
        m.match_date,
        m.opponent_name,
        sq.description AS squad_name
    FROM matches m
    JOIN squads sq
        ON sq.id = m.squad_id
    WHERE sq.code = 'C'
    ORDER BY
        m.match_date DESC,
        m.id DESC
    LIMIT 1
),

player_attendance AS (
    SELECT
        pt.id AS player_team_id,
        ts.session_date,
        ast.code AS attendance_status,

        ROW_NUMBER() OVER (
            PARTITION BY pt.id
            ORDER BY ts.session_date DESC
        ) AS attendance_rank

    FROM attendance_records ar
    JOIN attendance_statuses ast
        ON ast.id = ar.attendance_status_id
    JOIN training_sessions ts
        ON ts.id = ar.training_session_id
    JOIN player_teams pt
        ON pt.id = ar.player_team_id
    JOIN teams t
        ON t.id = pt.team_id
    JOIN seasons s
        ON s.id = t.season_id
    WHERE
        t.name = 'M13'
        AND s.year = 2026
),

attendance_summary AS (
    SELECT
        player_team_id,

        ROUND(
            100.0 * SUM(CASE WHEN attendance_status = 'present' THEN 1 ELSE 0 END)
            / NULLIF(COUNT(*), 0),
            2
        ) AS attendance_percentage,

        ROUND(
            100.0 * SUM(
                CASE
                    WHEN attendance_rank <= 4 AND attendance_status = 'present'
                    THEN 1 ELSE 0
                END
            )
            / NULLIF(SUM(CASE WHEN attendance_rank <= 4 THEN 1 ELSE 0 END), 0),
            2
        ) AS last_4_attendance_percentage,

        ROUND(
            100.0 * SUM(
                CASE
                    WHEN attendance_rank <= 2 AND attendance_status = 'present'
                    THEN 1 ELSE 0
                END
            )
            / NULLIF(SUM(CASE WHEN attendance_rank <= 2 THEN 1 ELSE 0 END), 0),
            2
        ) AS last_2_attendance_percentage

    FROM player_attendance
    GROUP BY player_team_id
),

latest_level AS (
    SELECT
        player_team_id,
        level_score
    FROM (
        SELECT
            ple.player_team_id,
            ple.level_score,
            ROW_NUMBER() OVER (
                PARTITION BY ple.player_team_id
                ORDER BY ple.evaluation_date DESC, ple.id DESC
            ) AS rn
        FROM player_level_evaluations ple
    ) x
    WHERE rn = 1
)

SELECT
    lm.match_date,
    lm.squad_name,
    lm.opponent_name,

    CONCAT(p.first_name, ' ', p.last_name) AS player_name,

    played_position.description AS position_played,
    primary_position.description AS primary_position,
    alternative_position.description AS alternative_position,

    latest_level.level_score,

    attendance_summary.attendance_percentage,
    attendance_summary.last_4_attendance_percentage,
    attendance_summary.last_2_attendance_percentage,

    mpr.jersey_number,

    CASE
        WHEN mpr.starter THEN 'Starter'
        ELSE 'Substitute'
    END AS player_role

FROM last_match lm

JOIN match_player_records mpr
    ON mpr.match_id = lm.id

JOIN player_teams pt
    ON pt.id = mpr.player_team_id

JOIN players p
    ON p.id = pt.player_id

LEFT JOIN player_positions played_position
    ON played_position.id = mpr.player_position_id

LEFT JOIN player_positions primary_position
    ON primary_position.id = pt.primary_position_id

LEFT JOIN player_positions alternative_position
    ON alternative_position.id = pt.alternative_position_id

LEFT JOIN latest_level
    ON latest_level.player_team_id = pt.id

LEFT JOIN attendance_summary
    ON attendance_summary.player_team_id = pt.id

ORDER BY
    COALESCE(mpr.jersey_number, 99),
    p.last_name,
    p.first_name;