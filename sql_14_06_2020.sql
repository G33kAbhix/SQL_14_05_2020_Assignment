--      CODER ABHIX         SQL          -14-06-2020-
CREATE TABLE STUDENT (
  ST_ROLL NUMBER(6),
  ST_NAME VARCHAR2(30),
  ST_ADDR VARCHAR2(50),
  PRIMARY KEY (ST_ROLL)
);

INSERT INTO STUDENT VALUES (1, 'AAA', 'KOLKATA');
INSERT INTO STUDENT VALUES (2, 'BBB', 'DGP');
COMMIT;

CREATE TABLE SUBJECT (
  SUB_ID VARCHAR2(6),
  T_NAME VARCHAR2(30),
  PRIMARY KEY (SUB_ID)
);

INSERT INTO SUBJECT VALUES ('MCA10', 'TECH1');
INSERT INTO SUBJECT VALUES ('MCA16', 'TECH2');
INSERT INTO SUBJECT VALUES ('MCA19', 'TECH3');
COMMIT;

CREATE TABLE TEACHER (
  T_NAME  VARCHAR2(30),
  T_ADDR  VARCHAR2(50),
  T_DESIG VARCHAR2(12),
  PRIMARY KEY (T_NAME)
);

INSERT INTO TEACHER VALUES ('TECH1', 'DGP', 'HOD');
INSERT INTO TEACHER VALUES ('TECH2', 'KOL', 'ASST HOD');
INSERT INTO TEACHER VALUES ('TECH3', 'DGP', 'ASST TECH');
COMMIT;

CREATE TABLE CLASS (
  CL_R_NO NUMBER(4),
  YEAR    VARCHAR2(8),
  SUB_ID  VARCHAR2(6),
  PRIMARY KEY (CL_R_NO)
);

INSERT INTO CLASS VALUES (200, '2020', 'MCA10');
INSERT INTO CLASS VALUES (201, '2020', 'MCA16');
INSERT INTO CLASS VALUES (202, '2020', 'MCA19');
COMMIT;


CREATE TABLE MARKS (
  SUB_ID  VARCHAR2(6),
  ST_ROLL NUMBER(6),
  MARKS   NUMBER(3)
);

INSERT INTO MARKS VALUES ('MCA10', 1, 99);
INSERT INTO MARKS VALUES ('MCA16', 1, 89);
INSERT INTO MARKS VALUES ('MCA19', 1, 90);
INSERT INTO MARKS VALUES ('MCA10', 2, 82);
INSERT INTO MARKS VALUES ('MCA10', 2, 100);
INSERT INTO MARKS VALUES ('MCA10', 2, 92);
COMMIT;

SELECT *
FROM STUDENT1;
SELECT *
FROM SUBJECT;
SELECT *
FROM TEACHER;
SELECT *
FROM CLASS;
SELECT *
FROM MARKS;

-- a) List the marks obtained by a student for a given st_roll.
SELECT MARKS
FROM MARKS
WHERE ST_ROLL = &ST_ROLL;

-- b) Find the total marks obtained by a student.
SELECT SUM(MARKS) AS TOTAL_MARKS
FROM MARKS
WHERE ST_ROLL = 1
GROUP BY (ST_ROLL);

-- c) Find the percentage of marks obtained by a student.
SELECT SUM(MARKS) / COUNT(MARKS) AS MARKS_PERCENTAGE
FROM MARKS
WHERE ST_ROLL = 1
GROUP BY (ST_ROLL);

-- d) List the names of teacher in sorted order.
SELECT T_NAME AS TEACHER_NAME
FROM TEACHER
ORDER BY T_NAME ASC;

-- e) Find the class-room-id for subjects taken by a teacher (given t_name).
SELECT C.CL_R_NO
FROM CLASS C
  INNER JOIN SUBJECT S
    ON C.SUB_ID = S.SUB_ID
WHERE S.T_NAME = &T_NAME;

-- f) List the names of students in sorted order subject wise.
SELECT
  S.ST_NAME AS STUDENT_NAME,
  M.SUB_ID
FROM STUDENT S
  INNER JOIN MARKS M
    ON S.ST_ROLL = M.ST_ROLL
GROUP BY (M.SUB_ID, S.ST_NAME)
ORDER BY (S.ST_NAME) ASC;

-- g) List the names of student who got maximum marks subject wise.

SELECT
  S.ST_NAME AS STUDENT_NAME, M.MARKS
FROM STUDENT S
  INNER JOIN MARKS M
    ON S.ST_ROLL = M.ST_ROLL
WHERE (M.MARKS, M.SUB_ID) IN
  (SELECT
    MAX(MARKS.MARKS),
    SUB_ID
  FROM MARKS
  GROUP BY (MARKS.SUB_ID));

-- h) Find the name of subject who got maximum total marks.

SELECT
  ST_NAME AS STUDENT_NAME,
  MAXSUM  AS MAXIMUM_MARKS
FROM (  SELECT
          ST_NAME,
          SUM(M.MARKS) MAXSUM
        FROM STUDENT S
          INNER JOIN MARKS M
            ON S.ST_ROLL = M.ST_ROLL
        GROUP BY S.ST_ROLL, S.ST_NAME) s1
WHERE s1.MAXSUM = ( SELECT MAX(SUM(MARKS))
                    FROM MARKS
                    GROUP BY (ST_ROLL));

