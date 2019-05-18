program lab2;  {Construct a vector arithmetic mean of }
uses crt;      {positive elements of the rows}
var a:array[1..50,1..50] of longint;
    b:array[1..50] of real;
    i,j,n,k:longint;
    sr:real;
begin
  clrscr;
  textcolor(green);
  write('Enter number of rows and cols of a square matrix: ');
  readln(n);
  writeln('Enter the elements of the matrix: ');
for i:=1 to n do
for j:=1 to n do
  begin
  write('a[',i,',',j,']:');
  readln(a[i,j]);
  end;
writeln('Source matrix: ');
for i:=1 to n do
  begin
    for j:=1 to n do
      write(a[i,j]:3,' ');
      writeln;
  end;
writeln;
for i:=1 to n do
 begin
  k:=0;
  sr:=0;
  for j:=1 to n do
     begin
       if a[i,j]<=0 then continue
       else
         begin
       sr:=sr+a[i,j];
       k:=k+1;
         end;
       sr:=sr/k;
     end;
  b[i]:=sr;
  end;
write('Resulting vector: ');
for i:=1 to n do
write(' ',b[i]:1:1,' ');
readln;
end.
