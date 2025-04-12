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
	
	procedure reporte(var mae: maestro);
	var
		t: text;
		nombre: string;
		regm: productos;
	begin
		writeln('Ingrese el nombre del archivo de texto a crear');
		readln(nombre);
		assign(t,nombre);
		reset(mae);
		while(not eof(mae)) do begin
			read(mae,regm);
			if(regm.stockAct < regm.stockMin) then
				writeln(t, nombre, ' ', descripcion, ' ', stockAct, ' ', precio);
		end;
		close(t);
		close(mae);
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
	
	procedure actualizarMaestro(var mae: maestro; var vDet: vecDetalles);	
	var
		vReg: vecRegistros;
		i: integer;
		regm: productos;4
		min: regDetalle;
		cant, aux: integer;
	begin
		for i:= 1 to 3 do begin
			reset(vDet[i]);
			leer(vDet[i],vReg[i]);
		end;
		minimo(vDet,vReg,min);
		while(min.cod <> valorAlto) do begin
			cant:= 0;
			codAct:= min.cod;
			while(min.cod <> valorAlto) and (min.cod = codAct) do begin
				cant:= cant + min.cantV;
				minimo(vDet,vReg,min);
			end;
			read(mae,regm);
			while(regm.cod <> codAct) do begin
				read(mae,regm);
			end;
			seek(mae,filepos(mae)-1);
			regm.stockAct:= regm.stockAct - cant;
			write(mae,regm);
		end;
		reporte(mae);
		close(mae);
		for i:= 1 to 3 do
			close(v[i]);
	end;
	
	procedure crearDetalles(var v: vecDetalles);
	var
		i: integer;
	begin
		for i:= 1 to 3 do begin
			unDetalle(v[i]);
			writeln('archivo detalle ', i, ' creado con exito');
		end;			
	end;	
	
	var
		mae: maestro;
		vec: vecDetalles;
	begin
		crearMaestro(mae);
		crearDetalles(vec);
		actualizarMaestro(mae,vec);
	end.	
