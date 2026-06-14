WITH latest_level AS (
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
    sq.description AS squad_name,
    COUNT(*) AS players_count,
    ROUND(AVG(ll.level_score), 2) AS avg_level,
    MIN(ll.level_score) AS min_level,
    MAX(ll.level_score) AS max_level
FROM match_player_records mpr
JOIN matches m ON m.id = mpr.match_id
JOIN squads sq ON sq.id = m.squad_id
JOIN player_teams pt ON pt.id = mpr.player_team_id
LEFT JOIN latest_level ll ON ll.player_team_id = pt.id
WHERE m.match_date = (
    SELECT MAX(match_date)
    FROM matches
)
GROUP BY sq.description
ORDER BY sq.description;