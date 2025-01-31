/*
Test Case: delete & insert
Priority: 1
Reference case:
Author: Rong Xu

Test Point:
one user insert into an unempty table, another delete the whole table

NUM_CLIENTS = 2
C1: delete from t    -- delete 0 row
C2: insert(4); commit -- no block
C1: delete from t     -- delete 0 row
C1: select            -- no row be selected
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level read committed;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level repeatable read;

/* preparation */
C1: drop table if exists t;
C1: create table t(id int primary key,col varchar(10));
C1: commit work;
MC: wait until C1 ready;

/* test case */
/* expect delete 0 row */
C1: delete from t;
MC: wait until C1 ready;
C2: insert into t values(4,'abc');
MC: wait until C2 ready;
C1: commit;
/* expect C1 select id = 4 */
MC: wait until C1 ready;
C2: select * from t order by 1,2;
MC: wait until C2 ready;
/* expect delete 0 row */
C1: delete from t;
MC: wait until C1 ready;
C2: commit;
MC: wait until C2 ready;
/* expect delete 0 row */
C1: select * from t order by 1,2;
C1: commit;
/* expect id value: 4 */
C1: select * from t order by 1,2;
C1: commit;
MC: wait until C1 ready;

C2: quit;
C1: quit;

