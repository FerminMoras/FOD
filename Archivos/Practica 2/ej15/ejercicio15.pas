program ej15;
const
	dF = 3;
	valorAlto = 9999;
type
	infoMae = record
		codProvincia: integer;
		nomProvincia: string;
		codLocalidad: integer;
		nomLocalidad: string;
		sinLuz: integer;
		sinGas: integer;
		deChapa: integer;
		sinAgua: integer;
		sinSanitarios: integer;
	end;
	
	infoDet = record
		codProvincia: integer;
		codLocalidad: integer;
		conLuz: integer;
		construidas: integer;
		conAgua: integer;
		conGas: integer;
		conSanitarios: integer;
	end;
	
	maestro = file of infoMae;
	detalle = file of infoDet;
	
	vecDetalles = array[1..dF] of detalle;
	vecRegistros = array[1..dF] of infoDet;
	
	procedure leer(var det: detalle; var d: infoDet);
	begin
		if(not eof(det)) then
			read(det,d)
		else
			d.codProvincia:= valorAlto;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: infoDet);
	var
		pos,i: integer;
	begin
		min.codProvincia:= valorAlto;
		for i:= 1 to dF do begin
			if (vR[i] < min.codProvincia) then begin
				min:= vR[i];
				pos:= i;
			end;
		end;
		if (min.codPronvicia <> valorAlto) then
			leer(vD[pos],vR[pos],min);
	end;
	
	procedure unDetalle(var det:detalle);
	var
		d: infoDet;
		nombre: string;
		t: text;
	begin
		writeln('ingrese el nombre del archivo detalle a leer');
		readln(nombre);
		assign(t, nombre);
		reset(t);
		writeln('ingrese el nombre del archivo detalle binario a crear');
		readln(nombre);
		assign(det, nombre);
		rewrite(det);
		while(not eof(t)) do begin
			readln(t, d.codProvincia, d.codLocalidad, d.conLuz, d.construidas, d.conAgua, d.conGas, d.conSanitarios);
			write(det,d);
		end;
		close(t);
		close(det);
	end;
	
	procedure crearDetalles(var vD:vecDetalles);
	var
		i: integer;
	begin
		for i:= 1 to dF do begin
			unDetalle(vD[i]);
			writeln('archivo detalle creado con exito');
		end;	
	end;			
		
	procedure crearMaestro(var mae: maestro);
	var
		t: text;
		m: infoMae;
		nombre: string;
	begin
		writeln('ingrese el nombre del archivo maestro a leer');
		readln(nombre);
		assign(t, nombre);
		reset(t);
		writeln('ingrese el nombre del archivo maestro binario a crear');
		readln(nombre);
		assign(mae, nombre);
		rewrite(mae);
		while(not eof(t)) do begin
			readln(t, m.codProvincia, m.codLocalidad, m.sinLuz, m.sinGas, m.deChapa, m.sinAgua, m.sinSanitarios, m.nomProvincia);
			readln(t, m.nomLocalidad)
			write(mae, m);
		end;
		close(t);
		close(mae);
		writeln('El archivo maestro fue creado con exito');	
	end;
	
	procedure actualizarMaestro(var mae: maestro; var vD: vecDetalles);
	var
		vR: vecRegistros;
		locActual,provActual: integer;
		conLuz, conAgua, conChapa, conGas, conSanitarios: integer;
		min: infoDet;
		regm: infoMae;
	begin
		reset(mae);
		resetear(vD);
		minimo(vD,vR,min);
		while(min.codProvincia <> valorAlto) do begin
			provActual:= min.codProvincia;
			while(min.codProvincia = provActual) do begin
				locActual:= min.codLocalidad;
				if()
	end;
	
	procedure resetear(var vD: vecDetalles);
	var
		i:integer;
	begin
		for i:= 1 to dF do 
			reset(vD[i]);
	end;
	
	procedure cerrar(var vD: vecDetalles);
	var
		i:integer;
	begin
		for i:= 1 to dF do 
			close(vD[i]);
	end;
	
	procedure informar(var mae: maestro);	
	
		
