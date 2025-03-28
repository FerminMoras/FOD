program ejercicio6;
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
	
	procedure leerCel(var c: celulares);
	begin
		writeln('Ingresar codigo');
		readln(c.cod);
		writeln('Ingresar nombre');
		readln(c.nombre);
		writeln('Ingresar descripcion');
		readln(c.descripcion);
		writeln('Ingresar marca');
		readln(c.marca);
		writeln('Ingresar precio');
		readln(c.precio);
		writeln('Ingresar stock minimo');
		readln(c.stockMin);
		writeln('Ingresar stock disponible');
		readln(c.stockDisp);
	end;
	
	procedure aggCelular(var a: archivoCelulares);
	var
		c: celulares;
		nombreAr: String;
	begin
		writeln('Ingrese el nombre del archivo binario');
		readln(nombreAr);
		assign(a,nombreAr);
		reset(a);
		leerCel(c);
		seek(a,FileSize(a));
		write(a,c);
		close(a);
	end;	
	
	procedure modificarStock(var a: archivoCelulares);
	var
		c:celulares;
		nombreAr:String;
		cel: integer;
	begin
		writeln('Ingrese el nombre del archivo binario');
		readln(nombreAr);
		assign(a,nombreAr);
		reset(a);
		
		writeln('Ingresar un codigo de celular');
		readln(cel);
		
		while (not EOF(a)) do begin
			read(a,c);
			if (cel = c.cod) then begin
				c.stockDisp:= 0;
				write(a,c);
			end;	
		end;
		close(a);
	end;
	
	procedure sinStock(var a: archivoCelulares);
	var
		c: celulares;
		arText: Text;
		nombreAr: String;
	begin
		writeln('Ingrese el nombre del archivo binario');
		readln(nombreAr);
		assign(a,nombreAr);
		reset(a);
		
		writeln('Ingrese el nombre del archivo de texto a exportar');
		readln(nombreAr);
		assign(arText,nombreAr);
		rewrite(arText);
		
		while (not EOF(a)) do begin
			read(a,c);
			if(c.stockDisp = 0) then begin
				With c do begin
					writeln(arText, ' ', cod, ' ', precio:2:0, ' ', marca);
					writeln(arText, ' ', stockDisp, ' ', stockMin, ' ', descripcion);
					writeln(arText, ' ', nombre);
				end;
			end;
		end;
		
		close(arText);
		close(a);
		writeln('Archivo exportado');
	end;
		
var
	//c: celulares;
	opcion: char;
	arCelulares: archivoCelulares;
begin
		writeln('Seleccione una opcion');
		writeln;
		writeln('a- Añadir celular');
		writeln;
		writeln('b- Modificar Stock');
		writeln;
		writeln('c- Importar txt con celulares sin stock');
		writeln;
		readln(opcion);
		case opcion of
            'a': aggCelular(arCelulares);
            'b': modificarStock(arCelulares);
            'c': sinStock(arCelulares);
        end;									
end.					
