/*
Test Case: deferred trigger & invalidate transaction
Priority: 1
Reference case:
Author: Lily

Test Point:
when trigger is called, insert statement is executed

NUM_CLIENTS = 2
C1: update tt1 to fire a trigger to invalidate transaction; 
C2: select from tt1; 
*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS tt1;
C1: CREATE TABLE tt1( id INT, col INT);
C1: INSERT INTO tt1 VALUES(1,60),(2,60),(3,60);
C1: CREATE TRIGGER deferred_trg DEFERRED UPDATE ON tt1 IF obj.col=100 EXECUTE INVALIDATE TRANSACTION;
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: UPDATE tt1 SET col=100 WHERE id=3;
MC: wait until C1 ready;

C2: SELECT * FROM tt1 ORDER BY id;
MC: wait until C2 ready;
/* expected - reject to commit */
C1: commit;
MC: sleep 1;
C2: SELECT * FROM tt1 order by id;
C1: rollback;
C2: SELECT * FROM tt1 order by id;
C2: quit;
C1: quit;
