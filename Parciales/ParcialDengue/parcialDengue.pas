program parcialDengue;
const
	valorAlto = 9999;
	dF = 3;
type
	reg_maestro = record
		codigo: integer;
		nombre: string;
		casos: integer;
	end;
	
	reg_detalle = record
		codigo: integer;
		positivos: integer;
	end;
	
	maestro = file of reg_maestro;
	detalle = file of reg_detalle;
	
	vecDetalles = array [1..dF] of detalle;
	vecRegistros = array [1..dF] of reg_detalle;
	
	procedure leer(var det: detalle; var d: reg_detalle);
	begin
		if (not eof(det)) then
			read(det,d)
		else
			d.codigo:= valorAlto;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min: reg_detalle);
	var
		pos,i: integer;
	begin
		min.codigo:= valorAlto;
		for i:= 1 to dF do begin
			if(vR[i].codigo < min.codigo) then begin
				min:= vR[i];
				pos:= i;
			end;
		end;	
		if(min.codigo <> valorAlto) then
			leer(vD[pos],vR[pos]);
	end;
	
	procedure actualizarMaestro(var mae: maestro; var vD:vecDetalles);
	var
		codActual,cant,i: integer;
		vR: vecRegistros;
		min: reg_detalle;
		regm: reg_maestro;
		nombre: string;
	begin
		assign(mae,'maestro.dat');
		reset(mae);
		for i:= 1 to dF do begin
			writeln('ingrese el nombre del archivo para asignarlo');
			readln(nombre);
			assign(vD[i],nombre);
			reset(vD[i]);
			leer(vD[i],vR[i]);
		end;
		minimo(vD,vR,min);
		while(min.codigo <> valorAlto) do begin
			cant:= 0;
			codActual:= min.codigo;
			while(min.codigo <> valorAlto) and (codActual = min.codigo) do begin
				cant:= cant + min.positivos;
				minimo(vD,vR,min);
			end;
			read(mae,regm);
			while(regm.codigo <> min.codigo) do begin
				if(regm.casos > 15) then
					writeln('El municipio de: ', regm.nombre, ' codigo: ', codActual, ' posee mas de 15 casos positivos');
				read(mae,regm);	
			end;		
			seek(mae,filepos(mae)-1);	
			regm.casos:= regm.casos + cant;
			if(regm.casos > 15) then
					writeln('El municipio de: ', regm.nombre, ' codigo: ', codActual, ' posee mas de 15 casos positivos');
			write(mae,regm);
		end;
		close(mae);
		for i:= 1 to dF do
			close(vD[i]);
		writeln('Archivo maestro actualizado con exito');	
	end;
var
	mae: maestro;
	v: vecDetalles;
begin
	actualizarMaestro(mae,v);
end.	
