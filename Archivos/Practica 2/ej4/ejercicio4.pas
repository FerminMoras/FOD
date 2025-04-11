program ejercicio4;
type
	valorAlto = 9999;
	dF= 3; //hago 3 archivos porq ni ganas de hacer 30
	
	productos = record
		cod: integer;
		nombre: string;
		descripcion: string;
		stockAct: integer;
		stockMin: integer;
		precio: real;
	end;
	
	regDetalle = record
		cod: integer;
		cantV: integer;
	end;
	
	detalle = file of regDetalle;
	maestro = file of productos;
	vecDetalles = array [1..dF] of detalle;
	vecRegistros = array [1..dF] of regDetalle;
	
	procedure leer(var det: detalle; var regd: regDetalle);
	begin
		if(not(eof(det))) then
			read(det,regd)
		else
			regd.cod:= valorAlto;
	end;	
		
	procedure minimo(var vDetalle: vecDetalles; var vRegistro: vecRegistros; var min: regDetalle);
	var
		i: integer;
		pos: integer;
	begin
		for i:= 1 to 3 do begin
			if(vRegistro[i].cod < min.cod) then begin
				min:= vRegistro[i];
				pos:= i;
			end;
		if(min.cod <> valorAlto) then
			leer(vDetalle[pos], vRegistro[pos]);
	end;
	
	procedure unDetalle(var det: detalle);
	var
		t: text;
		regd: regDetalle;
		nombre: string;
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
			readln(t, regd.cod, regd.cantV);
			write(det,regd);
		end;
		close(t);
		close(det);
	end;
	
	procedure crearMaestro(var mae: maestro);
	var
		t: text;
		regm: productos;
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
			readln(t, regm.cod, regm.stockAct, regm.stockMin, reg.precio, reg.nombre);
			readln(t, regm.descripcion);
			write(mae, regm);
		end;
		close(t);
		close(mae);
		writeln('El archivo maestro fue creado con exito');	
	end;
	
	procedure actualizarMaestro(var mae: maestro; var vDet: vDetalles);	
	var
		vReg: vecRegistros;
		i: integer;
		regm: productos;
		min: regDetalle;
		cant, aux: integer;
	begin
	
	end;
	
	
	procedure crearDetalles(var v: vDetalles);
	var
		i: integer;
	begin
		for i:= 1 to 3 do begin
			unDetalle(v[i]);
			writeln('archivo detalle ', i, ' creado con exito');
		end;			
	end;	
	
	var
	
	begin
	
	end.	
