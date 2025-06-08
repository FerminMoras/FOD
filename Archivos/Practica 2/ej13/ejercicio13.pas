Program ejercicio13;
const
	valorAlto = 9999;
type
	usuario = record
		nro: integer;
		nameUser: string;
		nombre: string;
		apellido: string;
		cantMail: integer;
	end;
	
	mail = record
		nro: integer;
		cuentaDes: integer;
		mensaje: string;
	end;
	
	maestro = file of usuario;
	detalle = file of mail;
	
	procedure leer(var det: detalle; var m: mail);
	begin
		if(not eof(det)) then
			read(det,m)
		else
			m.nro:= valorAlto;
	end;
	
	procedure crearDetalle(var det: detalle);
	var
		t:text;
		m:mail;
	begin
		assign(t,'mailsDetalle.txt');
		reset(t);
		assign(det,'mailsDetalle.dat');
		rewrite(det);
		while(not eof(det)) do begin
			readln(t, m.nro, m.cuentaDes, m.mensaje);
			write(det,m);
		end;
		close(t);
		close(det);
		writeln('Archivo detalle creado con exito');	
	end;
	
	procedure crearMaestro(var mae: maestro);
	var
		t:text;
		u:usuario;
	begin
		assign(t,'logmail.txt');
		reset(t);
		assign(mae,'logmail.dat');
		rewrite(mae);
		while(not eof(mae)) do begin
			readln(t, u.nro, u.cantMail, u.nameUser);
			readln(t, u.nombre);
			readln(t, u.apellido);
			write(mae,u);
		end;
		close(t);
		close(mae);
		writeln('Archivo maestro creado con exito');	
	end;	
	
	procedure actualizarMaestro(var mae: maestro; var det: detalle);
	var
		m:mail;
		u:usuario;
	begin
		reset(mae);
		reset(det);
		leer(det,m);
		while(m.nro <> valorAlto) do begin
			read(mae,u);
			while(u.nro <> m.nro) do 
				read(mae,u);
			while(u.nro = m.nro) do begin
				u.cantMail:= u.cantMail + 1;
				leer(det,m);
			end;
			seek(mae,filepos(mae)-1);
			write(mae,u);
		end;
		close(mae);
		close(det);
		writeln('Archivo maestro actualizado con exito');		
	end;
	
	procedure generarTxt(var mae: maestro);
	var
		texto: text;
		u:usuario;
	begin
		reset(mae);
		assign(texto,'txtGenerado.txt');
		rewrite(texto);
		while (not eof(mae)) do begin
			read(mae,u);
			writeln('nro_usuario: ', u.nro, 'CantidadMensajesEnviados: ', u.cantMail);
		end;
		close(texto);
		close(mae);
		writeln('Archivo txt generado con exito');
	end;	
var
	mae: maestro;
	det: detalle;
begin
	crearDetalle(det);
	crearMaestro(mae);
	actualizarMaestro(mae,det);
	generarTxt(mae);
end.

{El inciso B lo que se tendria que hacer en el procedimiento donde
actualizo el maestro es, crear una variable auxiliar text, asignarle
un nombre y crear ese archivo .txt con un rewrite, lo siguiente
seria, cada vez que actualizo un numero de usuario y lo guardo en el
maestro, ahi deberiamso escribirlo (write) en el archivo .txt.
entonces cuando finaliza el procedimiento te queda el maestro 
actualizo y el .txt generado.}
