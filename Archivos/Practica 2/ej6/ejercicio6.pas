program ejercicio6;
const
	codAlto = 9999;
	dF = 3; 
type
	rango = 1..dF;
	
	regDetalle = record
		codigoLoc: integer;
		codigoCepa: integer;
		cantidadAct: integer;
		cantidadNue: integer;
		cantidadRecu: integer;
		cantidadFalle: integer;
	end;
	
	regMaestro = record
		codigoLoc: integer;
		codigoCepa: integer;
		cantidadAct: integer;
		cantidadNue: integer;
		cantidadRecu: integer;
		cantidadFalle: integer;
		nombreCepa: string;
		nombreLoc: string;
	end;
	
	detalle = file of regDetalle;
	maestro = file of regMaestro;
	vecRegistros = array [rango] of regDetalle;
	vecDetalles = array [rango] of detalle;
	
	procedure leer(var det: detalle; var regd: regDetalle);
	begin
		if(not(eof(det))) then
			read(det,regd)
		else
			regd.codigoLoc:= codAlto;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min:regDetalle);
	var
		i: rango;
		pos: rango;
	begin
		min.codigoloc:= codAlto;
		for i:= 1 to dF do begin
			if(vR[i].codigoLoc <= min.codigoLoc) and (vR[i].codigoCepa <= min.codigoCepa) then begin
				min:= vR[i];
				pos:= i;
			end;
		if(codAlto <> min.codigoLoc) then
			leer(vD[pos],vR[pos]);
		end;	
		writeln('minimo: ', min.codigoLoc);
	end;	
	
	procedure unDetalle(var det: detalle);
	var
		regd: regDetalle;
		t: text;
		nombre: string;
	begin
		writeln('leer detalle');
		readln(nombre);
		assign(t,nombre);
		
		writeln('crear detalle');
		readln(nombre);
		assign(det,nombre);
		
		reset(t);
		rewrite(det);
		while(not eof(t)) do begin
			with regd do begin
				readln(t,codigoLoc,codigoCepa,cantidadAct,cantidadNue,cantidadRecu,cantidadFalle);
				write(det,regd);
			end;
		end;
		close(t);
		close(det);
	end;			
			
	procedure crearDetalles(var v: vecDetalles);
	var 
		i:rango;
	begin
		for i:= 1 to dF do
			unDetalle(v[i]);
	end;
	
	procedure crearMaestro(var mae: maestro);
	var
		regm:regMaestro;
		t:text;
		nombre:string;
	begin
		writeln('leer maestro');
		readln(nombre);
		assign(t,nombre);
		
		writeln('crear maestro');
		readln(nombre);
		assign(mae,nombre);
		
		reset(t);
		rewrite(mae);
		while(not eof(t)) do begin
			with regm do begin
				readln(t,codigoLoc,codigoCepa,cantidadAct,cantidadNue,cantidadRecu,cantidadFalle,nombreLoc);
				readln(t,nombreCepa);
				write(mae,regm);
			end;
		end;
		close(t);
		close(mae);
	end;	
	
	procedure actualizarMaestro(var mae: maestro; var vD: vecDetalles);
	var
		vR: vecRegistros;
		regm: regMaestro;
		i: rango;
		min: regDetalle;
		codCAct,codLAct,cantF,cantN,cantR,cantA,cantLocalidad: integer;
	begin
		assign(vD[1],'detalle1.dat');
		writeln('asigno 1');
		assign(vD[2],'detalle2.dat');
		writeln('asigno 2');
		assign(vD[3],'detalle3.dat');
		writeln('asigno 3');
		assign(mae,'maestro.dat');
		writeln('asigno 4');
		reset(mae);
		writeln('reseteo maestro');
		for i:= 1 to dF do begin
			reset(vD[i]);
			writeln('reseteo un detalle');
			leer(vD[i],vR[i]);
		end;
		minimo(vD,vR,min);
		writeln('salgo del minimo');
		writeln('minimo: ', min.codigoLoc);
		while(min.codigoLoc <> codAlto) do begin
			writeln('entra primer while');
			cantLocalidad:= 0;
			codLAct:= min.codigoLoc;
			codCAct:= min.codigoCepa;
			cantF:= 0;
			cantA:= 0;
			cantR:= 0;
			cantN:= 0;
			while(min.codigoLoc = codLAct) and (min.codigoCepa = codCAct) do begin
				writeln('entra 2do while');
				cantF:= cantF + min.cantidadFalle;
				cantA:= cantA + min.cantidadAct;
				cantR:= cantR + min.cantidadRecu;
				cantN:= cantN + min.cantidadNue;
				minimo(vD,vR,min);
			end;
			read(mae,regm);
			while(regm.codigoLoc <> codLAct) and (regm.codigoLoc <> codCAct) do begin //preguntar si tengo que buscar en el registro maestro preguntando por los dos ordenes.
				read(mae,regm);
			end;
			writeln('encuentra codigo igual');
			regm.cantidadAct:= cantA;
			regm.cantidadFalle:= regm.cantidadFalle + cantF;
			regm.cantidadRecu:= regm.cantidadRecu + cantR;
			regm.cantidadNue:= cantN;
			if(regm.cantidadAct > 50) then
				cantLocalidad:= cantLocalidad + 1;
			seek(mae,filepos(mae)-1);
			writeln('posiciona puntero maestro');
			write(mae,regm);
			writeln('actualiza maestro');
		end;
		close(mae);
		for i:= 1 to dF do
			close(vD[i]);
		writeln('la cantidad de localidades con mas de 50 casos activos es: ', cantLocalidad);	
	end;
	
	procedure imprimir(var mae: maestro);
	var
		regm: regMaestro;
	begin
		reset(mae);
		while(not eof(mae)) do begin
			read(mae,regm);
			with regm do begin
				writeln(codigoLoc,codigoCepa,cantidadAct,cantidadRecu,cantidadFalle,cantidadNue,nombreLoc);
				writeln(nombreCepa);
			end;
		end;
		close(mae);		
	end;
		
var
	mae: maestro;
	vecD: vecDetalles;
begin
	//crearDetalles(vecD);
	//crearMaestro(mae);
	actualizarMaestro(mae,vecD);
	imprimir(mae);
end.
