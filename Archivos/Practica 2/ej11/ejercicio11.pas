program ejercicio11;
const
	valorAlto = 9999;
type
	rango = 1..15;
	regMaestro = record
		depto: integer;
		division: integer;
		numeroEmp: integer;
		categoria: integer;
		horas: integer;
	end;
	
	arrayHoras = array [rango] of real;
	maestro = file of regMaestro;
	
	procedure leer(var mae:maestro; var regm: regMaestro);
	begin
		if(not(eof(mae))) then
			read(mae,regm)
		else
			regm.depto:= valorAlto;
	end;
	
	procedure crearArreglo(var v: arrayHoras);
	var
		categoria: rango;
		t: text;
		nombre: string;
		monto: real;
	begin
		writeln('ingresar nombre del archivo para cargar el arreglo');
		readln(nombre);
		assign(t,nombre);
		while(not eof(t)) do begin
			readln(t, categoria, monto);
			v[categoria]:= monto;
		end;	
		close(t);
		writeln('arreglo cargado con exito');
	end;		
	
	procedure crearMaestro(var mae: maestro);
	var
		regm: regMaestro;
		t: text;
		nombre: string;
	begin
		writeln('leer maestro');
		readln(nombre);
		assign(t,nombre);
		reset(t);
		
		writeln('crear maestro');
		readln(nombre);
		assign(mae,nombre);
		rewrite(mae);
		
		while(not eof(t)) do begin
			readln(t, regm.depto, regm.numeroEmp, regm.categoria, regm.horas, regm.division);
			write(mae,regm);
		end;
		
		close(mae);
		close(t);
		writeln('archivo maestro creado con exito');
	end;
	
	procedure informarDatos(var mae: maestro; v: arrayHoras);
	var
		regm: regMaestro;
		montoEmp: real;
		montoDiv: real;
		montoDepto: real;
		horasEmp: integer;
		horasDiv: integer;
		horasDepto: integer;
		deptoActual: integer;
		divActual: integer;
		numeroAct: integer;
		categoria: integer;
	begin
		reset(mae);
		leer(mae,regm);
		while(regm.depto <> valorAlto) do begin
			deptoActual:= regm.depto;
			montoDepto:= 0;
			horasDepto:= 0;
			writeln('Departamento: ', regm.depto);
			while(deptoActual = regm.depto) do begin
				divActual:= regm.division;
				montoDiv:= 0;
				horasDiv:= 0;
				writeln('Division: ', regm.division);
				writeln('Numero empleado        Total hs         Importe a cobrar');
				while(deptoActual = regm.depto) and (divActual = regm.division) do begin
					numeroAct:= regm.numeroEmp;
					montoEmp:= 0;
					horasEmp:= 0;
					categoria:= regm.categoria;
					while(deptoActual = regm.depto) and (divActual = regm.division) and (numeroAct = regm.numeroEmp) do begin
						horasEmp:= horasEmp + regm.horas;
						leer(mae,regm);
					end;
					montoEmp:= v[categoria] * horasEmp;
					writeln(numeroAct,'       ', horasEmp, '      ', montoEmp:0:2);
					montoDiv:= montoDiv + montoEmp;
					horasDiv:= horasDiv + horasEmp;
				end;
				writeln('Total de horas division: ', horasDiv);		
				writeln('Monto total division: ', montoDiv:0:2);
				horasDepto:= horasDepto + horasDiv;
				montoDepto:= montoDepto + horasDepto;
			end;
			writeln('Total de horas departamento: ', horasDepto);		
			writeln('Monto total departamento: ', montoDepto:0:2);
		end;
		close(mae);			
	end;
var
	v: arrayHoras;
	mae: maestro;
begin
	crearMaestro(mae);
	crearArreglo(v);
	informarDatos(mae,v);
end.	
