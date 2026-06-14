-- M13 2026 - Players seed

-- Permitir datos incompletos reales
ALTER TABLE players ALTER COLUMN birth_date DROP NOT NULL;
ALTER TABLE player_positions ALTER COLUMN player_position_number DROP NOT NULL;

-- Posiciones genéricas usadas por el staff
INSERT INTO player_positions (
    player_position_number,
    code,
    description,
    position_group,
    position_sub_group
)
VALUES
(NULL, 'first_line', 'Primera Línea', 'FORWARDS', 'FIRST_LINE'),
(NULL, 'second_line', 'Segunda Línea', 'FORWARDS', 'SECOND_LINE'),
(NULL, 'third_line', 'Tercera Línea', 'FORWARDS', 'THIRD_LINE'),
(NULL, 'scrum_half_generic', 'Medio Scrum', 'BACKS', 'SCRUM_HALF'),
(NULL, 'fly_half_generic', 'Apertura', 'BACKS', 'FLY_HALF'),
(NULL, 'center_generic', 'Centro', 'BACKS', 'CENTER'),
(NULL, 'wing_generic', 'Wing', 'BACKS', 'WING'),
(NULL, 'fullback_generic', 'Full Back', 'BACKS', 'FULLBACK')
ON CONFLICT (code) DO NOTHING;


CREATE TEMP TABLE temp_m13_players (
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    document_number VARCHAR(50),
    birth_date DATE,
    primary_position_code VARCHAR(50),
    alternative_position_code VARCHAR(50)
);

INSERT INTO temp_m13_players VALUES
('Tomas','Badra',NULL,NULL,NULL,NULL),
('Luca','Ballatore','53263788','2013-11-01','second_line','third_line'),
('Dante','Barros Fachin','53504428','2013-07-23','wing_generic','scrum_half_generic'),
('Pedro','Beltrán','53481135','2013-10-02','second_line','third_line'),
('Pedro','Bernardi','52868692','2013-05-27','third_line','second_line'),
('Camilo','Branda',NULL,NULL,'first_line','second_line'),
('Francisco','Brandan',NULL,NULL,'first_line','second_line'),
('Tomas','Carranza','53263948','2013-08-06','fly_half_generic','fullback_generic'),
('Francisco','Castellanos','53223880','2013-06-25','first_line','third_line'),
('Salvador','Ceballos','52868612','2013-05-03','wing_generic','fullback_generic'),
('Dante','Cicarella','53504463',NULL,'second_line','third_line'),
('Ramiro','Citati','53481609','2013-10-21','wing_generic','fullback_generic'),
('Matías','Colino',NULL,NULL,'first_line','third_line'),
('Santino','De Almeida',NULL,NULL,'first_line','first_line'),
('Baltazar','De la Cuesta','52864210','2013-01-23','third_line','center_generic'),
('Ignacio','De Miguel','52962688','2013-03-07','center_generic','third_line'),
('Gregorio','Del Valle',NULL,NULL,'scrum_half_generic','wing_generic'),
('Agustín','Dellavedova',NULL,NULL,'second_line','first_line'),
('Cayetano','Ferla','53733849','2014-04-10','wing_generic','scrum_half_generic'),
('Greogorio','Fernandez','52866602','2013-04-09','center_generic','third_line'),
('Tomas','Ferrer','53078262','2013-06-13','first_line','third_line'),
('Santiago','Ferro','53407555','2013-08-29','wing_generic','center_generic'),
('Gregorio','Gacitúa',NULL,NULL,'wing_generic','scrum_half_generic'),
('Ignacio','Grenat',NULL,NULL,'first_line','second_line'),
('Joaquín','Hadad',NULL,NULL,'second_line','first_line'),
('Dylan','Haymal','52867062',NULL,'first_line','second_line'),
('Rimón','Huespe',NULL,NULL,'second_line','third_line'),
('Tomer','Iacomo','53264383','2013-08-14','second_line','first_line'),
('Segundo','Idoyaga',NULL,NULL,'third_line','wing_generic'),
('Facundo','Isaia','53507209','2013-10-31','first_line','third_line'),
('Mateo','Juaneda',NULL,NULL,'scrum_half_generic','fly_half_generic'),
('Augusto','Lascano',NULL,NULL,'second_line','third_line'),
('Genaro','Leonelli','53264381','2013-08-12','third_line','second_line'),
('Benjamín','Lorenzi Zamboni','52866926','2013-04-11','scrum_half_generic','fly_half_generic'),
('Pedro','Lozada','52868447','2013-05-05','second_line','third_line'),
('Francisco','Martinolli',NULL,NULL,'first_line','second_line'),
('Genaro','Mateo','53078553','2013-09-02','first_line','second_line'),
('Felipe','Mayer','53077915','2013-05-28','wing_generic','center_generic'),
('Santiago','Mayer','53077914','2013-05-28','center_generic','third_line'),
('Benicio','Mellano','53583417','2013-10-29','wing_generic','second_line'),
('Bautista','Meroi','53506332','2013-12-02','first_line','fly_half_generic'),
('Ignacio','Molina','53075483','2013-03-24','second_line','third_line'),
('Felipe','Nebbia','53481130','2013-09-30','third_line','wing_generic'),
('Cristobal','Novillo',NULL,NULL,'first_line','second_line'),
('Vicente','Oliva','53481621','2013-10-21','scrum_half_generic','fly_half_generic'),
('Constantino','Olocco','52865217','2013-02-05','first_line','second_line'),
('Federico','Pez','53507783','2013-12-19','fly_half_generic','center_generic'),
('Vicente','Quaglia',NULL,NULL,'second_line','first_line'),
('Toto','Ramirez','53262419','2013-07-29','first_line','second_line'),
('Facundo','Robino','52962656','2013-02-21','second_line','third_line'),
('Emiliano','Rocca','53076127','2013-05-11','second_line','third_line'),
('Conrado','Roggio',NULL,NULL,'second_line','third_line'),
('Facundo','Romero Victorica','53076442','2013-04-18','scrum_half_generic','fly_half_generic'),
('Gregorio','Roque Allende',NULL,NULL,'first_line','third_line'),
('Pedro','Rotundo','53426503','2013-09-20','first_line','first_line'),
('Facundo','Rubioli','52863529','2013-01-18','center_generic','third_line'),
('Santiago','Ruiz Orszo',NULL,NULL,'second_line','first_line'),
('Tomas','Salort','53472897','2013-10-10',NULL,NULL),
('Francisco','Sanchez','53099258','2013-04-04','fullback_generic','third_line'),
('Octavio','Segovia','52868695','2013-05-29','third_line','first_line'),
('Santino','Sosa','52866931','2013-04-13','first_line','second_line'),
('Federico','Taborda','53119061','2013-04-13','fly_half_generic','center_generic'),
('Cristobal Toto','Tosco','52868630','2013-05-16','center_generic','third_line'),
('Clemente','Vazquez','52868630','2013-03-21','first_line','first_line'),
('Santiago','Vera','53117019','2013-03-22','wing_generic','center_generic'),
('Patricio','Viale','53078338','2013-07-04','wing_generic','wing_generic'),
('Lautaro','Videla','52864316','2013-03-01','first_line','first_line'),
('Camilo','Villegas','52863928','2013-01-30','third_line','third_line'),
('Justo','Zamorato','52859156','2013-01-16','first_line','first_line'),
('Felipe','Zeballos','53504525','2013-11-06','first_line','second_line');

INSERT INTO players (
    first_name,
    last_name,
    document_number,
    birth_date
)
SELECT
    first_name,
    last_name,
    document_number,
    birth_date
FROM temp_m13_players;

INSERT INTO player_teams (
    player_id,
    team_id,
    primary_position_id,
    alternative_position_id,
    active,
    joined_at,
    created_by
)
SELECT
    p.id,
    t.id,
    pp1.id,
    pp2.id,
    TRUE,
    '2026-02-01',
    'seed'
FROM temp_m13_players tmp
JOIN players p
    ON p.first_name = tmp.first_name
   AND p.last_name = tmp.last_name
JOIN teams t
    ON t.name = 'M13'
JOIN seasons s
    ON s.id = t.season_id
   AND s.year = 2026
LEFT JOIN player_positions pp1
    ON pp1.code = tmp.primary_position_code
LEFT JOIN player_positions pp2
    ON pp2.code = tmp.alternative_position_code;


    