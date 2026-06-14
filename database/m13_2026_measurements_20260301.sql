-- M13 2026 - Player measurements - 2026-03-01
-- Carga de altura y peso tomados el 2026-03-01.
-- Sólo se insertan jugadores con altura y peso informados.

BEGIN;

CREATE TEMP TABLE temp_m13_measurements_20260301 (
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    height_cm NUMERIC(5,2),
    weight_kg NUMERIC(5,2)
);

INSERT INTO temp_m13_measurements_20260301 (
    first_name,
    last_name,
    height_cm,
    weight_kg
)
VALUES
('Luca', 'Ballatore', 163, 53),
('Dante', 'Barros Fachin', 135, 39),
('Pedro', 'Beltrán', 173, 62),
('Pedro', 'Bernardi', 170, 60),
('Camilo', 'Branda', 167, 82),
('Francisco', 'Castellanos', 150, 38),
('Salvador', 'Ceballos', 159, 51),
('Dante', 'Cicarella', 162, 48),
('Baltazar', 'De la Cuesta', 168, 59),
('Ignacio', 'De Miguel', 163, 42),
('Gregorio', 'Del Valle', 140, 37),
('Cayetano', 'Ferla', 141, 32),
('Greogorio', 'Fernandez', 166, 58),
('Tomas', 'Ferrer', 150, 52),
('Santiago', 'Ferro', 162, 40),
('Ignacio', 'Grenat', 164, 68),
('Tomer', 'Iacomo', 171, 67),
('Facundo', 'Isaia', 152, 69),
('Genaro', 'Leonelli', 168, 64),
('Benjamín', 'Lorenzi Zamboni', 147, 39),
('Pedro', 'Lozada', 166, 59),
('Genaro', 'Mateo', 159, 59),
('Benicio', 'Mellano', 154, 40),
('Felipe', 'Nebbia', 150, 38),
('Vicente', 'Oliva', 144, 32),
('Constantino', 'Olocco', 152, 46),
('Federico', 'Pez', 141, 43),
('Facundo', 'Robino', 154, 43),
('Emiliano', 'Rocca', 167, 60),
('Facundo', 'Romero Victorica', 165, 53),
('Francisco', 'Sanchez', 162, 47),
('Octavio', 'Segovia', 150, 40),
('Santino', 'Sosa', 165, 61),
('Federico', 'Taborda', 156, 48),
('Cristobal Toto', 'Tosco', 170, 61),
('Clemente', 'Vazquez', 143, 34),
('Santiago', 'Vera', 160, 50),
('Camilo', 'Villegas', 167, 57),
('Justo', 'Zamorato', 150, 41);

-- Evita duplicados si el seed se ejecuta más de una vez.
DELETE FROM player_measurements pm
USING player_teams pt
JOIN players p
    ON p.id = pt.player_id
JOIN teams t
    ON t.id = pt.team_id
JOIN seasons s
    ON s.id = t.season_id
WHERE pm.player_team_id = pt.id
  AND t.name = 'M13'
  AND s.year = 2026
  AND pm.measurement_date = '2026-03-01'
  AND EXISTS (
      SELECT 1
      FROM temp_m13_measurements_20260301 tmp
      WHERE tmp.first_name = p.first_name
        AND tmp.last_name = p.last_name
  );

INSERT INTO player_measurements (
    player_team_id,
    measurement_date,
    height_cm,
    weight_kg,
    created_by
)
SELECT
    pt.id,
    '2026-03-01',
    tmp.height_cm,
    tmp.weight_kg,
    'seed'
FROM temp_m13_measurements_20260301 tmp
JOIN players p
    ON p.first_name = tmp.first_name
   AND p.last_name = tmp.last_name
JOIN player_teams pt
    ON pt.player_id = p.id
JOIN teams t
    ON t.id = pt.team_id
JOIN seasons s
    ON s.id = t.season_id
WHERE t.name = 'M13'
  AND s.year = 2026;

COMMIT;

-- Verificación sugerida:
-- SELECT
--     p.first_name,
--     p.last_name,
--     pm.measurement_date,
--     pm.height_cm,
--     pm.weight_kg
-- FROM player_measurements pm
-- JOIN player_teams pt ON pt.id = pm.player_team_id
-- JOIN players p ON p.id = pt.player_id
-- JOIN teams t ON t.id = pt.team_id
-- JOIN seasons s ON s.id = t.season_id
-- WHERE t.name = 'M13'
--   AND s.year = 2026
--   AND pm.measurement_date = '2026-03-01'
-- ORDER BY p.last_name, p.first_name;
