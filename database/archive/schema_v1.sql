-- Rugby Attendance App - Schema V1

-- Drop tables in dependency order
DROP TABLE IF EXISTS match_events CASCADE;
DROP TABLE IF EXISTS match_player_records CASCADE;
DROP TABLE IF EXISTS matches CASCADE;
DROP TABLE IF EXISTS player_evaluation_items CASCADE;
DROP TABLE IF EXISTS player_evaluations CASCADE;
DROP TABLE IF EXISTS athletic_test_results CASCADE;
DROP TABLE IF EXISTS player_measurements CASCADE;
DROP TABLE IF EXISTS attendance_records CASCADE;
DROP TABLE IF EXISTS training_sessions CASCADE;
DROP TABLE IF EXISTS team_coaches CASCADE;
DROP TABLE IF EXISTS player_teams CASCADE;

DROP TABLE IF EXISTS match_event_types CASCADE;
DROP TABLE IF EXISTS match_types CASCADE;
DROP TABLE IF EXISTS evaluation_criteria CASCADE;
DROP TABLE IF EXISTS evaluation_categories CASCADE;
DROP TABLE IF EXISTS athletic_test_types CASCADE;
DROP TABLE IF EXISTS training_session_types CASCADE;
DROP TABLE IF EXISTS attendance_statuses CASCADE;
DROP TABLE IF EXISTS coach_roles CASCADE;
DROP TABLE IF EXISTS player_positions CASCADE;

DROP TABLE IF EXISTS coaches CASCADE;
DROP TABLE IF EXISTS players CASCADE;
DROP TABLE IF EXISTS teams CASCADE;
DROP TABLE IF EXISTS seasons CASCADE;
DROP TABLE IF EXISTS clubs CASCADE;


-- Core tables

CREATE TABLE clubs (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    short_name VARCHAR(50),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE seasons (
    id SERIAL PRIMARY KEY,
    year INTEGER NOT NULL UNIQUE,
    description VARCHAR(100),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE teams (
    id SERIAL PRIMARY KEY,
    club_id INTEGER NOT NULL REFERENCES clubs(id),
    season_id INTEGER NOT NULL REFERENCES seasons(id),
    name VARCHAR(50) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (club_id, season_id, name)
);

CREATE TABLE players (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE NOT NULL,
    document_number VARCHAR(50),
    email VARCHAR(150),
    phone VARCHAR(50),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE coaches (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    document_number VARCHAR(50),
    email VARCHAR(150),
    phone VARCHAR(50),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Lookup tables

CREATE TABLE player_positions (
    id SERIAL PRIMARY KEY,
    player_position_number INTEGER NOT NULL UNIQUE,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    position_group VARCHAR(30) NOT NULL,
    position_sub_group VARCHAR(50) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE coach_roles (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE attendance_statuses (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE training_session_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE athletic_test_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    unit VARCHAR(50) NOT NULL,
    lower_is_better BOOLEAN NOT NULL DEFAULT FALSE,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE evaluation_categories (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE evaluation_criteria (
    id SERIAL PRIMARY KEY,
    evaluation_category_id INTEGER NOT NULL REFERENCES evaluation_categories(id),
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE match_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE match_event_types (
    id SERIAL PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description VARCHAR(100) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Team relations

CREATE TABLE player_teams (
    id SERIAL PRIMARY KEY,
    player_id INTEGER NOT NULL REFERENCES players(id),
    team_id INTEGER NOT NULL REFERENCES teams(id),
    primary_position_id INTEGER REFERENCES player_positions(id),
    alternative_position_id INTEGER REFERENCES player_positions(id),
    active BOOLEAN NOT NULL DEFAULT TRUE,
    joined_at DATE,
    left_at DATE,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (player_id, team_id)
);

CREATE TABLE team_coaches (
    id SERIAL PRIMARY KEY,
    team_id INTEGER NOT NULL REFERENCES teams(id),
    coach_id INTEGER NOT NULL REFERENCES coaches(id),
    coach_role_id INTEGER NOT NULL REFERENCES coach_roles(id),
    priority INTEGER DEFAULT 1,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    joined_at DATE,
    left_at DATE,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (team_id, coach_id, coach_role_id)
);


-- Training and attendance

CREATE TABLE training_sessions (
    id SERIAL PRIMARY KEY,
    team_id INTEGER NOT NULL REFERENCES teams(id),
    training_session_type_id INTEGER NOT NULL REFERENCES training_session_types(id),
    session_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    location VARCHAR(150),
    description VARCHAR(250),
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE attendance_records (
    id SERIAL PRIMARY KEY,
    player_team_id INTEGER NOT NULL REFERENCES player_teams(id),
    training_session_id INTEGER NOT NULL REFERENCES training_sessions(id),
    attendance_status_id INTEGER NOT NULL REFERENCES attendance_statuses(id),
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (player_team_id, training_session_id)
);


-- Physical measurements and athletic tests

CREATE TABLE player_measurements (
    id SERIAL PRIMARY KEY,
    player_team_id INTEGER NOT NULL REFERENCES player_teams(id),
    measurement_date DATE NOT NULL,
    height_cm NUMERIC(5,2),
    weight_kg NUMERIC(5,2),
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE athletic_test_results (
    id SERIAL PRIMARY KEY,
    player_team_id INTEGER NOT NULL REFERENCES player_teams(id),
    athletic_test_type_id INTEGER NOT NULL REFERENCES athletic_test_types(id),
    test_date DATE NOT NULL,
    value NUMERIC(8,2) NOT NULL,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Player evaluations

CREATE TABLE player_evaluations (
    id SERIAL PRIMARY KEY,
    player_team_id INTEGER NOT NULL REFERENCES player_teams(id),
    evaluator_coach_id INTEGER REFERENCES coaches(id),
    evaluation_date DATE NOT NULL,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE player_evaluation_items (
    id SERIAL PRIMARY KEY,
    player_evaluation_id INTEGER NOT NULL REFERENCES player_evaluations(id),
    evaluation_criteria_id INTEGER NOT NULL REFERENCES evaluation_criteria(id),
    score INTEGER NOT NULL,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (score BETWEEN 1 AND 10),
    UNIQUE (player_evaluation_id, evaluation_criteria_id)
);


-- Matches

CREATE TABLE matches (
    id SERIAL PRIMARY KEY,
    team_id INTEGER NOT NULL REFERENCES teams(id),
    match_type_id INTEGER NOT NULL REFERENCES match_types(id),
    match_date DATE NOT NULL,
    opponent_name VARCHAR(100) NOT NULL,
    location VARCHAR(150),
    home_away VARCHAR(20),
    score_for INTEGER,
    score_against INTEGER,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CHECK (home_away IN ('home', 'away', 'neutral'))
);

CREATE TABLE match_player_records (
    id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL REFERENCES matches(id),
    player_team_id INTEGER NOT NULL REFERENCES player_teams(id),
    player_position_id INTEGER REFERENCES player_positions(id),
    starter BOOLEAN NOT NULL DEFAULT FALSE,
    captain BOOLEAN NOT NULL DEFAULT FALSE,
    minutes_played INTEGER,
    jersey_number INTEGER,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (match_id, player_team_id)
);

CREATE TABLE match_events (
    id SERIAL PRIMARY KEY,
    match_id INTEGER NOT NULL REFERENCES matches(id),
    player_team_id INTEGER REFERENCES player_teams(id),
    match_event_type_id INTEGER NOT NULL REFERENCES match_event_types(id),
    minute INTEGER,
    value NUMERIC(8,2) DEFAULT 1,
    notes TEXT,
    created_by VARCHAR(100),
    updated_by VARCHAR(100),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);


-- Useful indexes

CREATE INDEX idx_teams_club_season ON teams(club_id, season_id);
CREATE INDEX idx_player_teams_player ON player_teams(player_id);
CREATE INDEX idx_player_teams_team ON player_teams(team_id);
CREATE INDEX idx_team_coaches_team ON team_coaches(team_id);
CREATE INDEX idx_training_sessions_team_date ON training_sessions(team_id, session_date);
CREATE INDEX idx_attendance_records_session ON attendance_records(training_session_id);
CREATE INDEX idx_attendance_records_player_team ON attendance_records(player_team_id);
CREATE INDEX idx_player_measurements_player_team_date ON player_measurements(player_team_id, measurement_date);
CREATE INDEX idx_athletic_test_results_player_team_date ON athletic_test_results(player_team_id, test_date);
CREATE INDEX idx_player_evaluations_player_team_date ON player_evaluations(player_team_id, evaluation_date);
CREATE INDEX idx_matches_team_date ON matches(team_id, match_date);
CREATE INDEX idx_match_player_records_match ON match_player_records(match_id);
CREATE INDEX idx_match_events_match ON match_events(match_id);
