program ejercicio14;
const
	valorAlto = 'ZZZ';
type
	vuelo = record
		destino: string;
		fecha: string;
		horaSalida: string;
		cantAsientos: integer;
	end;
	
	infoVuelo = record
		destino: string;
		fecha: string;
		horaSalida: string;
		cantComprados: integer;
	end;
	
	maestro = file of vuelo;
	detalle = file of infoVuelo;
	
	procedure leer(var det: detalle; var i: infoVuelo);
	begin
		if(not eof(det)) then
			read(det,i)
		else
			i.destino:= valorAlto;
	end;
	
	procedure minimo(var det1,det2: detalle; var rd1,rd2,min: infoVuelo);
	begin
		if(rd1.destino < rd2.destino) then begin
			min:= rd1;
			leer(det1,rd1);
		end
		else begin
			min:= rd2;
			leer(det2,rd2);
		end;	
	end;
	
	procedure crearDetalle(var det: detalle);
	var
		t: text;
		i: infoVuelo;
	begin
		assign(t,'detalle.txt');
		reset(t);
		assign(det,'detalle.dat');
		rewrite(det);
		while (not eof(t)) do begin
			readln(t, i.cantComprados, i.horaSalida);
			readln(t, i.fecha);
			readln(t, i.destino);
			write(det,i);
		end;
		close(t);
		close(det);
		writeln('archivo detalle creado con exito');		
	end;
	
	procedure crearMaestro(var mae: maestro);
	var
		t: text;
		v: vuelo;
	begin
		assign(t,'maestro.txt');
		reset(t);
		assign(mae,'maestro.dat');
		rewrite(mae);
		while (not eof(t)) do begin
			readln(t, v.cantAsientos, v.horaSalida);
			readln(t, v.fecha);
			readln(t, v.destino);
			write(mae,v);
		end;
		close(t);
		close(mae);
		writeln('archivo maestro creado con exito');	
	end;
	
	procedure actualizarMaestro(var mae: maestro; var det1,det2: detalle);
	var
		v: vuelo;
		min,rd1,rd2: infoVuelo;
	begin
		reset(mae);
		reset(det1);
		reset(det2);
		leer(det1,rd1);
		leer(det2,rd2);
		minimo(det1,det2,rd1,rd2,min);
		while(min.destino <> 'ZZZ') do begin
			read(mae,v);
			while(v.destino <> min.destino) do 
				read(mae,v);
			while(v.destino = min.destino) do begin
				while(v.fecha <> min.fecha) do 
					read(mae,v);
				while (v.destino = min.destino) and (v.fecha = min.fecha) do begin
					while(v.horaSalida <> min.horaSalida) do
						read(mae,v);
					while (v.destino = min.destino) and (v.fecha = min.fecha) and (v.horaSalida = min.horaSalida) do begin
						v.cantAsientos:= v.cantAsientos - min.cantComprados;
						minimo(det1,det2,rd1,rd2,min);
					end;
					seek(mae,filepos(mae)-1);
					write(mae,v);
				end;
			end;
		end;
		close(mae);
		close(det1);
		close(det2);
		writeln('Archivo maestro actualizado con exito');				
	end;
	
	procedure generarLista(var mae: maestro);
	var
		cant: integer;
		t: text;
		v: vuelo;
	begin
		assign(t,'listaVuelos.txt');
		rewrite(t);
		reset(mae);
		writeln('ingrese la cantidad de asientos');
		readln(cant);
		while(not eof(mae)) do begin
			read(mae,v);
			if(cant < v.cantAsientos) then
				writeln(t, v.destino, ' ', v.fecha, ' ', v.horaSalida);
		end;
		close(mae);
		close(t);
		writeln('Lista de vuelos generada con exito');			
	end;	 
var
	mae: maestro;
	det1,det2: detalle;
begin
	crearMaestro(mae);
	crearDetalle(det1);
	crearDetalle(det2);
	actualizarMaestro(mae,det1,det2);
	generarLista(mae);
end.
