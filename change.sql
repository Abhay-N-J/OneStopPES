USE PROJECT_V1;

ALTER TABLE STUDENT
MODIFY COLUMN BRANCH VARCHAR(100);

UPDATE STUDENT
SET BRANCH = "Computer Science"
WHERE BRANCH = "CSE";

ALTER TABLE STUDENT
DROP COLUMN SECTION;

ALTER TABLE STUDENT
ADD COLUMN SEM INT;

UPDATE STUDENT
SET SEM = 1 WHERE ACC_INFO IS NOT NULL;

UPDATE STUDENT
SET SEM = 2 WHERE ACC_INFO IS NULL;

ALTER TABLE ANNOUNCEMENTS
DROP PRIMARY KEY;

ALTER TABLE ANNOUNCEMENTS
MODIFY COLUMN LINK VARCHAR(255);

ALTER TABLE ANNOUNCEMENTS
MODIFY COLUMN MESSAGE VARCHAR(255);

ALTER TABLE ANNOUNCEMENTS
ADD PRIMARY KEY(BRANCH,SEM,TITLE,MESSAGE);

INSERT INTO ANNOUNCEMENTS (BRANCH, SEM, ADMIN_ID, LINK, MESSAGE, TITLE)
VALUES 
('Computer Science', 1, 1, 'https://example.com/link1', 'The meeting room has been changed to GJBC', 'Meeting Change'),
('Computer Science', 1, 2, 'https://example.com/link2', 'The review has been rescheduled to next week', 'Rescheduled Review'),
('Computer Science', 1, 3, 'https://example.com/link3', 'Reminder: Bring your ID cards for the workshop', 'Workshop Reminder'),
('Computer Science', 2, 4, 'https://example.com/link4', 'The deadline for assignment submission has been extended', 'Assignment Extension'),
('Computer Science', 2, 5, 'https://example.com/link5', 'Venue for the coding competition has been shifted to the library', 'Competition Venue Change'),
('Computer Science', 1, 4, 'https://example.com/link6', 'Important: Lab session canceled for tomorrow', 'Canceled Lab Session'),
('Computer Science', 2, 1, 'https://example.com/link7', 'Meeting for project discussion at 3 PM today', 'Project Meeting'),
('Computer Science', 1, 5, 'https://example.com/link8', 'Seminar on AI and Machine Learning next week', 'AI Seminar'),
('Computer Science', 2, 3, 'https://example.com/link9', 'Workshop on Data Structures and Algorithms this Saturday', 'DSA Workshop'),
('Computer Science', 1, 2, 'https://example.com/link10', 'Reminder: Complete your course feedback forms', 'Feedback Reminder');

DELIMITER //

CREATE PROCEDURE GetStudentAnnouncements(IN student_srn INT)
BEGIN
    SELECT A.LINK, A.MESSAGE, A.TITLE
    FROM STUDENT S
    JOIN ANNOUNCEMENTS A ON S.BRANCH = A.BRANCH AND S.SEM = A.SEM
    WHERE S.SRN = student_srn;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE GetStudentCoursesAndElectives(
    IN student_id INT
)
BEGIN
    SELECT 
        c.C_CODE AS code,
        c.C_NAME AS name,
        c.DEPT,
        c.CREDITS
    FROM COURSE c
    WHERE c.C_CODE IN (
        SELECT sc.C_CODE
        FROM ST_COURSES sc
        WHERE sc.SRN = student_id
    )
    UNION ALL
    SELECT 
        e.E_CODE AS code,
        e.E_NAME AS name,
        e.DEPT,
        e.CREDITS
    FROM ELECTIVES e
    WHERE e.E_CODE IN (
        SELECT se.E_CODE
        FROM ST_ELECTIVES se
        WHERE se.SRN = student_id
    );
END //

DELIMITER ;

INSERT INTO INSTRUCTOR (INSTR_ID, INSTR_NAME, ROOM_NO, TIME)
VALUES
    (6, 'Dr. Brown', 106, '2:00 PM'),
    (7, 'Professor Garcia', 107, '4:00 PM'),
    (8, 'Dr. Miller', 108, '12:00 PM'),
    (9, 'Professor Davis', 109, '5:00 PM'),
    (10, 'Dr. Rodriguez', 110, '8:00 AM');

INSERT INTO TIME_TABLE (DAY, BRANCH, SEM, ROOM_NO, TIME)
VALUES
    ('Monday', 'Computer Science', 2, 106, '2:00 PM'),
    ('Tuesday', 'Computer Science', 2, 107, '4:00 PM'),
    ('Wednesday', 'Computer Science', 2, 108, '12:00 PM'),
    ('Thursday', 'Computer Science', 2, 109, '5:00 PM'),
    ('Friday', 'Computer Science', 2, 110, '8:00 AM');

DELIMITER //

CREATE PROCEDURE GetSemesterSchedule(IN semester INT)
BEGIN
    SELECT TT.DAY, TT.ROOM_NO, TT.TIME,
        CASE
            WHEN RT.C_CODE IS NOT NULL THEN RT.C_CODE
            WHEN RT.E_CODE IS NOT NULL THEN RT.E_CODE
        END AS Course_Elective_Code,
        I.INSTR_NAME
    FROM TIME_TABLE TT
    JOIN ROOM RT ON TT.ROOM_NO = RT.ROOM_NO AND TT.TIME = RT.TIME
    JOIN INSTRUCTOR I ON RT.ROOM_NO = I.ROOM_NO AND RT.TIME = I.TIME
    WHERE TT.SEM = semester;
END //

DELIMITER ;

