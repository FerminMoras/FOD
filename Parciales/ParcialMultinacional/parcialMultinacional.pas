program parcialMultinacional;
type
	empleado = record
		dni: integer;
		nombre: string;
		apellido: string;
		edad: integer;
		domicilio: string;
		nacimiento: string;
	end;
	
	archivo = file of empleado;
	
	procedure leerEmpleado(var e:empleado);
	begin
		writeln('ingrese dni');
		readln(e.dni);
		writeln('ingrese nombre');
		readln(e.nombre);
		writeln('ingrese apellido');
		readln(e.apellido);
		writeln('ingrese edad');
		readln(e.edad);
		writeln('ingrese domicilio');
		readln(e.domicilio);
		writeln('ingrese nacimiento');
		readln(e.nacimiento);
	end;
	
	procedure crearArchivo(var arc: archivo);
	var
		t:text;
		e:empleado;
	begin
		assign(t,'archivo.txt');
		reset(t);
		assign(arc,'archivo.dat');
		rewrite(arc);
		while (not eof(t)) do begin
			readln(t, e.dni, e.edad, e.nombre);
			readln(t, e.nHoja, e.apellido);
			write(arc,e);
		end;
		close(t);
		close(arc);
	end;
	
	procedure agregarEmpleado(var arc: archivo);
	var
		cabecera,e:empleado;
		dni:integer;
	begin	
		reset(arc);
		read(arc,cabecera);
		leerEmpleado(e);
		if(existeEmpleado(e.dni) = false) then begin
			if(cabecera.dni = 0) then begin
				seek(arc, filesize(arc));
				write(arc,e);
			end
			else begin
				seek(arc, cabecera.dni * -1);
				read(arc, cabecera);
				seek(arc, filepos(arc)-1);
				write(arc,e);
				seek(arc,0);
				write(arc,cabecera);
			end;		
		end
		else
			writeln('El empleado con dni: ', dni, 'ya existe');
		close(arc);	
	end;
	
	procedure quitarEmpleado(var arc: archivo);
	var
		cabecera,e: empleado;
		dni: integer;
		ok: boolean;
	begin
		reset(arc);
		ok:= false;
		read(arc,cabecera)
		writeln('Ingrese el dni del empleado que desea eliminar');
		readln(dni);
		if(existeEmpleado(dni) then begin
			while(not eof(arc)) do begin
				read(arc,e);
				if(e.dni = dni) then begin
					seek(arc, filepos(arc)-1);
					write(arc,cabecera);
					cabecera.dni:= (filepos(arc)-1) * -1;
					seek(arc,0);
					write(arc,cabecera);
				end;
			end;
		end
		else
			writeln('El empleado con dni ', e.dni, ' no existe');
		close(arc);	
	end;	
var

begin

end.		
