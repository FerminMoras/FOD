program ejercicio2;
const
	valorAlto = 9999;
type
	productos = record
		cod: integer;
		precio: real;
		stockAct: integer;
		stockMin: integer;
		nombre: string[30];
	end;
	
	ventas = record
		cod: integer;
		cantVendida: integer;
	end;
	
	arMaestro = file of productos;
	arDetalle = file of ventas;
	
	procedure leer(var arc: arDetalle; var v:ventas);
	begin
		if(not (eof(arc))) then 
			read(arc,v)
		else
			v.cod:= valorAlto;
	end;
	
	procedure crearBinarios(var mae: arMaestro; var det: arDetalle);
	var
		v: ventas;
		p: productos;
		cargaD: text;
		cargaM: text;
	begin
		assign(cargaD, 'detalle.txt');
		assign(det, 'detalle.dat');
		rewrite(det);
		reset(cargaD);
		while(not eof(cargaD)) do begin
			readln(cargaD, v.cod, v.cantVendida);
			write(det,v);
		end;
		writeln('archivo binario detalle creado con exito');
		close(det);
		
		assign(cargaM, 'maestro.txt');
		assign(mae, 'maestro.dat');
		rewrite(mae);
		reset(cargaM);
		while(not eof(cargaM)) do begin
			readln(cargaM, p.cod, p.precio, p.stockAct, p.stockMin, p.nombre);
			write(mae,p);
		end;
		writeln('archivo binario maestro creado con exito');
		close(mae);
	end;
	
	procedure actualizarMaestro(var mae: arMaestro; var det: arDetalle);
	var
		v: ventas;
		p: productos;
		codActual: integer;
		total: integer;
	begin
		reset(mae);
		reset(det);
		read(mae,p);
		leer(det,v);
		while(v.cod <> valorAlto) do begin
			codActual:= v.cod;
			total:= 0;
			while(v.cod = codActual) do begin
				total:= total + v.cantVendida;
				leer(det,v);
			end;
			while(codActual <> p.cod) do begin
				read(mae,p);
			end;	
			p.stockAct:= p.stockAct - total;
			seek(mae,filepos(mae)-1);
			write(mae,p);
		end;
		close(mae);
		close(det);
	end;
	
	procedure imprimir(var a: arMaestro);
	var
		p: productos;
	begin
		reset(a);
		while(not eof(a)) do begin
			read(a,p);
			writeln('codigo: ', p.cod, ' monto: ', p.precio:2:0, ' Stock Actual: ', p.stockAct, ' Stock Minimo: ', p.stockMin, ' nombre: ', p.nombre);
		end;
		close(a);
	end;		
var
	mae: arMaestro;
	det: arDetalle;
begin
	crearBinarios(mae,det);
	actualizarMaestro(mae,det);
	imprimir(mae);
end.
