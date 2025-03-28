program ejercicio2;
type
	archivo = file of integer;
var
	enteros: archivo;
	num: integer;
begin
	assign(enteros, 'enteros.dat');
	reset(enteros);
	while not(EOF(enteros)) do begin
		read(enteros,num);
		if (num < 1500) then
			writeln(num);
	end;
	close(enteros);
end.		
