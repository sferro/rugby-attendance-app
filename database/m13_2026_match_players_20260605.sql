-- M13 2026 - Match player records - 2026-06-05

CREATE TEMP TABLE temp_match_players (
    squad_code VARCHAR(20),
    opponent_name VARCHAR(100),
    player_order INTEGER,
    last_name VARCHAR(100),
    first_name VARCHAR(100)
);

INSERT INTO temp_match_players VALUES
-- Tablada A vs Carlos Paz
('A', 'Carlos Paz', 1, 'Branda', 'Camilo'),
('A', 'Carlos Paz', 2, 'Isaia', 'Facundo'),
('A', 'Carlos Paz', 3, 'Ballatore', 'Luca'),
('A', 'Carlos Paz', 4, 'Lozada', 'Pedro'),
('A', 'Carlos Paz', 5, 'Lascano', 'Augusto'),
('A', 'Carlos Paz', 6, 'Cicarella', 'Dante'),
('A', 'Carlos Paz', 7, 'Leonelli', 'Genaro'),
('A', 'Carlos Paz', 8, 'De la Cuesta', 'Baltazar'),
('A', 'Carlos Paz', 9, 'Romero Victorica', 'Facundo'),
('A', 'Carlos Paz', 10, 'Pez', 'Federico'),
('A', 'Carlos Paz', 11, 'De Miguel', 'Ignacio'),
('A', 'Carlos Paz', 12, 'Rubioli', 'Facundo'),
('A', 'Carlos Paz', 13, 'Mayer', 'Felipe'),
('A', 'Carlos Paz', 14, 'Vera', 'Santiago'),
('A', 'Carlos Paz', 15, 'Sanchez', 'Francisco'),
('A', 'Carlos Paz', 16, 'Mateo', 'Genaro'),
('A', 'Carlos Paz', 17, 'Robino', 'Facundo'),
('A', 'Carlos Paz', 18, 'Rocca', 'Emiliano'),
('A', 'Carlos Paz', 19, 'Oliva', 'Vicente'),
('A', 'Carlos Paz', 20, 'Carranza', 'Tomas'),
('A', 'Carlos Paz', 21, 'Mayer', 'Santiago'),
('A', 'Carlos Paz', 22, 'Quaglia', 'Vicente'),

-- Tablada B vs Cordoba Rugby
('B', 'Cordoba Rugby', 1, 'Sosa', 'Santino'),
('B', 'Cordoba Rugby', 2, 'Ferrer', 'Tomas'),
('B', 'Cordoba Rugby', 3, 'Grenat', 'Ignacio'),
('B', 'Cordoba Rugby', 4, 'Molina', 'Ignacio'),
('B', 'Cordoba Rugby', 5, 'Roggio', 'Conrado'),
('B', 'Cordoba Rugby', 6, 'Segovia', 'Octavio'),
('B', 'Cordoba Rugby', 7, 'Bernardi', 'Pedro'),
('B', 'Cordoba Rugby', 8, 'Villegas', 'Camilo'),
('B', 'Cordoba Rugby', 9, 'Lorenzi Zamboni', 'Benjamín'),
('B', 'Cordoba Rugby', 10, 'Taborda', 'Federico'),
('B', 'Cordoba Rugby', 11, 'Ceballos', 'Salvador'),
('B', 'Cordoba Rugby', 12, 'Fernandez', 'Greogorio'),
('B', 'Cordoba Rugby', 13, 'Tosco', 'Cristobal Toto'),
('B', 'Cordoba Rugby', 14, 'Ferro', 'Santiago'),
('B', 'Cordoba Rugby', 15, 'Citati', 'Ramiro'),
('B', 'Cordoba Rugby', 16, 'Rotundo', 'Pedro'),
('B', 'Cordoba Rugby', 17, 'Beltrán', 'Pedro'),
('B', 'Cordoba Rugby', 18, 'Barros Fachin', 'Dante'),
('B', 'Cordoba Rugby', 19, 'Mellano', 'Benicio'),
('B', 'Cordoba Rugby', 20, 'Huespe', 'Rimón'),
('B', 'Cordoba Rugby', 21, 'Zamorato', 'Justo'),
('B', 'Cordoba Rugby', 22, 'Hadad', 'Joaquín'),

-- Tablada C vs Tala C
('C', 'Tala C', 1, 'Haymal', 'Dylan'),
('C', 'Tala C', 2, 'Rotundo', 'Pedro'),
('C', 'Tala C', 3, 'Olocco', 'Constantino'),
('C', 'Tala C', 4, 'Dellavedova', 'Agustín'),
('C', 'Tala C', 5, 'De Almeida', 'Santino'),
('C', 'Tala C', 6, 'Salort', 'Tomas'),
('C', 'Tala C', 7, 'Robino', 'Facundo'),
('C', 'Tala C', 8, 'Martinolli', 'Francisco'),
('C', 'Tala C', 9, 'Del Valle', 'Gregorio'),
('C', 'Tala C', 10, 'Juaneda', 'Mateo'),
('C', 'Tala C', 11, 'Vazquez', 'Clemente'),
('C', 'Tala C', 12, 'Colino', 'Matías'),
('C', 'Tala C', 13, 'Meroi', 'Bautista'),
('C', 'Tala C', 14, 'Viale', 'Patricio'),
('C', 'Tala C', 15, 'Oliva', 'Vicente'),
('C', 'Tala C', 16, 'Idoyaga', 'Segundo'),
('C', 'Tala C', 17, 'Novillo', 'Cristobal');

INSERT INTO match_player_records (
    match_id,
    player_team_id,
    player_position_id,
    starter,
    jersey_number,
    created_by
)
SELECT
    m.id,
    pt.id,
    CASE
        WHEN tmp.player_order <= 15 THEN pp_by_number.id
        ELSE pt.primary_position_id
    END AS player_position_id,
    CASE WHEN tmp.player_order <= 15 THEN TRUE ELSE FALSE END AS starter,
    CASE WHEN tmp.player_order <= 15 THEN tmp.player_order ELSE NULL END AS jersey_number,
    'seed'
FROM temp_match_players tmp
JOIN players p
    ON p.first_name = tmp.first_name
   AND p.last_name = tmp.last_name
JOIN player_teams pt
    ON pt.player_id = p.id
JOIN teams t
    ON t.id = pt.team_id
JOIN seasons s
    ON s.id = t.season_id
   AND s.year = 2026
JOIN matches m
    ON m.team_id = t.id
   AND m.match_date = '2026-06-05'
   AND m.opponent_name = tmp.opponent_name
JOIN squads sq
    ON sq.id = m.squad_id
   AND sq.code = tmp.squad_code
LEFT JOIN player_positions pp_by_number
    ON pp_by_number.player_position_number = tmp.player_order
WHERE t.name = 'M13'
ON CONFLICT (match_id, player_team_id) DO NOTHING;

-- Verificación: jugadores del listado que no matchearon
SELECT
    tmp.squad_code,
    tmp.opponent_name,
    tmp.player_order,
    tmp.last_name,
    tmp.first_name
FROM temp_match_players tmp
LEFT JOIN players p
    ON p.first_name = tmp.first_name
   AND p.last_name = tmp.last_name
WHERE p.id IS NULL
ORDER BY tmp.squad_code, tmp.player_order;
