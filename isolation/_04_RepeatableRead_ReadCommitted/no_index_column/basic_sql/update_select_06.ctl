/*
Test Case: update & select
Priority: 1
Reference case:
Author: Mandy

Test Point:
1. Reading queries can only have a look at data committed before the queries began
2. changes committed after the query started are never seen

NUM_CLIENTS = 2
C1: update, commit after C2's query start
C2: select three times - before C1 commit, after C1 commit, after C2 commit. 
*/

MC: setup NUM_CLIENTS = 2;

C1: set transaction lock timeout INFINITE;
C1: set transaction isolation level repeatable read;

C2: set transaction lock timeout INFINITE;
C2: set transaction isolation level read committed;

/* preparation */
C1: drop table if exists t1;
C1: create table t1(id int, col varchar(10));
C1: insert into t1 values(1,'abc');insert into t1 values(2,'def');insert into t1 values(3,'ghijk');insert into t1 values(4,'lmn');insert into t1 values(5,'opq');insert into t1 values(6,'rs');
C1: commit work;
MC: wait until C1 ready;

/* test case */
C1: update t1 set col='aaa' where id=6;
MC: wait until C1 ready;
C2: select t1.* from t1 where (select sleep(10)) = 0 order by id;
MC: sleep 2;
C1: commit;
MC: wait until C1 ready;
MC: wait until C2 ready;

C2: select * from t1 order by 1,2;
C2: commit;
C2: select * from t1 order by 1,2;
C2: commit;
MC: wait until C2 ready;

C1: quit;
C2: quit;
