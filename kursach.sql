CREATE TYPE PRODUCER_ROLES AS ENUM ('producer', 'executive producer', 'co-producer', 'associate producer', 
 'assistant producer', 'line producer', 'administrative producer', 'creative producer', 'information producer');
CREATE TYPE EDITOR_POSITIONS AS ENUM ('literature editor', 'technical editor' , 'art editor', 'main editor');
CREATE TYPE ARTIST_TYPES AS ENUM ('character artist', 'battle artist', 'location artist', 'background artist', 'effect artist', 
 'animation artist', 'coloring artist');
CREATE TYPE PROCESS_STATUS AS ENUM ('started', 'in process', 'revision', 'finished');
CREATE TYPE INSERTION_LOCATIONS AS ENUM ('the beginning', 'the middle', 'the end');
CREATE TYPE SOUND_TYPES AS ENUM ('music', 'noises');
CREATE TYPE DIGITIZATION_TYPES AS ENUM ('adding contrast, then scanning', 'scanning, then adding contrast');
CREATE TYPE REVISION_TYPES AS ENUM ('full revision', 'part revision');
CREATE TYPE COLORING_TYPES AS ENUM ('colored', 'black-white');
CREATE TYPE VOICE_ACTING_TYPES AS ENUM ('preliminary', 'follow-up');
CREATE TYPE PLOT_TYPES AS ENUM ('main', 'additional', 'spin-off');
CREATE TYPE LOCATION_TYPES AS ENUM ('field', 'forest', 'city', 'village', 'jungle', 'lake', 'mounatains', 'desert', 'cave', 'waterfall', 'castle');
CREATE TYPE ABILITY_TYPES AS ENUM ('attack', 'defence', 'heal', 'chatting');
CREATE TYPE USING_TECHNOLOGIES AS ENUM ('drawings', 'dolls', '3D');
CREATE TYPE ARTIFACT_TYPES AS ENUM ('image', 'video', 'text', 'music', 'sounds');
CREATE TYPE EFFECT_LEVELS AS ENUM('AAA', 'AA', 'A', 'BBB', 'BB', 'B', 'CCC', 'CC', 'C');
CREATE TYPE RECORDING_ACTORS_POSITIONS AS ENUM('main', 'second_role');

/*
*сущность рабочие и все её характеристические сущности
*/
CREATE TABLE workers(
    MAIN_WORKER_ID SERIAL,
    NAME VARCHAR(32) NOT NULL,
    SECOND_NAME VARCHAR(32) NOT NULL,
    GENDER VARCHAR(32) NOT NULL,
    PLACE_OF_BIRTH TEXT NOT NULL,
    CONSTRAINT WORKERS_PK PRIMARY KEY(MAIN_WORKER_ID)
);
CREATE INDEX workers_full_name_idx ON workers (SECOND_NAME, NAME);
CREATE INDEX workers_id_idx ON workers USING hash (MAIN_WORKER_ID);

CREATE TABLE storyboard_artists(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT STORYBOARD_ARTISTS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX storyboard_artists_id_idx ON storyboard_artists USING hash (WORKER_ID);
CREATE INDEX storyboard_artists_main_worker_id_idx ON storyboard_artists USING hash (MAIN_WORKER_ID);

CREATE TABLE producers(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ROLE PRODUCER_ROLES,
    CONSTRAINT PRODUCERS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX producers_id_idx ON producers USING hash (WORKER_ID);
CREATE INDEX producers_main_worker_id_idx ON producers USING hash (MAIN_WORKER_ID);

CREATE TABLE audio_specialist(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT AUDIO_SPECIALIST_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX audio_specialist_id_idx ON audio_specialist USING hash (WORKER_ID);
CREATE INDEX audio_specialist_main_worker_id_idx ON audio_specialist USING hash (MAIN_WORKER_ID);

CREATE TABLE digitizers(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DIGITIZERS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX digitizers_id_idx ON digitizers USING hash (WORKER_ID);
CREATE INDEX digitizers_main_worker_id_idx ON digitizers USING hash (MAIN_WORKER_ID);

CREATE TABLE smoothing_specialist(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SMOOTHING_SPECIALIST_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX smoothing_specialist_id_idx ON smoothing_specialist USING hash (WORKER_ID);
CREATE INDEX smoothing_specialist_main_worker_id_idx ON smoothing_specialist USING hash (MAIN_WORKER_ID);

CREATE TABLE art_director(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ART_DIRECTOR_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX art_director_id_idx ON art_director USING hash (WORKER_ID);
CREATE INDEX art_director_main_worker_id_idx ON art_director USING hash (MAIN_WORKER_ID);

CREATE TABLE screenwriters(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FILMS_NUMBER INTEGER,
    CONSTRAINT SCREENWRITERS_PK PRIMARY KEY(WORKER_ID),
    CONSTRAINT SCREENWRITER_FILMS_NUMBER_CHECK CHECK(FILMS_NUMBER >= 0)
);
CREATE INDEX screenwriters_id_idx ON screenwriters USING hash (WORKER_ID);
CREATE INDEX screenwriters_main_worker_id_idx ON screenwriters USING hash (MAIN_WORKER_ID);

CREATE TABLE regisseurs(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FILMS_NUMBER INTEGER,
    CONSTRAINT REGISSEURS_PK PRIMARY KEY(WORKER_ID),
    CONSTRAINT REGISSEURS_FILMS_NUMBER_CHECK CHECK(FILMS_NUMBER >= 0)
);
CREATE INDEX regisseurs_id_idx ON regisseurs USING hash (WORKER_ID);
CREATE INDEX regisseurs_main_worker_id_idx ON regisseurs USING hash (MAIN_WORKER_ID);

CREATE TABLE roles_designers(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ROLES_DESIGNERS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX roles_designers_id_idx ON roles_designers USING hash (WORKER_ID);
CREATE INDEX roles_designers_main_worker_id_idx ON roles_designers USING hash (MAIN_WORKER_ID);

CREATE TABLE recording_actors(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    POSITION RECORDING_ACTORS_POSITIONS,
    CONSTRAINT RECORDING_ACTORS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX recording_actors_id_idx ON recording_actors USING hash (WORKER_ID);
CREATE INDEX recording_actors_main_worker_id_idx ON recording_actors USING hash (MAIN_WORKER_ID);

CREATE TABLE editors(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    POSITION EDITOR_POSITIONS,
    CONSTRAINT EDITORS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX editors_id_idx ON editors USING hash (WORKER_ID);
CREATE INDEX editors_main_worker_id_idx ON editors USING hash (MAIN_WORKER_ID);

CREATE TABLE artists(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ARTIST_TYPE ARTIST_TYPES,
    USING_TECHNOLOGY USING_TECHNOLOGIES,
    CONSTRAINT ARTISTS_PK PRIMARY KEY(WORKER_ID)
);
CREATE INDEX artists_id_idx ON artists USING hash (WORKER_ID);
CREATE INDEX artists_main_worker_id_idx ON artists USING hash (MAIN_WORKER_ID);

/*
*сущность users
*/
CREATE TABLE users(
    USER_ID SERIAL PRIMARY KEY,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    LOGIN VARCHAR(32) UNIQUE NOT NULL,
    USER_PASSWORD TEXT NOT NULL,
    EMAIL VARCHAR(32),
    AVATAR_FILE_LINK TEXT,
    LAST_LOG_OUT DATE
);
CREATE INDEX IF NOT EXISTS users_pk_idx ON users USING hash(USER_ID);
CREATE INDEX user_email_full_idx ON users(LOGIN, EMAIL);

CREATE TABLE roles(
    ROLE_VALUE VARCHAR(32) PRIMARY KEY
);

CREATE TABLE users_roles(
    USER_ID INTEGER REFERENCES users(USER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ROLE_VALUE VARCHAR(32) REFERENCES roles(ROLE_VALUE) ON UPDATE CASCADE ON DELETE CASCADE
);

insert into roles values('ROLE_ART_DIRECTOR');
insert into roles values('ROLE_ARTIST');
insert into roles values('ROLE_AUDIO_SPECIALIST');
insert into roles values('ROLE_DIGITIZER');
insert into roles values('ROLE_EDITOR');
insert into roles values('ROLE_PRODUCER');
insert into roles values('ROLE_RECORDING_ACTOR');
insert into roles values('ROLE_REGISSEUR');
insert into roles values('ROLE_ROLES_DESIGNER');
insert into roles values('ROLE_SCREENWRITER');
insert into roles values('ROLE_SMOOTHING_SPECIALIST');
insert into roles values('ROLE_STORYBOARD_ARTIST');


/*
*создание сущности продукт
*/
CREATE TABLE products(
    PRODUCT_ID SERIAL PRIMARY KEY,
    POSTER_PATH TEXT,
    DESCRIPTION TEXT,
    PRODUCT_NAME VARCHAR(32),
    AUTHOR_NAME VARCHAR(64)
);

CREATE TABLE users_products(
    USER_ID INTEGER REFERENCES users(USER_ID) ON UPDATE CASCADE ON DELETE SET NULL,
    PRODUCT_ID INTEGER REFERENCES products(PRODUCT_ID) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE OR REPLACE FUNCTION create_product(
    poster_path TEXT,
    description TEXT,
    product_name VARCHAR,
    author_name VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    prod_id INTEGER;
BEGIN
    INSERT INTO products(POSTER_PATH, DESCRIPTION, PRODUCT_NAME, AUTHOR_NAME) VALUES(poster_path, description, product_name, author_name) RETURNING PRODUCT_ID INTO prod_id;
    RETURN prod_id;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION associate_product_and_user(
    product_id INTEGER,
    user_id INTEGER
) RETURNS BOOLEAN AS 
$$
BEGIN
    INSERT INTO users_products(USER_ID, PRODUCT_ID) VALUES(user_id, product_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql;

/*
*сущность процессы и все её характеристические сущности
*/
CREATE TABLE processes(
    MAIN_PROCESS_ID SERIAL,
    PRODUCT_ID INTEGER REFERENCES products(PRODUCT_ID) ON UPDATE CASCADE ON DELETE SET NULL,
    DURATION INTEGER NOT NULL,
    DEADLINE_DATE TIMESTAMP NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    STATUS PROCESS_STATUS NOT NULL,
    START_DATE TIMESTAMP NOT NULL,
    CONSTRAINT PROCESSES_PK PRIMARY KEY(MAIN_PROCESS_ID),
    CONSTRAINT PROCESSES_DURATION_CHECK CHECK(DURATION > 0),
    CONSTRAINT PROCESS_DATES_CHECk CHECK(DEADLINE_DATE > START_DATE)
);
CREATE INDEX processes_id_idx ON processes USING hash (MAIN_PROCESS_ID);
CREATE INDEX process_status_idx ON processes (STATUS);

CREATE TABLE storyboard_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FRAME_NUMBER INTEGER,
    CONSTRAINT STORYBOARD_PROCESS_PK PRIMARY KEY(PROCESS_ID),
    CONSTRAINT STORYBOARD_PROCESS_FRAME_NUMBER_CHECK CHECK(FRAME_NUMBER >= 0)
);
CREATE INDEX storyboard_process_id_idx ON storyboard_process USING hash (PROCESS_ID);
CREATE INDEX storyboard_process_main_process_id_idx ON storyboard_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX frame_number_idx ON storyboard_process (FRAME_NUMBER);

CREATE TABLE advertising_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    INSERTION_LOCATION INSERTION_LOCATIONS,
    CONSTRAINT ADVERTISNG_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX advertising_process_id_idx ON advertising_process USING hash (PROCESS_ID);
CREATE INDEX advertising_process_main_process_id_idx ON advertising_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX insertion_location_idx ON advertising_process (INSERTION_LOCATION);

CREATE TABLE adding_sound_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    SOUND_TYPE SOUND_TYPES,
    CONSTRAINT ADDING_SOUND_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX adding_sound_process_id_idx ON adding_sound_process USING hash (PROCESS_ID);
CREATE INDEX adding_sound_process_main_process_id_idx ON adding_sound_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX sound_type ON adding_sound_process (SOUND_TYPE);

CREATE TABLE digitization_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    SKETCHES_NUMBER INTEGER,
    DIGITIZATION_TYPE DIGITIZATION_TYPES,
    CONSTRAINT DIGITIZATION_PROCESS_PK PRIMARY KEY(PROCESS_ID),
    CONSTRAINT DIGITIZATION_PROCESS_SKETCHES_NUMBER_CHECK CHECK(SKETCHES_NUMBER >= 0)
);
CREATE INDEX digitization_process_id_idx ON digitization_process USING hash (PROCESS_ID);
CREATE INDEX digitization_process_main_process_id_idx ON digitization_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX digitization_type_idx ON digitization_process (DIGITIZATION_TYPE);

CREATE TABLE smoothing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SMOOTHING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX smoothing_process_id_idx ON smoothing_process USING hash (PROCESS_ID);
CREATE INDEX smoothing_process_main_process_id_idx ON smoothing_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE revisions_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    REVISION_TYPE REVISION_TYPES,
    CONSTRAINT REVISIONS_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX revisions_process_id_idx ON revisions_process USING hash (PROCESS_ID);
CREATE INDEX revisions_process_main_process_id_idx ON revisions_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX revision_type_idx ON revisions_process (REVISION_TYPE);

CREATE TABLE coloring_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    COLORING_TYPE COLORING_TYPES,
    CONSTRAINT COLORING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX coloring_process_id_idx ON coloring_process USING hash (PROCESS_ID);
CREATE INDEX coloring_process_main_process_id_idx ON coloring_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX coloring_type_idx ON coloring_process (COLORING_TYPE);

CREATE TABLE animation_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FRAME_RATE INTEGER,
    ANIMATION_TECHNOLOGY VARCHAR(32),
    CONSTRAINT ANIMATION_PROCESS_PK PRIMARY KEY(PROCESS_ID),
    CONSTRAINT ANIMATION_PROCESS_FRAME_RATE_CHECK CHECK(FRAME_RATE > 0)
);
CREATE INDEX animation_process_id_idx ON animation_process USING hash (PROCESS_ID);
CREATE INDEX animation_process_main_process_id_idx ON animation_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX animation_technology_idx ON animation_process (ANIMATION_TECHNOLOGY);

CREATE TABLE adding_effect_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    EFFECT_LEVEL EFFECT_LEVELS,
    CONSTRAINT ADDING_EFFECT_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX adding_effect_process_id_idx ON adding_effect_process USING hash (PROCESS_ID);
CREATE INDEX adding_effect_process_main_process_id_idx ON adding_effect_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX effect_level_idx ON adding_effect_process (EFFECT_LEVEL);

CREATE TABLE location_drawing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT LOCATION_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX location_drawing_process_id_idx ON location_drawing_process USING hash (PROCESS_ID);
CREATE INDEX location_drawing_process_main_process_id_idx ON location_drawing_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE battle_drawing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX battle_drawing_process_id_idx ON battle_drawing_process USING hash (PROCESS_ID);
CREATE INDEX battle_drawing_process_main_process_id_idx ON battle_drawing_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE character_drawing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTER_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX character_drawing_process_id_idx ON character_drawing_process USING hash (PROCESS_ID);
CREATE INDEX character_drawing_process_main_process_id_idx ON character_drawing_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE character_select_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTER_SELECT_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX character_select_process_id_idx ON character_select_process USING hash (PROCESS_ID);
CREATE INDEX character_select_process_main_process_id_idx ON character_select_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE voice_acting_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    VOICE_ACTING_TYPE VOICE_ACTING_TYPES,
    CONSTRAINT VOICE_ACTING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX voice_acting_process_id_idx ON voice_acting_process USING hash (PROCESS_ID);
CREATE INDEX voice_acting_process_main_process_id_idx ON voice_acting_process USING hash (MAIN_PROCESS_ID);
CREATE INDEX voice_acting_type ON voice_acting_process (VOICE_ACTING_TYPE);

CREATE TABLE ability_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ABILITY_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX ability_description_process_id_idx ON ability_description_process USING hash (PROCESS_ID);
CREATE INDEX ability_description_process_main_process_id_idx ON ability_description_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE character_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTER_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX character_description_process_id_idx ON character_description_process USING hash (PROCESS_ID);
CREATE INDEX character_description_process_main_process_id_idx ON character_description_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE location_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT LOCATION_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX location_description_process_id_idx ON location_description_process USING hash (PROCESS_ID);
CREATE INDEX location_description_process_main_process_id_idx ON location_description_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE battle_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX battle_description_process_id_idx ON battle_description_process USING hash (PROCESS_ID);
CREATE INDEX battle_description_process_main_process_id_idx ON battle_description_process USING hash (MAIN_PROCESS_ID);

CREATE TABLE plot_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PLOT_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);
CREATE INDEX plot_process_id_idx ON plot_process USING hash (PROCESS_ID);
CREATE INDEX plot_process_main_process_id_idx ON plot_process USING hash (MAIN_PROCESS_ID);

/*
*создание сущности артефакт
*/
CREATE TABLE artifacts(
    ARTIFACT_ID SERIAL,
    MAIN_WORKER_ID INTEGER REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE SET NULL,
    ARTIFACT_TYPE ARTIFACT_TYPES NOT NULL,
    SIZE INTEGER NOT NULL,
    UPLOAD_DATE TIMESTAMP NOT NULL,
    FILE_LINK TEXT NOT NULL,
    CONSTRAINT ARTIFACTS_PK PRIMARY KEY(ARTIFACT_ID),
    CONSTRAINT ARTIFACTS_SIZE_CHECK CHECK(SIZE >= 0)
);
CREATE INDEX artifact_id_idx ON artifacts USING hash (ARTIFACT_ID);
CREATE INDEX artifacts_main_worker_id_idx ON artifacts USING hash (MAIN_WORKER_ID);
CREATE INDEX artifact_type_idx ON artifacts (ARTIFACT_TYPE);
CREATE INDEX upload_date_idx ON artifacts (UPLOAD_DATE DESC);
CREATE INDEX artifact_type_upload_date_idx ON artifacts (ARTIFACT_TYPE, UPLOAD_DATE);

/*
*создание сущности история
*/



/*
*создание основных стержневых сущностей
*/
CREATE TABLE plot(
    PLOT_ID SERIAL,
    PLOT_PROCESS INTEGER REFERENCES plot_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PLOT_NAME VARCHAR(32) NOT NULL,
    PAGES_NUMBER INTEGER NOT NULL,
    PLOT_TYPE PLOT_TYPES NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    CONSTRAINT PLOT_PK PRIMARY KEY(PLOT_ID),
    CONSTRAINT PLOT_PAGES_NUMBER_CHECK CHECK(PAGES_NUMBER > 0)
);
CREATE INDEX plot_id_idx ON plot USING hash (PLOT_ID);
CREATE INDEX plot_process_idx ON plot USING hash (PLOT_PROCESS);
CREATE INDEX plot_name_idx ON plot USING hash (PLOT_NAME);

CREATE TABLE events(
    EVENT_ID SERIAL,
    EVENT_NAME VARCHAR(32) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    IMPORTANCE_LEVEL INTEGER NOT NULL,
    CONSTRAINT EVENTS_PK PRIMARY KEY(EVENT_ID),
    CONSTRAINT EVENTS_IMPORTANCE_LEVEL_CHECK CHECK(IMPORTANCE_LEVEL BETWEEN 0 AND 10)
);
CREATE INDEX event_id_idx ON events USING hash (EVENT_ID);
CREATE INDEX event_name_idx ON events USING hash (EVENT_NAME);

CREATE TABLE locations(
    LOCATION_ID SERIAL,
    DESCRIPTION_ID INTEGER REFERENCES location_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    DRAWING_ID INTEGER REFERENCES location_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    LOCATION_NAME VARCHAR(32) NOT NULL,
    AREA INTEGER NOT NULL,
    LOCATION_TYPE LOCATION_TYPES NOT NULL,
    FOR_BATTLE BOOLEAN NOT NULL,
    CONSTRAINT LOCATIONS_PK PRIMARY KEY(LOCATION_ID),
    CONSTRAINT LOCATIONS_AREA_CHECK CHECK(AREA > 0)
);
CREATE INDEX location_id_idx ON locations USING hash (LOCATION_ID);
CREATE INDEX location_description_id_idx ON locations USING hash (DESCRIPTION_ID);
CREATE INDEX location_drawing_id_idx ON locations USING hash (DRAWING_ID);
CREATE INDEX location_name_idx ON locations USING hash (LOCATION_NAME);

CREATE TABLE battle(
    BATTLE_ID SERIAL,
    DESCRIPTION_ID INTEGER REFERENCES battle_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    DRAWING_ID INTEGER REFERENCES battle_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    BATTLE_NAME VARCHAR(32) NOT NULL,
    DURATION NUMERIC(5,3) NOT NULL,
    CONSTRAINT BATTLE_PK PRIMARY KEY(BATTLE_ID)
);
CREATE INDEX battle_id ON battle USING hash (BATTLE_ID);
CREATE INDEX battle_description_id_idx ON battle USING hash (DESCRIPTION_ID);
CREATE INDEX battle_drawing_id_idx ON battle USING hash (DRAWING_ID);
CREATE INDEX battle_name_idx ON battle USING hash (BATTLE_NAME);

CREATE TABLE abilities(
    ABILITY_ID SERIAL,
    DESCRIPTION_ID INTEGER REFERENCES ability_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ABILITY_NAME VARCHAR(32) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    ABILITY_TYPE ABILITY_TYPES NOT NULL,
    COMPLEXITY_LEVEL INTEGER NOT NULL,
    CONSTRAINT ABILITIES_PK PRIMARY KEY(ABILITY_ID),
    CONSTRAINT ABILITIES_COMPLEXITY_LEVEL_CHECK CHECK(COMPLEXITY_LEVEL BETWEEN 0 AND 10)
);
CREATE INDEX ability_id_idx ON abilities USING hash (ABILITY_ID);
CREATE INDEX ability_description_id_idx ON abilities USING hash (DESCRIPTION_ID);
CREATE INDEX ability_name_idx ON abilities USING hash (ABILITY_NAME);

CREATE TABLE character(
    CHARACTER_ID SERIAL,
    VOICE_ACTING_ID INTEGER REFERENCES voice_acting_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    SELECTION_ID INTEGER REFERENCES character_select_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    DRAWING_ID INTEGER REFERENCES character_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    DESCRIPTION_ID INTEGER REFERENCES character_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CHARACTER_NAME VARCHAR(32) NOT NULL,
    GENDER VARCHAR(32) NOT NULL,
    PROTAGONIST BOOLEAN NOT NULL,
    POSITIVE BOOLEAN NOT NULL,
    AGE INTEGER NOT NULL,
    BIRTH_DATE TIMESTAMP,
    CONSTRAINT CHARACTER_PK PRIMARY KEY(CHARACTER_ID),
    CONSTRAINT CHARACTER_AGE_CHECK CHECK(AGE > 0)
);
CREATE INDEX character_id_idx ON character USING hash (CHARACTER_ID);
CREATE INDEX character_voice_acting_id_idx ON character USING hash (VOICE_ACTING_ID);
CREATE INDEX character_selection_id_idx ON character USING hash (SELECTION_ID);
CREATE INDEX character_drawing_id_idx ON character USING hash (DRAWING_ID);
CREATE INDEX character_description_id_idx ON character USING hash (DESCRIPTION_ID);
CREATE INDEX character_name_idx ON character USING hash (CHARACTER_NAME);

/*
*создание ассоциаций между процессами
*/
CREATE TABLE revision_storyboarding(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PROCESS_ID INTEGER REFERENCES storyboard_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_STORYBOARDING_PK PRIMARY KEY(REVISION_ID, PROCESS_ID)
);
CREATE INDEX revision_storyboarding_revision_id_idx ON revision_storyboarding USING hash (REVISION_ID);
CREATE INDEX revision_storyboarding_process_id_idx ON revision_storyboarding USING hash (PROCESS_ID);

CREATE TABLE revision_adding_sound(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PROCESS_ID INTEGER REFERENCES adding_sound_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_ADDING_SOUND_PK PRIMARY KEY(REVISION_ID, PROCESS_ID)
);
CREATE INDEX revision_adding_sound_revision_id_idx ON revision_adding_sound USING hash (REVISION_ID);
CREATE INDEX revision_adding_sound_process_id_idx ON revision_adding_sound USING hash (PROCESS_ID);

CREATE TABLE revision_smoothing(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PROCESS_ID INTEGER REFERENCES smoothing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_SMOOTHING_PK PRIMARY KEY(REVISION_ID, PROCESS_ID)
);
CREATE INDEX revision_smoothing_revision_id_idx ON revision_smoothing USING hash (REVISION_ID);
CREATE INDEX revision_smoothing_process_id_idx ON revision_smoothing USING hash (PROCESS_ID);

CREATE TABLE revision_adding_effects(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PROCESS_ID INTEGER REFERENCES adding_effect_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_ADDING_EFFECTS_PK PRIMARY KEY(REVISION_ID, PROCESS_ID)
);
CREATE INDEX revision_adding_effects_revision_id_idx ON revision_adding_effects USING hash (REVISION_ID);
CREATE INDEX revision_adding_effects_process_id_idx ON revision_adding_effects USING hash (PROCESS_ID);

CREATE TABLE revision_animation(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PROCESS_ID INTEGER REFERENCES animation_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_ANIMATION_PK PRIMARY KEY(REVISION_ID, PROCESS_ID)
);
CREATE INDEX revision_animation_revision_id_idx ON revision_animation USING hash (REVISION_ID);
CREATE INDEX revision_animation_process_id_idx ON revision_animation USING hash (PROCESS_ID);

CREATE TABLE revision_coloring(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PROCESS_ID INTEGER REFERENCES coloring_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_COLORING_PK PRIMARY KEY(REVISION_ID, PROCESS_ID)
);
CREATE INDEX revision_coloring_revision_id_idx ON revision_coloring USING hash (REVISION_ID);
CREATE INDEX revision_coloring_process_id_idx ON revision_coloring USING hash (PROCESS_ID);

/*
*создание ассоциаций между процессами и выполняющими их работниками
*/
CREATE TABLE artist_storyboard_process(
    PROCESS_ID INTEGER REFERENCES storyboard_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES storyboard_artists(WORKER_ID) ON UPDATE CASCADE ON  DELETE CASCADE,
    CONSTRAINT ARTIST_STORYBOARD_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_storyboard_process_id_idx ON artist_storyboard_process USING hash (PROCESS_ID);
CREATE INDEX artist_storyboard_process_worker_id_idx ON artist_storyboard_process USING hash (WORKER_ID);

CREATE TABLE producer_advertising_process(
    PROCESS_ID INTEGER REFERENCES advertising_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES producers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PRODUCER_ADVERTISING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX producer_advertising_process_id_idx ON producer_advertising_process USING hash (PROCESS_ID);
CREATE INDEX producer_advertising_process_worker_id_idx ON producer_advertising_process USING hash (WORKER_ID);

CREATE TABLE audio_adding_process(
    PROCESS_ID INTEGER REFERENCES adding_sound_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES audio_specialist(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT AUDIO_ADDING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX audio_adding_process_id_idx ON audio_adding_process USING hash (PROCESS_ID);
CREATE INDEX audio_adding_process_worker_id_idx ON audio_adding_process USING hash (WORKER_ID);

CREATE TABLE digitizers_digitization_process(
    PROCESS_ID INTEGER REFERENCES digitization_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES digitizers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DIGITIZERS_DIGITIZATION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX digitizers_digitization_process_id_idx ON digitizers_digitization_process USING hash (PROCESS_ID);
CREATE INDEX digitizers_digitization_process_worker_id_idx ON digitizers_digitization_process USING hash (WORKER_ID);

CREATE TABLE smoother_smoothing_process(
    PROCESS_ID INTEGER REFERENCES smoothing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES smoothing_specialist(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SMOOTHER_SMOOTHING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX smoother_smoothing_process_id_idx ON smoother_smoothing_process USING hash (PROCESS_ID);
CREATE INDEX smoother_smoothing_process_worker_id_idx ON smoother_smoothing_process USING hash (WORKER_ID);

CREATE TABLE art_director_revision_process(
    PROCESS_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES art_director(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ART_DIRECTOR_REVISION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX art_director_revision_process_id_idx ON art_director_revision_process USING hash (PROCESS_ID);
CREATE INDEX art_director_revision_worker_id_idx ON art_director_revision_process USING hash (WORKER_ID);

CREATE TABLE artist_coloring_process(
    PROCESS_ID INTEGER REFERENCES coloring_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_COLORING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_coloring_process_id_idx ON artist_coloring_process USING hash (PROCESS_ID);
CREATE INDEX artist_coloring_process_worker_id_idx ON artist_coloring_process USING hash (WORKER_ID);

CREATE TABLE artist_animation_process(
    PROCESS_ID INTEGER REFERENCES animation_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_ANIMATION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_animation_process_id_idx ON artist_animation_process USING hash (PROCESS_ID);
CREATE INDEX artist_animation_process_worker_id_idx ON artist_animation_process USING hash (WORKER_ID);

CREATE TABLE artist_effects_process(
    PROCESS_ID INTEGER REFERENCES adding_effect_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_EFFECTS_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_effects_process_id_idx ON artist_effects_process USING hash (PROCESS_ID);
CREATE INDEX artist_effects_process_worker_id_idx ON artist_effects_process USING hash (WORKER_ID);

CREATE TABLE artist_location_drawing_process(
    PROCESS_ID INTEGER REFERENCES location_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_LOCATION_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_location_drawing_process_id_idx ON artist_location_drawing_process USING hash (PROCESS_ID);
CREATE INDEX artist_location_drawing_process_worker_id_idx ON artist_location_drawing_process USING hash (WORKER_ID);

CREATE TABLE artist_battle_drawing_process(
    PROCESS_ID INTEGER REFERENCES battle_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_BATTLE_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_battle_drawing_process_id_idx ON artist_battle_drawing_process USING hash (PROCESS_ID);
CREATE INDEX artist_battle_drawing_process_worker_id_idx ON artist_battle_drawing_process USING hash (WORKER_ID);

CREATE TABLE artist_character_drawing_process(
    PROCESS_ID INTEGER REFERENCES character_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_CHARACTER_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX artist_character_drawing_process_id_idx ON artist_character_drawing_process USING hash (PROCESS_ID);
CREATE INDEX artist_character_drawing_process_worker_id_idx ON artist_character_drawing_process USING hash (WORKER_ID);

CREATE TABLE editors_character_process(
    PROCESS_ID INTEGER REFERENCES character_select_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES editors(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EDITORS_CHARACTER_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX editors_character_process_id_idx ON editors_character_process USING hash (PROCESS_ID);
CREATE INDEX editors_character_process_worker_id_idx ON editors_character_process USING hash (WORKER_ID);

CREATE TABLE recorder_voice_acting_process(
    PROCESS_ID INTEGER REFERENCES voice_acting_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES recording_actors(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT RECORDER_VOICE_ACTING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX recorder_voice_acting_process_id_idx ON recorder_voice_acting_process USING hash (PROCESS_ID);
CREATE INDEX recorder_voice_acting_process_worker_id_idx ON recorder_voice_acting_process USING hash (WORKER_ID);

CREATE TABLE designer_ability_process(
    PROCESS_ID INTEGER REFERENCES ability_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES roles_designers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DESIGNER_ABILITY_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX designer_ability_process_id_idx ON designer_ability_process USING hash (PROCESS_ID);
CREATE INDEX designer_ability_process_worker_id_idx ON designer_ability_process USING hash (WORKER_ID);

CREATE TABLE designer_character_process(
    PROCESS_ID INTEGER REFERENCES character_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES roles_designers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DESIGNER_CHARACTER_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX designer_character_process_id_idx ON designer_character_process USING hash (PROCESS_ID);
CREATE INDEX designer_character_process_worker_id_idx ON designer_character_process USING hash (WORKER_ID);

CREATE TABLE regisseur_location_process(
    PROCESS_ID INTEGER REFERENCES location_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES regisseurs(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REGISSEUR_LOCATION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX regisseur_location_process_id_idx ON regisseur_location_process USING hash (PROCESS_ID);
CREATE INDEX regisseur_location_process_worker_id_idx ON regisseur_location_process USING hash (WORKER_ID);

CREATE TABLE screenwriter_battle_process(
    PROCESS_ID INTEGER REFERENCES battle_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES screenwriters(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SCREENWRITER_BATTLE_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX screenwriter_battle_process_id_idx ON screenwriter_battle_process USING hash (PROCESS_ID);
CREATE INDEX screenwriter_battle_process_worker_id_idx ON screenwriter_battle_process USING hash (WORKER_ID);

CREATE TABLE regisseurs_plot_process(
    PROCESS_ID INTEGER REFERENCES plot_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES regisseurs(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REGISSEURS_PLOT_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX regisseurs_plot_process_id_idx ON regisseurs_plot_process USING hash (PROCESS_ID);
CREATE INDEX regisseurs_plot_process_worker_id_idx ON regisseurs_plot_process USING hash (WORKER_ID);

CREATE TABLE screenwriter_plot_process(
    PROCESS_ID INTEGER REFERENCES plot_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES screenwriters(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SCREENWRITER_PLOT_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);
CREATE INDEX screenwriter_plot_process_id_idx ON screenwriter_plot_process USING hash (PROCESS_ID);
CREATE INDEX screenwriter_plot_process_worker_id_idx ON screenwriter_plot_process USING hash (WORKER_ID);

/*
*создание ассоциации между процессами и артефактами
*/
CREATE TABLE process_artifact(
    MAIN_PROCESS_ID INTEGER REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ARTIFACT_ID INTEGER REFERENCES artifacts(ARTIFACT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PROCESS_ARTIFACT_PK PRIMARY KEY(MAIN_PROCESS_ID, ARTIFACT_ID)
);
CREATE INDEX process_artifact_main_process_id_idx ON process_artifact USING hash (MAIN_PROCESS_ID);
CREATE INDEX process_artifact_artifact_id_idx ON process_artifact USING hash (ARTIFACT_ID);


/*
*создание ассоциаций между основными стержневыми сущностями
*/
CREATE TABLE events_plots(
    EVENT_ID INTEGER REFERENCES events(EVENT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PLOT_ID INTEGER REFERENCES plot(PLOT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVENTS_PLOTS_PK PRIMARY KEY(EVENT_ID, PLOT_ID)
);
CREATE INDEX events_plots_event_id_idx ON events_plots USING hash (EVENT_ID);
CREATE INDEX events_plots_plot_id_idx ON events_plots USING hash (PLOT_ID);

CREATE TABLE event_location(
    EVENT_ID INTEGER REFERENCES events(EVENT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    LOCATION_ID INTEGER REFERENCES locations(LOCATION_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVENT_LOCATION_PK PRIMARY KEY(EVENT_ID, LOCATION_ID)
);
CREATE INDEX event_location_event_id_idx ON event_location USING hash (EVENT_ID);
CREATE INDEX event_location_location_id_idx ON event_location USING hash (LOCATION_ID);

CREATE TABLE events_characters(
    EVENT_ID INTEGER REFERENCES events(EVENT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CHARACTER_ID INTEGER REFERENCES character(CHARACTER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVENTS_CHARACTERS_PK PRIMARY KEY(EVENT_ID, CHARACTER_ID)
);
CREATE INDEX events_characters_event_id_idx ON events_characters USING hash (EVENT_ID);
CREATE INDEX events_characters_character_id_idx ON events_characters USING hash (CHARACTER_ID);

CREATE TABLE battle_location(
    LOCATION_ID INTEGER REFERENCES locations(LOCATION_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    BATTLE_ID INTEGER REFERENCES battle(BATTLE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_LOCATION_PK PRIMARY KEY(BATTLE_ID, LOCATION_ID)
);
CREATE INDEX battle_location_location_id_idx ON battle_location USING hash (LOCATION_ID);
CREATE INDEX battle_location_battle_id_idx ON battle_location USING hash (BATTLE_ID);

CREATE TABLE battle_abilities(
    BATTLE_ID INTEGER REFERENCES battle(BATTLE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ABILITY_ID INTEGER REFERENCES abilities(ABILITY_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_ABILITIES_PK PRIMARY KEY(BATTLE_ID, ABILITY_ID)
);
CREATE INDEX battle_abilities_battle_id_idx ON battle_abilities USING hash (BATTLE_ID);
CREATE INDEX battle_abilities_ability_id_idx ON battle_abilities USING hash (ABILITY_ID);

CREATE TABLE battle_characters(
    BATTLE_ID INTEGER REFERENCES battle(BATTLE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CHARACTER_ID INTEGER REFERENCES character(CHARACTER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_CHARACTERS_PK PRIMARY KEY(BATTLE_ID, CHARACTER_ID)
);
CREATE INDEX battle_characters_battle_id_idx ON battle_characters USING hash (BATTLE_ID);
CREATE INDEX battle_characters_character_id_idx ON battle_characters USING hash (CHARACTER_ID);

CREATE TABLE characters_abilities(
    CHARACTER_ID INTEGER REFERENCES character(CHARACTER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ABILITY_ID INTEGER REFERENCES abilities(ABILITY_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTERS_ABILITIES_PK PRIMARY KEY(CHARACTER_ID, ABILITY_ID)
);
CREATE INDEX characters_abilities_character_id_idx ON characters_abilities USING hash (CHARACTER_ID);
CREATE INDEX characters_abilities_ability_id_idx ON characters_abilities USING hash (ABILITY_ID);

/*
*табличка для логирования инфы о триггерах
*/
CREATE TABLE trigger_info(
    ID SERIAL PRIMARY KEY,
    TG_OP TEXT NOT NULL,
    TG_RELNAME VARCHAR(32) NOT NULL,
    TG_NAME VARCHAR(32) NOT NULL,
    CREATION_TIME TIMESTAMP WITH TIME ZONE NOT NULL
);

/*
*функции для добавления и создания работников
*/
CREATE OR REPLACE FUNCTION add_worker(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    RETURN mw_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_storyboard_artist(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO storyboard_artists(MAIN_WORKER_ID) VALUES(mw_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_storyboard_artist(
    main_worker_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO storyboard_artists(MAIN_WORKER_ID) VALUES(main_worker_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_producer(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT,
    role VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO producers(MAIN_WORKER_ID, ROLE) VALUES(mw_id, role::PRODUCER_ROLES) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_producer(
    main_worker_id INTEGER,
    role VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO producers(MAIN_WORKER_ID, ROLE) VALUES(main_worker_id, role::PRODUCER_ROLES) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_audio_specialist(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO audio_specialist(MAIN_WORKER_ID) VALUES(mw_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_audio_specialist(
    main_worker_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO audio_specialist(MAIN_WORKER_ID) VALUES(main_worker_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_digitizer(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO digitizers(MAIN_WORKER_ID) VALUES(mw_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_digitizer(
    main_worker_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO digitizers(MAIN_WORKER_ID) VALUES(main_worker_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_smoothing_specialist(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO smoothing_specialist(MAIN_WORKER_ID) VALUES(mw_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_smoothing_specialist(
    main_worker_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO smoothing_specialist(MAIN_WORKER_ID) VALUES(main_worker_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_art_director(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO art_director(MAIN_WORKER_ID) VALUES(mw_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_art_director(
    main_worker_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO art_director(MAIN_WORKER_ID) VALUES(main_worker_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_screenwriter(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT,
    films_number INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO screenwriters(MAIN_WORKER_ID, FILMS_NUMBER) VALUES(mw_id, films_number) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_screenwriter(
    main_worker_id INTEGER,
    films_number INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO screenwriters(MAIN_WORKER_ID, FILMS_NUMBER) VALUES(main_worker_id, films_number) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_regisseur(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT,
    films_number INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO regisseurs(MAIN_WORKER_ID, FILMS_NUMBER) VALUES(mw_id, films_number) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_regisseur(
    main_worker_id INTEGER,
    films_number INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO regisseurs(MAIN_WORKER_ID, FILMS_NUMBER) VALUES(main_worker_id, films_number) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_roles_designer(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO roles_designers(MAIN_WORKER_ID) VALUES(mw_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_roles_designer(
    main_worker_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO roles_designers(MAIN_WORKER_ID) VALUES(main_worker_id) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_recording_actor(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT,
    pos VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO recording_actors(MAIN_WORKER_ID, POSITION) VALUES(mw_id, pos::RECORDING_ACTORS_POSITIONS) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_recording_actor(
    main_worker_id INTEGER,
    pos VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO recording_actors(MAIN_WORKER_ID, POSITION) VALUES(main_worker_id, pos::RECORDING_ACTORS_POSITIONS) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_editor(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT,
    pos VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO editors(MAIN_WORKER_ID, POSITION) VALUES(mw_id, pos::EDITOR_POSITIONS) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_editor(
    main_worker_id INTEGER,
    pos VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO editors(MAIN_WORKER_ID, POSITION) VALUES(main_worker_id, pos::EDITOR_POSITIONS) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_artist(
    name VARCHAR,
    second_name VARCHAR,
    gender VARCHAR,
    place_of_birth TEXT,
    artist_type VARCHAR,
    using_technology VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mw_id INTEGER;
    w_id INTEGER;
BEGIN
    INSERT INTO workers(NAME, SECOND_NAME, GENDER, PLACE_OF_BIRTH) VALUES(name, second_name, gender, place_of_birth) RETURNING MAIN_WORKER_ID INTO mw_id;
    INSERT INTO artists(MAIN_WORKER_ID, ARTIST_TYPE, USING_TECHNOLOGY) 
    VALUES(mw_id, artist_type::ARTIST_TYPES, using_technology::USING_TECHNOLOGIES) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_existing_artist(
    main_worker_id INTEGER,
    artist_type VARCHAR,
    using_technology VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    w_id INTEGER;
BEGIN
    INSERT INTO artists(MAIN_WORKER_ID, ARTIST_TYPE, USING_TECHNOLOGY) 
    VALUES(main_worker_id, artist_type::ARTIST_TYPES, using_technology::USING_TECHNOLOGIES) RETURNING WORKER_ID INTO w_id;
    RETURN w_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для добавления и создания процессов
*/
CREATE OR REPLACE FUNCTION create_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    RETURN mp_id;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION create_storyboard_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    frame_number INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO storyboard_process(MAIN_PROCESS_ID, FRAME_NUMBER) VALUES(mp_id, frame_number) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_storyboard_process(
    main_process_id INTEGER,
    frame_number INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO storyboard_process(MAIN_PROCESS_ID, FRAME_NUMBER) VALUES(main_process_id, frame_number) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_advertising_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    insertion_location VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO advertising_process(MAIN_PROCESS_ID, INSERTION_LOCATION) VALUES(mp_id, insertion_location::INSERTION_LOCATIONS) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_advertising_process(
    main_process_id INTEGER,
    insertion_location VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO advertising_process(MAIN_PROCESS_ID, INSERTION_LOCATION) VALUES(main_process_id, insertion_location::INSERTION_LOCATIONS) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_adding_sound_effect_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    sound_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO adding_sound_process(MAIN_PROCESS_ID, SOUND_TYPE) VALUES(mp_id, sound_type::SOUND_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_adding_sound_effect_process(
    main_process_id INTEGER,
    sound_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO adding_sound_process(MAIN_PROCESS_ID, SOUND_TYPE) VALUES(main_process_id, sound_type::SOUND_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_digitization_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    sketches_number INTEGER,
    digitization_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO digitization_process(MAIN_PROCESS_ID, SKETCHES_NUMBER, DIGITIZATION_TYPE) VALUES(mp_id, sketches_number, digitization_type::DIGITIZATION_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_digitization_process(
    main_process_id INTEGER,
    sketches_number INTEGER,
    digitization_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO digitization_process(MAIN_PROCESS_ID, SKETCHES_NUMBER, DIGITIZATION_TYPE) 
    VALUES(main_process_id, sketches_number, digitization_type::DIGITIZATION_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_smoothing_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO smoothing_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_smoothing_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO smoothing_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_revision_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    revision_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO revisions_process(MAIN_PROCESS_ID, REVISION_TYPE) VALUES(mp_id, revision_type::REVISION_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_revision_process(
    main_process_id INTEGER,
    revision_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO revisions_process(MAIN_PROCESS_ID, REVISION_TYPE) VALUES(main_process_id, revision_type::REVISION_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_coloring_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    coloring_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO coloring_process(MAIN_PROCESS_ID, COLORING_TYPE) VALUES(mp_id, coloring_type::COLORING_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_coloring_process(
    main_process_id INTEGER,
    coloring_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO coloring_process(MAIN_PROCESS_ID, COLORING_TYPE) VALUES(main_process_id, coloring_type::COLORING_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_animation_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    frame_rate INTEGER,
    animation_technology VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO animation_process(MAIN_PROCESS_ID, frame_rate, animation_technology) VALUES(mp_id, frame_rate, animation_technology) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_animation_process(
    main_process_id INTEGER,
    frame_rate INTEGER,
    animation_technology VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO animation_process(MAIN_PROCESS_ID, FRAME_RATE, ANIMATION_TECHNOLOGY) VALUES(main_process_id, frame_rate, animation_technology) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_adding_effect_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    effect_level VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO adding_effect_process(MAIN_PROCESS_ID, EFFECT_LEVEL) VALUES(mp_id, effect_level::EFFECT_LEVELS) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_adding_effect_process(
    main_process_id INTEGER,
    effect_level VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO adding_effect_process(MAIN_PROCESS_ID, EFFECT_LEVEL) VALUES(main_process_id, effect_level::EFFECT_LEVELS) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_location_drawing_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO location_drawing_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_location_drawing_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO location_drawing_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_battle_drawing_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO battle_drawing_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_battle_drawing_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO battle_drawing_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_character_drawing_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO character_drawing_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_character_drawing_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO character_drawing_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_character_select_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO character_select_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_character_select_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO character_select_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_voice_acting_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP,
    voice_acting_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO voice_acting_process(MAIN_PROCESS_ID, VOICE_ACTING_TYPE) VALUES(mp_id, voice_acting_type::VOICE_ACTING_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_voice_acting_process(
    main_process_id INTEGER,
    voice_acting_type VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO voice_acting_process(MAIN_PROCESS_ID, VOICE_ACTING_TYPE) VALUES(main_process_id, voice_acting_type::VOICE_ACTING_TYPES) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_ability_description_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO ability_description_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_ability_description_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO ability_description_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_character_description_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO character_description_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_character_description_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO character_description_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_location_description_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO location_description_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_location_description_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO location_description_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_battle_description_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO battle_description_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_battle_description_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO battle_description_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_plot_process(
    product_id INTEGER,
    duration INTEGER,
    deadline_date TIMESTAMP,
    description TEXT,
    status VARCHAR,
    start_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    mp_id INTEGER;
    p_id INTEGER;
BEGIN
    INSERT INTO processes(PRODUCT_ID, DURATION, DEADLINE_DATE, DESCRIPTION, STATUS, START_DATE) 
    VALUES(product_id, duration, deadline_date, description, status::PROCESS_STATUS, start_date) RETURNING MAIN_PROCESS_ID INTO mp_id;
    INSERT INTO plot_process(MAIN_PROCESS_ID) VALUES(mp_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_existing_plot_process(
    main_process_id INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    p_id INTEGER;
BEGIN
    INSERT INTO plot_process(MAIN_PROCESS_ID) VALUES(main_process_id) RETURNING PROCESS_ID INTO p_id;
    RETURN p_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для добавления артефактов
*/
CREATE OR REPLACE FUNCTION create_artifact(
    upload_user INTEGER,
    artifact_type VARCHAR,
    size INTEGER,
    upload_date TIMESTAMP,
    file_link TEXT
) RETURNS INTEGER AS
$$
DECLARE
    a_id INTEGER;
BEGIN
    INSERT INTO artifacts(MAIN_WORKER_ID, ARTIFACT_TYPE, SIZE, UPLOAD_DATE, FILE_LINK) 
    VALUES(upload_user, artifact_type::ARTIFACT_TYPES, size, upload_date, file_link) RETURNING ARTIFACT_ID INTO a_id;
    RETURN a_id;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для добавления основных стержневых сущностей
*/
CREATE OR REPLACE FUNCTION create_plot(
    process_id INTEGER,
    pages_number INTEGER,
    plot_type VARCHAR,
    description TEXT,
    plot_name VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    plot_id INTEGER;
BEGIN
    INSERT INTO plot(PROCESS_ID, PAGES_NUMBER, PLOT_TYPE, DESCRIPTION, PLOT_NAME) 
    VALUES(process_id, pages_number, plot_type::PLOT_TYPES, description, plot_name) RETURNING PLOT_ID INTO plot_id;
    RETURN plot_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_events(
    description TEXT,
    importance_level INTEGER,
    event_name VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    event_id INTEGER;
BEGIN
    INSERT INTO events(EVENT_NAME, DESCRIPTION, IMPORTANCE_LEVEL) 
    VALUES(event_name, description, importance_level) RETURNING EVENT_ID INTO event_id;
    RETURN event_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_locations(
    description_id INTEGER,
    drawing_id INTEGER,
    area INTEGER,
    location_type VARCHAR,
    for_battle BOOLEAN,
    location_name VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    location_id INTEGER;
BEGIN
    INSERT INTO locations(DESCRIPTION_ID, DRAWING_ID, AREA, LOCATION_TYPE, FOR_BATTLE, LOCATION_NAME) 
    VALUES(description_id, drawing_id, area, location_type::LOCATION_TYPES, for_battle, location_name) RETURNING LOCATION_ID INTO location_id;
    RETURN location_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_battle(
    description_id INTEGER,
    drawing_id INTEGER,
    duration NUMERIC,
    battle_name VARCHAR
) RETURNS INTEGER AS
$$
DECLARE
    battle_id INTEGER;
BEGIN
    INSERT INTO battle(DESCRIPTION_ID, DRAWING_ID, DURATION, BATTLE_NAME) 
    VALUES(description_id, drawing_id, duration, battle_name) RETURNING BATTLE_ID INTO battle_id;
    RETURN battle_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_abilities(
    description_id INTEGER,
    ability_name VARCHAR,
    description TEXT,
    ability_type VARCHAR,
    complexity_level INTEGER
) RETURNS INTEGER AS
$$
DECLARE
    ability_id INTEGER;
BEGIN
    INSERT INTO abilities(DESCRIPTION_ID, ABILITY_NAME, DESCRIPTION, ABILITY_TYPE, COMPLEXITY_LEVEL) 
    VALUES(description_id, ability_name, description, ability_type::ABILITY_TYPES, complexity_level) RETURNING ABILITY_ID INTO ability_id;
    RETURN ability_id;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION create_character(
    voice_acting_id INTEGER,
    selection_id INTEGER,
    drawing_id INTEGER,
    description_id INTEGER,
    character_name VARCHAR,
    gender VARCHAR,
    protagonist BOOLEAN,
    positive BOOLEAN,
    age INTEGER,
    birth_date TIMESTAMP
) RETURNS INTEGER AS
$$
DECLARE
    character_id INTEGER;
BEGIN
    INSERT INTO abilities(VOICE_ACTING_ID, SELECTION_ID, DRAWING_ID, DESCRIPTION_ID, CHARACTER_NAME, GENDER, PROTAGONIST, POSITIVE, AGE, BIRTH_DATE) 
    VALUES(voice_acting_id, selection_id, drawing_id, description_id, character_name, gender, protagonist, positive, age, birth_date) RETURNING CHARACTER_ID INTO character_id;
    RETURN character_id;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для заполнения ассоциаций между артефактами и процессами
*/
CREATE OR REPLACE FUNCTION associate_artifact_and_process(
    artifact_id INTEGER,
    main_process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO process_artifact(ARTIFACT_ID, MAIN_PROCESS_ID) VALUES(artifact_id, main_process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для заполнения ассоциаций между стержневыми сущностями
*/
CREATE OR REPLACE FUNCTION associate_event_and_location(
    location_id INTEGER,
    event_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO event_location(LOCATION_ID, EVENT_ID) VALUES(location_id, event_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_event_and_plot(
    event_id INTEGER,
    plot_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO events_plots(EVENT_ID, PLOT_ID) VALUES(event_id, plot_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_event_and_character(
    event_id INTEGER,
    character_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO events_characters(EVENT_ID, CHARACTER_ID) VALUES(event_id, character_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_battle_and_location(
    location_id INTEGER,
    battle_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO battle_location(LOCATION_ID, BATTLE_ID) VALUES(location_id, battle_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_battle_and_ability(
    battle_id INTEGER,
    ability_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO battle_abilities(BATTLE_ID, ABILITY_ID) VALUES(battle_id, ability_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_battle_and_character(
    battle_id INTEGER,
    character_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO battle_characters(BATTLE_ID, CHARACTER_ID) VALUES(battle_id, character_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_character_and_ability(
    ability_id INTEGER,
    character_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO characters_abilities(ABILITY_ID, CHARACTER_ID) VALUES(ability_id, character_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для заполнения ассоциаций между работниками и процессами
*/
CREATE OR REPLACE FUNCTION associate_storyboarder_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_storyboard_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_producer_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO producer_advertising_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_audio_specialist_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO audio_adding_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_digitizer_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO digitizers_digitization_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_smoother_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO smoother_smoothing_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_art_director_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO art_director_revision_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_artist_and_coloring_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_coloring_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_artist_and_animation_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_animation_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_artist_and_effects_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_effects_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_artist_and_location_drawing_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_location_drawing_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_artist_and_battle_drawing_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_battle_drawing_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_artist_and_character_drawing_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO artist_character_drawing_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_editor_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO editors_character_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_recorder_and_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO recorder_voice_acting_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_designer_and_ability_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO designer_ability_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_designer_and_character_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO designer_character_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_regisseur_and_location_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO regisseur_location_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_regisseur_and_plot_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO regisseurs_plot_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_screenwriter_and_battle_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO screenwriter_battle_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_screenwriter_and_plot_process(
    worker_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO screenwriter_plot_process(WORKER_ID, PROCESS_ID) VALUES(worker_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для заполнения ассоциаций между ревизиями и процессами
*/
CREATE OR REPLACE FUNCTION associate_revision_and_storyboarding(
    revision_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO revision_storyboarding(REVISION_ID, PROCESS_ID) VALUES(revision_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_revision_and_adding_sound(
    revision_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO revision_adding_sound(REVISION_ID, PROCESS_ID) VALUES(revision_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_revision_and_smoothing(
    revision_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO revision_smoothing(REVISION_ID, PROCESS_ID) VALUES(revision_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_revision_and_adding_effects(
    revision_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO revision_adding_effects(REVISION_ID, PROCESS_ID) VALUES(revision_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_revision_and_animation(
    revision_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO revision_animation(REVISION_ID, PROCESS_ID) VALUES(revision_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION associate_revision_and_coloring(
    revision_id INTEGER,
    process_id INTEGER
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO revision_coloring(REVISION_ID, PROCESS_ID) VALUES(revision_id, process_id);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*функции для удаления работников
*/
CREATE OR REPLACE FUNCTION delete_storyboarder(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM storyboard_artists WHERE storyboard_artists.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_producer(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM producers WHERE producers.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_audio_specialist(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM audio_specialist WHERE audio_specialist.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_digitizer(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM digitizers WHERE digitizers.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_smoothing_specialist(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM smoothing_specialist WHERE smoothing_specialist.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_art_director(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM art_director WHERE art_director.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_screenwriter(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM screenwriters WHERE screenwriters.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_regisseur(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM regisseurs WHERE regisseurs.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_roles_designer(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM roles_designers WHERE roles_designers.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_recording_actor(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM recording_actors WHERE recording_actors.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_editor(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM editors WHERE editors.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_artist(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM artists WHERE artists.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_worker(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM workers WHERE workers.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

/*
*создание функций для работы с аккаунтом
*/
CREATE OR REPLACE FUNCTION delete_user(main_worker_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM users WHERE users.MAIN_WORKER_ID = main_worker_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_user(
    main_worker_id INTEGER,
    login VARCHAR,
    user_password VARCHAR,
    email VARCHAR,
    avatar_file_link TEXT,
    last_log_out DATE
) RETURNS INTEGER AS
$$
DECLARE
    u_id INTEGER;
BEGIN
    INSERT INTO users(MAIN_WORKER_ID, LOGIN, USER_PASSWORD, EMAIL, AVATAR_FILE_LINK, LAST_LOG_OUT) 
    VALUES(main_worker_id, login, user_password, email, avatar_file_link, last_log_out) RETURNING USER_ID INTO u_id;
    RETURN u_id;
EXCEPTION
  WHEN unique_violation THEN
    RETURN -1;
  WHEN foreign_key_violation THEN
    RETURN -2;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_role(
    user_role VARCHAR
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO roles(ROLE_VALUE) VALUES(user_role);
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION add_role_to_user(
    user_id INTEGER,
    user_role VARCHAR
) RETURNS BOOLEAN AS
$$
BEGIN
    INSERT INTO users_roles(USER_ID, ROLE_VALUE) VALUES(user_id, user_role);
    RETURN TRUE;
EXCEPTION
  WHEN foreign_key_violation THEN
    RETURN FALSE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_users_role(role_value VARCHAR) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM users_roles WHERE ROLE_VALUE = role_value;
    RETURN TRUE;
END
$$ LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION update_last_log_out(
    login VARCHAR,
    last_log_out DATE
) RETURNS BOOLEAN AS
$$
BEGIN
    UPDATE users u SET u.LAST_LOG_OUT = last_log_out WHERE u.LOGIN = login;
    RETURN TRUE;
END
$$ LANGUAGE plpgsql VOLATILE;

/*
*создание функций для удаления процессов
*/
CREATE OR REPLACE FUNCTION delete_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM processes WHERE processes.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_storyboard_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM storyboard_process WHERE storyboard_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_advertising_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM advertising_process WHERE advertising_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_adding_sound_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM adding_sound_process WHERE adding_sound_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_digitization_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM digitization_process WHERE digitization_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_smoothing_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM smoothing_process WHERE smoothing_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_revisions_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM revisions_process WHERE revisions_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_coloring_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM coloring_process WHERE coloring_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_animation_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM animation_process WHERE animation_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_adding_effect_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM adding_effect_process WHERE adding_effect_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_location_drawing_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM location_drawing_process WHERE location_drawing_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_battle_drawing_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM battle_drawing_process WHERE battle_drawing_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_character_drawing_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM character_drawing_process WHERE character_drawing_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_character_select_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM character_select_process WHERE character_select_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_voice_acting_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM voice_acting_process WHERE voice_acting_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_ability_description_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM ability_description_process WHERE ability_description_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_character_description_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM character_description_process WHERE character_description_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_location_description_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM location_description_process WHERE location_description_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_battle_description_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM battle_description_process WHERE battle_description_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_plot_process(main_process_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM plot_process WHERE plot_process.MAIN_PROCESS_ID=main_process_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

/*
*функции для удаления основных сущностей
*/
CREATE OR REPLACE FUNCTION delete_plot(plot_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM plot WHERE plot.PLOT_ID=plot_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_events(event_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM events WHERE events.EVENT_ID=event_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_locations(location_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM locations WHERE locations.LOCATION_ID=location_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_battle(battle_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM battle WHERE battle.BATTLE_ID=battle_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_ability(ability_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM abilities WHERE abilities.ABILITY_ID=ability_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;

CREATE OR REPLACE FUNCTION delete_character(character_id INTEGER) RETURNS BOOLEAN AS
$$
BEGIN
    DELETE FROM character WHERE character.CHARACTER_ID=character_id;
    RETURN TRUE;
END
$$
LANGUAGE plpgsql VOLATILE;