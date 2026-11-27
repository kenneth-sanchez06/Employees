/*La base de datos employees creada.*/
show databases;
/*Las tablas principales.*/
show tables;
/*Una consulta que muestre el número de registros de las tablas.*/
select count(*) from employees;
select count(*) from departments;
select count(*) from dept_emp;
select count(*) from dept_manager;
select count(*) from salaries;
select count(*) from titles;