program kontr24;    (*Check on the sorted order.   If not sorted,*)
uses crt;           (*sort by the linear selection with counting.*)
var a,b,c:array[1..100,1..100] of integer;
    i,j,n,k,ds,us,buf:integer;
begin
  clrscr;
  textcolor(green);
  write('Enter dimension of the row and any column of the square matrix: ');
  readln(n);
  writeln('Enter the values elements of the matrix: ');
  for i:=1 to n do
  for j:=1 to n do
    begin
      b[i,j]:=1;
      write('a[',i,',',j,']:');
      readln(a[i,j]);
    end;
  us:=0;
  ds:=0;
  buf:=n*(n-1);
  writeln('Source matrix :');
  for i:=1 to n do
    begin
      for j:=1 to n do
        write(a[i,j]:3,' ');
        writeln;
    end;
  for i:=1 to n do
    for j:=1 to n-1 do
      begin
        k:=j+1;
        if a[i,j]<=a[i,k] then us:=us+1;
        if a[i,j]>=a[i,k] then ds:=ds+1;
      end;
  if us=buf then
    begin
      writeln('Matrix is ordered in ascending order.');
      writeln('Sorting is not required.');
      buf:=1;
    end;
  if ds=buf then
    begin
      writeln('Matrix is ordered in descending order.');
      writeln('Sorting is not required.');
      buf:=1;
    end;
  if buf<>1 then
    begin
      for i:=1 to n do
        for j:=1 to n-1 do
          for k:=j+1 to n do
            begin
              if a[i,j]>a[i,k] then b[i,j]:=b[i,j]+1
              else b[i,k]:=b[i,k]+1;
            end;
      writeln;
      for i:=1 to n do
        for j:=1 to n do
          for k:=1 to n do
            if j=b[i,k] then c[i,j]:=a[i,k];
      writeln('Sorted matrix :');
      for i:=1 to n do
        begin
          for j:=1 to n do
            write(c[i,j]:3,' ');
            writeln;
        end;
    end;
readln;
end.
