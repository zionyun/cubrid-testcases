/*
Test Case: truncate & update
Priority: 2
Reference case: cc_basic/_01_ReadCommitted/foreign_key_column/truncate_update_01.ctl
Author: Lily

Test Point:
B reference A, truncate A, update B, B is blocked.

NUM_CLIENTS = 2
C1: truncate table referenced table; 
C2: update reference table;
C1: rollback;
C2: commit;

*/

MC: setup NUM_CLIENTS = 2;
C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;
C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: DROP TABLE IF EXISTS t_foreign;
C1: DROP TABLE IF EXISTS t_primary;
C1: CREATE TABLE t_primary(id INT PRIMARY KEY,col VARCHAR(10));
C1: CREATE TABLE t_foreign(id INT,col VARCHAR(10),FOREIGN KEY(id) REFERENCES t_primary(id) ON DELETE CASCADE);
C1: INSERT INTO t_primary VALUES(1,'a'),(2,'b');
C1: INSERT INTO t_foreign VALUES(1,'test'),(2,'make');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: TRUNCATE TABLE t_primary CASCADE;
MC: wait until C1 ready;
C2: UPDATE t_foreign SET id=2 WHERE id=1;
MC: wait until C2 blocked;
C1: rollback;
MC: wait until C2 ready;

C2: SELECT * FROM t_primary ORDER BY 1,2;
C2: SELECT * FROM t_foreign ORDER BY 1,2;
C2: commit;

C2: quit;
C1: quit;

