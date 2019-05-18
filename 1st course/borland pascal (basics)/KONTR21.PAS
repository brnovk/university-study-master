program kontr21;                       {If max elements of cols exceeds the   }
uses crt;                              {amount min elements of rows, elements,}
var a:array[1..100,1..100] of integer; {standing on the secondary diagonal    }
    b:array[1..100] of integer;        {elements add appropriate max columns. }
    i,j,n,min,min_i,max_j:integer;     {Otherwise the matrix remain unchanged.}
begin
  clrscr;
  textcolor(green);
  write('Enter the dimension of the square matrix rows and columns: ');
  readln(n);
  writeln('Enter the values of the elements of the matrix:');
  for i:=1 to n do
  for j:=1 to n do
    begin
      write('a[',i,',',j,']: ');
      readln(a[i,j]);
    end;
  writeln;
  writeln('Source matrix:');
  writeln;
  for i:=1 to n do
    begin
      for j:=1 to n do
        write(a[i,j]:3,' ');
        writeln;
    end;
  writeln;
  min_i:=0;
  for i:=1 to n do
    begin
      min:=a[i,1];
      for j:=1 to n do
        if a[i,j]<min then min:=a[i,j];
      min_i:=min_i+min;
    end;
  for j:=1 to n do
    begin
      max_j:=a[1,j];
      for i:=1 to n do
        if a[i,j]>max_j then max_j:=a[i,j];
      b[j]:=max_j;
    end;
  if max_j>min_i then
    begin
      for i:=1 to n do
        for j:=1 to n do
          if j=n-i+1 then a[i,j]:=a[i,j]+b[j];
    end;
  writeln('Resulting matrix:');
  writeln;
  for i:=1 to n do
    begin
      for j:=1 to n do
        write(a[i,j]:5,' ');
        writeln;
    end;
  readln;
end.
