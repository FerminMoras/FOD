program ejercicio9;
const

type
	cli = record
		cod: integer;
		nombre: string;
		apellido: string;
	end;
	
	fec = record
		anio: integer;
		mes: integer;
		dia: integer;
	end;	
	
	regMaestro = record
		cliente: cli;
		fecha: fec;
		monto: real;
	end;
	
	maestro = file of regMaestro;
	
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
			readln(t, regm.cli.cod, regm.cli.nombre;)
			readln(t, regm.cli.apellido);
			readln(t, regm.fec.anio, regm.fec.mes, regm.fec.dia, regm.monto);
			write(mae,regm);
		end;
		
		close(mae);
		close(t);
		writeln('archivo maestro creado con exito');
	end;
	
	procedure reporte(var mae: maestro);
	var
		regm: regMaestro;
		totalCliente: real;
		totalVentas: real;
		codAct,anioAct,mesAct: integer;
	begin
		reset(mae);
		totalVentas:= 0;
		while(not eof(mae)) do begin
			totalClientes:= 0;
			codActual:= regm.cli.cod;
			anioAct:= regm.fec.anio;
			mesAct:= regm.fec.mes;
			read(mae,regm);
			while(codAct = regm.cli.cod) and (mesAct = regm.fec.anio) and (mesAct = regm.fec.mes) and (not eof(mae)) do begin
				if (regm.monto <> 0) then
					writeln('En el mes ', regm.fec.mes, ' gasto:', regm.total);
				totalCliente:= totalCliente + regm.monto;
				read(mae,regm);
			end;
			totalVentas:= totalVentas + totalCliente;
		end;
		writeln('El total recaudado para la empresa fue de: ', totalVentas);
		close(mae);
	end;				
			
var
	mae: maestro;
begin
	crearMaestro(mae);
	reporte(mae);
end.
