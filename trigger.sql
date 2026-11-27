/*creacion tabla*/
Create table IF NOT EXISTS auditoria_salarios (id_auditoria int auto_increment PRIMARY KEY NOT NULL,
							Numero_empleado int NOT NULL,
                            Salario_registrado int NOT NULL, 
                            fecha_inicio_salario date NOT NULL,
                            fecha_termino_salario date NOT NULL,
                            fecha_Hora timestamp DEFAULT current_timestamp);

/*Creacion trigger*/
drop trigger if exists trg_bd1_auditoria_insert_salario;
DELIMITER //
CREATE TRIGGER trg_bd1_auditoria_insert_salario
AFTER INSERT ON salaries
FOR EACH ROW
BEGIN
    insert into auditoria_salarios (Numero_empleado, Salario_registrado, fecha_inicio_salario,
                            fecha_termino_salario)
	values (NEW.emp_no, NEW.salary, NEW.from_date, NEW.to_date);
END //
DELIMITER ;

insert into salaries (emp_no, salary,from_date, to_date)
values (100001, 92000, '2026-01-01', '2026-12-12');

select * from salaries
where emp_no = 100001
and salary = 92000;

select * from auditoria_salarios;