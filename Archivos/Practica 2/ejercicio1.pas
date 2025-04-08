program ejercicio1;
const
	valorAlto = 9999;
type
	empleados = record
		cod: integer;
		monto: real;
		nombre: String;
	end;
	
	arEmpleados = file of empleados;
	
	procedure leer(var arc: arEmpleados; var e: empleados);
	begin
		if(not eof(arc)) then
			read(arc,e)
		else
			e.cod:= valorAlto;
	end;
	
	procedure crearArchivo(var arc: arEmpleados; var carga:text);
	var
		e: empleados;
		nombre: string;
	begin
		writeln('Ingrese un nombre para el archivo binario');
		readln(nombre);
		assign(arc,nombre);
		rewrite(arc);
		reset(carga);
		while (not eof(carga)) do begin
			with e do begin
				readln(carga, cod, monto, nombre);
				write(arc,e);
			end;	
		end;
		close(carga);
		close(arc);
		writeln('archivo binario creado');
	end;
	
	procedure actualizarMaestro(var arc: arEmpleados; var mae: arEmpleados);
	var
		e, empTotal, aux: empleados;
		nombre: string;
		montoTotal: real;
	begin
		writeln('ingrese el nombre del archivo detalle existente');
		readln(nombre);
		assign(arc,nombre);
		reset(arc);
		
		writeln('ingrese el nombre del archivo maestro a crear');
		readln(nombre);
		assign(mae,nombre);
		rewrite(mae);
		
		leer(arc,e);
		while (e.cod <> valorAlto) do begin
			montoTotal:= 0;
			aux:= e;
			while(aux.cod = e.cod) do begin
				montoTotal:= montoTotal + e.monto;
				leer(arc,e);
			end;
			empTotal:= aux;
			empTotal.monto:= montoTotal;
			write(mae,empTotal);		
		end;
		close(mae);
		close(arc);
	end;
	
	procedure imprimir(var a: arEmpleados);
	var
		e: empleados;
	begin
		reset(a);
		while(not eof(a)) do begin
			read(a,e);
			writeln('codigo: ', e.cod, ' monto: ', e.monto:2:0, ' nombre: ', e.nombre);
		end;
		close(a);
	end;
			
var
	carga: text;
	arc: arEmpleados;
	mae: arEmpleados;
begin
	assign(carga, 'empleados.txt');
	crearArchivo(arc,carga);
	actualizarMaestro(arc,mae);
	imprimir(mae);
end.
