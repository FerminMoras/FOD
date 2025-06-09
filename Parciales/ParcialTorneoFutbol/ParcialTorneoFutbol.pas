program parcial;
const
	valorAlto = 9999;
type
	equipo = record
		codEquipo: integer;
		nombre: string;
		anio: integer;
		codTorneo: integer;
		codRival: integer;
		golesAf: integer;
		golesEc: integer;
		puntos: integer;
	end;
	
	archivo = file of equipo;
	
	procedure leer(var arc: archivo; var e: equipo);
	begin
		if(not eof(arc)) then
			read(arc,e)
		else
			e.anio:= valorAlto;
	end;
	
	procedure crearArchivo(var arc: archivo);
	var
		t: text;
		e: equipo;
	begin
		assign(t,'archivo.txt');
		reset(t);
		assign(arc,'archivo.dat');
		rewrite(arc);
		while (not eof(t)) do begin
			readln(t, e.codEquipo, e.anio, e.codTorneo, e.codRival, e.golesAf, e.golesEc, e.puntos, e.nombre);
			write(arc,e);
		end;
		close(t);
		close(arc);
		writeln('archivo creado con exito');	
	end;
	
	procedure generarInforme(var arc: archivo);
	var
		nombreAct,nombreMax: string;
		e: equipo;
		golesAf, golesEc, ganados, perdidos, empatados: integer;
		max, totalPuntos, anioActual, codTorActual, codEqActual: integer;
	begin
		reset(arc);
		leer(arc,e);
		while(e.anio <> valorAlto) do begin
			anioActual:= e.anio;
			writeln('Año: ', anioActual);
			while (e.anio = anioActual) do begin
				codTorActual:= e.codTorneo;
				writeln('Codigo torneo: ', codTorActual);
				max:= -9999;
				while(e.anio = anioActual) and (e.codTorneo = codTorActual) do begin
					totalPuntos:= 0;
					golesAf:= 0;
					golesEc:= 0;
					ganados:= 0;
					perdidos:= 0;
					empatados:= 0;
					codEqActual:= e.codEquipo;
					nombreAct:= e.nombre;
					writeln('Codigo equipo: ', codEqActual, ' Nombre equipo: ', nombreAct);
					while(e.anio = anioActual) and (e.codTorneo = codTorActual) and (codEqActual = e.codEquipo) do begin
						totalPuntos:= totalPuntos + e.puntos;
						golesAf:= golesAf + e.golesAf;
						golesEc:= golesEc + e.golesEc;
						if (e.puntos = 3) then
							ganados:= ganados + 1
						else begin
							if (e.puntos = 0) then
								perdidos:= perdidos + 1
							else
								empatados:= empatados + 1
						end;
						leer(arc,e);
					end;			
					if(totalPuntos > max) then begin
						max:= totalPuntos;
						nombreMax:= nombreAct;
					end;	
					writeln('Cantidad total de goles a favor del equipo ', codEqActual, ': ', golesAf);
					writeln('Cantidad total de goles en contra del equipo ', codEqActual, ': ', golesEc);
					writeln('Diferencia de goles del equipo ', codEqActual, ': ', golesAf - golesEc);
					writeln('Cantidad total de partidos ganados del equipo ', codEqActual, ': ', ganados);
					writeln('Cantidad total de partidos perdidos del equipo ', codEqActual, ': ', perdidos);
					writeln('Cantidad total de partidos empatados del equipo ', codEqActual, ': ', empatados);
					writeln('Cantidad total de puntos del equipo ', codEqActual, ': ', totalPuntos);
				end;
			end;
			writeln('El equipo ', nombreMax, ' fue campeon del torneo ', codTorActual, ' del año ', anioActual);
		end;			
		close(arc);	
	end;	
var
	arc: archivo;
begin
	crearArchivo(arc);
	generarInforme(arc);
end.	
