program kontr31;  (*Finding words ending with same letter as the first word.*)
uses crt;
const
  z:string='|\/ ,.#:;?!"-{}()_&<>';
var
  f,g:boolean;
  b:char;
  s,buf:string;
  i,j,w,ns,ds,d,bufr:integer;
begin
  clrscr;
  textcolor(green);
  write('Enter the text: ');
  readln(s);
  d:=length(s);
  ns:=1;
  buf:='.';
  s:=s+buf;
  f:=true;
  g:=true;
  for i:=1 to d+1 do
    for j:=1 to 21 do
    if s[i]=z[j] then
      begin
        ds:=i-ns;
        ns:=i+1;
          if ds<>0 then
            if f=true then
              begin
                w:=i-1;
                b:=s[w];
                f:=false;
                writeln('First word in the text ends with letter: (',b,')');
              end;
            if f=false then
              begin
                bufr:=ns-(ds+1);
                buf:=copy(s,bufr,ds);
                w:=length(buf);
                if buf[w]=b then
                  if g=true then
                    begin
                      writeln('This text on the (', b,') end with words:');
                      g:=false;
                      writeln(buf);
                    end
                    else
                    writeln(buf);
              end;
      end;
  readln;
  end.
