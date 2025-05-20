program ejercicio6;
type
	prenda = record
		cod: integer;
		descripcion: string;
		colores: string;
		tipo: string;
		stock: integer;
		precio: real;
	end;
	
	maestro = file of prenda;
	detalle = file of integer;
	
	procedure crearMaestro(var mae: maestro);
	var
		p: prenda;
		t: text;
	begin
		assign(t,'maestro.txt');
		reset(t);
		assign(mae,'maestro.dat');
		rewrite(mae);
		
		while(not eof(t)) do begin
			readln(t, p.cod, p.stock, p.precio, p.descripcion);
			readln(t, p.colores);
			readln(t, p.tipo);
			write(mae, p);
		end;
		close(t);
		close(mae);
		writeln('archivo maestro creado con exito');
	end;
	
	procedure crearDetalle(var det: detalle);
	var
		cod: integer;
		t: text;
	begin
		assign(t,'detalle.txt');
		reset(t);
		assign(det,'detalle.dat');
		rewrite(det);
		while(not eof(t)) do begin
			readln(t, cod);
			write(det, cod);
		end;
		close(t);
		close(det);
		writeln('archivo maestro creado con exito');
	end;
	
	procedure realizarBajas(var mae: maestro; var det: detalle);
	var
		cod: integer;
		p:prenda;
	begin
		reset(mae);
		reset(det);
		while (not eof(det)) do begin
			read(det, cod);
			seek(mae, 0);
			read(mae, p);
			while (p.cod <> cod) do
				read(mae,p);
			seek(mae, filepos(mae)-1);
			p.stock:= -1;
			write(mae, p);
		end;
		close(mae);
		close(det);
		writeln('bajas realizadas con exito');
	end;
	
	procedure maestroNuevo(var mae,aux: maestro);
	var
		p:prenda;
	begin
		assign(aux, 'auxiliar.dat');
		rewrite(aux);
		reset(mae);
		while(not eof(mae)) do begin
			read(mae,p);
			if(p.stock >= 0) then
				write(aux,p);
		end;
		close(mae);
		close(aux);
		erase(mae);
		rename(aux, 'maestro.dat');
	end;		
	
	procedure imprimirMae(var mae: maestro);
	var
		p: prenda;
	begin
		reset(mae);
		while(not eof(mae)) do begin
			read(mae,p);
			writeln('codigo: ', p.cod, ' stock: ', p.stock, ' precio: ', p.precio:2:0, ' descripcion: ', p.descripcion);
		end;
		close(mae);
	end;		
var
	det: detalle;
	mae,aux: maestro;
begin
	crearDetalle(det);
	crearMaestro(mae);
	writeln('<-----MAESTRO SIN BAJAS----->');
	imprimirMae(mae);
	writeln();
	realizarBajas(mae,det);
	maestroNuevo(mae,aux);
	writeln('<-----MAESTRO CON BAJAS----->');
	imprimirMae(aux);
end.
