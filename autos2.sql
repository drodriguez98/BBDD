-- Borra os coches que non se estean a distribu�r en ning�n concesionario

delete from coches 
where codcoche not in 
(select codcoche from distribucion where codcoche is not null);

delete from coches 
where codcoche in 
(select codcoche from coches minus select codcoche from distribucion)

delete from coches t 
where not exits 
(select codcoche from distribucion where codcoche=t.codcoche);

--  Obte-los datos de coches (marca, nome, modelo) vendidos polos concesionarios de 'Madrid', ordenado por marca e modelo de coche

select b.*, c.nombre as marca 
from ventas a, coches b, marcas c, concesionarios d
where a.codcoche=b.codcoche and a.codconc=d.codconc and b.codmarca=c.codmarca
and d.ciudad = 'MADRID' 
order by c.nombre, b.modelo;

-- Obte-lo n�mero total de coches turbodi�sel (o modelo leva as letras TD nalgunha parte da palabra) dispo�ibles no conxunto de concesionarios

select sum(cantidad) as coches_turbodiesel 
from distribucion a, coches b 
where a.codcoche=b.codcoche and modelo like ('%TD%');

select sum(cantidad) as coches_turbodiesel 
from distribucion a, coches b 
where a.codcoche=b.codcoche 
and modelo in 
(select modelo from coches where modelo like ('%TD%'));

--  Obte-la media de autom�biles que te�en todos os concesionarios    

select avg(sum(cantidad)) as media_coches from distribucion group by codconc;

select avg(sum(nvl(a.cantidad,0))) as media_coches from distribucion a right join concesionarios b on a.codconc=b.codconc group by b.codconc;

--  Obte-los c�digos de coches vendidos a clientes de Madrid  

select codcoche 
from ventas a, clientes b 
where a.dni=b.dni 
and b.ciudad = 'MADRID';

select codcoche 
from ventas 
where dni in 
(select dni from clientes where ciudad = 'MADRID');

--  Obte-los c�digos de coches vendidos a clientes de Madrid en concesionarios de Madrid

select codcoche from ventas where dni in 
(select dni from clientes where ciudad = 'MADRID') 
and codconc in 
(select codconc from concesionarios where ciudad = 'MADRID');

--  Obte-los datos persoais de clientes que compran os coches en concesionarios de cidades diferentes da que residen, ordenado por apelidos e nome   

select b.* 
from ventas a, clientes b, concesionarios c 
where a.dni=b.dni and a.codconc=c.codconc 
and b.ciudad <> c.ciudad 
order by b.apellidos, b.nombre;

select * 
from clientes t 
where dni in 
(select dni from ventas where codconc in 
(select codconc from concesionarios where ciudad <> t.ciudad));

select * 
from clientes t 
where exists 
(select * from ventas a, concesionarios b where a.codconc=b.codconc and a.dni=t.dni and b.ciudad <> t.ciudad);

select * from clientes t 
where exists 
(select * from ventas where dni=t.dni and codconc in 
(select codconc from concesionarios where ciudad <> t.ciudad));

select * from clientes t 
where exists 
(select * from ventas a where dni=t.dni and exists 
(select * from concesionarios where codconc=a.codconc and ciudad <> t.ciudad));

select * from clientes t 
where dni in 
(select dni from ventas where codconc in 
(select codconc from concesionarios where ciudad <> t.ciudad)) 
and dni not in 
(select dni from ventas where codconc in 
(select codconc from concesionarios where ciudad = t.ciudad) and dni is not null);

--  Obte-los datos persoais de clientes que compraron un coche nalg�n concesionario de Madrid, ordeado por dni     

select * from clientes 
where dni in 
(select dni from ventas a, concesionarios b where a.codconc=b.codconc and b.ciudad = 'MADRID') 
order by dni;

--  Obte-las cores de coche dos que se venderon m�is de 10 unidades no �ltimo ano, ordeados polo maior n�mero de ventas     -->     MAL

select color from ventas 
where extract(year from fecha) in (select(max(extract(year from fecha)))
group by color 
having count(color) > 10 
order by count(color) desc;

--  Obte-la lista ordeada alfab�ticamente de concesionarios que dispo�an de menos de 3 modelos de coche

select nombre from concesionarios where codconc in (select codconc from distribucion group by codconc having count(codcoche) < 3) order by nombre desc;

--  Obtelos datos das ventas (datos do coche e comprador) de calquera veh�culo das seguintes marcas: Renault, Citroen, Audi, Opel ou Mercdes

select b.*, d.* 
from ventas a, coches b, marcas c, clientes d
where a.codcoche=b.codcoche and a.dni=d.dni and b.codmarca=c.codmarca
and c.nombre in 
(select nombre from marcas where nombre in ('RENAULT', 'CITROEN', 'AUDI', 'OPEL','MERCEDES'));

-- Obter nome e apelidos dos clientes que adquiriron como m�nimo un coche branco e un coche vermello

select * from clientes 
where dni in 
(select dni from ventas where color='ROJO') 
and dni in 
(select dni from ventas where color='BLANCO');

select * from clientes t 
where dni in
(select dni from ventas where color='ROJO' 
and exists
(select * from ventas where color='BLANCO' and dni=t.dni));

select * from clientes  
where dni in
((select dni from ventas where color='ROJO') 
intersect
(select dni from ventas where color='BLANCO'));

--  Obte-los nomes dos clientes que non te�an comprado ning�n coche vermello a ning�n concesionario de Madrid

select nombre from clientes where dni not in 
(select dni from ventas where color='ROJO' and codconc in 
(select codconc from concesionarios where ciudad ='MADRID')
and dni is not null);

--  Obte-lo concesionario que non sexa de Madrid, tal que a s�a media de veh�culos en stock sexa a m�is alta de t�dalas medias

select * from concesionarios where ciudad <> 'MADRID' 
and codconc in 
(select codconc from distribucion group by codconc having avg(cantidad)=(select max(avg(cantidad)) from distribucion group by codconc));