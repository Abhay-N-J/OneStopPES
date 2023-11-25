-- Additional records for the STUDENT table
INSERT INTO STUDENT (SRN, BRANCH, NAME, EMAIL, SECTION, ACC_INFO, CGPA)
VALUES
  (3, 103, 'Alice Johnson', 'alice@example.com', 1, 5555555555, 3.9),
  (4, 104, 'Bob Williams', 'bob@example.com', 2, 6666666666, 3.6);
  -- Add more records accordingly

-- Additional records for the SCHOLARSHIP table
INSERT INTO SCHOLARSHIP (SC_ID, TYPE, SEM, SRN)
VALUES
  (103, 1, 1, 3),
  (104, 2, 2, 4);
  -- Add more records accordingly

-- Additional records for the COURSE table
INSERT INTO COURSE (C_NAME, C_CODE, DEPT, CREDITS)
VALUES
  ('Chemistry', 1003, 1, 3),
  ('Biology', 1004, 1, 4);
  -- Add more records accordingly

-- Additional records for the ELECTIVES table
INSERT INTO ELECTIVES (E_CODE, E_NAME, CREDITS, DEPT, PRE_REQ)
VALUES
  (2003, 'Machine Learning', 4, 2, 1001),
  (2004, 'Robotics', 4, 2, 1001);
  -- Add more records accordingly

-- Additional records for the ADMIN table
INSERT INTO ADMIN (ADMIN_ID, NAME, PASSWORD)
VALUES
  (3, 'Admin3', 'password3'),
  (4, 'Admin4', 'password4');
  -- Add more records accordingly

-- Additional records for the ANNOUNCEMENTS table
INSERT INTO ANNOUNCEMENTS (BRANCH, SEM, ADMIN_ID)
VALUES
  (103, 1, 3),
  (104, 2, 4);
  -- Add more records accordingly

-- Additional records for the FEEDBACK_AND_REPLY table
INSERT INTO FEEDBACK_AND_REPLY (QUERY, REPLY, SRN, ADMIN_ID)
VALUES
  (3, 3, 3, 3),
  (4, 4, 4, 4);
  -- Add more records accordingly

-- Additional records for the ROOM table
INSERT INTO ROOM (ROOM_NO, TIME, C_CODE, E_CODE)
VALUES
  (103, 3, 1003, 2003),
  (104, 4, 1004, 2004);
  -- Add more records accordingly

-- Additional records for the EXAM_INFO table
INSERT INTO EXAM_INFO (E_ID, TIME, DATE, ROOM, C_CODE, E_CODE)
VALUES
  (3, 3, '2023-01-03', 103, 1003, 2003),
  (4, 4, '2023-01-04', 104, 1004, 2004);
  -- Add more records accordingly

-- Additional records for the TIME_TABLE table
INSERT INTO TIME_TABLE (DAY, BRANCH, SEM, ROOM_NO, TIME)
VALUES
  (1, 103, 1, 103, 3),
  (2, 104, 2, 104, 4);
  -- Add more records accordingly

-- Additional records for the INSTRUCTOR table
INSERT INTO INSTRUCTOR (INSTR_ID, INSTR_NAME, ROOM_NO, TIME)
VALUES
  (3, 'Instructor3', 103, 3),
  (4, 'Instructor4', 104, 4);
  -- Add more records accordingly

-- Additional records for the RES_ELEC table
INSERT INTO RES_ELEC (ISA1, ISA2, ESA, SRN, E_CODE)
VALUES
  (85, 80, 90, 3, 2003),
  (80, 75, 85, 4, 2004);
  -- Add more records accordingly

-- Additional records for the RES_COURSE table
INSERT INTO RES_COURSE (ISA1, ISA2, ESA, SRN, C_CODE)
VALUES
  (75, 70, 80, 3, 1003),
  (70, 65, 75, 4, 1004);
  -- Add more records accordingly

-- Additional records for the ST_COURSES table
INSERT INTO ST_COURSES (SRN, C_CODE, INSTR_ID)
VALUES
  (3, 1003, 3),
  (4, 1004, 4);
  -- Add more records accordingly

-- Additional records for the ST_ELECTIVES table
INSERT INTO ST_ELECTIVES (SRN, INSTR_ID, E_CODE)
VALUES
  (3, 3, 2003),
  (4, 4, 2004);
  -- Add more records accordingly

-- Additional 5 records for the STUDENT table
INSERT INTO STUDENT (SRN, BRANCH, NAME, EMAIL, SECTION, ACC_INFO, CGPA)
VALUES
  (5, 105, 'Emily Davis', 'emily@example.com', 1, 7777777777, 3.7),
  (6, 106, 'Michael Wilson', 'michael@example.com', 2, 8888888888, 3.4),
  (7, 107, 'Sophia Martinez', 'sophia@example.com', 1, 9999999999, 3.9),
  (8, 108, 'Alexander Anderson', 'alexander@example.com', 2, 1010101010, 3.2),
  (9, 109, 'Olivia Garcia', 'olivia@example.com', 1, 1111111111, 3.6);

-- Additional 5 records for the SCHOLARSHIP table
INSERT INTO SCHOLARSHIP (SC_ID, TYPE, SEM, SRN)
VALUES
  (105, 2, 1, 5),
  (106, 1, 2, 6),
  (107, 2, 1, 7),
  (108, 1, 2, 8),
  (109, 2, 1, 9);

-- Additional 5 records for the COURSE table
INSERT INTO COURSE (C_NAME, C_CODE, DEPT, CREDITS)
VALUES
  ('History', 1005, 3, 3),
  ('Geography', 1006, 3, 4),
  ('Computer Science', 1007, 2, 4),
  ('Literature', 1008, 4, 3),
  ('Economics', 1009, 5, 4);

-- Additional 5 records for the ELECTIVES table
INSERT INTO ELECTIVES (E_CODE, E_NAME, CREDITS, DEPT, PRE_REQ)
VALUES
  (2005, 'Network Security', 4, 2, 1007),
  (2006, 'Human-Computer Interaction', 3, 2, 1007),
  (2007, 'Microbiology', 4, 1, 1006),
  (2008, 'Game Development', 3, 2, 1007),
  (2009, 'International Relations', 4, 5, 1005);

-- Additional 5 records for the ADMIN table
INSERT INTO ADMIN (ADMIN_ID, NAME, PASSWORD)
VALUES
  (5, 'Admin5', 'password5'),
  (6, 'Admin6', 'password6'),
  (7, 'Admin7', 'password7'),
  (8, 'Admin8', 'password8'),
  (9, 'Admin9', 'password9');

-- Additional 5 records for the ANNOUNCEMENTS table
INSERT INTO ANNOUNCEMENTS (BRANCH, SEM, ADMIN_ID)
VALUES
  (105, 1, 5),
  (106, 2, 6),
  (107, 1, 7),
  (108, 2, 8),
  (109, 1, 9);

-- Additional 5 records for the FEEDBACK_AND_REPLY table
INSERT INTO FEEDBACK_AND_REPLY (QUERY, REPLY, SRN, ADMIN_ID)
VALUES
  (5, 5, 5, 5),
  (6, 6, 6, 6),
  (7, 7, 7, 7),
  (8, 8, 8, 8),
  (9, 9, 9, 9);

-- Additional 5 records for the ROOM table
INSERT INTO ROOM (ROOM_NO, TIME, C_CODE, E_CODE)
VALUES
  (105, 5, 1005, 2005),
  (106, 6, 1006, 2006),
  (107, 7, 1007, 2007),
  (108, 8, 1008, 2008),
  (109, 9, 1009, 2009);

-- Additional 5 records for the EXAM_INFO table
INSERT INTO EXAM_INFO (E_ID, TIME, DATE, ROOM, C_CODE, E_CODE)
VALUES
  (5, 5, '2023-01-05', 105, 1005, 2005),
  (6, 6, '2023-01-06', 106, 1006, 2006),
  (7, 7, '2023-01-07', 107, 1007, 2007),
  (8, 8, '2023-01-08', 108, 1008, 2008),
  (9, 9, '2023-01-09', 109, 1009, 2009);

-- Additional 5 records for the TIME_TABLE table
INSERT INTO TIME_TABLE (DAY, BRANCH, SEM, ROOM_NO, TIME)
VALUES
  (1, 105, 1, 105, 5),
  (2, 106, 2, 106, 6),
  (3, 107, 1, 107, 7),
  (4, 108, 2, 108, 8),
  (5, 109, 1, 109, 9);

-- Additional 5 records for the INSTRUCTOR table
INSERT INTO INSTRUCTOR (INSTR_ID, INSTR_NAME, ROOM_NO, TIME)
VALUES
  (5, 'Instructor5', 105, 5),
  (6, 'Instructor6', 106, 6),
  (7, 'Instructor7', 107, 7),
  (8, 'Instructor8', 108, 8),
  (9, 'Instructor9', 109, 9);

-- Additional 5 records for the RES_ELEC table
INSERT INTO RES_ELEC (ISA1, ISA2, ESA, SRN, E_CODE)
VALUES
  (80, 75, 85, 5, 2005),
  (75, 70, 80, 6, 2006),
  (85, 80, 90, 7, 2007),
  (70, 65, 75, 8, 2008),
  (90, 85, 95, 9, 2009);

-- Additional 5 records for the RES_COURSE table
INSERT INTO RES_COURSE (ISA1, ISA2, ESA, SRN, C_CODE)
VALUES
  (70, 65, 75, 5, 1005),
  (65, 60, 70, 6, 1006),
  (75, 70, 80, 7, 1007),
  (60, 55, 65, 8, 1008),
  (80, 75, 85, 9, 1009);

-- Additional 5 records for the ST_C

-- Inserting records into the STUDENT table
INSERT INTO STUDENT (SRN, BRANCH, NAME, EMAIL, SECTION, ACC_INFO, CGPA)
VALUES
  (1, 101, 'John Doe', 'john@example.com', 1, 1234567890, 3.5),
  (2, 102, 'Jane Smith', 'jane@example.com', 2, 9876543210, 3.8);
  -- Add more records accordingly

-- Inserting records into the SCHOLARSHIP table
INSERT INTO SCHOLARSHIP (SC_ID, TYPE, SEM, SRN)
VALUES
  (101, 1, 1, 1),
  (102, 2, 2, 2);
  -- Add more records accordingly

-- Inserting records into the COURSE table
INSERT INTO COURSE (C_NAME, C_CODE, DEPT, CREDITS)
VALUES
  ('Mathematics', 1001, 1, 4),
  ('Physics', 1002, 1, 3);
  -- Add more records accordingly

-- Inserting records into the ELECTIVES table
INSERT INTO ELECTIVES (E_CODE, E_NAME, CREDITS, DEPT, PRE_REQ)
VALUES
  (2001, 'Data Science', 3, 2, 1001),
  (2002, 'Artificial Intelligence', 3, 2, 1001);
  -- Add more records accordingly

-- Inserting records into the ADMIN table
INSERT INTO ADMIN (ADMIN_ID, NAME, PASSWORD)
VALUES
  (1, 'Admin1', 'password1'),
  (2, 'Admin2', 'password2');
  -- Add more records accordingly

-- Inserting records into the ANNOUNCEMENTS table
INSERT INTO ANNOUNCEMENTS (BRANCH, SEM, ADMIN_ID)
VALUES
  (101, 1, 1),
  (102, 2, 2);
  -- Add more records accordingly

-- Inserting records into the FEEDBACK_AND_REPLY table
INSERT INTO FEEDBACK_AND_REPLY (QUERY, REPLY, SRN, ADMIN_ID)
VALUES
  (1, 1, 1, 1),
  (2, 2, 2, 2);
  -- Add more records accordingly

-- Inserting records into the ROOM table
INSERT INTO ROOM (ROOM_NO, TIME, C_CODE, E_CODE)
VALUES
  (101, 1, 1001, 2001),
  (102, 2, 1002, 2002);
  -- Add more records accordingly

-- Inserting records into the EXAM_INFO table
INSERT INTO EXAM_INFO (E_ID, TIME, DATE, ROOM, C_CODE, E_CODE)
VALUES
  (1, 1, '2023-01-01', 101, 1001, 2001),
  (2, 2, '2023-01-02', 102, 1002, 2002),
  -- Add more records accordingly

-- Inserting records into the TIME_TABLE table
INSERT INTO TIME_TABLE (DAY, BRANCH, SEM, ROOM_NO, TIME)
VALUES
  (1, 101, 1, 101, 1),
  (2, 102, 2, 102, 2),
  -- Add more records accordingly

-- Inserting records into the INSTRUCTOR table
INSERT INTO INSTRUCTOR (INSTR_ID, INSTR_NAME, ROOM_NO, TIME)
VALUES
  (1, 'Instructor1', 101, 1),
  (2, 'Instructor2', 102, 2),
  -- Add more records accordingly

-- Inserting records into the RES_ELEC table
INSERT INTO RES_ELEC (ISA1, ISA2, ESA, SRN, E_CODE)
VALUES
  (90, 85, 95, 1, 2001),
  (85, 80, 90, 2, 2002),
  -- Add more records accordingly

-- Inserting records into the RES_COURSE table
INSERT INTO RES_COURSE (ISA1, ISA2, ESA, SRN, C_CODE)
VALUES
  (85, 80, 90, 1, 1001),
  (80, 75, 85, 2, 1002),
  -- Add more records accordingly

-- Inserting records into the ST_COURSES table
INSERT INTO ST_COURSES (SRN, C_CODE, INSTR_ID)
VALUES
  (1, 1001, 1),
  (2, 1002, 2),
  -- Add more records accordingly

-- Inserting records into the ST_ELECTIVES table
INSERT INTO ST_ELECTIVES (SRN, INSTR_ID, E_CODE)
VALUES
  (1, 1, 2001),
  (2, 2, 2002)
  -- Add more records accordingly