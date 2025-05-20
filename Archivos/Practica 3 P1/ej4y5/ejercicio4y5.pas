program ejercicio4y5.pas;
type
	reg_flor = record
		nombre: string[45];
		codigo: integer;
	end;
	
	tArchFlores = file of reg_flor;
		
	procedure leerFlor(var f:reg_flor);
	begin
		writeln('ingrese el codigo');
		readln(f.codigo);
		if(f.codigo <> -1) then begin
			writeln('ingrese el nombre');
			readln(f.nombre);
		end;
	end;		
	
	procedure crearArchivo(var arc: tArchFlores);
	var
		nombre: string;
		f: reg_flor;
	begin
		writeln('ingrese el nombre del archivo a crear');
		readln(nombre);
		assign(arc,nombre);
		rewrite(arc);
		f.codigo:= 0;
		f.nombre:= 'cabecera';
		write(arc,f);
		leerFlor(f);
		while(f.codigo <> -1) do begin
			write(arc,f);
			leerFlor(f);
		end;
		close(arc);
		writeln('archivo creado con exito');		
	end;
	
	procedure alta(var arc: tArchFlores; nombre: string; codigo: integer);
	var
		f, aux: reg_flor;
	begin
		reset(arc);
		read(arc,aux);
		f.codigo:= codigo;
		f.nombre:= nombre;
		if(aux.codigo = 0) then begin
			seek(arc, filesize(arc));
			write(arc,f);
		end
		else begin
			seek(arc, aux.codigo * -1);
			read(arc,aux);
			seek(arc, filepos(arc)-1);
			write(arc,f);
			seek(arc,0);
			write(arc,aux);
		end;
		close(arc);
		writeln('alta realizada con exito');
	end;		
	
	procedure baja(var arc: tArchFlores; flor: reg_flor);
	var
		f,aux: reg_flor;
		ok: boolean;
	begin
		reset(arc);
		ok:= false;
		read(arc,aux);
		while(not eof(arc)) and (not ok) do begin
			read(arc,f);
			if(f.codigo = flor.codigo) then begin
				ok:= true;
				seek(arc, filepos(arc)-1);
				write(arc,aux);
				aux.codigo:= (filepos(arc)-1) * -1;
				seek(arc,0);
				write(arc,aux);
			end;	
		end;
		close(arc);
		if (ok) then
			writeln('baja realizada con exito')
		else		
			writeln('no se encontro la flor');
	end;
	
	procedure imprimirArc(var arc: tArchFlores);
	var
		f:reg_flor;
	begin
		reset(arc);
		seek(arc,1);
		while(not eof(arc)) do begin
			read(arc,f);
			if (f.codigo > 0) then
				writeln('Nombre:', f.nombre, ' Codigo: ', f.codigo);
		end;
		close(arc);			
	end;	
var
	arc: tArchFlores;
	flor: reg_flor;
	nombre: string;
	codigo: integer;
begin
	crearArchivo(arc);
	writeln('<-----ALTA----->');
	writeln('ingrese el nombre de la flor para realizar el alta');
	readln(nombre);
	writeln('ingrese el codigo de la flor para realizar el alta');
	readln(codigo);
	alta(arc,nombre,codigo);
	writeln('<-----BAJA----->');
	writeln('ingrese el nombre de la flor para realizar la baja');
	readln(nombre);
	writeln('ingrese el codigo de la flor para realizar la baja');
	readln(codigo);
	flor.nombre:= nombre;
	flor.codigo:= codigo;
	baja(arc,flor);
	writeln();
	writeln('<-------CONTENIDO DEL ARCHIVO------->');
	imprimirArc(arc);	
end.
