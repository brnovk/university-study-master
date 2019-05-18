program kontr13;(*Sort by linear selection with counting*)
uses crt;
var a,b,c:array [1..100]of integer;
    n,i,j:integer;
Begin
clrscr;
textcolor(green);
write('Enter the size of the vector: ');
readln(n);
writeln('Enter the vector elements: ');
for i:=1 to n do
 begin
  write('a[',i,']= ');
  readln(a[i]);
  b[i]:=1;
 end;
writeln('Source vector: ');
for i:=1 to n do
write(a[i]:3,' ');
writeln;
for i:=1 to n-1 do
  for j:=i+1 to n do
    if a[i]>a[j] then b[i]:=b[i]+1 else
    if a[i]<=a[j] then b[j]:=b[j]+1;
for i:=1 to n do
  for j:=1 to n do
    if i=b[j] then
    c[i]:=a[j];
writeln;
writeln('Sorted vector:');
for i:=1 to n do
write(c[i]:3,' ');
readln;
end.
