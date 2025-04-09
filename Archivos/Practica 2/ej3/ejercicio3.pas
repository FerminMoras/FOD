program ejercicio3;
const
	valorAlto = 'ZZZZ';
type
	infoAlfa = record
		nombre: string[30];
		cantPer: integer;
		total: integer;
	end;
	
	censo = record
		nombre: string[30];
		cod: integer;
		cantPer: integer;
		total: integer;
	end;
	
	mae = file of infoAlfa;
	det = file of censo;
	
	procedure leer(var det:det; var c: censo);
	begin
		if(not(eof(det))) then
			read(det,c)
		else
			c.nombre:= valorAlto;
	end;
	
	procedure minimo(var det1,det2: det; var min,c1,c2: censo);
	begin
		if(c1.nombre <= c2.nombre) then begin
			min:= c1;
			leer(det1,c1);
		end	
		else begin
			min:= c2;
			leer(det2,c2);
		end;
	end;
	
	procedure crearDetalle (var det: det);
	var
		c:censo;
		t:text;
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
			readln(t, c.cod, c.cantPer, c.total, c.nombre);
			write(det,c);
		end;
		close(t);
		close(det);
		writeln('archivo binario detalle cargado con exito');	
	end;	
		
	procedure crearMaestro(var mae: mae);
	var
		i: infoAlfa;
		t: text;
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
			readln(t, i.cantPer, i.total, i.nombre);
			write(mae,i);
		end;
		close(t);
		close(mae);
		writeln('archivo binario maestro creado con exito');
	end;
	
	procedure actualizarMaestro(var maestro: mae; var det1,det2: det);
	var
		i: infoAlfa;
		c1,c2,min: censo;
	begin
		assign(det1, 'detalle1.dat');
		assign(det2, 'detalle2.dat');
		assign(maestro, 'maestro.dat');
		reset(det1);
		reset(det2);
		reset(maestro);
		writeln('pasa los reset');
		leer(det1,c1);
		leer(det2,c2);
		writeln('pasa los leer');
		minimo(det1,det2,min,c1,c2);
		while(min.nombre <> valorAlto) do begin
			writeln('entra al 1er while');
			read(maestro,i);
			while(min.nombre <> i.nombre) do begin
				writeln('entra al 2do while');
				read(maestro,i);
			end;		
			while(min.nombre = i.nombre) do begin
				writeln('entra al 3er while');
				i.cantPer:= i.cantPer + min.cantPer;
				i.total:= i.total + min.total;
				minimo(det1,det2,min,c1,c2);
			end;
			writeln('escribe los registros');
			seek(maestro,filepos(maestro)-1);
			write(maestro,i);	
		end;
		close(det1);
		close(det2);
		close(maestro);
		writeln('archivo maestro actualizado con exito');
	end;
	
	procedure imprimir(var maestro: mae);
	var
		i: infoAlfa;
	begin
		reset(maestro);
		while(not eof(maestro)) do begin
            read(maestro, i);
            with i do
				writeln('Provincia: ',nombre,' Cantidad de personas alfabetizadas: ', cantPer, ' Total de personas encuestadas: ', total);
		end;
		close(maestro);
	end;			
var
	det1,det2: det;
	maestro: mae;
begin
	//crearDetalle(det1);
	//crearDetalle(det2);
	//crearMaestro(maestro);
	actualizarMaestro(maestro,det1,det2);
	imprimir(maestro);
end.

















