program ejercicio1;
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
			readln(t, p.codigo, p.nombre, p.precio, p.stockAct, p.stockMin);
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
			readln(t, v.codigo, v.cantU);
			write(det,v);
		end;
		
		close(det);
		close(t);
		writeln('archivo detalle creado con exito');	
	end;
	
	//PREGUNTAR POR ESTA RESOLUCION.
	procedure actualizarMaestroIncisoA(var mae:maestro; var det:detalle);
	var
		p:productos;
		v:ventas;
		totalV: integer;
	begin
		reset(mae);
		reset(det);
		while(not eof(mae)) do begin
			read(mae,p);
			totalV:= 0;
			while(not eof(det)) do begin
				read(det,v);
				if(v.codigo = p.codigo) then
					totalV:= totalV + v.cantU;
			end;
			seek(det,0);
			if(totalV > 0) then begin
				p.stockAct:= p.stockAct - totalV;
				seek(mae,filepos(mae)-1);
				write(mae,p);
			end;
		end;
		close(mae);
		close(det);			
	end;
	
	//en el punto B no es necesario agrupar y sumar los datos ya que solamente aparecen 1 o 0 veces, entonces directamente
	//lees y actualizas el maestro.
		
var
	mae: maestro;
	det: detalle;
begin
	crearDetalle(det);
	crearMaestro(mae);
	actualizarMaestroIncisoA(mae,det);
end.	
	
