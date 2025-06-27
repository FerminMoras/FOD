program ej8repaso;
const
	valorAlto = 9999;
	dF = 3; //en realidad son 16
type
	infoMae = record
		cod: integer;
		provincia: string;
		habitantes: integer;
		totalKg: real;
	end;
	
	infoDet = record
		cod: integer;
		cantKg: real;
	end;
	
	maestro = file of infoMae;
	detalle = file of infoDet;
	
	vecDetalles = array [1..dF] of detalle;
	vecRegistros = array [1..dF] of infoDet;
	
	procedure leer(var det: detalle; var d: infoDet);
	begin
		if (not eof(det)) then
			read(det,d)
		else
			d.cod:= valorAlto;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: infoDet);
	var
		i: integer;
		pos: integer;
	begin
		min.cod:= valorAlto;
		for i:= 1 to dF do begin
			if (vR[i].cod < min.cod) then begin
				min:= vR[i];
				pos:= i;
			end;	
		end;
		if(min.cod <> valorAlto) then
			leer(vD[pos],vR[pos])
	end;
	
	procedure unDetalle(var det: detalle);
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
			readln(t, d.cod, d.cantKg);
			write(det,d);
		end;
		close(t);
		close(det);
	end;
		
	procedure crearDetalles(var vD:vecDetalles);
	var
		i: integer;
	begin
		for i:= 1 to dF do
			unDetalle(vD[i]);
			writeln('archivo detalle creado con exito');
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
			readln(t, m.cod, m.habitantes, m.totalKg, m.provincia);
			write(mae, m);
		end;
		close(t);
		close(mae);
		writeln('El archivo maestro fue creado con exito');	
	end;
	
	procedure resetearDet(var vD: vecDetalles);
	var
		i: integer;
	begin
		for i:= 1 to dF do
			reset(vD[i]);
	end;
	
	procedure cerrarDet(var vD: vecDetalles);
	var
		i: integer;
	begin
		for i:= 1 to dF do
			close(vD[i]);
	end;	
	
	procedure actualizarMaestro(var mae: maestro; var vD:vecDetalles);
	var
		vR: vecRegistros;
		min: infoDet;
		m: infoMae;
		cantConsumida: real;
		codAct: integer;
	begin
		reset(mae);
		resetearDet(vD);
		minimo(vD,vR,min);
		while (min.cod <> valorAlto) do begin
			codAct:= min.cod;
			cantConsumida:= 0;
			while(min.cod = codAct) do begin
				cantConsumida:= cantConsumida + min.cantKg;
				minimo(vD,vR,min);
			end;
			
			read(mae,m);
			while(m.cod <> codAct) do 
				read(mae,m);	
			seek(mae,filepos(mae)-1);
			if(cantConsumida > 10000) then begin
				writeln('Codigo: ', codAct, 'Provincia: ', m.provincia);
				writeln('Promedio consumido por habitante: ', cantConsumida/m.habitantes:2:0);
				writeln();
			end;	
			m.totalKg:= m.totalKg + cantConsumida;
			write(mae,m);
		end;	
		close(mae);
		cerrarDet(vD);
		writeln('archivo maestro actualizado con exito');	
	end;		
				
var
	mae: maestro;
	vD: vecDetalles;
begin
	crearDetalles(vD);
	crearMaestro(mae);
	actualizarMaestro(mae,vD);
end.
