--          PRÁCTICA 3

-- 1. Hallar la comisión, el nombre y el salario de los empleados con más de tres hijos, ordenados por comisión y, dentro de comisión, alfabéticamente.

select nombre, comision, salario, num_hijos 
from empleados 
where num_hijos > 3 
order by comision;

-- 2. Obtener los nombres de los departamentos que no dependen de otros.

select nombre 
from departamentos 
where depto_jefe is null;

-- 3. Obtener, por orden alfabético, los nombres y los salarios de los empleados cuyo salario esté comprendido entre 1250 y 1300 euros.

select nombre, salario 
from empleados 
where salario between 1250 and 1300 
order by nombre;

-- 4. Datos de los empleados que cumplen la condición anterior o tienen al menos un hijo.

select * 
from empleados 
where salario between 1250 and 1300 and num_hijos >= 1 
order by nombre;

-- 5. Muestre para cada empleado el número de meses que lleva el empleado en la empresa junto con su nombre.            *****

-- 6. Calcule aquellos empleados que llevan más de 35 años en la empresa. Muestre todos los datos de cada uno de ellos.     *****

-- 7. Hallar, por orden alfabético, los nombres de los empleados tales que si se les da una gratificación de 10 euros por hijo, el total de esta gratificación no supera la centésima parte del salario.

select nombre 
from empleados 
where num_hijos * 10 <= 0.1 * salario;

-- 8. Hallar, por orden de número de empleado, el nombre y el salario total (salario más comisión) de los empleados cuyo salario total supera los 1300 euros mensuales.

select nombre, salario + comision as salario_total 
from empleados 
where salario + comision > 1300 
order by cod;

-- 9. Obtener, por orden alfabético, los nombres de los departamentos que no contengan la palabra 'Dirección' ni 'Sector'          SIN CORREGIR

select nombre 
from departamentos 
where nombre not in ('sector', 'direccion') 
order by nombre;

-- 10. Obtener, por orden alfabético, los nombres de los departamentos que, o bien tienen directores en funciones y su presupuesto no excede los 5 mil euros, o bien no dependen de ningún otro departamento.

select nombre 
from departamentos 
where (tipo_dir = 'F' and presupuesto <= 5000) or (depto_jefe is null);


--          PRÁCTICA 4

-- 1. Hallar el número de empleados de toda la empresa.

select count (*) as total_empleados 
from empleados;

-- 2. Hallar cuántos departamentos existen y el presupuesto anual medio de la empresa para el global de todos los departamentos.

select count (distinct nombre) as total_departamentos, avg (presupuesto) as presupuesto_medio 
from departamentos;

-- 3. Hallar el número de empleados y de extensiones telefónicas distintas del departamento 112.

select count(cod), count(telefono) 
from empleados 
where departamento not in '112';

-- 4. Idem para los departamentos que no tienen director en propiedad.

select count(numero), count(telefono)
from empleados a, departamentos b
where a.departamento=b.numero and b.director is null;

-- 5. Datos de los empleados que trabajan en un centro con dirección en calle Atocha (cualquier número y ciudad) y tienen dos hijos exactamente. No use subconsultas anidadas.

select a.*, b.nombre, c.direccion from empleados a, departamentos b, centros c
where a.departamento=b.numero and b.centro=c.numero
and a.num_hijos = 2 and c.direccion like '%C. ATOCHA%';

-- 6. Extraiga un listado donde aparezca el código de los departamentos y su nombre conjuntamente con el código de los centros en donde están situados y el nombre de estos centros.

select a.numero as cod_depart, a.nombre as departamento, b.numero as cod_centro, b.nombre as centro
from departamentos a, centros b
where a.centro=b.numero;
