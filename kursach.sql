CREATE TYPE PRODUCER_ROLES AS ENUM ('Продюсер', 'Исполнительный продюсер', 'Сопродюсер', 'Ассоциированный продюсер', 
 'Ассистирующий продюсер', 'Линейный продюсер', 'Административный продюсер', 'Креативный продюсер', 'Информационный продюсер');
CREATE TYPE RECORDING_ACTOR_POSITIONS AS ENUM ('Дубляж', 'Озвучка ролей', 'Запись музыки');
CREATE TYPE EDITOR_POSITIONS AS ENUM ('Литературный редактор', 'Технический редактор' , 'Художественный редактор', 'Главный редактор');
CREATE TYPE ARTIST_TYPES AS ENUM ('Худ. по персонажам', 'Худ. по цвету', ' Худ. по фону', 'Худ. по анимации', 'Худ. по раскраске',
 'Худ. по компоновке', 'Худ. по эффектам', 'Худ. по локациям', 'Худ. по сражениям');
CREATE TYPE PROCESS_STATUS AS ENUM ('Начат', 'В процессе', 'На ревизии', 'Завершён');
CREATE TYPE INSERTION_LOCATIONS AS ENUM ('Начало серии', 'Середиина серии', 'Конец серии');
CREATE TYPE SOUND_TYPES AS ENUM ('Музыка', 'Шумы');
CREATE TYPE DIGITIZATION_TYPES AS ENUM ('Добавляется контраст, а затем сканирование',
 'Сканирование, а затем добавляется контраст');
CREATE TYPE REVISION_TYPES AS ENUM ('Мониторинг всех процессов', 'Мониторинг части процессов');
CREATE TYPE COLORING_TYPES AS ENUM ('Цветная', 'Чёрно-белая');
CREATE TYPE VOICE_ACTING_TYPES AS ENUM ('Предварительная', 'Последующая');
CREATE TYPE PLOT_TYPES AS ENUM ('Основной', 'Дополнительный', 'Флэш бэк');
CREATE TYPE LOCATION_TYPES AS ENUM ('Поле', 'Лес', 'Город', 'Деревня', 'Джунгли', 'Водоём', 'Горы', 'Пустыня', 'Пещера', 'Водопад', 'Замок');
CREATE TYPE ABILITY_TYPES AS ENUM ('Атака', 'Защита', 'Хилка', 'Трёп');
CREATE TYPE USING_TECHNOLOGIES AS ENUM ('Рисунки', 'Куклы', 'Трёхмерная графика');
CREATE TYPE ARTIFACT_TYPES AS ENUM ();
CREATE TYPE EFFECT_LEVELS AS ENUM('AAA', 'AA', 'A', 'BBB', 'BB', 'B', 'CCC', 'CC', 'C');

/*
*сущность рабочие и все её характеристические сущности
*/
CREATE TABLE workers(
    MAIN_WORKER_ID SERIAL,
    NAME VARCHAR(32) NOT NULL,
    SECOND_NAME VARCHAR(32) NOT NULL,
    GENDER VARCHAR(32) NOT NULL,
    AGE INTEGER NOT NULL,
    PLACE_OF_BIRTH TEXT NOT NULL,
    CONSTRAINT WORKERS_PK PRIMARY KEY(MAIN_WORKER_ID),
    CONSTRAINT WORKERS_AGE_CHECK CHECK(AGE > 0 AND AGE < 120)
);

CREATE TABLE storyboard_artists(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT STORYBOARD_ARTISTS_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE producers(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ROLE PRODUCER_ROLES NOT NULL,
    CONSTRAINT PRODUCERS_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE audio_specialist(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT AUDIO_SPECIALIST_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE digitizers(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DIGITIZERS_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE smoothing_specialist(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SMOOTHING_SPECIALIST PRIMARY KEY(WORKER_ID)
);

CREATE TABLE art_director(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ART_DIRECTOR_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE screenwriters(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FILMS_NUMBER INTEGER NOT NULL,
    GENRES VARCHAR(32)[] NOT NULL,
    CONSTRAINT SCREENWRITERS_PK PRIMARY KEY(WORKER_ID),
    CONSTRAINT SCREENWRITER_FILMS_NUMBER_CHECK CHECK(FILMS_NUMBER >= 0)
);

CREATE TABLE regisseurs(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FILMS_NUMBER INTEGER NOT NULL,
    GENRES VARCHAR(32)[] NOT NULL,
    CONSTRAINT REGISSEURS_PK PRIMARY KEY(WORKER_ID),
    CONSTRAINT REGISSEURS_FILMS_NUMBER_CHECK CHECK(FILMS_NUMBER >= 0)
);

CREATE TABLE roles_designers(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ROLES_DESIGNERS_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE recording_actors(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    POSITION RECORDING_ACTORS_POSITIONS NOT NULL,
    CONSTRAINT RECORDING_ACTORS_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE editors(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    GENRES VARCHAR(32)[] NOT NULL,
    POSITION EDITOR_POSITIONS NOT NULL,
    CONSTRAINT EDITORS_PK PRIMARY KEY(WORKER_ID)
);

CREATE TABLE artists(
    WORKER_ID SERIAL,
    MAIN_WORKER_ID INTEGER UNIQUE REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ARTIST_TYPE ARTIST_TYPES NOT NULL,
    USING_TECHNOLOGY USING_TECHNOLOGIES NOT NULL,
    CONSTRAINT ARTISTS_PK PRIMARY KEY(WORKER_ID)
);

/*
*сущность процессы и все её характеристические сущности
*/
CREATE TABLE processes(
    MAIN_PROCESS_ID SERIAL,
    DURATION INTEGER NOT NULL,
    DEADLINE_DATE DATE NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    STATUS PROCESS_STATUS NOT NULL,
    ESTIMATION_TIME INTERVAL NOT NULL,
    START_DATE DATE NOT NULL,
    CONSTRAINT PROCESSES_PK PRIMARY KEY(MAIN_PROCESS_ID),
    CONSTRAINT PROCESSES_DURATION_CHECK CHECK(DURATION > 0),
    CONSTRAINT PROCESS_DATES_CHECk CHECK(DEADLINE_DATE > START_DATE)
);

CREATE TABLE storyboard_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FRAME_NUMBER INTEGER NOT NULL,
    CONSTRAINT STORYBOARD_PROCESS_PK PRIMARY KEY(PROCESS_ID),
    CONSTRAINT STORYBOARD_PROCESS_FRAME_NUMBER_CHECK CHECK(FRAME_NUMBER >= 0)
);

CREATE TABLE adevertising_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    INSERTION_LOCATION INSERTION_LOCATIONS NOT NULL,
    CONSTRAINT ADVERTISNG_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE adding_sound_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    SOUND_TYPE SOUND_TYPES NOT NULL,
    CONSTRAINT ADDING_SOUND_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE digitization_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    SKETCHES_NUMBER INTEGER NOT NULL,
    DIGITIZATION_TYPE DIGITIZATION_TYPES NOT NULL,
    CONSTRAINT DIGITIZATION_PROCESS_PK PRIMARY KEY(PROCESS_ID),
    CONSTRAINT DIGITIZATION_PROCESS_SKETCHES_NUMBER_CHECK CHECK(SKETCHES_NUMBER >= 0)
);

CREATE TABLE smoothing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SMOOTHING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE revisions_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    REVISION_TYPE REVISION_TYPES NOT NULL,
    CONSTRAINT REVISIONS_PROCESS PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE coloring_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    COLORING_TYPE COLORING_TYPES NOT NULL,
    CONSTRAINT COLORING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE animation_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    FRAME_RATE INTEGER NOT NULL,
    ANIMATION_TECHNOLOGY VARCHAR(32) NOT NULL,
    CONSTRAINT ANIMATION_PROCESS_PK PRIMARY KEY(PROCESS_ID),
    CONSTRAINT ANIMATION_PROCESS_FRAME_RATE_CHECK CHECK(FRAME_RATE > 0)
);

CREATE TABLE adding_effect_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    EFFECT_LEVEL EFFECT_LEVELS NOT NULL,
    CONSTRAINT ADDING_EFFECT_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE location_drawing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT LOCATION_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE battle_drawing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE character_drawing_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTER_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE character_select_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTER_SELECT_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE voice_acting_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    VOICE_ACTING_TYPE VOICE_ACTING_TYPES NOT NULL,
    CONSTRAINT VOICE_ACTING_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE ability_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ABILITY_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE character_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTER_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE location_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT LOCATION_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE battle_description_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_DESCRIPTION_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

CREATE TABLE plot_process(
    PROCESS_ID SERIAL,
    MAIN_PROCESS_ID INTEGER UNIQUE REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PLOT_PROCESS_PK PRIMARY KEY(PROCESS_ID)
);

/*
*создание сущности артефакт
*/
CREATE TABLE artifacts(
    ARTIFACT_ID SERIAL,
    WORKER_ID INTEGER REFERENCES workers(MAIN_WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ARTIFACT_TYPE ARTIFACT_TYPES NOT NULL,
    SIZE INTEGER NOT NULL,
    UPLOAD_DATE TIMESTAMP NOT NULL,
    UPLOAD_USER VARCHAR(32) NOT NULL,
    CONSTRAINT ARTIFACTS_PK PRIMARY KEY(ARTIFACT_ID),
    CONSTRAINT ARTIFACTS_SIZE_CHECK CHECK(SIZE >= 0)
);

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
    NARRATIVE_PERIOD INTERVAL NOT NULL,
    CONSTRAINT PLOT_PK PRIMARY KEY(PLOT_ID),
    CONSTRAINT PLOT_PAGES_NUMBER_CHECK CHECK(PAGES_NUMBER > 0)
);

CREATE TABLE events(
    EVENT_ID SERIAL,
    EVENT_NAME VARCHAR(32) NOT NULL,
    DESCRIPTION TEXT NOT NULL,
    IMPORTANCE_LEVEL INTEGER NOT NULL,
    CONSTRAINT EVENTS_PK PRIMARY KEY(EVENT_ID),
    CONSTRAINT EVENTS_IMPORTANCE_LEVEL_CHECK CHECK(IMPORTANCE_LEVEL BETWEEN 0 AND 10)
);

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

CREATE TABLE battle(
    BATTLE_ID SERIAL,
    DESCRIPTION_ID INTEGER REFERENCES battle_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    DRAWING_ID INTEGER REFERENCES battle_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    BATTLE_NAME VARCHAR(32) NOT NULL,
    DURATION NUMERIC(5,3) NOT NULL,
    CONSTRAINT BATTLE_PK PRIMARY KEY(BATTLE_ID)
);

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
    BIRTH_DATE DATE,
    CONSTRAINT CHARACTER_PK PRIMARY KEY(CHARACTER_ID),
    CONSTRAINT CHARACTER_AGE_CHECK CHECK(AGE > 0)
);

/*
*создание ассоциаций между процессами
*/
CREATE TABLE revision_storyboarding(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DEADLINE_DATE CASCADE,
    STORYBOARDING_ID INTEGER REFERENCES storyboard_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_STORYBOARDING_PK PRIMARY KEY(REVISION_ID, STORYBOARDING_ID)
);

CREATE TABLE revision_adding_sound(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ADDING_ID INTEGER REFERENCES adding_sound_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_ADDING_SOUND_PK PRIMARY KEY(REVISION_ID, ADDING_ID)
);

CREATE TABLE revision_smoothing(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    SMOOTHING_ID INTEGER REFERENCES smoothing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_SMOOTHING_PK PRIMARY KEY(REVISION_ID, SMOOTHING_ID)
);

CREATE TABLE revision_adding_effects(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ADDING_ID INTEGER REFERENCES adding_effect_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_ADDING_EFFECTS_PK PRIMARY KEY(REVISION_ID, ADDING_ID)
);

CREATE TABLE revision_animation(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ANIMATION_ID INTEGER REFERENCES animation_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_ANIMATION_PK PRIMARY KEY(REVISION_ID, ANIMATION_ID)
);

CREATE TABLE revision_coloring(
    REVISION_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    COLORING_ID INTEGER REFERENCES coloring_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REVISION_COLORING_PK PRIMARY KEY(REVISION_ID, COLORING_ID)
);

/*
*создание ассоциаций между процессами и выполняющими их работниками
*/
CREATE TABLE artist_storyboard_process(
    PROCESS_ID INTEGER REFERENCES storyboard_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES storyboard_artists(WORKER_ID) ON UPDATE CASCADE ON  DELETE CASCADE,
    CONSTRAINT ARTIST_STORYBOARD_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE producer_advertising_process(
    PROCESS_ID INTEGER REFERENCES adevertising_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES producers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PRODUCER_ADVERTISING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE audio_adding_process(
    PROCESS_ID INTEGER REFERENCES adding_sound_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES audio_specialist(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT AUDIO_ADDING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE digitizers_digitization_process(
    PROCESS_ID INTEGER REFERENCES digitization_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES digitizers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DIGITIZERS_DIGITIZATION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE smoother_smoothing_process(
    PROCESS_ID INTEGER REFERENCES smoothing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES smoothing_specialist(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SMOOTHER_SMOOTHING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE art_director_revision_process(
    PROCESS_ID INTEGER REFERENCES revisions_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES art_director(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ART_DIRECTOR_REVISION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE artist_coloring_process(
    PROCESS_ID INTEGER REFERENCES coloring_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_COLORING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE artist_animation_process(
    PROCESS_ID INTEGER REFERENCES animation_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_ANIMATION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE artist_effects_process(
    PROCESS_ID INTEGER REFERENCES adding_effect_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_EFFECTS_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE artist_location_drawing_process(
    PROCESS_ID INTEGER REFERENCES location_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_LOCATION_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE artist_battle_drawing_process(
    PROCESS_ID INTEGER REFERENCES battle_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_BATTLE_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE artist_character_drawing_process(
    PROCESS_ID INTEGER REFERENCES character_drawing_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES artists(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT ARTIST_CHARACTER_DRAWING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE editors_character_process(
    PROCESS_ID INTEGER REFERENCES character_select_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES editors(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EDITORS_CHARACTER_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE recorder_voice_acting_process(
    PROCESS_ID INTEGER REFERENCES voice_acting_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES recording_actors(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT RECORDER_VOICE_ACTING_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE designer_ability_process(
    PROCESS_ID INTEGER REFERENCES ability_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES roles_designers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DESIGNER_ABILITY_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE designer_character_process(
    PROCESS_ID INTEGER REFERENCES character_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES roles_designers(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT DESIGNER_CHARACTER_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE regisseur_location_process(
    PROCESS_ID INTEGER REFERENCES location_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES regisseurs(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REGISSEUR_LOCATION_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE screenwriter_battle_process(
    PROCESS_ID INTEGER REFERENCES battle_description_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES screenwriters(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SCREENWRITER_BATTLE_PROCESS_Pk PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE regisseurs_plot_process(
    PROCESS_ID INTEGER REFERENCES plot_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES regisseurs(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT REGISSEURS_PLOT_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

CREATE TABLE screenwriter_plot_process(
    PROCESS_ID INTEGER REFERENCES plot_process(PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    WORKER_ID INTEGER REFERENCES screenwriters(WORKER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT SCREENWRITER_PLOT_PROCESS_PK PRIMARY KEY(PROCESS_ID, WORKER_ID)
);

/*
*создание ассоциации между процессами и артифактами
*/
CREATE TABLE process_artifact(
    MAIN_PROCESS_ID INTEGER REFERENCES processes(MAIN_PROCESS_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ARTIFACT_ID INTEGER REFERENCES artifacts(ARTIFACT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT PROCESS_ARTIFACT_PK PRIMARY KEY(MAIN_PROCESS_ID, ARTIFACT_ID)
);

/*
*создание ассоциаций между основными стержневыми сущностями
*/
CREATE TABLE events_plots(
    EVENT_ID INTEGER REFERENCES events(EVENT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    PLOT_ID INTEGER REFERENCES plot(PLOT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVENTS_PLOTS_PK PRIMARY KEY(EVENT_ID, PLOT_ID)
);

CREATE TABLE event_location(
    EVENT_ID INTEGER INTEGER REFERENCES events(EVENT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    LOCATION_ID INTEGER REFERENCES locations(LOCATION_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVENT_LOCATION_PK PRIMARY KEY(EVENT_ID, LOCATION_ID)
);

CREATE TABLE events_characters(
    EVENT_ID INTEGER INTEGER REFERENCES events(EVENT_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CHARACTER_ID INTEGER REFERENCES character(CHARACTER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT EVENTS_CHARACTERS_PK PRIMARY KEY(EVENT_ID, CHARACTER_ID)
);

CREATE TABLE battle_location(
    LOCATION_ID INTEGER REFERENCES locations(LOCATION_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    BATTLE_ID INTEGER REFERENCES battle(BATTLE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_LOCATION_PK PRIMARY KEY(BATTLE_ID, LOCATION_ID)
);

CREATE TABLE battle_abilities(
    BATTLE_ID INTEGER REFERENCES battle(BATTLE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ABILITY_ID INTEGER REFERENCES abilities(ABILITY_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_ABILITIES_PK PRIMARY KEY(BATTLE_ID, ABILITY_ID)
);

CREATE TABLE battle_characters(
    BATTLE_ID INTEGER REFERENCES battle(BATTLE_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CHARACTER_ID INTEGER REFERENCES character(CHARACTER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT BATTLE_CHARACTERS_PK PRIMARY KEY(BATTLE_ID, CHARACTER_ID)
);

CREATE TABLE characters_abilities(
    CHARACTER_ID INTEGER REFERENCES character(CHARACTER_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    ABILITY_ID INTEGER REFERENCES abilities(ABILITY_ID) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT CHARACTERS_ABILITIES_PK PRIMARY KEY(CHARACTER_ID, ABILITY_ID)
);

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
*создание триггеров и триггерных функций
*/
CREATE OR REPLACE FUNCTION check_if_battle() RETURNS trigger AS
$body$
DECLARE 
    is_for_battle BOOLEAN;
BEGIN
    SELECT l.FOR_BATTLE INTO is_for_battle FROM locations AS l WHERE l.LOCATION_ID = NEW.LOCATION_ID;
    IF is_for_battle IS TRUE THEN
        INSERT INTO trigger_info(TG_OP, TG_RELNAME, TG_NAME, CREATION_TIME) VALUES(TG_OP, TG_RELNAME, TG_NAME, NOW());
        RETURN NEW;
    ELSE
        RETURN NULL;
    END IF;
END
$body$ LANGUAGE plpgsql VOLATILE;
CREATE TRIGGER is_battle_location BEFORE INSERT OR UPDATE ON battle_location FOR EACH ROW EXECUTE PROCEDURE check_if_battle();

/*
*создание функций для основных стержневых сущностей
*/
CREATE OR REPLACE FUNCTION get_locations_and_battles() RETURNS 
TABLE(
    LOCATION_ID INTEGER, 
    LOCATION_NAME VARCHAR, 
    BATTLE_NAME VARCHAR, 
    BATTLE_ID INTEGER) AS
$body$
BEGIN
    RETURN QUERY SELECT l.LOCATION_ID, l.LOCATION_NAME, b.BATTLE_NAME, b.BATTLE_ID FROM locations AS l 
    JOIN battle_location USING(LOCATION_ID) JOIN battle AS b USING(BATTLE_ID);
END
$body$
LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_abilities_in_battle() RETURNS 
TABLE(
    BATTLE_NAME VARCHAR, 
    ABILITY_NAME VARCHAR, 
    ABILITY_DESCRIPTION VARCHAR, 
    ABILITY_TYPE ABILITY_TYPES) AS
$body$
BEGIN
    RETURN QUERY SELECT b.BATTLE_NAME, a.ABILITY_NAME, a.DESCRIPTION, a.ABILITY_TYPE FROM battle AS b 
    JOIN battle_abilities USING(BATTLE_ID) JOIN abilities AS a USING(ABILITY_ID);
END
$body$
LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_character_ablilities(character_name VARCHAR) RETURNS 
TABLE(
    CHARACTER_NAME VARCHAR, 
    ABILITY_NAME VARCHAR, 
    ABILITY_DESCRIPTION TEXT, 
    ABILITY_TYPE ABILITY_TYPES, 
    COMPLEXITY_LEVEL INTEGER) AS
$body$
BEGIN
    RETURN QUERY SELECT c.CHARACTER_NAME, a.ABILITY_NAME, a.DESCRIPTION, a.ABILITY_TYPE, a.COMPLEXITY_LEVEL FROM character AS c 
    JOIN characters_abilities USING(CHARACTER_ID) JOIN abilities AS a USING(ABILITY_ID) WHERE c.CHARACTER_NAME LIKE character_name;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_battle_info(name VARCHAR, is_battle_name BOOLEAN) RETURNS 
TABLE(
    CHARACTER_NAME VARCHAR, 
    BATTLE_NAME VARCHAR, 
    BATTLE_DURATION NUMERIC, 
    ABILITY_NAME VARCHAR, 
    ABILITY_DESCRIPTION TEXT, 
    ABILITY_TYPE ABILITY_TYPES, 
    COMPLEXITY_LEVEL INTEGER) AS
$body$
DECLARE
    table_attribute TEXT;
    table_name TEXT;
BEGIN
    IF is_battle_name IS TRUE THEN
        table_name := 'b';
        table_attribute := 'BATTLE_NAME';
    ELSE
        table_name := 'c';
        table_attribute := 'CHARACTER_NAME'
    END IF;
    RETURN QUERY EXECUTE FORMAT 
    ('SELECT c.CHARACTER_NAME, b.BATTLE_NAME, b.DURATION, a.ABILITY_NAME, a.DESCRIPTION, a.ABILITY_TYPE, a.COMPLEXITY_LEVEL 
    FROM character AS c JOIN battle_characters USING(CHARACTER_ID) JOIN battle AS b USING(BATTLE_ID) 
    JOIN battle_abilities USING(BATTLE_ID) JOIN abilities AS a USING(ABILITY_ID) 
    JOIN battle_location USING(BATTLE_ID) JOIN locations USING(LOCATION_ID) WHERE %2$I.%1$I LIKE $1', 
    table_attribute, table_name) USING name;
END
$body$ LANGUAGE plpgsql STABLE;

/*
*создание функций для работников
*/
CREATE OR REPLACE FUNCTION get_storyboarder_info(storyboarder_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT) AS
$body$
BEGIN
    RETURN QUERY SELECT s.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH FROM storyboard_artists AS s 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE s.WORKER_ID = storyboarder_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_producer_info(producer_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT,
    ROLE PRODUCER_ROLES) AS
$body$
BEGIN
    RETURN QUERY SELECT p.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH, p.ROLE FROM producers AS p 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE p.WORKER_ID = producer_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_audio_specialist_info(audio_specialist_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT) AS
$body$
BEGIN
    RETURN QUERY SELECT a.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH FROM audio_specialist AS a 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE a.WORKER_ID = audio_specialist_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_digitizer_info(digitizer_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT) AS
$body$
BEGIN
    RETURN QUERY SELECT d.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH FROM digitizers AS d 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE d.WORKER_ID = digitizer_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_smoothing_specialist_info(smoothing_specialist_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT) AS
$body$
BEGIN
    RETURN QUERY SELECT s.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH FROM smoothing_specialist AS s 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE s.WORKER_ID = smoothing_specialist_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_art_director_info(art_director_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT) AS
$body$
BEGIN
    RETURN QUERY SELECT ad.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH FROM art_director AS ad 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE ad.WORKER_ID = art_director_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_screenwriter_info(screenwriter_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT,
    FILMS_NUMBER INTEGER,
    GENRES VARCHAR[]) AS
$body$
BEGIN
    RETURN QUERY 
    SELECT sw.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH, sw.FILMS_NUMBER, sw.GENRES FROM screenwriters AS sw 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE sw.WORKER_ID = screenwriter_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_regisseur_info(regisseur_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT,
    FILMS_NUMBER INTEGER,
    GENRES VARCHAR[]) AS
$body$
BEGIN
    RETURN QUERY 
    SELECT r.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH, r.FILMS_NUMBER, r.GENRES FROM regisseurs AS r 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE r.WORKER_ID = regisseur_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_roles_designer_info(roles_designer_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT) AS
$body$
BEGIN
    RETURN QUERY SELECT rd.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH FROM roles_designers AS rd 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE rd.WORKER_ID = roles_designer_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_recording_actor_info(recording_actor_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT,
    POSITION RECORDING_ACTOR_POSITIONS) AS
$body$
BEGIN
    RETURN QUERY SELECT ra.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH, ra.POSITION FROM recording_actors AS ra 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE ra.WORKER_ID = recording_actors;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_editor_info(editor_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT,
    GENRES VARCHAR[],
    POSITION EDITOR_POSITIONS) AS
$body$
BEGIN
    RETURN QUERY 
    SELECT e.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH, e.GENRES, e.POSITION FROM editors AS e 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE e.WORKER_ID = editor_id;
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_artist_info(artist_id INTEGER) RETURNS 
TABLE(
    WORKER_ID INTEGER, 
    WORKER_NAME VARCHAR,
    WORKER_SECOND_NAME VARCHAR, 
    GENDER VARCHAR, 
    AGE INTEGER, 
    PLACE_OF_BIRTH TEXT,
    ARTIST_TYPE ARTIST_TYPES,
    USING_TECHNOLOGY USING_TECHNOLOGIES) AS
$body$
BEGIN
    RETURN QUERY 
    SELECT a.WORKER_ID, w.NAME, w.SECOND_NAME, w.GENDER, w.AGE, w.PLACE_OF_BIRTH, a.ARTIST_TYPE, a.USING_TECHNOLOGY FROM artists AS a 
    JOIN workers AS w USING(MAIN_WORKER_ID) WHERE a.WORKER_ID = artist_id;
END
$body$ LANGUAGE plpgsql STABLE;

/*
*создание функций для процессов
*/
CREATE OR REPLACE FUNCTION get_main_process_joined_artifacts_info() RETURNS 
TABLE(
    MAIN_PROCESS_ID INTEGER,
    DURATION INTEGER, 
    DEADLINE_DATE DATE, 
    DESCRIPTION TEXT, 
    STATUS PROCESS_STATUS, 
    ESTIMATION_TIME INTERVAL, 
    START_DATE DATE, 
    ARTIFACT_ID INTEGER, 
    ARTIFACT_TYPE ARTIFACT_TYPES, 
    SIZE INTEGER, 
    UPLOAD_DATE TIMESTAMP, 
    UPLOAD_USER VARCHAR) AS
$body$
BEGIN
    RETURN QUERY 
    SELECT 
    mp.MAIN_PROCESS_ID, mp.DURATION, mp.DEADLINE_DATE, mp.DESCRIPTION, mp.STATUS, mp.ESTIMATION_TIME, mp.START_DATE, a.ARTIFACT_ID, a.ARTIFACT_TYPE, a.SIZE, a.UPLOAD_DATE, a.UPLOAD_USER
    FROM processes AS mp JOIN process_artifact USING(MAIN_PROCESS_ID) 
    JOIN artifacts AS a USING(ARTIFACT_ID);
END
$body$ LANGUAGE plpgsql STABLE;

CREATE OR REPLACE FUNCTION get_storyboard_process_info(storyboard_process_id INTEGER) RETURNS 
TABLE(
    PROCESS_ID INTEGER,
    FRAME_NUMBER INTEGER,
    DURATION INTEGER, 
    DEADLINE_DATE DATE, 
    DESCRIPTION TEXT, 
    STATUS PROCESS_STATUS, 
    ESTIMATION_TIME INTERVAL, 
    START_DATE DATE, 
    ARTIFACT_ID INTEGER, 
    ARTIFACT_TYPE ARTIFACT_TYPES, 
    SIZE INTEGER, 
    UPLOAD_DATE TIMESTAMP, 
    UPLOAD_USER VARCHAR) AS
$body$
BEGIN
    RETURN QUERY SELECT 
    sp.PROCESS_ID, sp.FRAME_NUMBER, mpa.DURATION, mpa.DEADLINE_DATE, mpa.DESCRIPTION, mpa.STATUS, mpa.ESTIMATION_TIME, 
    mpa.START_DATE, mpa.ARTIFACT_ID, mpa.ARTIFACT_TYPE, mpa.SIZE, mpa.UPLOAD_DATE, mpa.UPLOAD_USER 
    FROM storyboard_process AS sp JOIN get_main_process_joined_artifacts_info() AS mpa USING(MAIN_PROCESS_ID) 
    WHERE sp.PROCESS_ID=storyboard_process_id;
END
$body$ LANGUAGE plpgsql STABLE;

/*
*это наброски того, что должны делать функции по выборке из отдельных таблиц
*/
SELECT * FROM coloring_process AS cp WHERE cp.ID = 4;

JOIN get_main_process_info(cp.MAIN_PROCESS_ID) USING(MAIN_PROCESS_ID)