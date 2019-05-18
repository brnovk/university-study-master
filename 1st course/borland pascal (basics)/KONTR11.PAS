program kontr11;{Calculation of number of maximum number}
uses crt;
var a:array[1..50] of longint;
    i_max,max,i,n,q:longint;
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
  max:=a[1];
  for i:=1 to n do
    if a[i]>max then
        max:=a[i];
  q:=0;
  for i:=1 to n do
    if a[i]=max then
    q:=q+1;
  writeln('Maximum value for the number of vector: ',max);
  writeln('Meets in the vector ',q,' time(s)');
  readln;
end.
