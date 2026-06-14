-- M13 2026 - Player level evaluations seed
-- Generated from CSV.
-- Assumed evaluation date: 2026-03-01
-- Level scale: 1 = lowest level, 10 = highest level

CREATE TEMP TABLE temp_m13_player_levels (
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    level_score NUMERIC(4,2)
);

INSERT INTO temp_m13_player_levels (
    first_name,
    last_name,
    level_score
)
VALUES
('Tomas', 'Badra', 2.00),
('Luca', 'Ballatore', 6.00),
('Dante', 'Barros Fachin', 8.00),
('Pedro', 'Beltrán', 8.00),
('Pedro', 'Bernardi', 8.00),
('Camilo', 'Branda', 6.00),
('Francisco', 'Brandan', 2.00),
('Tomas', 'Carranza', 8.00),
('Francisco', 'Castellanos', 8.00),
('Salvador', 'Ceballos', 8.00),
('Dante', 'Cicarella', 6.00),
('Ramiro', 'Citati', 6.00),
('Matías', 'Colino', 4.00),
('Santino', 'De Almeida', 2.00),
('Baltazar', 'De la Cuesta', 10.00),
('Ignacio', 'De Miguel', 8.00),
('Gregorio', 'Del Valle', 4.00),
('Agustín', 'Dellavedova', 2.00),
('Cayetano', 'Ferla', 6.00),
('Greogorio', 'Fernandez', 10.00),
('Tomas', 'Ferrer', 8.00),
('Santiago', 'Ferro', 6.00),
('Gregorio', 'Gacitúa', 4.00),
('Ignacio', 'Grenat', 4.00),
('Joaquín', 'Hadad', 2.00),
('Dylan', 'Haymal', 4.00),
('Rimón', 'Huespe', 6.00),
('Tomer', 'Iacomo', 6.00),
('Segundo', 'Idoyaga', 4.00),
('Facundo', 'Isaia', 8.00),
('Mateo', 'Juaneda', 4.00),
('Augusto', 'Lascano', 4.00),
('Genaro', 'Leonelli', 8.00),
('Benjamín', 'Lorenzi Zamboni', 6.00),
('Pedro', 'Lozada', 8.00),
('Francisco', 'Martinolli', 2.00),
('Genaro', 'Mateo', 8.00),
('Felipe', 'Mayer', 6.00),
('Santiago', 'Mayer', 6.00),
('Benicio', 'Mellano', 4.00),
('Bautista', 'Meroi', 6.00),
('Ignacio', 'Molina', 6.00),
('Felipe', 'Nebbia', 8.00),
('Cristobal', 'Novillo', 2.00),
('Vicente', 'Oliva', 6.00),
('Constantino', 'Olocco', 2.00),
('Santiago', 'Ruiz Orszo', 2.00),
('Federico', 'Pez', 8.00),
('Vicente', 'Quaglia', 2.00),
('Toto', 'Ramirez', 2.00),
('Benjamin', 'Revuelto', 2.00),
('Facundo', 'Robino', 6.00),
('Emiliano', 'Rocca', 6.00),
('Conrado', 'Roggio', 4.00),
('Facundo', 'Romero Victorica', 10.00),
('Gregorio', 'Roque Allende', 4.00),
('Pedro', 'Rotundo', 6.00),
('Facundo', 'Rubioli', 10.00),
('Tomas', 'Salort', 4.00),
('Francisco', 'Sanchez', 10.00),
('Octavio', 'Segovia', 10.00),
('Santino', 'Sosa', 6.00),
('Federico', 'Taborda', 10.00),
('Cristobal Toto', 'Tosco', 10.00),
('Evaristo', 'Uriburu', 4.00),
('Clemente', 'Vazquez', 2.00),
('Santiago', 'Vera', 6.00),
('Patricio', 'Viale', 6.00),
('Lautaro', 'Videla', 2.00),
('Camilo', 'Villegas', 10.00),
('Justo', 'Zamorato', 4.00),
('Felipe', 'Zeballos', 6.00);

-- Optional check: players in this file that are not currently linked to M13 2026.
SELECT
    tmp.first_name,
    tmp.last_name,
    tmp.level_score
FROM temp_m13_player_levels tmp
LEFT JOIN players p
    ON LOWER(TRIM(p.first_name)) = LOWER(TRIM(tmp.first_name))
   AND LOWER(TRIM(p.last_name)) = LOWER(TRIM(tmp.last_name))
LEFT JOIN player_teams pt
    ON pt.player_id = p.id
LEFT JOIN teams t
    ON t.id = pt.team_id
LEFT JOIN seasons s
    ON s.id = t.season_id
WHERE
    pt.id IS NULL
    OR t.name <> 'M13'
    OR s.year <> 2026
ORDER BY
    tmp.last_name,
    tmp.first_name;

-- Insert player level evaluations.
-- The NOT EXISTS condition prevents duplicated rows if the seed is executed more than once.
INSERT INTO player_level_evaluations (
    player_team_id,
    evaluator_coach_id,
    evaluation_date,
    level_score,
    notes,
    created_by
)
SELECT
    pt.id AS player_team_id,
    (
        SELECT c.id
        FROM coaches c
        WHERE LOWER(c.first_name) = 'sebastian'
          AND LOWER(c.last_name) = 'ferro'
        LIMIT 1
    ) AS evaluator_coach_id,
    DATE '2026-03-01' AS evaluation_date,
    tmp.level_score,
    'Initial M13 2026 level evaluation' AS notes,
    'seed' AS created_by
FROM temp_m13_player_levels tmp
JOIN players p
    ON LOWER(TRIM(p.first_name)) = LOWER(TRIM(tmp.first_name))
   AND LOWER(TRIM(p.last_name)) = LOWER(TRIM(tmp.last_name))
JOIN player_teams pt
    ON pt.player_id = p.id
JOIN teams t
    ON t.id = pt.team_id
JOIN seasons s
    ON s.id = t.season_id
WHERE
    t.name = 'M13'
    AND s.year = 2026
    AND NOT EXISTS (
        SELECT 1
        FROM player_level_evaluations ple
        WHERE ple.player_team_id = pt.id
          AND ple.evaluation_date = DATE '2026-03-01'
    );

-- Verification summary
SELECT
    COUNT(*) AS inserted_or_existing_level_evaluations
FROM player_level_evaluations ple
JOIN player_teams pt
    ON pt.id = ple.player_team_id
JOIN teams t
    ON t.id = pt.team_id
JOIN seasons s
    ON s.id = t.season_id
WHERE
    t.name = 'M13'
    AND s.year = 2026
    AND ple.evaluation_date = DATE '2026-03-01';
