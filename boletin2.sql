-- Obter os apelidos dos empregados

select apellidos from empleados;


-- Obter os apelidos dos empregados sen repetición 

select distinct apellidos from empleados;


--  Obter os datos de todos os empregados que se apelidan 'López'

select * from empleados where apellidos = 'López';


--  Obter os datos de todos os empregados que se apelidan 'López' ou 'Pérez'

select * from empleados where apellidos = 'López' or apellidos = 'Pérez';


--  Obter os datos de todos os empregados que traballan no departamento 14

select * from empleados where departamento = 14


--  Obter os datos de todos os empregados que traballan no departamento 37 e tamén no 77

select * from empleados where departamento = 37 and departamento = 77;


--  Obter os datos de todos os empregados que teñan a letra 'p' como inicial do seu apelido

select * from empleados where apellidos like 'P%';


--  Obter o presuposto total de todos os departamentos

select sum(presupuesto) as total from departamentos;
