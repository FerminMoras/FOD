program ejercicio8;
const
	codAlto = 9999;
	dF = 3;
type
	rango = 1..dF;
	
	regMaestro = record
		cod: integer;
		nombre: string;
		habitantes: integer;
		totalKg: real;
	end;
	
	regDetalle = record
		cod: integer;
		cantKg: real;
	end;
	
	detalle = file of regDetalle;
	maestro = file of regMaestro;
	vecDetalles = array [rango] of detalle;	
	vecRegistros = array [rango] of regDetalle;
	
	procedure leer(var det: detalle; var regd: regDetalle);
	begin
		if(not (eof(det))) then
			read(det,regd)
		else
			regd.cod:= codAlto;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: regDetalle);
	var
		i: rango;
		pos: rango;
	begin
		min.cod:= codAlto;
		for i:= 1 to dF do begin
			if(vR[i].cod < min.cod) then begin
				min:= vR[i];
				pos:= i;
			end;
		end;
		if(min.cod <> codAlto) then
			leer(vD[pos],vR[pos]);
	end;
	
	procedure unDetalle(var det: detalle);
	var
		regd: regDetalle;
		t: text;
		nombre: string;
	begin
		writeln('leer detalle');
		readln(nombre);
		assign(t,nombre);
		reset(t);
		
		writeln('crear detalle');
		readln(nombre);
		assign(det,nombre);
		rewrite(det);
		
		while(not eof(t)) do begin
			readln(t, regd.cod, regd.cantKg);
			write(det,regd);
		end;
		close(t);
		close(det);
		writeln('archio detalle creado con exito');
	end;
	
	procedure crearDetalles(var vD: vecDetalles);
	var
		i:rango;
	begin
		for i:= 1 to dF do 
			unDetalle(vD[i]);
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
			readln(t, regm.cod, regm.habitantes, regm.totalKg, regm.nombre);
			write(mae,regm);
		end;
		close(t);
		close(mae);
		writeln('archio maestro creado con exito');
	end;
	
	procedure actualizarMaestro(var mae: maestro; var vD: vecDetalles);
	var
		vR: vecRegistros;
		regm: regMaestro;
		i: rango;
		codActual: integer;
		kilos: real;
		min: regDetalle;
	begin
		assign(vD[1],'detalle1.dat');
		writeln('asigno 1');
		assign(vD[2],'detalle2.dat');
		writeln('asigno 2');
		assign(vD[3],'detalle3.dat');
		writeln('asigno 3');
		assign(mae,'maestro.dat');
		writeln('asigno 4');
		reset(mae); //colocamos puntero del maestro al inicio
		read(mae,regm);
		writeln('resetamos maestro');
		for i:= 1 to dF do begin
			reset(vD[i]); //colocamos puntero de los detalle al inicio
			writeln('resetamos detalles');
			leer(vD[i],vR[i]); //leemos los detalles
		end;
		minimo(vD,vR,min); //vamos buscando el minimo en cada detalle para poder procesarlo
		while(min.cod <> codAlto) do begin //mientras no lleguemos al valor alto
			writeln('1er while');
			kilos:= 0;
			codActual:= min.cod;
			while(codActual = min.cod) do begin //procesamos mientras el codigo sea igual
				writeln('2do while');
				minimo(vD,vR,min);
			end;
			writeln('kilos: ', kilos:2:0);
			while(regm.cod <> min.cod) and (not eof(mae)) do begin //buscamos el codigo en el maestro
				writeln('3er while');
				read(mae,regm);
			end;
			if(regm.cod = min.cod) then begin
				regm.totalKg:= regm.totalKg + kilos;
				seek(mae,filepos(mae)-1);
				writeln('Escribe el maestro');
				write(mae,regm); //actualizamos en el maestro
			end;	
		end;
		close(mae);
		for i:= 1 to dF do
			close(vD[i]); 
	end;
	
	procedure imprimir(var mae: maestro);
	var
		regm: regMaestro;
	begin
		reset(mae);
		while(not eof(mae)) do begin
			read(mae,regm);
			with regm do begin
				writeln(cod,' ',habitantes,' ',totalKg:2:0,' ',nombre);
			end;
		end;
		close(mae);		
	end;	
var
	v: vecDetalles;
	mae: maestro;
begin
	//crearDetalles(v);
	//crearMaestro(mae);
	actualizarMaestro(mae,v);
	imprimir(mae);
end.	
