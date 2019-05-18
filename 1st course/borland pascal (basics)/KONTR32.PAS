program kontr32;   (*Finding the first word with highest number of letter '¨'*)
uses crt;
const
  z:string='|\/ ,.#:;?!"-{}()_&<>';
  b:char='¨';
var
  f:boolean;
  s,buf,max_i:string;
  i,j,w,ns,ds,d,x,k,tmp:integer;
begin
clrscr;
  textcolor(green);
  write('Enter text: ');
  readln(s);
  d:=length(s);
  buf:='.';
  s:=s+buf;
  ns:=1;
  f:=true;
  for i:=1 to d+1 do
    for j:=1 to 21 do
    if s[i]=z[j] then
      begin
        ds:=i-ns;
        ns:=i+1;
          if ds<>0 then
              begin
                x:=ns-(ds+1);
                buf:=copy(s,x,ds);
                w:=length(buf);
                x:=0;
                for k:=1 to w do
                  if buf[k]=b then x:=x+1;
                  if (f=true) and (x<>0) then
                    begin
                      f:=false;
                      max_i:=buf;
                      tmp:=x;
                    end;
                  if (f=false) and (x>tmp)  then
                    begin
                      max_i:=buf;
                      tmp:=x;
                    end;
              end;
      end;
  if f=true then write('There are no words in text of the letter (',b,')') else
  write('The first word with the highest number of letters (',b,') : ',max_i);
  readln;
  end.
