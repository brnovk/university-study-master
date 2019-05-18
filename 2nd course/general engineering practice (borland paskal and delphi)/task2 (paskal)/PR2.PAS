program PR2;
uses crt, graph;
var x0,x1,y0,y1,buf,buf2,er,r,i: integer;
    f:boolean;
    t:text;
begin
  clrscr;
  writeln('Program calculates whether the point lies on, inside or outside the circle');
  writeln('Select the method of reading the source data:');
  writeln('0 - reading from a file INPUT.TXT;');
  writeln('1 - manual data input;');
  writeln('2 - exit;');
  repeat
    {$i-}
    read(buf);
    {$i+}
    f:=(ioresult <> 0);
    if f=true then
      writeln('Error! The entered character can not be used...');
    if ((f=false) and (buf<0)) or ((f=false) and (buf>2)) then
      begin
        writeln('Character you entered is not appropriate!!!');
		writeln('Enter symbol <<0>>, <<1>> or <<2>>');
        f:=true;
      end;
  until not f;

  if buf=1 then
    begin
      repeat
        write('Enter the radius of the circle: ');
        {$i-}
        readln(r);
        {$i+}
        f:=(ioresult <> 0);
        if f=true then
          writeln('Error! The entered character can not be used...');
        if ((f=false) and (r<1)) or ((f=false) and (r>240)) then
          begin
            writeln('You entered is not appropriate number!!!');
            writeln('Acceptable in this problem range from 1 to 240.');
            f:=true;
          end;
      until not f;

      repeat
        write('Enter the circle center coordinate of X: ');
        {$i-}
        readln(x0);
        {$i+}
        f:=(ioresult <> 0);
        if f=true then
          writeln('Error! The entered character can not be used...');
        if ((f=false) and (x0<(-320+r))) or ((f=false) and (x0>(320-r))) then
          begin
            writeln('You entered is not appropriate number!!!');
            writeln('Valid input range radius: from ',-320+r,' to ',320-r,'.');
            f:=true;
          end;
      until not f;

      repeat
        write('Enter the y-coordinate of the center of the circle Y: ');
        {$i-}
        readln(y0);
        {$i+}
        f:=(ioresult <> 0);
        if f=true then
          writeln('Error! The entered character cannot be used...');
        if ((f=false) and (y0<(-240+r))) or ((f=false) and (y0>(240-r))) then
          begin
            writeln('The number you entered is not suitable!!!');
            writeln('Valid input range radius: from ',-240+r,' to ',240-r,'.');
            f:=true;
          end;
      until not f;

      repeat
        write('Enter a coordinate point X: ');
        {$i-}
        readln(x1);
        {$i+}
        f:=(ioresult <> 0);
        if f=true then
          writeln('Error! The entered character cannot be used...');
        if ((f=false) and (x1<-320)) or ((f=false) and (x1>320)) then
          begin
            writeln('The number you entered is not suitable!!!');
            writeln('The valid range for this task: from -320 to 320.');
            f:=true;
          end;
      until not f;

      repeat
        write('Enter the coordinate of a point Y: ');
        {$i-}
        readln(y1);
        {$i+}
        f:=(ioresult <> 0);
        if f=true then
          writeln('Error! The entered character cannot be used...');
        if ((f=false) and (y1<-240)) or ((f=false) and (y1>240)) then
          begin
            writeln('The number you entered is not suitable!!!');
            writeln('The valid range for this task: from -240 to 240.');
            f:=true;
          end;
      until not f;

    end;

  if buf=0 then
    begin
      assign(t,'INPUT.TXT');
      {$i-}
      reset(t);
      {$i+}
      if ioresult <> 0 then
      begin
        rewrite(t);
        writeln(t,'50');
        writeln(t,'0');
        writeln(t,'0');
        writeln(t,'30');
        writeln(t,'30');
        close(t);
        writeln('When reading or opening a file error occurred!');
        writeln('Create a new INPUT.TXT with the default settings:');
        writeln(' - Radius of the circle: 50;');
        writeln(' - Coordinate of the center of the circle on X: 0;');
        writeln(' - Coordinate of the center of the circle on Y: 0;');
        writeln(' - Coordinate of a point on the X: 30;');
        writeln(' - Coordinate of a point on the Y: 30;');
        reset(t);
        readln(t,r);
        readln(t,x0);
        readln(t,y0);
        readln(t,x1);
        readln(t,y1);
        close(t);
      end else
        begin
          readln(t,r);
          readln(t,x0);
          readln(t,y0);
          readln(t,x1);
          readln(t,y1);
          close(t);
          if (r<1) or (r>240) then
            begin
              writeln('Incorrect data in the file INPUT.TXT;');
              writeln('The file will be deleted and the program completed;');
              writeln('Run the program again.');
              readln;
              readln;
              erase(t);
              exit;
            end;
          if (x0<-320+r) or (x0>320-r) then
            begin
              writeln('Incorrect data in the file INPUT.TXT;');
              writeln('The file will be deleted and the program completed;');
              writeln('Run the program again.');
              readln;
              readln;
              erase(t);
              exit;
            end;
          if (y0<-240+r) or (y0>240-r) then
            begin
              writeln('Incorrect data in the file INPUT.TXT;');
              writeln('The file will be deleted and the program completed;');
              writeln('Run the program again.');
              readln;
              readln;
              erase(t);
              exit;
            end;
          if (x1<-320) or (x1>320) then
            begin
              writeln('Incorrect data in the file INPUT.TXT;');
              writeln('The file will be deleted and the program completed;');
              writeln('Run the program again.');
              readln;
              readln;
              erase(t);
              exit;
            end;
          if (y1<-240) or (y1>240) then
            begin
              writeln('Incorrect data in the file INPUT.TXT;');
              writeln('The file will be deleted and the program completed;');
              writeln('Run the program again.');
              readln;
              readln;
              erase(t);
              exit;
            end;
        end;
    end;


  if buf=2 then exit;

  writeln;
  writeln('Result:');
  if ((sqr(x1-x0)+sqr(y1-y0))=sqr(r)) then
    writeln('The point lies on the circle') else
      if ((sqr(x1-x0)+sqr(y1-y0))<sqr(r)) then
        writeln('The point lies inside the circle') else
          writeln('Point lies outside the circle');

  writeln;
  writeln('Select further action:');
  writeln('0 - displayed result in graphic form;');
  writeln('1 - exit;');

  repeat
    {$i-}
    read(buf);
    {$i+}
    f:=(ioresult <> 0);
    if f=true then
      writeln('Error! The entered character can not be used...');
    if ((f=false) and (buf<0)) or ((f=false) and (buf>1)) then
      begin
        writeln('The character you entered is not appropriate!!!');
		writeln('Enter symbol <<0>> or <<1>>');
        f:=true;
      end;
  until not f;

  if buf=1 then exit;

  if buf=0 then
    begin
      x0:=x0+320;
      x1:=x1+320;
      y0:=y0+240;
      y1:=y1+240;
      buf:=Detect;
      initgraph(buf,buf2,'');
      er:=graphresult;
      if er<>grok then writeln(grapherrormsg(er)) else
        begin
          circle(x0,y0,r);

          {Draw a horizontal coordinate axis}
	  line(0, getmaxY div 2, getmaxX, getmaxY div 2);
          {Draw a vertical coordinate axis}
          line(getmaxX div 2, 0, getmaxX div 2, getmaxY);

          {Fill in the horizontal axis strokes}
	  er:=round((getmaxX/10)-1);
          buf2:= getmaxY div 2;
          for i:=1 to er do
            begin
              buf:=i*10;
              line(buf, buf2-2, buf, buf2+2);
            end;

	  outtextXY(buf,buf2-12,'X');

          {Fill the vertical axis strokes}
	  er:=round((getmaxY/10)-1);
          buf2:= getmaxX div 2;
          for i:=1 to er do
            begin
              buf:=i*10;
              line(buf2-2, buf, buf2+2, buf);
            end;

          outtextXY(buf2+8,5,'Y');
          outtextXY((getmaxX div 2)+3,(getmaxY div 2)-8,'0');

          putpixel(x1+1,y1,10);
          putpixel(x1,y1+1,10);
          putpixel(x1-1,y1,10);
          putpixel(x1,y1-1,10);
          putpixel(x1,y1,10);


          readkey;
          closegraph;
        end;
       readln;
    end;
  readln;
end.
