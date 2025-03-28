program ejercicio1;
type
	archivo_enteros = file of integer;
var
	arEnteros: archivo_enteros;
	nombre_archivo: string[15];
	num: integer;
begin
	writeln('ingrese el nombre para el archivo');
	readln(nombre_archivo);
	assign(arEnteros,nombre_archivo);
	rewrite(arEnteros);
	writeln('ingrese un numero');
	readln(num);
	while (num <> 30000) do begin
		write(arEnteros,num);
		writeln('ingrese un numero');
		readln(num);
	end;
	close(arEnteros);
end.			
