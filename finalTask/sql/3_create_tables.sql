USE account_db;

CREATE TABLE user (
	id INTEGER NOT NULL AUTO_INCREMENT,
	login VARCHAR(255) NOT NULL UNIQUE,
	password CHAR(32) NOT NULL,
	/*
	 * 0 - студент (Role.STUDENT)
	 * 1 - работник деканата (Role.ADMINISTRATOR)
	 * 2 - преподаватель (Role.TUTOR)
	 */
	role TINYINT NOT NULL CHECK (role IN (0, 1, 2)),
	surname VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	patronymic VARCHAR(255) NOT NULL,
	CONSTRAINT pk_user PRIMARY KEY (id)
);

/*
 * таблицы-справочники:
 * - диспилины
 * - аудитории
 */

 CREATE TABLE subject (
    id INTEGER NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_subject PRIMARY KEY (id)
 );

CREATE TABLE classroom (
    id INTEGER NOT NULL AUTO_INCREMENT,
    number CHAR(32) NOT NULL,
    capacity INTEGER NOT NULL,
    /*
	 * 0 - семианрская (Type.SEMINAR)
	 * 1 - лекционная (Type.LECTURE)
	 */
    classroomType TINYINT NOT NULL CHECK (classroomType IN (0, 1)),
    hasProjector BIT NOT NULL,
    CONSTRAINT pk_classroom PRIMARY KEY (id)
);

/*
 * конец таблиц-справочников
 */

CREATE TABLE ugroup (
    id INTEGER NOT NULL AUTO_INCREMENT ,
    group_number INTEGER NOT NULL, 
    course_number INTEGER NOT NULL,
    faculty_id INTEGER NOT NULL,
    CONSTRAINT pk_group PRIMARY KEY (id),
);

CREATE TABLE subgroup (
    id INTEGER NOT NULL AUTO_INCREMENT,
    subgroup_number CHAR NOT NULL,
    group_id INTEGER NOT NULL,
    CONSTRAINT pk_subgroup PRIMARY KEY (id),
    CONSTRAINT fk_subgroup_group FOREIGN KEY (group_id) REFERENCES ugroup (id)
);

CREATE TABLE timetable (
    id INTEGER NOT NULL AUTO_INCREMENT,
    /*
	 * 0 - пн (Day.MONDAY)
	 * 1 - вт (Day.TUESDAY)
	 * 2 - ср (Day.WEDNESDAY)
	 * 3 - чт (Day.THURSDAY)
	 * 4 - пт (Day.FRIDAY)
	 * 5 - сб (Day.SATURDAY)
	 */
	day TINYINT NOT NULL CHECK (day IN (0, 1, 2, 3, 4, 5)),
	pair_number INTEGER NOT NULL, -- номер пары
	subject_id INTEGER NOT NULL,
	/*
	 * 0 - лекция (Type.LECTURE)
	 * 1 - практическое занятие (Type.PRACTICE)
	 */
	type TINYINT NOT NULL CHECK (classroomType IN (0, 1)),
	classroom_id INTEGER NOT NULL,
	tutor_id INTEGER NOT NULL,
	CONSTRAINT pk_timetable PRIMARY KEY (id),
	CONSTRAINT fk_timetable_subject FOREIGN KEY (subject_id) REFERENCES subject (id),
	CONSTRAINT fk_timetable_classroom FOREIGN KEY (classroom_id) REFERENCES classroom (id)
);

CREATE TABLE timetable_group (
	id INTEGER NOT NULL AUTO_INCREMENT,
    timetable_id INTEGER NOT NULL,
    subgroup_id INTEGER NOT NULL,
    CONSTRAINT pk_timetable_group PRIMARY KEY (id),
    CONSTRAINT fk_timetable_group_timetable FOREIGN KEY (timetable_id)
        REFERENCES timetable (id),
    CONSTRAINT fk_timetable_group_subgroup FOREIGN KEY (subgroup_id)
        REFERENCES subgroup (id)
);

CREATE TABLE student (
	id INTEGER NOT NULL AUTO_INCREMENT,
	subgroup_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	CONSTRAINT pk_student PRIMARY KEY (id),
	CONSTRAINT fk_student_subgroup FOREIGN KEY (subgroup_id) REFERENCES subgroup (id),
	CONSTRAINT fk_student_user FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE administrator (
	id INTEGER NOT NULL AUTO_INCREMENT,
	position VARCHAR(255) NOT NULL,
	user_id INTEGER NOT NULL,
	CONSTRAINT pk_administrator PRIMARY KEY (id),
	CONSTRAINT fk_administrator_user FOREIGN KEY (user_id) REFERENCES user (id)
);

CREATE TABLE tutor (
    id INTEGER NOT NULL AUTO_INCREMENT,
    position VARCHAR(255) NOT NULL,
    degree VARCHAR(255) NOT NULL,
    user_id INTEGER NOT NULL,
    CONSTRAINT pk_tutor PRIMARY KEY (id),
	CONSTRAINT fk_tutor_user FOREIGN KEY (user_id) REFERENCES user (id)
);


/* успеваемость */
 CREATE TABLE performance (
    id INTEGER NOT NULL AUTO_INCREMENT,
    student_id INTEGER NOT NULL,
    subject_id INTEGER NOT NULL,
    semester TINYINT NOT NULL CHECK (semester IN (1, 2, 3, 4, 5, 6, 7, 8)),
    credit CHAR(32), /* зачёт */
    exam CHAR(32),
    CONSTRAINT pk_performance PRIMARY KEY (id),
    CONSTRAINT fk_performance_student FOREIGN KEY (student_id) REFERENCES student (id),
    CONSTRAINT fk_performance_subject FOREIGN KEY (subject_id) REFERENCES subject (id)
 );