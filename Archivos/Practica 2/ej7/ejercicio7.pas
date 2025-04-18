program ejercicio7;
const
	codAlto = 9999;
type
	regMaestro = record
		codAlu: integer;
		nombre: string;
		apellido: string;
		cantC: integer;
		cantF: integer;
	end;
	
	regCursadas = record
		codAlu: integer;
		codMat: integer;
		anio: integer;
		resultado: string;
	end;
	
	regFinales = record
		codAlu: integer;
		codMat: integer;
		fecha: string;
		nota: integer;
	end;
	
	detalleC = file of regCursadas;
	detalleF = file of regFinales;
	maestro = file of regMaestro;
	
	procedure leerCursada(var det:detalleC; regd: regCursadas);
	begin
		if(not(eof(det))) then
			read(det,regd)
		else
			regd.codAlu:= codAlto;
	end;
	
	procedure leerFinales(var det:detalleF; regd: regFinales);
	begin
		if(not(eof(det))) then
			read(det,regd)
		else
			regd.codAlu:= codAlto;
	end;
	
	procedure actualizarMaestro(var mae: maestro; var detC: detalleC; var detF: detalleF);
	var
		regm: regMaestro;
		regC: regCursadas;
		regF: regCursadas;
		aluActual: integer;
		totalF: integer;
		totalC: integer;
	begin
		//suponemos que estan los archivos binarios creados y asignados..
		reset(mae);
		reset(detF);
		reset(detC);
		leerCursada(detC,regD);
		leerCursada(detF,regF);
		read(mae,regm);
		while(not eof(mae)) do begin
			aluActual:= regm.codAlu;
			totalC:= 0;
			totalF:= 0;
			while (aluActual = regC.codAlu) do begin //procesamos cursadas
				if (regC.resultado = 'aprobado') then
					totalC:= totalC + 1;
				leerCursada(detC,regC);
			end;
			while(aluActual = regF.codAlu) do begin //procesamos finales
				if(regF.nota >= 4) then
					totalF:= totalF + 1;
				leerFinales(detF,regF);
			end;
			regm:= regm.cantC + cantC;		
			regm:= regm.cantF + cantF;
			seek(mae,filepos(regm)-1);
			write(mae,regm);
		end;
		close(mae);
		close(detF);
		close(detC);
	end;	
var
	detC: detalleC;
	detF: detalleF;
	mae: maestro;
begin
	//crearDetalles(detF,detC);
	//crearMaestro(mae);
	actualizarMaestro(mae,detC,detF);
end.
