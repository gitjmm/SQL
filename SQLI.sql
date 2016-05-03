-- Ejercicios
-- Estos ejercicios utilizan el esquema HR
-- Ejecutar en sqlplus el archivo hr_main

-- Seleccionar nombre de empleados y salario con salario mayor que 15000 y que se encuentren en el departamento 20 o 50
select last_name, salary
from employees
where salary > 15000 and department_id in (20,50) 

-- Seleccionar apellidos y meses trabajados por los empleados
select e.last_name, round(months_between(sysdate,e.hire_date)) meses_trabajados
from employees e
order by meses_trabajados

-- Seleccionar apellidos, fecha de contratación y calcular nueva fecha que sea el primer martes dentro de 5 meses
select last_name, hire_date,to_char(next_day(add_months(hire_date,5),'MARTES'), 
'fmDay, "el" Ddspth "del" Month, YYYY') "Nueva fecha"
from employees


-- Calcular el salario maximo, minimo, la suma , la media y agrupar por job_id.
select job_id,round(max(salary),0) HIGH, round(min(salary),0) MIN, round(SUM(salary),0) SUMA, round(AVG(salary),0) MEDIA 
from employees
group by job_id


-- Seleccionar apellidos, job_id, id departamento y nombre de departamento cuya localización sea Seattle
select e.last_name,e.job_id,e.department_id,d.department_name 
from employees e 
join departments d on (d.department_id = e.department_id)
join locations l on (l.location_id = d.location_id)
where lower(l.city) = 'Seattle'




-- Lista de paises que no tienen departamentos en ellos. Mostrar id del pais y el nombre
select c.country_id
from countries c
minus
select c.country_id
from countries c join locations l on (c.country_id = l.country_id)
join departments d on (l.location_id = d.location_id)

-- Mostrar los trabajos de departamentos 10,20 y 50

select distinct job_id, department_id
from employees
where department_id = 10 or department_id = 20 or department_id = 50

-- Otra forma
select distinct job_id, department_id
from employees
where department_id = 10
union
select distinct job_id, department_id
from employees
where department_id = 20
union
select distinct job_id, department_id
from employees
where department_id = 50



-- Crear una vista que muestre los empleados del departamento 30 y que solo permite actualizar
-- datos de ese departamento
create or replace view dept30 as
select e.employee_id,e.last_name,e.department_id
from employees e
where department_id = 30
with check option constraint emp_dept30

update dept30
set department_id = 30
where last_name = 'Matos'

-- Crear la tabla midept con dos campos id y value. Crear un índice sobre id. Eliminar la tabla. 
create table midept(
id integer primary key,
value varchar2(50));


create index midept_value on midept(value)



drop table dept
