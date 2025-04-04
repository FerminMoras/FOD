program ejercicio1;
type
	ingresos = record
		cod: integer;
		nombre: String;
		monto: real;
	end;
	
	arMaestro = file of ingresos;
	arDetalle = file of ingresos;	
var
	mae: arMaestro;
	det: arDetalle;
	regC: comision;
begin
	assign(det, 'empleadosDetalles.txt');
end.
