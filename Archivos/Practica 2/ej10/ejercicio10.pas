program ejercicio10;
const
	codAlto = 9999;
type
	regMaestro = record
		codProv: integer;
		codLoc: integer;
		numeroM: integer;
		cantV: integer;
	end;
	
	maestro = file of regMaestro;
	
	procedure leer(var mae:maestro; var regm: regMaestro);
	begin
		if(not (eof(mae))) then
			read(mae,regm)
		else
			regm.codProv:= codAlto;
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
		totalLoc: integer;
		locAct: integer;
		provAct: integer;
	begin
		reset(mae);
		totalGral:= 0;
		leer(mae,regm);
		while(regm.codProv <> codAlto) do begin
			totalProv:= 0;
			writeln('Codigo de Provincia: ', regm.codProv);
			provAct:= regm.codProv;
			while(regm.codProv = provAct) do begin
				locAct:= regm.codLoc;
				writeln('Codigo de Localidad: ', '             ' ,'Total de votos: ');
				totalLoc:= 0;
				while (regm.codProv = provAct) and (regm.codLoc = locAct) do begin
					totalLoc:= totalLoc + regm.cantV;
					leer(mae,regm)
				end;
				writeln(locAct,'                                ', totalLoc);
				totalProv:= totalProv + totalLoc;	
			end;
			writeln('Total votos provicia: ', totalProv);
			totalGral:= totalGral + totalProv;
		end;
		writeln('Total general votos: ', totalGral);			
		close(mae);
	end;
						
var
	mae: maestro;
begin
	crearMaestro(mae);
	informarVotos(mae);
end.
