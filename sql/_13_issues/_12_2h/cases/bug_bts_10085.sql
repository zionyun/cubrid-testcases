--+ holdcas on;
create table t (i integer, s1 string) collate utf8_en_cs;
show full columns from t;
alter table t add column s2 string;
show full columns from t;
alter table t charset utf8 collate utf8_en_cs;
alter table t add column s3 string;
show full columns from t;
drop t;
create table t (i integer, s1 string) charset utf8;
show full columns from t;
alter table t charset iso88591;
show full columns from t;
alter table t add column s3 string;
show full columns from t;
drop t;
create table t (i integer, s1 string) charset utf8;
alter table t charset iso8859;
alter table t charset iso88591 collate utf8_en_cs;
show full columns from t;
alter table t add column s2 string;
show full columns from t;
alter table t charset iso88591 collate utf8_en_cs1;
drop t;
create table t (i integer, s1 string) collate utf8_en_cs1;
--+ holdcas off;