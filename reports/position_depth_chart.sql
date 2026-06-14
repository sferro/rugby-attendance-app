SELECT
    pp.position_group,
    pp.position_sub_group,
    pp.description AS primary_position,
    COUNT(*) AS players_count,
    ROUND(AVG(ll.level_score), 2) AS avg_level
FROM player_teams pt
JOIN players p ON p.id = pt.player_id
JOIN teams t ON t.id = pt.team_id
JOIN seasons s ON s.id = t.season_id
LEFT JOIN player_positions pp ON pp.id = pt.primary_position_id
LEFT JOIN (
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
) ll ON ll.player_team_id = pt.id
WHERE t.name = 'M13'
  AND s.year = 2026
GROUP BY pp.position_group, pp.position_sub_group, pp.description
ORDER BY pp.position_group, pp.position_sub_group, players_count DESC;