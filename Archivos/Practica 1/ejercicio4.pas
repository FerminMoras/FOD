program ejercicio4;
type
	empleados = record
		numero: integer;
		apellido: string[20];
		nombre: string[20];
		edad: integer;
		dni: integer;
	end;
	
	archivoEmpleados = file of empleados;

	procedure incisoA(var arc: archivoEmpleados; var e: empleados);
	var
		num: integer;
	begin
		reset(arc);
		writeln('<-----AGREGAR UN EMPLEADO AL FINAL DEL ARCHIVO----->');
		writeln('ingrese un numero de empleado');
		readln(num);
		while not (EOF(arc)) and (num <> e.numero) do
			read(arc,e);
		if (num <> e.numero) then begin
			writeln('ingrese un apellido');
			readln(e.apellido);
			writeln('ingrese un nombre');
			readln(e.nombre);
			writeln('ingrese un dni');
			readln(e.dni);
			writeln('ingrese una edad');
			readln(e.edad);
			e.numero:= num;
			seek(arc, filesize(arc));
			write(arc,e);
			close(arc);
		end
		else
			close(arc);
	end;
	
	procedure incisoB(var arc: archivoEmpleados; var e: empleados);
	var
		num: integer;
	begin
		reset(arc);
		writeln('ingrese un numero de empleado para cambiar su edad');
		readln(num);
		while not(EOF(arc)) and (e.numero <> num) do 
			read(arc,e);
		if (e.numero = num) then
			writeln('la edad antes', e.edad);
			e.edad:= e.edad + 1;
			writeln('la edad ahora', e.edad);
		close(arc);
	end;
	
	procedure incisoC(var arc: archivoEmpleados; var e: empleados; var t: text);		
	begin
		reset(arc);
		assign(t, 'listaEmpleados.txt');
		rewrite(t);
		while not (EOF(arc)) do begin
			read(arc,e);
			With e do begin
				writeln(nombre:5, apellido:5, edad:5, dni:5, numero:5);
				writeln(t ,' ', nombre:5,' ', apellido:5,' ', edad:5,' ', dni:5,' ', numero:5);
			end;	
		end;
		close(arc);
		close(t);	
	end;
	
	procedure incisoD(var arc: archivoEmpleados; var e: empleados; var faltaDni: text);
	begin
		reset(arc);
		assign(faltaDni, 'faltaDniEmpleado.txt');
		rewrite(faltaDni);
		while not (EOF(arc)) do begin
			read(arc,e);
			if (e.dni = 0) then
				With e do begin
				writeln(nombre:5, apellido:5, edad:5, dni:5, numero:5);
				writeln(faltaDni ,' ', nombre:5,' ', apellido:5,' ', edad:5,' ', dni:5,' ', numero:5);
			end;	
		end;
		close(arc);
		close(faltaDni);
	end;			
	
var
	arEmpleados: archivoEmpleados;
	emp: empleados;
	texto: text;
	faltaDniEmpleado: text;
begin
	assign(arEmpleados,'empleados.dat');
	incisoA(arEmpleados,emp);
	incisoB(arEmpleados,emp);
	incisoC(arEmpleados,emp,texto);
	incisoD(arEmpleados,emp,faltaDniEmpleado);
end.	
	
