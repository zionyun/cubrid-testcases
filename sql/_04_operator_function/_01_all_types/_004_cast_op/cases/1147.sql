--test cast function by casting bit data type to string,varchar(n),char(n),bit(n),nchar(n),nchar varying(n),bit varying(n),set of string,multiset of string,list of string in select clause

create class func_03(
varchartest     varchar(20),
sinttest         smallint,
inttest                 int,
numerictest     numeric(38,10),
floattest               float,
realtest                real,
doublepretest   double precision,
moneytest       monetary,
chartest        char(8),
datetest        date,
timetest        time,
timestamptest           timestamp,
bittest         bit(16),
nchartest       nchar(20),
ncharvartest    nchar varying(20),
bitvartest              bit varying(20),
stringtest      string);
create class dummy( a int );
insert into func_03 values ( '1234567890', 123, 12345, 9876543210987654321012345678.0123456789, 987654.321, 987654321.987654321,987654.321, 9876.1,'char1234', DATE '08/14/1977', TIME '02:10:00', TIMESTAMP '08/14/1977 5:35:00 pm',B'0', N'test111', N'test111', B'1','qa test');
insert into func_03 values ( '', 0, 0, 0, 0, 0,0, 0, '', null, null, null,B'', N'', N'', B'','');
insert into func_03(stringtest) values ( null);
insert into dummy values (1);

select bittest from func_03  order by 1;;	
select cast(bittest as string) from func_03 order by 1;;	
select cast(bittest as varchar(10)) from func_03 order by 1;;	
select cast(bittest as varchar(20)) from func_03 order by 1;;	
select cast(bittest as char(8)) from func_03 order by 1;
select cast(bittest as bit(80)) from func_03 order by 1;;	
select cast(bittest as nchar(20)) from func_03 order by 1;;	
select cast(bittest as nchar varying(20)) from func_03 order by 1;;	
select cast(bittest as bit varying(80)) from func_03 order by 1;;	
select cast(set{bittest} as set of string) from func_03 order by 1;;	
select cast(multiset{bittest} as multiset of string) from func_03 order by 1;
select cast(list{bittest} as list of string) from func_03 order by 1;

drop class func_03;
drop class dummy;
