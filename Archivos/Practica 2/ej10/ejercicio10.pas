program ejercicio10;

type
	regMaestro = record
		codProv: integer;
		codLoc: integer;
		numeroM: integer;
		cantV: integer;
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
			readln(t, regm.codProv, regm.codLoc, regm.numeroM, regm.cantV);
			write(mae,regm);
		end;
		
		close(mae);
		close(t);
		writeln('archivo maestro creado con exito');
	end;
	
	procedure informarVotos(var mae: maestro);
	var
		regm: regMaestro;
		totalProv: integer;
		totalGral: integer;
		locAct: integer;
		codAct: integer;
	begin
		reset(mae);
		totalGral:= 0;
		while(not eof(mae)) do begin
			totalProv:= 0;
			while(regm.codProv = provAct) and (regm.codLoc = locAct) do begin
				totalProv:= totalProv + cantV;
				writeln('Codigo de provincia: ',codProv);
				writeln('Codigo de Localidad: ',codLoc, '      ', 'Total de votos: ', );
				
	end;		
var

begin

end.
