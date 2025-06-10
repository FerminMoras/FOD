program parcialDinosaurios;
type	
	dinosaurio = record
		codigo: integer;
		tipo: string;
		alturaYpeso: string;
		descripcion: string;
		zona: string;
	end;
	
	archivo = file of dinosaurio;
	
	procedure leerDinosaurio(var d: dinosaurio);
	begin
		writeln('INGRESE LOS DATOS DEL DINOSAURIO A CREAR');
		writeln('ingresar codigo');
		readln(d.codigo);
		writeln('ingresar tipo');
		readln(d.tipo);
		writeln('ingresar altura y peso');
		readln(d.alturaYpeso);
		writeln('ingresar descripcion');
		readln(d.descripcion);
		writeln('ingresar zona');
		readln(d.zona);
	end;		

	procedure crearArchivo(var arc: archivo);
	var
		t:text;
		d:dinosaurio;
	begin
		assign(t,'archivo.txt');
		reset(t);
		assign(arc,'archivo.dat');
		rewrite(arc);
		while (not eof(t)) do begin
			readln(t, d.codigo, d.tipo);
			readln(t, d.alturaYpeso);
			readln(t, d.descripcion);
			readln(t, d.zona);
			write(arc,d);
		end;
		close(t);
		close(arc);
	end;
	
	procedure realizarBaja(var arc:archivo);
	var
		cabecera,d:dinosaurio;
		ok: boolean;
		cod: integer;
	begin
		assign(arc,'archivo.dat');
		reset(arc);
		read(arc,cabecera);
		writeln('ingrese el codigo del dinosaurio que desea eliminar');
		readln(cod);
		ok:= false;
		while(not eof(arc)) and (not ok) do begin
			read(arc,d);
			if(d.codigo = cod) then begin
				ok:= true;
				seek(arc,filepos(arc)-1);
				write(arc,cabecera);
				cabecera.codigo:= (filepos(arc)-1) * -1;
				seek(arc,0);
				write(arc,cabecera);	
			end;
		end;
		if (ok) then
			writeln('baja realizada con exito')
		else
			writeln('no se encontro el codigo ingresado');
		close(arc);	
	end;
	
	procedure realizarAlta(var arc:archivo; dino:dinosaurio);
	var
		cabecera:dinosaurio;
	begin
		assign(arc,'archivo.dat');
		reset(arc);
		read(arc,cabecera);
		if(cabecera.codigo = 0) then begin
			seek(arc,filesize(arc));
			write(arc,dino);
		end
		else begin
			seek(arc,cabecera.codigo * -1);
			read(arc,cabecera);
			seek(arc,filepos(arc)-1);
			write(arc,dino);
			seek(arc,0);
			write(arc,cabecera);
		end;
		close(arc);
		writeln('alta realizada con exito');
	end;
	
	procedure generarTxt(var arc:archivo);
	var
		d:dinosaurio;
		t:text;
	begin
		assign(arc,'archivo.dat');
		reset(arc);
		assign(t,'listaDinosaurios.txt');
		rewrite(t);
		while(not eof(arc)) do begin
			read(arc,d);
			if(d.codigo > 0) then
				writeln(t, d.codigo, ' ', d.tipo, ' ', d.alturaYpeso, ' ', d.descripcion, ' ', d.zona);
		end;
		close(arc);
		close(t);
		writeln('lista generada con exito');
	end;
var
	arc: archivo;
	d: dinosaurio;
	num: integer;
begin
	crearArchivo(arc);
	leerDinosaurio(d);
	realizarAlta(arc,d);
	writeln('Si desea realizar una baja ingrese el 1, si desea terminar ingrese -1');
	readln(num);
	while (num <> -1) do begin
		realizarBaja(arc);
		writeln('Si desea realizar una baja ingrese el 1, si desea terminar ingrese -1');
		readln(num);
	end;	
	generarTxt(arc);
end.
	
		
