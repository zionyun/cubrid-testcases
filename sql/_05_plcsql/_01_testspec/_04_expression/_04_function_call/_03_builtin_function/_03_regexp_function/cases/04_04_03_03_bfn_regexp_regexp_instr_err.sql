--+ server-message on

-- normal: basic usage of a builtin function call

create or replace procedure t () as
begin
    dbms_output.put_line(REGEXP_INSTR(NULL, 'abc')); -- Should be null and not printed. not 0.
    dbms_output.put_line(REGEXP_INSTR('12345abcdeabcde', NULL));
    dbms_output.put_line(REGEXP_INSTR('12345abcdeabcde', 'abc', NULL));
    dbms_output.put_line(REGEXP_INSTR('12345abcdeabcde', 'abc', 1, NULL));
    dbms_output.put_line(REGEXP_INSTR('12345abcdeabcde', 'abc', 1, 1, NULL));
end;

select count(*) from db_stored_procedure where sp_name = 't';
select count(*) from db_stored_procedure_args where sp_name = 't';

call t();

drop procedure t;

--+ server-message off
