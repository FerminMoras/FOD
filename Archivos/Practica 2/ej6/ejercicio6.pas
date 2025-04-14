program ejercicio6
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
		nombreCepa: integer;
		nombreLoc: integer;
	end;
	
	detalle = file of regDetalle;
	maestro = file of regMaestro;
	vecRegistros = array [rango] of regDetalle;
	vecDetalles = array [rango] of detalle;
	
	procedure leer(var det: detalle; var regd: regDetalle);
	begin
		if(not(eof(det))) then
			read(det,reg)
		else
			reg.codigoLoc:= codAlto;
	end;
	
	procedure minimo(var vD: vecDetalles; var vR: vecRegistros; var min:regDetalle);
	var
		i: rango;
		pos: integer;
	begin
		for i:= 1 to dF do begin
			if(vR[i].codigoLoc <= min.codigoLoc) and (vR[i].codigoCepa <= min.codigoCepa) then begin
				min:= v[i];
				pos:= i;
			end;
		if(codAlto <> min.codLocalidad) then
			leer(vD[pos],vR[pos]);
		end;	
	end;	
	
	//procedure crear maestro, crear detalle y crear un solo archivo detalle no los hago porque son todos iguales.
	
	procedure actualizarMaestro(var mae: maestro; var vD: vecDetalles);
	var
		vR: vecRegistros;
		i: rango;
		min: regDetalle;
		codCAct,codLAct,cantF,cantN,cantR,cantA: integer;
	begin
		reset(mae);
		for i:= 1 to dF do begin
			reset(vD[i]);
			leer(vD[i],vR[i]);
		end;
		minimo(vD,vR,min);
		while(min.codigooLoc <> codAlto) do begin
			codLAct:= min.codigoLoc;
			codCAct:= min.codigoCepa;
			cantF:= 0;
			cantA:= 0;
			cantR:= 0;
			cantN:= 0;
			while(min.codigoLoc = codLActual) and (min.codigoCepa = codCAct) do begin
				cantF:= cantF + min.cantidadFalle;
				cantA:= cantA + min.cantidadAct;
				cantR:= cantR + min.cantidadRec;
				cantN:= cantN + min.cantidadNue;
				minimo(vD,vR,min);
			end;
			read(mae,regm);
			while(mae.codigoLoc)	
var

begin

end.
