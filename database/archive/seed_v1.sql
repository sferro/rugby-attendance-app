INSERT INTO clubs (
    name,
    short_name
)
VALUES (
    'La Tablada',
    'LT'
);
INSERT INTO seasons (
    year,
    description
)
VALUES
(2024, 'Temporada 2024'),
(2025, 'Temporada 2025'),
(2026, 'Temporada 2026'),
(2027, 'Temporada 2027'),
(2028, 'Temporada 2028');

INSERT INTO player_positions (
    player_position_number,
    code,
    description,
    position_group,
    position_sub_group
)
VALUES
(1,  'prop_loosehead',    'Pilar Izquierdo', 'FORWARDS', 'FIRST_LINE'),
(2,  'hooker',            'Hooker',          'FORWARDS', 'FIRST_LINE'),
(3,  'prop_tighthead',    'Pilar Derecho',   'FORWARDS', 'FIRST_LINE'),

(4,  'lock_4',            'Segunda Línea',   'FORWARDS', 'SECOND_LINE'),
(5,  'lock_5',            'Segunda Línea',   'FORWARDS', 'SECOND_LINE'),

(6,  'flanker_blindside', 'Ala Cerrado',     'FORWARDS', 'THIRD_LINE'),
(7,  'flanker_openside',  'Ala Abierto',     'FORWARDS', 'THIRD_LINE'),
(8,  'number_8',          'Octavo',          'FORWARDS', 'THIRD_LINE'),

(9,  'scrum_half',        'Medio Scrum',     'BACKS',    'SCRUM_HALF'),

(10, 'fly_half',          'Apertura',        'BACKS',    'FLY_HALF'),

(11, 'left_wing',         'Wing Izquierdo',  'BACKS',    'WING'),
(12, 'inside_center',     'Centro Interno',  'BACKS',    'CENTER'),
(13, 'outside_center',    'Centro Externo',  'BACKS',    'CENTER'),
(14, 'right_wing',        'Wing Derecho',    'BACKS',    'WING'),

(15, 'fullback',          'Full Back',       'BACKS',    'FULLBACK');

INSERT INTO coach_roles (
    code,
    description
)
VALUES
('head_coach', 'Entrenador Principal'),
('assistant_coach', 'Entrenador Asistente'),
('forwards_coach', 'Entrenador de Forwards'),
('backs_coach', 'Entrenador de Backs'),
('scrum_coach', 'Entrenador de Scrum'),
('physical_trainer', 'Preparador Físico'),
('manager', 'Manager');

INSERT INTO attendance_statuses (
    code,
    description
)
VALUES
('present', 'Presente'),
('absent', 'Ausente'),
('injured', 'Lesionado'),
('late', 'Llegó Tarde'),
('excused', 'Justificado'),
('sick', 'Enfermo');

INSERT INTO training_session_types (
    code,
    description
)
VALUES
('training', 'Entrenamiento'),
('physical', 'Preparación Física'),
('skills', 'Destrezas'),
('captains_run', 'Captain Run'),
('video_review', 'Análisis de Video');

INSERT INTO match_types (
    code,
    description
)
VALUES
('league', 'Torneo'),
('friendly', 'Amistoso'),
('festival', 'Encuentro'),
('tour', 'Gira');

INSERT INTO evaluation_categories (
    code,
    description
)
VALUES
('technical', 'Técnica'),
('tactical', 'Táctica'),
('mental', 'Mental');

INSERT INTO athletic_test_types (
    code,
    description,
    unit,
    lower_is_better
)
VALUES
('sprint_30m', 'Sprint 30 metros', 'seconds', TRUE),
('bronco_test', 'Bronco Test', 'seconds', TRUE),
('yo_yo_test', 'Yo-Yo Test', 'meters', FALSE),
('vertical_jump', 'Salto Vertical', 'cm', FALSE);

