--   <CODER ABHIX>     -02-07-2020-

-- e) PLSQL Code to Find the class-room-id for subjects taken by a teacher (given t_name).

 SET SERVEROUTPUT ON
 DECLARE
   tname SUBJECT.T_NAME%TYPE;
   CURSOR cur_teach IS
     SELECT C.CL_R_NO, S.T_NAME
     FROM CLASS C
       INNER JOIN SUBJECT S
         ON C.SUB_ID = S.SUB_ID;

 BEGIN
   tname := &tname;
   DBMS_OUTPUT.PUT_LINE('CLASS ROOM ID ');
   DBMS_OUTPUT.PUT_LINE('______________');
   FOR roomid IN cur_teach
     LOOP
     IF roomid.T_NAME = tname THEN
     DBMS_OUTPUT.PUT_LINE(roomid.CL_R_NO);
     END IF;
   END LOOP;
 END;
 /

-- f) PLSQL CODE TO List the names of students in sorted order subject wise.

 SET SERVEROUTPUT ON
 DECLARE
   CURSOR cur_stdname IS
     SELECT
       S.ST_NAME AS STUDENT_NAME,
       M.SUB_ID
     FROM STUDENT S
       INNER JOIN MARKS M
         ON S.ST_ROLL = M.ST_ROLL
     GROUP BY (M.SUB_ID, S.ST_NAME)
     ORDER BY (S.ST_NAME) ASC;

 BEGIN
   DBMS_OUTPUT.PUT_LINE('STUDENT NAME          SUBJECT');
   DBMS_OUTPUT.PUT_LINE('______________        _________');
 FOR std IN cur_stdname
   LOOP
    DBMS_OUTPUT.PUT_LINE(std.STUDENT_NAME||'                   '||std.SUB_ID);
   END LOOP;
 END;
 /

----------------------- SQL QUERY ----------------------------

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
