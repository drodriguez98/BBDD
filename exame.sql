--  Mostra a matr�cula dos veh�culos que non foran alugados no ano actual (usa subconsulta non correlada IN)

select matricula from vehiculos 
where matricula not in 
(select matricula from alugueres 
where extract(year from data_inicial) = extract(year from sysdate) 
and matricula is not null);

--  Mostra a matr�cula dos veh�culos que non foran alugados no ano actual (usa subconsulta correlada EXISTS)

select matricula from vehiculos t
where not exists
(select * from alugueres 
where extract(year from data_inicial) = extract(year from sysdate) 
and matricula = t.matricula);

--  Mostra a matr�cula dos veh�culos que non foran alugados no ano actual (usa operadores de conxunto)      (+1)

select matricula 
from vehiculos minus
(select matricula from alugueres
where extract (year from data_inicial) = extract (year from sysdate));

--  Mostra a matr�cula dos veh�culos que non foran alugados no ano actual (usa joins)

select * from vehiculos a 
left join 
(select * from alugueres
where extract (year from data_inicial) = extract (year from sysdate)) b
on a.matricula=b.matricula 
where b.matricula is null order by 1;

--  Mostrar o dni e o nome dos clientes que alugaran algunha vez alg�n veh�culo da marca BMW        (+1)

select a.dni, a.nome as cliente
from clientes a, alugueres b, vehiculos c
where a.dni=b.dni and b.matricula=c.matricula
and c.marca in ('BMW');

--  Mostrar as matr�culas dos veh�culos alugados, xunto ao total de kil�metros recorridos con cada veh�culo e o total de di�eiro gastado no
--  aluguer de cada veh�culo, do cliente chamado �Jos� S�nchez�

select a.matricula, sum(a.kilometros), sum(a.num_dias*b.prezo_dia) as prezo_total
from alugueres a, vehiculos b, clientes c
where a.matricula=b.matricula and a.dni=c.dni 
and c.nome in ('Jos� S�nchez')
group by a.matricula;

--  Mostra todas as marcas e, por cada unha, a media de kil�metros que tiveron os veh�culos desa marca

select  a.marca, round (avg(nvl(b.kilometros,0)),3) as media_km
from vehiculos a left join alugueres b
on a.matricula=b.matricula 
group by a.marca;

--  Mostra a marca e os kilometros totais recorridos por ela da marca que m�is kilometros totais recorreu SIN CORREGIR

select a.marca, sum(b.kilometros) as km_totales
from vehiculos a left join alugueres b 
on a.matricula=b.matricula
group by a.marca 
having sum(b.kilometros) = (select max(sum(kilometros) from alugueres));

--  Fai unha consulta donde se mostren a marca e o modelo dos veh�culos que non est�n alugados hoxe

--  A axencia vai vender os coches que te�an m�is de tres anos ou fixeran m�is de 50000 kil�metros. Mostra as matr�culas dos veh�culos que 
--  cumpran esas condici�ns da t�boa Veh�culos

select a.matricula, sum(b.kilometros) as km_totais
from vehiculos a, alugueres b
where a.matricula=b.matricula and extract(year from a.data_compra) > (extract(year from sysdate) -3)
group by a.matricula
having sum(b.kilometros) > 50000;

--  Mostrando o dni e nome de todos os socios, para cada un mostra o total de di�eiro que gastaron na empresa de aluguer

select a.dni, a.nombre, sum(b.precio * c.num_dias) as gastos_totales
from clientes  a join (vehichulos b join alugueres c)
on a.dni=c.dni on b.matricula=c.matricula
group by a.dni, a.nombre;

--  Mostrando o dni e nome de todos os socios, para cada un mostra tam�n cantos alugueres fixeron

select a.dni, a.nome, count(dni) as alugueres_totais
from clientes a left join alugueres b 
on a.dni=b.dni 
group by a.dni, a.nome;

--  Queremos saber o que ga�ou a empresa no primeiro trimestre de 2018 cos veh�culos alugados a clientes espa�ois

select sum(a.prezo_dia*b.num_dias) as beneficios_2018
from vehiculos a, alugueres b, clientes c
where a.matricula=b.matricula and
b.data_inicial between "1/1/2018" and "31/3/2018" and c.nacionalidade in ('Espa�a');

--  Inter�sanos mostrar os tres veh�culos m�is alugados xunto coa s�a marca

select * from 
(select a.marca, a.matricula, count (*) as alugueres
from vehiculos a, alugueres b 
where a.matricula=b.matricula 
group by a.marca, a.matricula
order by 2 desc)
where rownum <4;

--  Realiza un listado completo de todos os socios, data de aluguer, matricula e modelo do coche alugado