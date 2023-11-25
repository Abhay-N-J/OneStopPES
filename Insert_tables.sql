INSERT INTO STUDENT (SRN, BRANCH, NAME, EMAIL, SECTION, ACC_INFO, CGPA) 
VALUES 
(1001, 'CSE', 'John Doe', 'john@example.com', 'A', 123456, 9.75),
(1002, 'CSE', 'Alice Smith', 'alice@example.com', 'B', 654321, 8.90),
(1003, 'CSE', 'Bob Johnson', 'bob@example.com', 'A', 987654, 9.60),
(1004, 'CSE', 'Emma Brown', 'emma@example.com', 'C', NULL, 7.80),
(1005, 'CSE', 'Michael Clark', 'michael@example.com', 'B', NULL, 8.85);

INSERT INTO SCHOLARSHIP (SC_ID, TYPE, SEM, SRN) 
VALUES 
(1, 'MRD', 1, 1001),
(2, 'CNR', 2, 1003),
(3, 'DAC', 1, 1005);

INSERT INTO COURSE (C_NAME, C_CODE, DEPT, CREDITS) 
VALUES 
('Introduction to Programming', 'CSCI101', 'Computer Science', 3),
('Database Management', 'CSCI201', 'Computer Science', 4),
('Data Structures', 'CSCI301', 'Computer Science', 4),
('Operating Systems', 'CSCI401', 'Computer Science', 3),
('Algorithms', 'CSCI501', 'Computer Science', 4);

INSERT INTO ELECTIVES (E_CODE, E_NAME, CREDITS, DEPT, PRE_REQ) 
VALUES 
('CSCI601', 'Computer Networks', 3, 'Computer Science', 'CSCI301'),
('CSCI701', 'Artificial Intelligence', 4, 'Computer Science', 'CSCI401'),
('CSCI801', 'Machine Learning', 4, 'Computer Science', 'CSCI501'),
('CSCI901', 'Software Engineering', 3, 'Computer Science', 'CSCI601'),
('CSCI1001', 'Cybersecurity', 4, 'Computer Science', 'CSCI701');

INSERT INTO ADMIN (ADMIN_ID, NAME, PASSWORD) 
VALUES 
(1, 'Admin1', 'admin@123'),
(2, 'Admin2', 'securepass'),
(3, 'Admin3', 'password123'),
(4, 'Admin4', 'admin1234'),
(5, 'Admin5', 'passadmin');

INSERT INTO ROOM (ROOM_NO, TIME, C_CODE, E_CODE) 
VALUES 
(101, '9:00 AM', 'CSCI101', NULL),
(102, '11:00 AM', 'CSCI201', NULL),
(103, '1:00 PM', 'CSCI301', NULL),
(104, '3:00 PM', 'CSCI401', NULL),
(105, '10:00 AM', 'CSCI501', NULL),
(106, '2:00 PM', NULL, 'CSCI601'),
(107, '4:00 PM', NULL, 'CSCI701'),
(108, '12:00 PM', NULL, 'CSCI801'),
(109, '5:00 PM', NULL, 'CSCI901'),
(110, '8:00 AM', NULL, 'CSCI1001');

INSERT INTO EXAM_INFO (E_ID, TIME, DATE, ROOM, C_CODE, E_CODE) 
VALUES 
(1, '9:00 AM', '2023-12-10', 101, 'CSCI101', NULL ),
(2, '11:00 AM', '2023-12-11', 102, 'CSCI201', NULL),
(3, '1:00 PM', '2023-12-12', 103, 'CSCI301', NULL),
(4, '3:00 PM', '2023-12-13', 104, 'CSCI401', NULL),
(5, '10:00 AM', '2023-12-14', 201, 'CSCI501', NULL),
(6, '12:00 PM', '2023-12-15', 106, NULL, 'CSCI601'),
(7, '2:00 PM', '2023-12-16', 107, NULL, 'CSCI701'),
(8, '4:00 PM', '2023-12-17', 108, NULL, 'CSCI801'),
(9, '9:00 AM', '2023-12-18', 109, NULL, 'CSCI901'),
(10, '11:00 AM', '2023-12-19', 110, NULL, 'CSCI1001');

INSERT INTO TIME_TABLE (DAY, BRANCH, SEM, ROOM_NO, TIME) 
VALUES 
('Monday', 'Computer Science', 1, 101, '9:00 AM'),
('Tuesday', 'Computer Science', 2, 102, '11:00 AM'),
('Wednesday', 'Computer Science', 1, 103, '1:00 PM'),
('Thursday', 'Computer Science', 2, 104, '3:00 PM'),
('Friday', 'Computer Science', 1, 105, '10:00 AM');

INSERT INTO INSTRUCTOR (INSTR_ID, INSTR_NAME, ROOM_NO, TIME) 
VALUES 
(1, 'Professor Smith', 101, '9:00 AM'),
(2, 'Professor Johnson', 102, '11:00 AM'),
(3, 'Professor Williams', 103, '1:00 PM'),
(4, 'Professor Brown', 104, '3:00 PM'),
(5, 'Professor Davis', 105, '10:00 AM');

INSERT INTO RES_ELEC (ISA1, ISA2, ESA, SRN, E_CODE) 
VALUES 
(30, 25, 70, 1001, 'CSCI601'),
(35, 28, 60, 1002, 'CSCI701'),
(38, 35, 55, 1003, 'CSCI801'),
(40, 39, 80, 1004, 'CSCI901'),
(30, 31, 75, 1005, 'CSCI1001');

INSERT INTO RES_COURSE (ISA1, ISA2, ESA, SRN, C_CODE) 
VALUES 
(30, 25, 70, 1001, 'CSCI101'),
(35, 28, 60, 1002, 'CSCI201'),
(38, 35, 55, 1003, 'CSCI301'),
(40, 39, 80, 1004, 'CSCI401'),
(30, 31, 75, 1005, 'CSCI501');

INSERT INTO ST_COURSES (SRN, C_CODE, INSTR_ID) 
VALUES 
(1001, 'CSCI101', 1),
(1002, 'CSCI201', 2),
(1003, 'CSCI301', 3),
(1004, 'CSCI401', 4),
(1005, 'CSCI501', 5);

INSERT INTO ST_ELECTIVES (SRN, INSTR_ID, E_CODE) 
VALUES 
(1001, 1, 'CSCI601'),
(1002, 2, 'CSCI701'),
(1003, 3, 'CSCI801'),
(1004, 4, 'CSCI901'),
(1005, 5, 'CSCI1001');
