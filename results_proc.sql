DELIMITER //

CREATE PROCEDURE CALCULATEGRADES(IN STUDENT_SRN INT)
BEGIN
    SELECT 
        RC.ISA1,
        RC.ISA2,
        RC.ESA,
        RC.C_CODE AS CODE,
        ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) AS FINAL,
        CASE
            WHEN ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) >= 90 THEN 'S'
            WHEN ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) >= 80 THEN 'A'
            WHEN ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) >= 70 THEN 'B'
            WHEN ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) >= 60 THEN 'C'
            WHEN ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) >= 50 THEN 'D'
            WHEN ((RC.ISA1 + RC.ISA2) / 2 * 50 / 40 + RC.ESA * 50 / 100) >= 40 THEN 'E'
            ELSE 'F'
        END AS GRADE
    FROM RES_COURSE RC
    WHERE RC.SRN = STUDENT_SRN

    UNION ALL

    SELECT 
        RE.ISA1 AS ISA1,
        RE.ISA2 AS ISA2,
        RE.ESA AS ESA,
        RE.E_CODE AS E_CODE,
        ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) AS FINAL,
        CASE
            WHEN ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) >= 90 THEN 'S'
            WHEN ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) >= 80 THEN 'A'
            WHEN ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) >= 70 THEN 'B'
            WHEN ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) >= 60 THEN 'C'
            WHEN ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) >= 50 THEN 'D'
            WHEN ((RE.ISA1 + RE.ISA2) / 2 * 50 / 40 + RE.ESA * 50 / 100) >= 40 THEN 'E'
            ELSE 'F'
        END AS GRADE
    FROM RES_ELEC RE
    WHERE RE.SRN = STUDENT_SRN;
END //

DELIMITER ;

UPDATE RES_ELEC
SET ISA1 = ISA1 - 2;

UPDATE RES_ELEC
SET ISA2 = ISA2 + 1;

UPDATE RES_ELEC
SET ESA = ESA + 10;
