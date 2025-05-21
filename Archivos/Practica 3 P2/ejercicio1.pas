program ejercicio1;
const
	valorAlto: 9999;
type
	productos = record
		codigo: integer;
		nombre: string;
		precio: real;
		stockAct: integer;
		stockMin: integer;
	end;
	
	ventas = record
		codigo: integer;
		cantU: integer;
	end;
	
	maestro = file of productos;
	detalle = file of ventas;
	
	procedure leer(var det: detalle; var v:ventas);
	begin
		if(not eof(det)) then
			read(det,v)
		else
			v.codigo:= valorAlto;
	end;	
	
	procedure crearMaestro(var mae: maestro);
	var
		p:productos;
		t: text;
	begin
		assign(t,'maestro.txt');
		reset(t);
		
		assign(mae,'maestro.dat');
		rewrite(mae);
		
		while(not eof(t)) do begin
			readln(t, p.cod, p.nombre, p.precio, p.stockAct, p.stockMin);
			write(mae,p);
		end;
		
		close(mae);
		close(t);
		writeln('archivo maestro creado con exito');	
	end;
	
	procedure crearDetalle(var det: detalle);
	var
		v:ventas;
		t: text;
	begin
		assign(t,'detalle.txt');
		reset(t);
		
		assign(det,'detalle.dat');
		rewrite(det);
		
		while(not eof(t)) do begin
			readln(t, v.cod, v.cantU);
			write(det,v);
		end;
		
		close(det);
		close(t);
		writeln('archivo detalle creado con exito');	
	end;
	
	procedure actualizarMaestroIncisoB(var mae: maestro; var det: detalle);
	var
	
	begin
	
	end;
	
	
	//en el punto B al no repetirse los archivos detalles no es necesario agrupar las ventas de un mismo codigo
	//directamente leemos el detalle y actualizamos el maestro, porque sabemos q no vamos a volver a encontrar
	//ese codigo.
	procedure actualizarMaestroIncisoB(var mae: maestro; var det: detalle);
	var
		p:productos;
		v:ventas;
	begin
		reset(mae);
		reset(det);
		leer(det,v);
		while(v.codigo <> valorAlto) do begin
			reset(mae);
			read(mae,p);
			while (not eof(mae)) and (v.codigo <> p.codigo) do
				read(mae,p);
			if(v.codigo = p.codigo) then begin
				seek(filepos(mae)-1);
				p.stockAct:= p.stockAct - v.cantU;
				write(mae,p);
			end
			leer(det,v);
		end;
		close(mae);
		close(det);
		writeln('archivo maestro actualizado con exito');
	end;	
var

begin

end.	
	
