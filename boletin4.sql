-- Amosar o nome das pel�culas

select nombre from peliculas;


-- Amosar t�dalas cualificaci�ns por idade que existen

select nombre,calificacionedad from peliculas 
group by calificacionedad,nombre;


-- Obter todas as pel�culas que a�nda non foron calificadas

select * from peliculas 
where calificacionedad is null;


-- Obter todas as salas nas que non se proxecta ningunha pel�cula

select * from salas 
where pelicula is null;


-- Obter informaci�n de todas as salas e, se � proxectada algunha pel�cula nela, amosar tam�n a informaci�n desa pel�cula

select a.*, b.nombre, b.calificacionedad 
from salas a left join peliculas b on a.pelicula=b.codigo;


-- Amosar a informaci�n de todas as pel�culas e, se non est�n proxectadas en ningunha sala, amosar tam�n a informaci�n da sala.

select a.*, b.nombre, b.calificacionedad 
from salas a right join peliculas b on a.pelicula=b.codigo;


-- Amosar o nome de pel�culas que a�nda non te�en sala asignada

select * from peliculas 
where codigo not in (select pelicula from salas where pelicula is not null);