--      <ABHISHEK MONDAL> [12001018036]         -25-06-2020-
       --------------------     PLSQL --------------------
-- c) PLSQL CODE TO Find the percentage of marks obtained by a student.
SET SERVEROUTPUT ON

  DECLARE
    stdroll STUDENT.ST_ROLL%TYPE;
    total_marks NUMBER(5,2) :=0;
    count_roll NUMBER :=0;
    CURSOR cur_marks_percent IS
      SELECT *
      FROM MARKS;
  BEGIN
    stdroll := &stdroll;
    DBMS_OUTPUT.PUT_LINE('MARKS PERCENTAGE  ');
    DBMS_OUTPUT.PUT_LINE('__________________');
    FOR m IN cur_marks_percent
      LOOP
      IF m.ST_ROLL = stdroll THEN
        total_marks := total_marks + m.MARKS;
        count_roll := count_roll + 1;
      END IF;
      END LOOP;
    total_marks := total_marks/count_roll;
      DBMS_OUTPUT.PUT_LINE(total_marks);
  END;
  /

-- d) PLSQL CODE TO List the names of teacher in sorted order.
SET SERVEROUTPUT ON
  DECLARE
    CURSOR cur_teacher_name IS
      SELECT *
      FROM TEACHER
      ORDER BY T_NAME ASC;
  BEGIN
    DBMS_OUTPUT.PUT_LINE('TEACHER NAME  ');
    DBMS_OUTPUT.PUT_LINE('______________');
    FOR t IN cur_teacher_name
      LOOP
      DBMS_OUTPUT.PUT_LINE(t.T_NAME);
      END LOOP;
  END;
  /

      ----------------------- SQL QUERY ----------------------------

-- c) Find the percentage of marks obtained by a student.
SELECT SUM(MARKS) / COUNT(MARKS) AS MARKS_PERCENTAGE
FROM MARKS
WHERE ST_ROLL = &ST_ROLL
GROUP BY (ST_ROLL);

-- d) List the names of teacher in sorted order.
SELECT T_NAME AS TEACHER_NAME
FROM TEACHER
ORDER BY T_NAME ASC;



/*  ---- OUTPUT ----------------

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
INSERT INTO TEACHER VALUES ('ATECH3', 'DGP', 'ASST TECH');
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
FROM STUDENT;
SELECT *
FROM SUBJECT;
SELECT *
FROM TEACHER;
SELECT *
FROM CLASS;
SELECT *
FROM MARKS;

SQL> SELECT *
  2  FROM STUDENT;

   ST_ROLL ST_NAME
---------- ------------------------------
ST_ADDR
--------------------------------------------------
         1 AAA
KOLKATA

         2 BBB
DGP


SQL> SELECT *
  2  FROM SUBJECT;

SUB_ID T_NAME
------ ------------------------------
MCA10  TECH1
MCA16  TECH2
MCA19  TECH3

SQL> SELECT *
  2  FROM TEACHER;

T_NAME
------------------------------
T_ADDR                                             T_DESIG
-------------------------------------------------- ------------
TECH1
DGP                                                HOD

TECH2
KOL                                                ASST HOD

TECH3
DGP                                                ASST TECH


T_NAME
------------------------------
T_ADDR                                             T_DESIG
-------------------------------------------------- ------------
ATECH3
DGP                                                ASST TECH


SQL> SELECT *
  2  FROM CLASS;

   CL_R_NO YEAR     SUB_ID
---------- -------- ------
       200 2020     MCA10
       202 2020     MCA19
       201 2020     MCA16

SQL> SELECT *
  2  FROM MARKS;

SUB_ID    ST_ROLL      MARKS
------ ---------- ----------
MCA10           1         99
MCA16           1         89
MCA19           1         90
MCA10           2         82
MCA10           2        100
MCA10           2         92

6 rows selected.

SQL> SET SERVEROUTPUT ON
SQL>
SQL>   DECLARE
  2      stdroll STUDENT.ST_ROLL%TYPE;
  3      total_marks NUMBER(5,2) :=0;
  4      count_roll NUMBER :=0;
  5      CURSOR cur_marks_percent IS
  6        SELECT *
  7        FROM MARKS;
  8    BEGIN
  9      stdroll := &stdroll;
 10      DBMS_OUTPUT.PUT_LINE('MARKS PERCENTAGE  ');
 11      DBMS_OUTPUT.PUT_LINE('__________________');
 12      FOR m IN cur_marks_percent
 13        LOOP
 14        IF m.ST_ROLL = stdroll THEN
 15          total_marks := total_marks + m.MARKS;
 16          count_roll := count_roll + 1;
 17        END IF;
 18        END LOOP;
 19      total_marks := total_marks/count_roll;
 20        DBMS_OUTPUT.PUT_LINE(total_marks);
 21    END;
 22    /
Enter value for stdroll: 1
old   9:     stdroll := &stdroll;
new   9:     stdroll := 1;
MARKS PERCENTAGE
__________________
92.67

PL/SQL procedure successfully completed.

SQL> SET SERVEROUTPUT ON
SQL>   DECLARE
  2      CURSOR cur_teacher_name IS
  3        SELECT *
  4        FROM TEACHER
  5        ORDER BY T_NAME ASC;
  6    BEGIN
  7      DBMS_OUTPUT.PUT_LINE('TEACHER NAME  ');
  8      DBMS_OUTPUT.PUT_LINE('______________');
  9      FOR t IN cur_teacher_name
 10        LOOP
 11        DBMS_OUTPUT.PUT_LINE(t.T_NAME);
 12        END LOOP;
 13    END;
 14    /
TEACHER NAME
______________
ATECH3
TECH1
TECH2
TECH3

PL/SQL procedure successfully completed.

SQL> SELECT SUM(MARKS) / COUNT(MARKS) AS MARKS_PERCENTAGE
  2  FROM MARKS
  3  WHERE ST_ROLL = &ST_ROLL
  4  GROUP BY (ST_ROLL);
Enter value for st_roll: 1
old   3: WHERE ST_ROLL = &ST_ROLL
new   3: WHERE ST_ROLL = 1

MARKS_PERCENTAGE
----------------
      92.6666667


SQL> -- d) List the names of teacher in sorted order.
SQL> SELECT T_NAME AS TEACHER_NAME
  2  FROM TEACHER
  3  ORDER BY T_NAME ASC;

TEACHER_NAME
------------------------------
ATECH3
TECH1
TECH2
TECH3

------------------           */
