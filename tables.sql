CREATE TABLE STUDENT
(
  SRN INT NOT NULL,
  BRANCH VARCHAR(10) NOT NULL,
  NAME VARCHAR(100) NOT NULL,
  EMAIL VARCHAR(100) NOT NULL,
  SECTION CHAR(1) NOT NULL,
  ACC_INFO INT ,
  CGPA DECIMAL(3, 2) NOT NULL,
  PRIMARY KEY (SRN),
  UNIQUE KEY (EMAIL)
)ENGINE=INNODB;

CREATE TABLE LOGINS 
(
  EMAIL VARCHAR(100) NOT NULL,
  PASS VARCHAR(100) NOT NULL,
  PRIMARY KEY(EMAIL),
  FOREIGN KEY (EMAIL) REFERENCES STUDENT(EMAIL)
)ENGINE=INNODB;

CREATE TABLE SCHOLARSHIP
(
  SC_ID INT NOT NULL,
  TYPE VARCHAR(100) NOT NULL,
  SEM INT NOT NULL,
  SRN INT NOT NULL,
  PRIMARY KEY (SC_ID),
  FOREIGN KEY (SRN) REFERENCES STUDENT(SRN)
)ENGINE=INNODB;

CREATE TABLE COURSE
(
  C_NAME VARCHAR(100) NOT NULL,
  C_CODE VARCHAR(100) NOT NULL,
  DEPT VARCHAR(100) NOT NULL,
  CREDITS INT NOT NULL,
  PRIMARY KEY (C_CODE)
)ENGINE=INNODB;

CREATE TABLE ELECTIVES
(
  E_CODE VARCHAR(100) NOT NULL,
  E_NAME VARCHAR(100) NOT NULL,
  CREDITS INT NOT NULL,
  DEPT VARCHAR(100) NOT NULL,
  PRE_REQ VARCHAR(100) NOT NULL,
  PRIMARY KEY (E_CODE)
)ENGINE=INNODB;

CREATE TABLE ADMIN
(
  ADMIN_ID INT NOT NULL,
  NAME VARCHAR(100) NOT NULL,
  PASSWORD VARCHAR(100) NOT NULL,
  PRIMARY KEY (ADMIN_ID)
)ENGINE=INNODB;

CREATE TABLE ANNOUNCEMENTS
(
  BRANCH VARCHAR(100) NOT NULL,
  SEM INT NOT NULL,
  ADMIN_ID INT NOT NULL,
  LINK VARCHAR(100),
  PRIMARY KEY (BRANCH, SEM),
  FOREIGN KEY (ADMIN_ID) REFERENCES ADMIN(ADMIN_ID)
)ENGINE=INNODB;

CREATE TABLE FEEDBACK_AND_REPLY
(
  QUERY VARCHAR(255) NOT NULL,
  REPLY VARCHAR(255) NOT NULL,
  SRN INT NOT NULL,
  ADMIN_ID INT NOT NULL,
  FOREIGN KEY (SRN) REFERENCES STUDENT(SRN),
  FOREIGN KEY (ADMIN_ID) REFERENCES ADMIN(ADMIN_ID)
)ENGINE=INNODB;

CREATE TABLE ROOM
(
  ROOM_NO INT NOT NULL,
  TIME VARCHAR(100) NOT NULL,
  C_CODE VARCHAR(100),
  E_CODE VARCHAR(100),
  PRIMARY KEY (ROOM_NO, TIME),
  FOREIGN KEY (C_CODE) REFERENCES COURSE(C_CODE),
  FOREIGN KEY (E_CODE) REFERENCES ELECTIVES(E_CODE)
)ENGINE=INNODB;

CREATE TABLE EXAM_INFO
(
  E_ID INT NOT NULL,
  TIME VARCHAR(100) NOT NULL,
  DATE DATE NOT NULL,
  ROOM INT NOT NULL,
  C_CODE VARCHAR(100),
  E_CODE VARCHAR(100),
  PRIMARY KEY (E_ID),
  FOREIGN KEY (C_CODE) REFERENCES COURSE(C_CODE),
  FOREIGN KEY (E_CODE) REFERENCES ELECTIVES(E_CODE)
)ENGINE=INNODB;

CREATE TABLE TIME_TABLE
(
  DAY VARCHAR(100) NOT NULL,
  BRANCH VARCHAR(100) NOT NULL,
  SEM INT NOT NULL,
  ROOM_NO INT NOT NULL,
  TIME VARCHAR(100) NOT NULL,
  PRIMARY KEY (BRANCH, SEM, ROOM_NO ),
  FOREIGN KEY (ROOM_NO, TIME) REFERENCES ROOM(ROOM_NO, TIME)
)ENGINE=INNODB;

CREATE TABLE INSTRUCTOR
(
  INSTR_ID INT NOT NULL,
  INSTR_NAME VARCHAR(100) NOT NULL,
  ROOM_NO INT NOT NULL,
  TIME VARCHAR(100) NOT NULL,
  PRIMARY KEY (INSTR_ID),
  FOREIGN KEY (ROOM_NO, TIME) REFERENCES ROOM(ROOM_NO, TIME)
)ENGINE=INNODB;

CREATE TABLE RES_ELEC
(
  ISA1 INT NOT NULL,
  ISA2 INT NOT NULL,
  ESA INT NOT NULL,
  SRN INT NOT NULL,
  E_CODE VARCHAR(100) NOT NULL,
  FOREIGN KEY (SRN) REFERENCES STUDENT(SRN),
  FOREIGN KEY (E_CODE) REFERENCES ELECTIVES(E_CODE)
)ENGINE=INNODB;

CREATE TABLE RES_COURSE
(
  ISA1 INT NOT NULL,
  ISA2 INT NOT NULL,
  ESA INT NOT NULL,
  SRN INT NOT NULL,
  C_CODE VARCHAR(100) NOT NULL,
  FOREIGN KEY (SRN) REFERENCES STUDENT(SRN),
  FOREIGN KEY (C_CODE) REFERENCES COURSE(C_CODE)
)ENGINE=INNODB;

CREATE TABLE ST_COURSES
(
  SRN INT NOT NULL,
  C_CODE VARCHAR(100) NOT NULL,
  INSTR_ID INT NOT NULL,
  FOREIGN KEY (SRN) REFERENCES STUDENT(SRN),
  FOREIGN KEY (C_CODE) REFERENCES COURSE(C_CODE),
  FOREIGN KEY (INSTR_ID) REFERENCES INSTRUCTOR(INSTR_ID)
)ENGINE=INNODB;

CREATE TABLE ST_ELECTIVES
(
  SRN INT NOT NULL,
  INSTR_ID INT NOT NULL,
  E_CODE VARCHAR(100) NOT NULL,
  FOREIGN KEY (SRN) REFERENCES STUDENT(SRN),
  FOREIGN KEY (INSTR_ID) REFERENCES INSTRUCTOR(INSTR_ID),
  FOREIGN KEY (E_CODE) REFERENCES ELECTIVES(E_CODE)
)ENGINE=INNODB;

DELIMITER //
CREATE TRIGGER before_insert_room
BEFORE INSERT ON ROOM
FOR EACH ROW
BEGIN
  IF NEW.C_CODE IS NOT NULL AND NEW.E_CODE IS NOT NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Either C_CODE or E_CODE should be NULL';
  END IF;
END;
//
DELIMITER ;

DELIMITER //
CREATE TRIGGER before_insert_exam
BEFORE INSERT ON EXAM_INFO
FOR EACH ROW
BEGIN
  IF NEW.C_CODE IS NOT NULL AND NEW.E_CODE IS NOT NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Either C_CODE or E_CODE should be NULL';
  END IF;
END;
//
DELIMITER ;