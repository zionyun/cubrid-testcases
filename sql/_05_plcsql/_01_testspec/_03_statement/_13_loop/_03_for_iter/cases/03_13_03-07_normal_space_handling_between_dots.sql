--+ server-message on

-- Verified for CBRD-25830
-- A procedure can be successfully created even if there are no spaces around the range operator (..) in a FOR loop.

--case1: No spaces on both sides
CREATE OR REPLACE PROCEDURE PROC_FOR_TEST IS 
BEGIN 
    FOR i IN 1..5 LOOP 
        DBMS_OUTPUT.PUT_LINE('Number: ' || i); 
    END LOOP; 
END;
CALL PROC_FOR_TEST();
DROP PROCEDURE PROC_FOR_TEST;

--case2: No space on the left side
CREATE OR REPLACE PROCEDURE PROC_FOR_TEST IS
BEGIN
    FOR i IN 1.. 5 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    END LOOP;
END;
CALL PROC_FOR_TEST();
DROP PROCEDURE PROC_FOR_TEST;

--case3: No space on the right side
CREATE OR REPLACE PROCEDURE PROC_FOR_TEST IS
BEGIN
    FOR i IN 1 ..5 LOOP
        DBMS_OUTPUT.PUT_LINE('Number: ' || i);
    END LOOP;
END;
CALL PROC_FOR_TEST();
DROP PROCEDURE PROC_FOR_TEST;

--+ server-message off
