program ejercio3;
type
	empleados = record
		numero: integer;
		apellido: string[20];
		nombre: string[20];
		edad: integer;
		dni: integer;
	end;
	
	archivoEmpleados = file of empleados;
	
	procedure cargaArchivo(var arc: archivoEmpleados; var e: empleados);
	begin
		writeln('ingrese un apellido');
		readln(e.apellido);
		while (e.apellido <> 'fin') do begin
			writeln('ingrese un nombre');
			readln(e.nombre);
			writeln('ingrese un dni');
			readln(e.dni);
			writeln('ingrese una edad');
			readln(e.edad);
			writeln('ingrese un numero de empleado');
			readln(e.numero);
			write(arc,e);
			writeln('ingrese otro apellido o fin para finalizar');
			readln(e.apellido);
		end;
	end;
	
	procedure incisoI(var arc: archivoEmpleados; var e: empleados);
	var
		nomApe: string[20];
	begin
		reset(arc);
		writeln('ingrese un nombre o apellido');
		readln(nomApe);
		while not(EOF(arc)) do begin
			read(arc,e);
			if (e.apellido = nomApe) then 
				writeln('se encontro este apellido:', e.apellido)
			else
				if (e.nombre = nomApe) then
					writeln('se encontro este nombre:',e.nombre)
		end;
		close(arc);				
	end;
	
	procedure incisoII(var arc: archivoEmpleados; var e: empleados);
	begin
		reset(arc);
		writeln('<---------LISTA EMPLEADOS-------->');
		while not(EOF(arc)) do begin
			read(arc,e);
			writeln('<----------------->');
			writeln(e.nombre);
			writeln(e.apellido);
			writeln(e.edad);
			writeln(e.dni);
			writeln(e.numero);
			writeln('<----------------->');
		end;
		close(arc);
	end;
	
	procedure incisoIII(var arc:archivoEmpleados; var e: empleados);
	begin
		reset(arc);
		writeln('<---------LISTA MAYORES 70 ANIOS-------->');
		while not(EOF(arc)) do begin
			read(arc,e);
			if (e.edad > 70) then begin
				writeln('<----------------->');
				writeln(e.nombre);
				writeln(e.apellido);
				writeln(e.edad);
				writeln(e.dni);
				writeln(e.numero);
				writeln('<----------------->');
			end;
		end;
		close(arc);
	end;
			
var
	arEmpleados: archivoEmpleados;
	emp: empleados;
	nombreArchivo: string[20];
begin
	writeln('<--------INCISO A--------->');
	writeln('ingrese un nombre para el archivo');
	readln(nombreArchivo);
	assign(arEmpleados,nombreArchivo);
	rewrite(arEmpleados);
	cargaArchivo(arEmpleados,emp);
	close(arEmpleados);
	writeln('<--------INCISO B--------->');
	incisoI(arEmpleados,emp);
	incisoII(arEmpleados,emp);
	incisoIII(arEmpleados,emp);
end.
