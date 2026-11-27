/*Creacion de vista*/
CREATE OR REPLACE VIEW vista_empleados_actuales AS
select e.emp_no as Numero_empleado,
			concat(e.first_name,' ', e.last_name) as Nombre_completo,
            e.gender as Genero, e.hire_date as Fecha_contratacion,
            d.dept_name as Departamento_actual,
            t.title as Puesto_actual, s.salary as salario_actual
from dept_emp de
join employees e
on de.emp_no = e.emp_no
join salaries s
on e.emp_no = s.emp_no
join departments d
on d.dept_no = de.dept_no
join titles t
on t.emp_no = e.emp_no
where s.to_date = '9999-01-01'
	AND de.to_date = '9999-01-01'
    AND t.to_date = '9999-01-01';
    
/*Consultar todos los empleados de un departamento específico.*/
select * from vista_empleados_actuales
	where Departamento_actual = 'sales';
    
/*Consultar los empleados con salario mayor a cierta cantidad.*/
select Numero_empleado, Nombre_completo, salario_actual
from vista_empleados_actuales
	where salario_actual > 70000;
    
/*Obtener el promedio salarial por departamento usando la vista.*/
select Departamento_actual, avg(salario_actual) as promedio_salarial
from vista_empleados_actuales
group by Departamento_actual;