WITH last_match AS (
    SELECT
        m.id,
        m.match_date,
        m.opponent_name,
        sq.description AS squad_name
    FROM matches m
    JOIN squads sq ON sq.id = m.squad_id
    WHERE sq.code = 'C'
    ORDER BY m.match_date DESC, m.id DESC
    LIMIT 1
)
SELECT
    lm.match_date,
    lm.squad_name,
    lm.opponent_name,
    p.first_name || ' ' || p.last_name AS player_name,
    played_position.description AS position_played,
    primary_position.description AS primary_position,
    mpr.jersey_number,
    CASE WHEN mpr.starter THEN 'Titular' ELSE 'Suplente' END AS player_role
FROM last_match lm
JOIN match_player_records mpr ON mpr.match_id = lm.id
JOIN player_teams pt ON pt.id = mpr.player_team_id
JOIN players p ON p.id = pt.player_id
LEFT JOIN player_positions played_position ON played_position.id = mpr.player_position_id
LEFT JOIN player_positions primary_position ON primary_position.id = pt.primary_position_id
ORDER BY COALESCE(mpr.jersey_number, 99), p.last_name;