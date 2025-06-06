program ejercicio12;
const
	valorAlto = 9999;
type
	accesos = record
		anio: integer;
		mes: integer;
		dia: integer;
		id: integer;
		tiempo: real;
	end;
	
	archivo = file of accesos;
	//Ordenado por año, mes, dia e idUsuario.
	
	procedure crearArchivo(var arc: archivo);
	var
		t: text;
		a: accesos;
	begin
		assign(t, 'usuarios.txt');
		reset(t);
		assign(arc, 'archivo.dat');
		rewrite(arc);
		while(not eof(t)) do begin
			readln(t, a.anio, a.mes, a.dia, a.id, a.tiempo);
			write(arc,a);
		end;
		close(arc);
		close(t);
		writeln('archivo creado con exito');
	end;
	
	procedure leer(var arc: archivo; var a: accesos);
	begin
		if(not eof(arc)) then
			read(arc,a)
		else
			a.anio:= valorAlto;
	end;
	
	procedure generarInforme(var arc: archivo);
	var
		a: accesos;
		anio, mesActual, diaActual, idActual: integer;
		tiempoAnio, tiempoMes, tiempoDia, tiempoUser: real;
	begin
		writeln('ingrese el año que quiere para generar el informe');
		readln(anio);
		reset(arc);
		leer(arc,a);
		if(a.anio <> valorAlto) then begin
			while(a.anio <> valorAlto) and (a.anio < anio) do
				leer(arc,a);
			if(a.anio = anio) then begin
				tiempoAnio:= 0;
				writeln('Año: ', a.anio);
				while(anio = a.anio) do begin
					mesActual:= a.mes;
					tiempoMes:= 0;
					writeln();
					writeln('Mes: ', a.mes);
					while(a.anio = anio) and (a.mes = mesActual) do begin
						diaActual:= a.dia;
						tiempoDia:= 0;
						writeln();
						writeln('Dia: ', a.dia);
						while (a.anio = anio) and (a.mes = mesActual) and (a.dia = diaActual) do begin
							idActual:= a.id;
							tiempoUser:= 0;
							while (a.anio = anio) and (a.mes = mesActual) and (a.dia = diaActual) and (a.id = idActual) do begin
								tiempoUser:= tiempoUser + a.tiempo;
								leer(arc,a);
							end;
							writeln('ID ', idActual, 'Tiempo total de acceso en el dia ', diaActual, 'del mes ', mesActual, ': ', tiempoUser:2:0);
							tiempoDia:= tiempoDia + tiempoUser;
						end;
						writeln('Tiempo total acceso dia ', diaActual, 'del mes ', mesActual, ': ', tiempoDia:2:0);
						tiempoMes:= tiempoMes + tiempoDia;
					end;
					writeln();
					writeln('Total tiempo de acceso mes: ', mesActual, ': ', tiempoMes:2:0);
					tiempoAnio:= tiempoAnio + tiempoMes;
				end;
				writeln('Total tiempo acceso año ', anio, ': ', tiempoAnio:2:0);
			end
			else
				writeln('Año no encontrado');
		end;
		close(arc);
	end;			
var
	arc: archivo;
begin
	crearArchivo(arc);
	generarInforme(arc);
end.
