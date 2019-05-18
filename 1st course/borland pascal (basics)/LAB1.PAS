program lab1; {If the minimum vector element stands on an even place,}
uses crt;     {multiply odd elements 2, otherwise - without change}
var a:array[1..50] of longint;
    i_min,min,i,n,q:longint;
begin
  clrscr;
  textcolor(green);
  write('Enter the vector length:' );
  readln(n);
  writeln('Enter the value of the vector elements: ');
  for i:=1 to n do
    begin
      write('a[',i,']=');
      readln(a[i]);
    end;
  writeln('Source vector: ');
  for i:=1 to n do
    write(a[i]:5);
  writeln;
  min:=a[1];
  i_min:=1;
  for i:=1 to n do
    if a[i]<min then
      begin
        min:=a[i];
        i_min:=i;
      end;
  if i_min mod 2 = 0 then
    begin
    for i:=1 to n do
      if i mod 2 <> 0 then
         a[i]:=a[i]*2
    end;
  writeln('Result vector: ');
  for i:=1 to n do
    write(a[i]:5);
  readln;
end.
