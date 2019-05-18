program pr1; {Find integers in the range from n to k, }
             {the number of subgroups in whom is      }
					   {the product of two prime numbers.       }
uses crt;
 var a:array[0..1000] of longint;
    b:array[0..500] of integer;
    buf,i,k,n,u,h,ch,d:longint;
    f:boolean;
begin
  clrscr;
  textcolor(green);
  repeat
    {$i-}
    write('Enter the lower limit of the range: ');
    readln(n);
    {$i+}
    f:=(ioresult <> 0);
    if f=true then
      writeln('Error! Entered character can not be used in this problem ...');
    if ((f=false) and (n<1)) or ((f=false) and (n>1000)) then
      begin
        writeln('Entered character is not included in the calculation range!');
		writeln('The range includes all integers from 1 to 1000.');
        f:=true;
      end;
  until not f;
  repeat
    {$i-}
    write('Enter the upper limit of the range: ');
    readln(k);
    {$i+}
    f:=(ioresult <> 0);
    if f=true then
      writeln('Error! The entered character can not be used in this task...');
    if ((f=false) and (k<1)) or ((f=false) and (k>1000)) then
      begin
        writeln('Entered character is not included in the calculation range!');
		writeln('The range includes all integers from 1 to 1000');
        f:=true;
      end;
  until not f;

  if k<n then
    begin
      writeln('Error!!!');
      writeln('Lower limit is greater than the upper range.');
      writeln('Press the "Enter" to complete the program...');
      readln;
      exit;
    end;

  u:=0;

{Calculate the number of dividers
ÿeach of the numbers given range}
{Record the results in a one-dimensional
ÿarray and display of on screen}

  for i:=0 to k-n do
    begin
      a[i]:=0;
      for buf:=1 to n+i do
        if ((n+i) mod buf)=0 then
          begin
            a[i]:=a[i]+1;
            if u<a[i] then
              begin
                u:=a[i];
              end;
          end;
    end;

  writeln('All numbers with the range of the number of divisors: ');
  for i:=0 to k-n do
    writeln('[',n+i,'] = ',a[i],'   ');

  writeln;

{Compute and write to an array <b> all prime numbers,
ÿup to half of the value to maksimatnogo Islands dividers}

  h:=0;
  for i:=2 to round(u/2) do
    begin
      ch:=0;
      for buf:=1 to i do
        if i mod buf=0 then
          ch:=ch+1;
        if ch=2 then
          begin
            b[h]:=i;
            h:=h+1;
          end;
    end;


{Displays all the prime numbers on the screen}
  writeln('All the prime numbers from 2 to ',b[h-1],':');
  for i:=0 to h-1 do
    write(' ',b[i]);

{Result}

  writeln;
  writeln('Result: ');
  ch:=n-1;
  u:=1;
  for i:=0 to k-n do
    begin
      f:=false;
      ch:=ch+1;
      for buf:=0 to h-1 do
        begin
          if f=true then break;
          for d:=0 to h-1 do
            if a[i]/b[buf]=b[d] then
              begin
                f:=true;
                write(' ',ch,' ');
                u:=0;
                break;
              end;
        end;
    end;
  if u=1 then  write('Desired natural numbers not in this range.');
  writeln;
  write('Press the "Enter" to complete the program...');
  readln;
end.
