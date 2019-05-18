program kontr12;(*Find the biggest of even and odd numbers of vectors*)
uses crt;
var a:array[1..50] of longint;
    max,i,n,q:longint;
begin
  clrscr;
  textcolor(green);
  write('Enter the dimension of the vector:' );
  readln(n);
  writeln('Enter the value of the elements of the vector: ');
  for i:=1 to n do
    begin
      write('a[',i,']=');
      readln(a[i]);
    end;
  writeln('Source vector: ');
  for i:=1 to n do
    write(a[i]:5);
  max:=a[1];
  for i:=1 to n do
    if a[i]>max then
    if a[i] mod 2 =0 then
       max:=a[i];
  q:=0;
  for i:=1 to n do
    if a[i] mod 2<>0 then
       q:=q+1;
  writeln;
  writeln('The biggest of the even numbers: ',max);
  writeln('Odd numbers in the vector: ',q);
  readln;
end.