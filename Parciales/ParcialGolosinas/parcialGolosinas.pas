Program parcialGolosinas;
const
	valorAlto = 9999;
	dF = 3;
type
	reg_maestro = record
		codigo: integer;
		nombre: string;
		precio: real;
		stockAct: integer;
		stockMin: integer;
	end;
	
	reg_detalle = record
		codigo: integer;
		cantV: integer;
	end;
	
	maestro = file of reg_maestro;
	detalle = file of reg_detalle;
	vecDetalles = array [1..dF]	of detalle;
	vecRegistros = array [1..dF] of reg_detalle;
	
	procedure leer(var det: detalle; var d:reg_detalle);
	begin
		if(not eof(det)) then
			read(det,d)
		else
			d.codigo:= valorAlto;	
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: reg_detalle);
	var
		pos,i: integer;
	begin
		min.codigo:= valorAlto;
		for i:= 1 to dF do begin
			if (vR[i].codigo < min.codigo) then begin
				min:= vR[i];
				pos:= i;
			end;
		end;
		if (min.codigo <> valorAlto) then begin
			leer(vD[pos],vR[pos]);
		end;	
	end;	
	
	procedure unDetalle(var det: detalle);
	var
		t: text;
		regd: reg_detalle;
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
			readln(t, regd.codigo, regd.cantV);
			write(det,regd);
		end;
		close(t);
		close(det);
	end;
	
	procedure crearDetalles(var v: vecDetalles);
	var
		i: integer;
	begin
		for i:= 1 to dF do begin
			unDetalle(v[i]);
			writeln('archivo detalle ', i, ' creado con exito');
		end;			
	end;	
	
	procedure crearMaestro(var mae: maestro);
	var
		t: text;
		regm: reg_maestro;
	begin
		assign(t, 'maestro.txt');
		reset(t);
		assign(mae, 'maestro.dat');
		rewrite(mae);
		while(not eof(t)) do begin
			readln(t, regm.codigo, regm.stockAct, regm.stockMin, regm.precio, regm.nombre);
			write(mae, regm);
		end;
		close(t);
		close(mae);
		writeln('El archivo maestro fue creado con exito');	
	end;
	
	procedure actualizarMaestro(var mae: maestro; var vD: vecDetalles);
	var
		min: reg_detalle;
		regm: reg_maestro;
		vR: vecRegistros;
		codAct,cant,i: integer;
		t: text;
	begin
		assign(t,'listaProducto.txt');
		rewrite(t);
		assign(mae,'maestro.dat');
		assign(vD[1],'detalle1.dat');
		assign(vD[2],'detalle2.dat');
		assign(vD[3],'detalle3.dat');
		reset(mae);
		for i:= 1 to dF do begin
			reset(vD[i]);
			leer(vD[i],vR[i]);
		end;	
		minimo(vD,vR,min);
		while(min.codigo <> valorAlto) do begin
			cant:= 0;
			codAct:= min.codigo;
			while(min.codigo <> valorAlto) and (min.codigo = codAct) do begin
				cant:= cant + min.cantV;
				minimo(vD,vR,min);
			end;
			read(mae,regm);
			while(regm.codigo <> codAct) do
				read(mae,regm);	
			seek(mae,filepos(mae)-1);
			if((cant * regm.precio) > 10000) then begin
				writeln(t, regm.codigo, regm.stockAct, regm.stockMin, regm.precio, regm.nombre);
			end;
			regm.stockAct:= regm.stockAct - cant;
			write(mae,regm);
		end;
		for i:= 1 to dF do 
			close(vD[i]);
		close(mae);
		close(t);
		writeln('Archivo maestro actualizado con exito');
	end;					
var
	vD: vecDetalles;
	mae: maestro;
begin
	//crearDetalles(vD);
	//crearMaestro(mae);
	actualizarMaestro(mae, vD);
end.
