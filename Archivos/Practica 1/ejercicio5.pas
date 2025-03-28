program ejercicio5;
type
	celulares = record
		cod: integer;
		nombre: string;
		descripcion: string;
		marca: string;
		precio: real;
		stockMin: integer;
		stockDisp: integer; 
	end;
	
	archivoCelulares = file of celulares;
	
	procedure crearArBinario(var arc: archivoCelulares);
	var
		nombreAr: string;
		nombreTxt: string;
		c: celulares;
		carga: Text;
	begin
		writeln('Ingrese el nombre del archivo de texto');
		readln(nombreTxt);
		assign(carga,nombreTxt);
		reset(carga);
		
		writeln('Ingrese un nombre para el archivo binario');
		readln(nombreAr);
		assign(arc,nombreAr);
		rewrite(arc);
		while (not eof(carga)) do 
		begin
			writeln('asdsad');
			with c do begin
				readln(carga, cod, precio, marca);
				readln(carga, stockDisp, stockMin, descripcion);
				readln(carga, nombre);
			end;
			writeln('llego antes del write');
			write(arc,c);
		end;
		writeln('Archivo cargado');
		close(carga);
		close(arc);	
	end;
	
	procedure listarStock(var arc: archivoCelulares);
	var
		c: celulares;	
	begin
		reset(arc);
		while not(EOF(arc)) do begin
			read(arc,c);
			if (c.stockDisp <c.stockMin) then
				With c do writeln(cod:5, nombre:5, descripcion:5, marca:5, precio:5, stockMin:5, stockDisp:5);	
		end;
	end;
	
	procedure listarDescripcion(var arc: archivoCelulares);
	var
		c: celulares;
		cadena: string;
	begin	
		reset(arc);
		writeln('ingrese una cadena de texto a buscar');
		readln(cadena);
		while not(EOF(arc)) do begin
			read(arc,c);
			if (c.descripcion = cadena) then
				With c do writeln(cod:5, nombre:5, descripcion:5, marca:5, precio:5, stockMin:5, stockDisp:5);
		end;		
	end;
	
	procedure exportar(var arc: archivoCelulares);
	var
		c:celulares;
		t:Text;
		nombreArchivo: string;
	begin
		writeln('Abrir archivo Binario: ');
        readln(nombreArchivo);
        assign(arc, nombreArchivo);
        reset(arc);

        assign(t, 'Celulares2.txt');
        rewrite(t);
        
		while not(EOF(arc)) do begin
			read(arc,c);
			With c do begin
				writeln(t, ' ', cod, ' ', precio:2:0, ' ', marca);
				writeln(t, ' ', stockDisp, ' ', stockMin, ' ', descripcion);
				writeln(t, ' ', nombre);
			end;
		end;
	end;
				
var
	//c: celulares;
	num: integer;
	arCelulares: archivoCelulares;
begin
	//crearArchivo(texto,c);
	writeln('Seleccione una opcion');
	writeln;
	writeln('1- Crear archivo binario de celulares');
	writeln;
	writeln('2- Listar en pantalla celulares con stock menor al minimo');
	writeln;
	writeln('3- Listar en pantalla celulares con descripcion propuesta por el usuario');
	writeln;
	writeln('4- Exportar archivo en forma de texto');
	writeln;
	writeln('5- Oprima 5 para finalizar');
	readln(num);
	while (num <> 5) do begin
		if(num = 1) then
			crearArBinario(arCelulares)
		else
			if (num = 2) then
				listarStock(arCelulares)
			else
				if (num = 3) then
					listarDescripcion(arCelulares)
				else
					if (num = 4) then
						exportar(arCelulares)
					else
						writeln('Valor incorrecto, por favor ingrese otro numero');
		writeln('Seleccione una opcion');
		writeln;
		writeln('1- Crear archivo binario de celulares');
		writeln;
		writeln('2- Listar en pantalla celulares con stock menor al minimo');
		writeln;
		writeln('3- Listar en pantalla celulares con descripcion propuesta por el usuario');
		writeln;
		writeln('4- Exportar archivo en forma de texto');
		writeln;
		writeln('5- Oprima 5 para finalizar');
		readln(num);				
	end;				
end.
