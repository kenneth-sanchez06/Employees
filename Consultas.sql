/*Consulta 1. Listado básico de empleados*/
select *
from (select * from employees
		order by emp_no ASC
        limit 50) as Primeros_cincuenta
order by last_name, first_name;

/*Consulta 2. Empleados contratados en un año específico*/
select e.emp_no as Numero_empleado, 
		concat(e.first_name,' ', e.last_name) as Nombre_completo,
        e.hire_date as Fecha_contratacion
from employees e
where year(e.hire_date) = 1990;

/*Consulta 3. Empleados y su departamento*/
select e.emp_no as Numero_empleado,
		concat(e.first_name,' ', e.last_name) as Nombre_completo,
        d.dept_name as Nombre_departamento,
        de.from_date as Fecha_inicio,
        de.to_date as Fecha_termino
from employees e
join dept_emp de
on e.emp_no = de.emp_no
join departments d
on de.dept_no = d.dept_no;

/*Consulta 4. Empleados actualmente asignados a departamentos*/
select e.emp_no as Numero_empleado,
		concat(e.first_name,' ', e.last_name) as Nombre_completo,
        de.dept_name as Departamento_actual,
        d.from_date as Fecha_inicio
from employees e
join dept_emp d
on e.emp_no = d.emp_no
join departments de
on d.dept_no = de.dept_no
where d.to_date = '9999-01-01';

/*Consulta 5. Cantidad de empleados por departamento actual*/
select de.dept_name as Departamento, count(d.emp_no) as empleados_actuales
from dept_emp d
join departments de
on d.dept_no = de.dept_no
where d.to_date = '9999-01-01'
group by de.dept_no;

/*Consulta 6. Salario actual de cada empleado*/
select e.emp_no as Numero_empleado,
		concat(e.first_name,' ', e.last_name) as Nombre_completo,
        s.salary as salario_actual, s.from_date as Fecha_recibido
from employees e
join salaries s
on e.emp_no = s.emp_no
where s.to_date = '9999-01-01';

/*Consulta 7. Promedio salarial por departamento actual*/
select de.dept_name as Departamento, avg(s.salary) as salario_promedio,
		min(s.salary) as salario_minimo, max(s.salary) as salario_maximo,
        count(d.emp_no) as empleados_actuales
from dept_emp d
join departments de
on d.dept_no = de.dept_no
join salaries s
on d.emp_no = s.emp_no
where s.to_date = '9999-01-01'
AND d.to_date = '9999-01-01'
group by Departamento;

/*Consulta 8. Departamentos con salario promedio mayor a cierta cantidad*/
select de.dept_name as Departamento, avg(s.salary) as salario_promedio
from dept_emp d
join departments de
on d.dept_no = de.dept_no
join salaries s
on d.emp_no = s.emp_no
where s.to_date = '9999-01-01'
	AND d.to_date = '9999-01-01'
group by Departamento
having avg(s.salary) > 65000;

/*Consulta 9. Historial de puestos de un empleado*/
select e.emp_no as Numero_empleado,
			concat(e.first_name,' ', e.last_name) as Nombre_completo,
            t.title as Puesto,
            t.from_date as Fecha_inicio,
            t.to_date as Fecha_termino
from employees e
join titles t
on e.emp_no = t.emp_no
where e.emp_no = 10009;

/*Consulta 10. Empleados que han sido gerentes*/
select e.emp_no as Numero_empleado,
			concat(e.first_name,' ', e.last_name) as Nombre_completo,
            d.dept_name as Departamento,
            dm.from_date as Fecha_inicio,
            dm.to_date as Fecha_termino
from employees e
join dept_manager dm
on e.emp_no = dm.emp_no
join departments d
on d.dept_no = dm.dept_no;

/*Consulta 11. Empleados con salario mayor al promedio general actual*/
select e.emp_no as Numero_empleado,
			concat(e.first_name,' ', e.last_name) as Nombre_completo,
            s.salary as salario_actual,
            (select avg(s.salary) from salaries s where s.to_date = '9999-01-01') as promedio_general_ac
from employees e
join salaries s
on e.emp_no = s.emp_no
where s.salary > (select avg(s.salary) from salaries s
					where s.to_date = '9999-01-01')
AND s.to_date = '9999-01-01';

/*Consulta 12. Último puesto registrado de cada empleado*/
select e.emp_no as Numero_empleado,
			concat(e.first_name,' ', e.last_name) as Nombre_completo,
            t.title as ultimo_titulo,
            t.from_date as Fecha_inicio,
            t.to_date as Fecha_termino
from employees e
join titles t
on e.emp_no = t.emp_no
where t.from_date = (select max(t2.from_date)
						from titles t2
						where t2.emp_no = e.emp_no);