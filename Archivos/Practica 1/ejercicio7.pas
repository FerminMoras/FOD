program ejercicio7;
type
	novelas = record
		cod: integer;
		precio: real;
		genero: string;
		nombre: string;
	end;
	
	arNovelas = file of novelas;
	
	procedure leerNovela(var n: novelas);
	begin
		writeln('ingresar codigo');
		readln(n.cod);
		writeln('ingresar precio');
		readln(n.precio);
		writeln('ingresar genero');
		readln(n.genero);
		writeln('ingresar nombre');
		readln(n.nombre);
	end;
	
	procedure crearBinario(var a: arNovelas);
	var
		n: novelas;
		nombre: string;
		texto: Text;
	begin
		writeln('ingrese el nombre del archivo de texto a leer');
		readln(nombre);
		assign(texto, nombre);
		reset(texto);
		
		writeln('ingrese el nombre del archivo binario');
		readln(nombre);
		assign(a, nombre);
		rewrite(a);
		
		while(not EOF(texto)) do begin
			with n do begin
				readln(texto, cod, precio, genero);
				readln(texto, nombre);
			end;	
			write(a,n);
		end;
		
		close(texto);
		close(a);
		writeln('Archivo binario creado con exito');
	end;
	
	procedure aggNovela(var a: arNovelas);
	var
		nombre: string;
		n: novelas;
	begin
		writeln('ingrese el nombre del archivo binario');
		readln(nombre);
		assign(a, nombre);
		reset(a);
		leerNovela(n);
		seek(a,FileSize(a));
		write(a,n);
		close(a);
		writeln('novela agregada con exito');
	end;
	
	procedure modificarNovela(var a: arNovelas);
	var
		nombre: string;
		n: novelas;
		codigo: integer;
	begin
		writeln('ingrese el nombre del archivo binario');
		readln(nombre);
		assign(a, nombre);
		reset(a);
		
		writeln('ingrese el codigo de la novela a buscar');
		readln(codigo);
		
		read(a,n);
		while (not EOF(a)) and (n.cod <> codigo) do begin
			if (codigo = n.cod) then begin
				n.cod:= codigo;
				n.precio:= 10000;
				n.genero:= 'romance';
				n.nombre:= 'tres metros sobre el cielo';
				write(a,n);
			end	
			else
				read(a,n);
		end;
	end;	
		
var
	a: arNovelas;
	num: integer;
begin
	crearBinario(a);
	writeln('Seleccione una opcion');
	writeln('1- Agregar una novela');
	writeln('2- Modificar una novela');
	readln(num);
	if (num = 1) then
		aggNovela(a)
	else
		if (num = 2) then
			modificarNovela(a)
		else
			writeln('Opcion equivocada, no se realizo ningun cambio');
end.
