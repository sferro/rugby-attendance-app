-- M13 2026 - La Tablada

-- Crear equipo M13 2026
INSERT INTO teams (
    club_id,
    season_id,
    name
)
VALUES (
    (SELECT id FROM clubs WHERE name = 'La Tablada'),
    (SELECT id FROM seasons WHERE year = 2026),
    'M13'
);

-- Agregar rol específico
INSERT INTO coach_roles (
    code,
    description
)
VALUES (
    'scrum_coach',
    'Entrenador de Scrum'
)
ON CONFLICT (code) DO NOTHING;

-- Cargar entrenadores
INSERT INTO coaches (
    first_name,
    last_name
)
VALUES
('Sebastian', 'Ferro'),
('Carlos', 'Romero Victorica'),
('Raul', 'Campos'),
('Nicolas', 'Issaia'),
('Carlos', 'Alvarez'),
('Pablo', 'Fernandez'),
('Alejo', 'Del Corro'),
('Eric', 'Farias'),
('Lucia', 'Ludueña'),
('Guillermo', 'Vazquez'),
('Gilberto', 'Olvida'),
('Salvador', 'Viale');

-- Asociar entrenadores a M13 2026
INSERT INTO team_coaches (
    team_id,
    coach_id,
    coach_role_id,
    priority
)
VALUES
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Sebastian' AND last_name = 'Ferro'),
    (SELECT id FROM coach_roles WHERE code = 'head_coach'),
    1
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Carlos' AND last_name = 'Romero Victorica'),
    (SELECT id FROM coach_roles WHERE code = 'backs_coach'),
    1
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Raul' AND last_name = 'Campos'),
    (SELECT id FROM coach_roles WHERE code = 'forwards_coach'),
    1
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Nicolas' AND last_name = 'Issaia'),
    (SELECT id FROM coach_roles WHERE code = 'scrum_coach'),
    1
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Carlos' AND last_name = 'Alvarez'),
    (SELECT id FROM coach_roles WHERE code = 'backs_coach'),
    2
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Pablo' AND last_name = 'Fernandez'),
    (SELECT id FROM coach_roles WHERE code = 'forwards_coach'),
    2
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Alejo' AND last_name = 'Del Corro'),
    (SELECT id FROM coach_roles WHERE code = 'forwards_coach'),
    3
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Eric' AND last_name = 'Farias'),
    (SELECT id FROM coach_roles WHERE code = 'physical_trainer'),
    1
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Lucia' AND last_name = 'Ludueña'),
    (SELECT id FROM coach_roles WHERE code = 'physical_trainer'),
    2
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Guillermo' AND last_name = 'Vazquez'),
    (SELECT id FROM coach_roles WHERE code = 'manager'),
    1
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Gilberto' AND last_name = 'Olvida'),
    (SELECT id FROM coach_roles WHERE code = 'manager'),
    2
),
(
    (SELECT t.id FROM teams t JOIN seasons s ON s.id = t.season_id WHERE t.name = 'M13' AND s.year = 2026),
    (SELECT id FROM coaches WHERE first_name = 'Salvador' AND last_name = 'Viale'),
    (SELECT id FROM coach_roles WHERE code = 'manager'),
    3
);

