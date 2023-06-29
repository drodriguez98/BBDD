-- Obter todos os datos de todos os almac�ns

select * from almacenes;


-- Obter todas as caixas que te�en un contido superior a 150�

select numreferencia 
from cajas 
where valor > 150;


-- Obter os tipos de contido das caixas

select contenido from cajas 
group by contenido;


-- Obter o valor medio de todas as caixas

select avg(valor) 
from cajas;


-- Obter o valor medio das caixas de cada almac�n

select a.codigo, avg(valor) 
from almacenes a, cajas b 
where b.almacenes=a.codigo 
group by almacenes;


-- Obter os c�digos dos almac�ns nos que o valor medio sexa superior a 150�

select almacen 
from cajas 
having avg(valor)>150 
group by almacen;


-- Obter o n�mero de referencia de cada caixa xunto co nome da cidade na que se atopa

select a.numreferencia, b.lugar 
from cajas a, almacenes b 
where a.codigo=b.almacen;


-- Obter o n�mero de caixas que hai en cada almac�n

select count(b.numreferencia), a.codigo 
from cajas b right join almacenes a on a.codigo=b.almacen 
group by a.codigo;


-- Obter o c�digo dos almac�ns que est�n saturados (nos que o n�mero de caixas � superior � capacidade)

select * from almacenes t 
where capacidad < (select count (*) from cajas where almacen=t.codigo);