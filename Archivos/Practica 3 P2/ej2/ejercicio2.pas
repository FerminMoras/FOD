program ejercicio2;
type
	votos = record
		codigo: integer;
		numero: integer;
		cantV: integer;
	end;
	
	archivo = file of votos;
	
	procedure crearArchivo(var arc: archivo);
	var
		t: text;
		v: votos;
	begin
		assign(t,'archivo.txt');
		reset(t);
		assign(arc,'archivo.dat');
		rewrite(arc);
		while(not eof(t)) do begin
			readln(t, v.codigo, v.numero, v.cantV);
			write(arc,v);
		end;
		close(arc);
		close(t);
		writeln('archivo creado con exito');	
	end;
	
	procedure recorrerArchivo(var arc,arcAux: archivo; var cantTotal: integer);
	var
		v,aux:votos;
		ok: boolean;
	begin
		reset(arc);
		assign(arcAux,'archivoAux.dat');
		rewrite(arcAux);
		cantTotal:= 0;
		while(not eof(arc)) do begin
			read(arc,v);
			ok:= false;
			seek(arcAux,0);
			while(not eof(arcAux)) and (not ok) do begin
				read(arcAux,aux);
				if(aux.codigo = v.codigo) then
					ok:= true;
			end;
			
			if (ok) then begin
				aux.cantV:= aux.cantV + v.cantV;
				seek(arcAux, filepos(arcAux)-1);
				write(arcAux,aux);
			end
			else
				write(arcAux,v);
			cantTotal:= cantTotal + 1;
		end;
		close(arc);
		close(arcAux);		
	end;
	
	procedure imprimirArc(var arc: archivo; cantTotal: integer);
	var
		v:votos;
	begin
		reset(arc);
		writeln('Codigo localidad                       Total votos');
		while (not eof(arc)) do begin
			read(arc,v);
			writeln(v.codigo,'                           ', v.cantV);
		end;
		writeln('Total general de votos: ', cantTotal);
	end;		
var
	arc,aux: archivo;
	cant: integer;
begin
	crearArchivo(arc);
	recorrerArchivo(arc,aux,cant);
	imprimirArc(aux,cant);
end.
