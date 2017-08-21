########################
# Drop all table
########################

##CREATE DATABASE tutorial;
##USE tutorial;

DROP TABLE IF EXISTS book, class, course, department, order_book, resource, role, section, speciality, staff, student, takes, timetable, USER;

CREATE TABLE book
(
  book_title       VARCHAR(30),
  isbn             VARCHAR(20),
  date_of_printing VARCHAR(20),
  author           VARCHAR(15),
  press            VARCHAR(15),
  category         CHAR,
  unit_price       FLOAT,
  PRIMARY KEY (book_title, isbn)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE class
(
  class_id   VARCHAR(30),
  class_name VARCHAR(10),
  YEAR       VARCHAR(20),
  spec_name  VARCHAR(15),
  PRIMARY KEY (class_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE course
(
  course_title VARCHAR(30),
  TYPE         VARCHAR(10),
  credits      FLOAT,
  speciality   VARCHAR(15),
  PRIMARY KEY (course_title)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE department
(
  dept_id   INT AUTO_INCREMENT,
  dept_name VARCHAR(15),
  PRIMARY KEY (dept_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE order_book
(
  staff_id   VARCHAR(30),
  sec_id     INT,
  book_title VARCHAR(30),
  isbn       VARCHAR(20),
  remark     VARCHAR(30),
  approval   TINYINT(1),
  PRIMARY KEY (staff_id, sec_id, book_title, isbn)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE resource (
  id         BIGINT AUTO_INCREMENT,
  NAME       VARCHAR(100),
  TYPE       VARCHAR(50),
  url        VARCHAR(200),
  parent_id  BIGINT,
  parent_ids VARCHAR(100),
  permission VARCHAR(100),
  available  BOOL   DEFAULT FALSE,
  PRIMARY KEY (id)
)
  CHARSET = utf8
  ENGINE = INNODB;
CREATE INDEX idx_resource_parent_id ON resource (parent_id);
CREATE INDEX idx_resource_parent_ids ON resource (parent_ids);

CREATE TABLE role (
  id           BIGINT AUTO_INCREMENT,
  role         VARCHAR(100),
  description  VARCHAR(100),
  resource_ids VARCHAR(100),
  available    BOOL   DEFAULT FALSE,
  PRIMARY KEY (id)
)
  CHARSET = utf8
  ENGINE = INNODB;
CREATE INDEX idx_sys_role_resource_ids ON role (resource_ids);

CREATE TABLE section
(
  sec_id       INT AUTO_INCREMENT,
  course_title VARCHAR(15),
  YEAR         VARCHAR(5),
  limitCount   INT,
  staff_id     VARCHAR(20),
  PRIMARY KEY (sec_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE speciality
(
  spec_id   INT AUTO_INCREMENT,
  dept_name VARCHAR(10),
  spec_name VARCHAR(15),
  YEAR      VARCHAR(5),
  PRIMARY KEY (spec_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE staff
(
  staff_id   VARCHAR(30),
  staff_name VARCHAR(20),
  PRIMARY KEY (staff_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE student
(
  student_id          VARCHAR(30),
  student_name        VARCHAR(20),
  id_card             VARCHAR(20),
  YEAR                VARCHAR(5),
  class_id            VARCHAR(10),
  telephone_number    VARCHAR(20),
  student_origin_base VARCHAR(10),
  gender              VARCHAR(4),
  pic_path            VARCHAR(45),
  leave_of_absence    BOOL,
  leave_school        BOOL,
    PRIMARY KEY (student_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE takes
(
  student_id VARCHAR(30),
  sec_id     VARCHAR(30),
  score      FLOAT,
  PRIMARY KEY (student_id, sec_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE timetable
(
  sec_id    INT,
  TIME      VARCHAR(20),
  weeks     VARCHAR(20),
  WEEK      VARCHAR(20),
  classroom VARCHAR(10)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;

CREATE TABLE USER
(
  user_id  VARCHAR(30),
  PASSWORD VARCHAR(50),
  salt     VARCHAR(100),
  role_ids VARCHAR(100),
  locked   BOOL DEFAULT FALSE,
  PRIMARY KEY (user_id)
)
  DEFAULT CHARSET = utf8,
  ENGINE = INNODB;
CREATE UNIQUE INDEX idx_user_username ON USER (user_id);

#ALTER TABLE staff ADD CONSTRAINT fk_user_staff FOREIGN KEY (staff_id) REFERENCES orders (user_id);
#ALTER TABLE order_book ADD CONSTRAINT fk_courses_user_books_classe FOREIGN KEY (staffs_id) REFERENCES staffs (staff_id),
#FOREIGN KEY (book_title,isbn) REFERENCES book (book_title,isbn),
#FOREIGN KEY (grade,professional,department) REFERENCES class (grade,professional,department),
#FOREIGN KEY (course_id) REFERENCES course (courses_id);






INSERT INTO USER (user_id, PASSWORD, salt, role_ids, locked)
VALUES ('admin', '3ab82b226b3b60f4eab8cd0a88887ba0', 'cd0faf6f821809044e35e35fd23cf44a', '1', 0);

INSERT INTO USER (user_id, PASSWORD, salt, role_ids, locked)
VALUES ('student', '5476883b25e9c7bb0528b6fdfa0f5de7', '20d98880380112ff6404bdcaa4ba9c10', '2', 0);

INSERT INTO USER (user_id, PASSWORD, salt, role_ids, locked)
VALUES ('student2', '5476883b25e9c7bb0528b6fdfa0f5de7', '20d98880380112ff6404bdcaa4ba9c10', '2', 0);


INSERT INTO USER (user_id, PASSWORD, salt, role_ids, locked)
VALUES ('teacher', 'f7e7844cad9aadb0c7f1722f2c9be050', 'a7bbf832a7472759146b0967a78e6ce5', '3', 0);

INSERT INTO USER (user_id, PASSWORD, salt, role_ids, locked)
VALUES ('supplier', '19a885f6627571598621fe5f5e9cbbc5', '9c64193184d34fa04a205d06b93ca3d6', '4', 0);

INSERT INTO role (role, description, resource_ids, available) VALUES ('admin', '管理员', '', 1);
INSERT INTO role (role, description, resource_ids, available) VALUES ('student', '学生', '', 1);
INSERT INTO role (role, description, resource_ids, available) VALUES ('teacher', '老师', '', 1);
INSERT INTO role (role, description, resource_ids, available) VALUES ('supplier', '供应商', '', 1);

INSERT INTO staff (staff_id, staff_name) VALUES ('teacher', 'teacher');


INSERT INTO book (book_title, isbn, date_of_printing, author, press, category, unit_price)
VALUES ('Effective JAVA', '1561315135213', '2008', 'Joshua Bloch', '工业出版社', 'A', 88);

INSERT INTO department (dept_name) VALUES ('管理系');
INSERT INTO department (dept_name) VALUES ('信息工程系');
INSERT INTO department (dept_name) VALUES ('机电系');

INSERT INTO speciality (dept_name, spec_name) VALUES ('信息工程系', '网络工程');

INSERT INTO section (course_title, YEAR, limitCount, staff_id) VALUES ('网络技术', 20161, 8, 'teacher');

INSERT INTO order_book (staff_id, sec_id, book_title, isbn, remark, approval)
VALUES ('teacher', 1, 'Effective JAVA', '1561315135213', '不要二手', 1);

INSERT INTO course (course_title, TYPE, credits, speciality)
VALUES ('网络技术', '必修课/公共课', 4, '网络工程');

INSERT INTO class (class_id, YEAR, spec_name)
VALUES ('161111', 20161, '网络工程');

INSERT INTO takes (student_id, sec_id, score)
VALUES ('student', 1, 5);

INSERT INTO takes (student_id, sec_id, score)
VALUES ('student2', 1, 5);
