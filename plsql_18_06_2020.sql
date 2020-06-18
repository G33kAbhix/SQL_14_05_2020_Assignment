-- CODER ABHIX    -18-06-2020-        --
          --------------------     PLSQL --------------------
-- a) PLSQL CODE TO List the marks obtained by a student for a given st_roll.
SET SERVEROUTPUT ON
DECLARE
  stdroll STUDENT.ST_ROLL%TYPE ;
  CURSOR cur_marks IS
    SELECT *
    FROM MARKS;
  BEGIN
  stdroll := &stdroll;
  DBMS_OUTPUT.PUT_LINE('MARKS     ');
  FOR s IN cur_marks
    LOOP
    IF s.ST_ROLL = stdroll THEN
      DBMS_OUTPUT.PUT_LINE(s.MARKS);
    END IF;
    END LOOP ;
END;
/

-- b) PLSQL CODE TO Find the total marks obtained by a student.
SET SERVEROUTPUT ON
DECLARE
  stdroll STUDENT.ST_ROLL%TYPE ;
  total_marks NUMBER :=0 ;
  CURSOR cur_marks IS
    SELECT *
    FROM MARKS;
  BEGIN
  stdroll := &stdroll;
  DBMS_OUTPUT.PUT_LINE('TOTAL  MARKS  ');
  FOR s IN cur_marks
    LOOP
    IF s.ST_ROLL = stdroll THEN
      total_marks := total_marks + s.MARKS;
    END IF;
  END LOOP ;
  DBMS_OUTPUT.PUT_LINE(total_marks);
END;
/


      ----------------------- SQL QUERY ----------------------------
-- a) List the marks obtained by a student for a given st_roll.
SELECT MARKS
FROM MARKS
WHERE ST_ROLL = &ST_ROLL;

-- b) Find the total marks obtained by a student.
SELECT SUM(MARKS) AS TOTAL_MARKS
FROM MARKS
WHERE ST_ROLL = &ST_ROLL
GROUP BY (ST_ROLL);

-- c) Find the percentage of marks obtained by a student.
SELECT SUM(MARKS) / COUNT(MARKS) AS MARKS_PERCENTAGE
FROM MARKS
WHERE ST_ROLL = &ST_ROLL
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
WHERE S.T_NAME = '&T_NAME';

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

