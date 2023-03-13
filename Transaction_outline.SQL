BEGIN TRANSACTION;
	
	CREATE TABLE estudiante(
		id int not null,
		nombre varchar(30) not null,
		fecha_nto date not null,
		PRIMARY KEY (id)
	
	);
	
	SAVEPOINT creacion;
	
	--comprobacion entre savepoint y rollback, no se añade el valor
	INSERT into estudiante VALUES(23,'juan','2003-03-04');
	
	ROLLBACK TO creacion;
	--desooues de rollback se aceptan inserts
	
	INSERT into estudiante VALUES (24, 'Messi', '1987-11-8');
	
	
END TRANSACTION;

COMMIT;
