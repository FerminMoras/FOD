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
	
	procedure leerDetalle(var det: detalle; var d: infoDet);
	begin
		if(not eof(det)) then
			read(det,d)
		else
			d.codProvincia:= valorAlto;
	end;
	
	procedure leerMaestro(var mae: maestro; var m: infoMae);
	begin
		if(not eof(mae)) then
			read(mae,m)
		else
			m.codProvincia:= valorAlto;
	end;		
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: infoDet);
	var
		pos,i: integer;
	begin
		min.codProvincia:= valorAlto;
		for i:= 1 to dF do begin
			if (vR[i].codProvincia < min.codProvincia) or ((vR[i].codProvincia = min.codProvincia) and (vR[i].codLocalidad < min.codLocalidad)) then begin
				min:= vR[i];
				pos:= i;
			end;
		end;
		if (min.codProvincia <> valorAlto) then
			leerDetalle(vD[pos],vR[pos]);
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
			readln(t, m.nomLocalidad);
			write(mae, m);
		end;
		close(t);
		close(mae);
		writeln('El archivo maestro fue creado con exito');	
	end;
	
	
	procedure cerrar(var vD: vecDetalles);
	var
		i:integer;
	begin
		for i:= 1 to dF do 
			close(vD[i]);
	end;
	
	procedure actualizarMaestro(var mae: maestro; var vD: vecDetalles);
	var
		i: integer;
		vR: vecRegistros;
		locActual,provActual: integer;
		conLuz, conAgua, construidas, conGas, conSanitarios: integer;
		min: infoDet;
		regm: infoMae;
	begin
		reset(mae);
		for i:= 1 to dF do begin
			reset(vD[i]);
			leerDetalle(vD[i],vR[i]);
		end;
		minimo(vD,vR,min);
		while(min.codProvincia <> valorAlto) do begin
			provActual:= min.codProvincia;
			while(min.codProvincia = provActual) do begin
				locActual:= min.codLocalidad;
				conLuz:= 0;
				conGas:= 0;
				conSanitarios:= 0;
				construidas:= 0;
				conAgua:= 0;
				while(min.codProvincia = provActual) and (min.codLocalidad = locActual) do begin
					conLuz:= conLuz + min.conLuz;
					conGas:= conGas + min.conGas;
					conSanitarios:= conSanitarios + min.conSanitarios;
					construidas:= construidas + min.construidas;
					conAgua:= conAgua + min.conAgua;
					minimo(vD,vR,min);
				end;
				leerMaestro(mae,regm);
				while(regm.codprovincia <> valorAlto) and ((regm.codProvincia <> provActual) or (regm.codLocalidad <> locActual)) do
					leerMaestro(mae,regm);
				if(regm.codProvincia = provActual) and (regm.codLocalidad = locActual) then begin
					regm.sinLuz:= regm.sinLuz - conLuz;
					regm.sinGas:= regm.sinGas - conGas;
					regm.sinSanitarios:= regm.sinSanitarios - conSanitarios;
					regm.deChapa:= regm.deChapa - construidas;
					regm.sinAgua:= regm.sinAgua - conAgua;
					seek(mae,filepos(mae)-1);
					write(mae,regm);
				end;
			end;
		end;
		close(mae);
		cerrar(vD);
		writeln('archivo maestro actualizado con exito');			
	end;
	
	procedure informar(var mae: maestro);	
	var
		cant: integer;
		regm: infoMae;
	begin
		cant:= 0;
		reset(mae);
		while(not eof(mae)) do begin
			read(mae,regm);
			writeln('Localidad: ', regm.nomLocalidad, ' Viviendas de chapa: ', regm.deChapa);
			if(regm.deChapa = 0) then
				cant:= cant + 1;
		end;
		writeln('La cantidad de localidades sin viviendas de chapa son: ', cant);
	end;
var
	mae: maestro;
	vD: vecDetalles;
begin
	crearMaestro(mae);
	crearDetalles(vD);
	actualizarMaestro(mae,vD);
	informar(mae);
end.
		
