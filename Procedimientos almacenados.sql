use employees;
/*Procedimiento 1. Buscar empleados por apellido*/
Drop procedure if exists sp_buscar_empleados_por_apellido;
DELIMITER //
create procedure sp_buscar_empleados_por_apellido(IN apellido varchar(30))
begin 
	select e.emp_no as Numero_empleado,
			e.first_name as Nombre, e.last_name as Apellido,
            e.gender as Genero, e.hire_date as Fecha_contratacion
    from employees e
    where e.last_name like concat('%', apellido, '%');
end // DELIMITER ;
call sp_buscar_empleados_por_apellido('Pe');

/*Procedimiento 2. Reporte de empleados por departamento*/
Drop procedure if exists sp_empleados_por_departamento;
DELIMITER //
create procedure sp_empleados_por_departamento(IN Numero_departamento char(4))
begin 
	select e.emp_no as Numero_empleado,
			concat(e.first_name,' ', e.last_name) as Nombre_completo,
            d.dept_name as Departamento,
            de.from_date as Fecha_inicio, s.salary as salario_actual
    from employees e
    join dept_emp de
    on e.emp_no = de.emp_no
    join departments d
    on de.dept_no = d.dept_no
    join salaries s
    on s.emp_no = e.emp_no
    where de.dept_no = Numero_departamento
    and s.to_date = '9999-01-01'
    AND de.to_date = '9999-01-01';
end // DELIMITER ;
call sp_empleados_por_departamento('d005');

/*Procedimiento 3. Resumen salarial de un departamento*/
Drop procedure if exists sp_resumen_salarial_departamento;
DELIMITER //
create procedure sp_resumen_salarial_departamento(IN Numero_departamento char(4))
begin 
	select d.dept_name as Nombre_departamento, count(e.emp_no) as Total_empleados_act,
			min(s.salary) as Salario_min_act, max(s.salary) as Salario_max_act,
            avg(s.salary) as Salario_prom_act
	from employees e
    join dept_emp de
    on e.emp_no = de.emp_no
    join departments d
    on de.dept_no = d.dept_no
    join salaries s
    on s.emp_no = e.emp_no
    where de.dept_no = Numero_departamento
    and s.to_date = '9999-01-01'
    AND de.to_date = '9999-01-01'
    group by Nombre_departamento;
end // DELIMITER ;
call sp_resumen_salarial_departamento('d005');