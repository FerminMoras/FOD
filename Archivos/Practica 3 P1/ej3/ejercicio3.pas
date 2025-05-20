program ejercicio3;

type
	novelas = record
		codigo: integer;
		genero: String;
		nombre: String;
		duracion: String;
		director: String;
		precio: real;
	end;
	
	archivo = file of novelas;
	
	procedure leerNovela(var n: novelas);
	begin
		writeln('ingresar el director');
		readln(n.director);
		if (n.director <> 'herron') then begin
			writeln('ingresar el codigo');
			readln(n.codigo);
			writeln('ingresar el genero');
			readln(n.genero);
			writeln('ingresar el nombre');
			readln(n.nombre);
			writeln('ingresar la duracion');
			readln(n.duracion);
			writeln('ingresar el precio');
			readln(n.precio);
		end;	
	end;
	
	procedure crearArchivo(var arc: archivo);
	var
		n:novelas;
		nombre: string;
	begin
		writeln('Ingrese el nombre del archivo');
		readln(nombre);
		assign(arc, nombre);
		rewrite(arc);
		n.codigo:= 0;
		n.genero:= '';
		n.nombre:= '';
		n.duracion:= '';
		n.director:= '';
		n.precio:= 0;
		write(arc,n);
		leerNovela(n);
		while(n.director <> 'herron') do begin
			write(arc,n);
			leerNovela(n);
		end;
		close(arc);	
	end;
				
	procedure darAlta(var arc: archivo);
	var
		n, aux: novelas;
	begin
		reset(arc);
		read(arc,aux);
		leerNovela(n);
		if (aux.codigo = 0) then begin
			seek(arc, filesize(arc));
			write(arc,n);
		end
		else begin
			seek(arc, aux.codigo * -1);
			read(arc,aux);
			seek(arc, filepos(arc)-1);
			write(arc,n);
			seek(arc,0);
			write(arc,aux);
		end;
		close(arc);	
	end;
	
	procedure modificarNovelaMenu(var n:novelas);
	var
		opcion: char;
	begin
		writeln('Elija una opcion');
		writeln('A- Modificar novela entera(excepto el codigo)');
		writeln('B- Modificar genero');
		writeln('C- Modificar nombre');
		writeln('D- Modificar duracion');
		writeln('E- Modificar director');
		writeln('F- Modificar precio');
		readln(opcion);
		case opcion of
			'A': 
				begin
					writeln('ingresar el genero');
					readln(n.genero);
					writeln('ingresar el nombre');
					readln(n.nombre);
					writeln('ingresar la duracion');
					readln(n.duracion);
					writeln('ingresar el director');
					readln(n.director);
					writeln('ingresar el precio');
					readln(n.precio);
				end;
			'B':
				begin
					writeln('ingrese el genero:');
					readln(n.genero);
				end;
			'C':
				begin
					writeln('ingrese el nombre:');
					readln(n.nombre);
				end;
			'D':
				begin
					writeln('ingrese la duracion:');
					readln(n.duracion);
				end;
			'E':
				begin
					writeln('ingrese el director:');
					readln(n.director);
				end;
			'F':
				begin
					writeln('ingrese el precio:');
					readln(n.precio);
				end;				
		  else
			writeln('Opcion invalida');
		end;
	end;
	
	procedure modificarNovela(var arc: archivo);
	var
		n: novelas;
		cod: integer;
		ok: boolean;
	begin
		reset(arc);
		ok:= false;
		writeln('ingrese el codigo a modificar:');
		readln(cod);
		while (not eof(arc)) and (not ok) do begin
			read(arc,n);
			if(cod = n.codigo) then begin
				ok:= true;
				modificarNovelaMenu(n);
				seek(arc, filepos(arc)-1);
				write(arc,n);
			end;
		end;
		if (ok) then
			writeln('se modifico la novela con codigo: ', cod)
		else
			writeln('no se encontro la novela');
	end;			
	
	procedure darBaja(var arc: archivo);
	var	
		aux,n:novelas;
		ok: boolean;
		cod: integer;
	begin
		reset(arc);
		ok:= false;
		writeln('ingrese el codigo de la novela a eliminar');
		readln(cod);
		read(arc,aux);
		while (not eof(arc)) and (not ok) do begin
			read(arc,n);
			if(n.codigo = cod) then begin
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
			writeln('novela borrada con exito')
		else
			writeln('no se encontro la novela');		
	end;
	
	procedure generarTxt(var arc: archivo);
	var
		texto: text;
		nombre: string;
		n:novelas;
	begin
		writeln('ingrese el nombre del archivo de texto a crear');
		readln(nombre);
		assign(texto,nombre);
		rewrite(texto);
		reset(arc);
		seek(arc,1);
		while (not eof(arc)) do begin
			read(arc,n);
			if(n.codigo < 1) then begin
				writeln('novela eliminada');
			with n do begin
				writeln(texto, 'Nombre: ', n.nombre);
				writeln(texto, 'Género: ', n.genero);
				writeln(texto, 'Director: ', n.director);
				writeln(texto, 'Duración: ', n.duracion);
				writeln(texto, 'Código: ', n.codigo);
				writeln(texto, 'Precio: ', n.precio:0:2);
			end;
			writeln();	
			end;
		end;
		close(arc);
		close(texto);
		writeln('Archivo de texto creado con exito');
	end;				
var
	arc: archivo;
	opcion: char;
begin
	writeln('MENU DE OPCIONES');
	writeln('1- CREAR ARCHIVO');
	writeln('2- REALIZAR ALTA');
	writeln('3- MODIFICAR NOVELA');
	writeln('4- REALIZAR BAJA');
	writeln('5- CREAR ARCHIVO DE TEXTO');
	writeln('6- SALIR');
	readln(opcion);
	while (opcion <> '6') do begin
		case opcion of
			'1': crearArchivo(arc);
			'2': darAlta(arc);
			'3': modificarNovela(arc);
			'4': darBaja(arc);
			'5': generarTxt(arc);
		else
			writeln('opcion invalida');
		end;	
		writeln('MENU DE OPCIONES');
		writeln('1- CREAR ARCHIVO');
		writeln('2- REALIZAR ALTA');
		writeln('B- MODIFICAR NOVELA');
		writeln('4- REALIZAR BAJA');
		writeln('5- CREAR ARCHIVO DE TEXTO');
		writeln('6- SALIR');
		readln(opcion);
	end;	
end.
