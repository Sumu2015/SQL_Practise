-- TRIGGER IN PLSQL.
-- CREATE A BACK UP COPY OF EMPLOYEES TABLE THAT WILL STORE DATA BEFORE DELETING ANY RECORD FROM THE TABLE.
CREATE TABLE BAK_EMP AS SELECT * FROM EMPLOYEES
WHERE 1=2;

SELECT * FROM BAK_EMP;

-- CREATE TRIGGER THAT WOULD HELP IN TAKING BACK UP OF EACH RECORD IN BAK_EMP TABLE DELETING RECORD FROM EMPLOYEES TABLE.
CREATE OR REPLACE TRIGGER NM
BEFORE INSERT OR UPDATE OR DELETE ON EMPLOYEES
FOR EACH ROW
DECLARE
L_TRANS VARCHAR2(10);
BEGIN
L_TRANS := CASE
WHEN INSERTING THEN 'INSERT'
WHEN UPDATING THEN 'UPDATE'
WHEN DELETING THEN 'DELETE'
END;
INSERT INTO BAK_EMP (CMD_EXECD, EXEC_TIME) VALUES (L_TRANS,SYSTIMESTAMP);
END;
/

INSERT INTO EMPLOYEES (EMPLOYEE_ID,LAST_NAME,EMAIL,HIRE_DATE,JOB_ID)
VALUES (500,'KAUSAR','S.KAUSAR22','08032023','IT_PROG');
COMMIT;

SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 500;
DELETE FROM EMPLOYEES WHERE EMPLOYEE_ID = 500;
COMMIT;

UPDATE EMPLOYEES
SET SALARY = 10000
WHERE EMPLOYEE_ID = 500;

SELECT * FROM BAK_EMP;