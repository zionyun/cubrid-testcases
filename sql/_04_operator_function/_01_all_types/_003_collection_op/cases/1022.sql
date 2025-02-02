--test operators seteq, subset, superset, superseteq with set(multiset,list) of timestamp
create class tb ( a set(timestamp), b multiset(timestamp) , c list(timestamp));
insert into tb values ( {},{},{});
insert into tb values ( null,null,null);

insert into tb values ({'5/5/2008 04:08:33 PM'},{'5/5/2008 04:08:34 PM'},{'5/5/2008 04:08:35 PM'});
insert into tb values ({'5/5/2008 04:08:33 PM'},{'5/5/2008 04:08:33 PM'},{'5/5/2008 05:08:33 PM'});
insert into tb values ({'5/5/2008 04:08:33 PM'},{'5/5/2008 04:08:13 PM'},{'5/5/2008 04:08:13 PM'});

select a, b from tb where a seteq b order by 1,2;
select a, b from tb where a superset b order by 1,2;
select a, b from tb where a subset b order by 1,2;
select a, b from tb where a setneq b order by 1,2;
select a, b from tb where a subseteq b order by 1,2;
select a, b from tb where a superseteq b order by 1,2;
select a, c from tb where a seteq c order by 1,2;
select a, c from tb where a superset c order by 1,2;
select a, c from tb where a subset c order by 1,2;
select a, c from tb where a setneq c order by 1,2;
select a, c from tb where a subseteq c order by 1,2;
select a, c from tb where a superseteq c order by 1,2;
select b, c from tb where b seteq c order by 1,2;
select b, c from tb where b superset c order by 1,2;
select b, c from tb where b subset c order by 1,2;
select b, c from tb where b setneq c order by 1,2;
select b, c from tb where b subseteq c order by 1,2;
select b, c from tb where b superseteq c order by 1,2;
select a, a from tb where a seteq a order by 1,2;
select b, b from tb where b seteq b order by 1,2;
select c, c from tb where c seteq c order by 1,2;
select a, a from tb where a setneq a order by 1,2;
select b, b from tb where b setneq b order by 1,2;
select c, c from tb where c setneq c order by 1,2;

drop class tb;
