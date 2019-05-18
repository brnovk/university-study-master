program kontr22;    {Determine myltiply of the elements in rows }
uses crt;           {that do not contain multiple elements '3'. }
var a:array[1..100,1..100] of integer;
    i,j,n,pr,t:integer;
begin
  clrscr;
  textcolor(green);
  write('Enter the dimensions of rows and columns of a square matrix: ');
  readln(n);
  writeln('Enter the values elements of the matrix:');
  for i:=1 to n do
  for j:=1 to n do
    begin
    write('a[',i,',',j,']: ');
    readln(a[i,j]);
    end;
  writeln;
  writeln('Source Matrix:');
  writeln;
  for i:=1 to n do
    begin
      for j:=1 to n do
        write(a[i,j]:3,' ');
        writeln;
    end;
  writeln;
  for i:=1 to n do
    begin
    pr:=1;
    t:=0;
      for j:=1 to n do
        begin
        if a[i,j] mod 3<>0 then
          begin
            pr:=pr*a[i,j];
            t:=t+1;
          end;
        end;
    if t=n then
    writeln('Product of the elements ',i,' line: ',pr);
    end;
  readln;
end.
