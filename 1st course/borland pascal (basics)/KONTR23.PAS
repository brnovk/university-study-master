program kontr23;   {Find the first number of the columns that}
uses crt;          {do not contain elements of smaller 's'.  }
var a:array[1..100,1..100] of integer;
       i,j,n,s,q:integer;
begin
clrscr;
textcolor(green);
write('Enter the number (S): ');
readln(s);
write('Enter the dimension of the row and any column of the square matrix: ');
readln(n);
writeln('Enter the values elements of the matrix: ');
for i:=1 to n do
for j:=1 to n do
  begin
     write('a[',i,',',j,']: ');
     readln(a[i,j]);
  end;
writeln;
writeln('Source matrix:');
for i:=1 to n do
  begin
    for j:=1 to n do
      write(a[i,j]:3,' ');
      writeln;
  end;
writeln;
for j:=1 to n do
  begin
    q:=0;
    begin
      for i:=1 to n do
        if a[i,j]>=s then
        q:=q+1;
        if q=n then
        write(' ',j,' col is first col of a matrix contains no elements less (',s,')');
    end;
    if q=n then break;
  end;
if q<>n then
write('In this matrix, there are elements in all columns, smaller numbers (',s,')');
readln;
end.
