--  1. Función que calcule el salario total de un trabajador.

set serveroutput on;

create or replace function salario_total 

return number as

begin

    select employee_id, salary + commission_pct into v_sal from  employees where salary=v_sal;  
    
end;
/
