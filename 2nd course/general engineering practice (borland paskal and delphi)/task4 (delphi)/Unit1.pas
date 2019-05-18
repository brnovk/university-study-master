unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, Spin, ComCtrls, Xpman, Math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox5: TGroupBox;
    SpinEdit3: TSpinEdit;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    GroupBox6: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    StringGrid3: TStringGrid;
    StringGrid4: TStringGrid;
    StringGrid5: TStringGrid;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Bevel1: TBevel;
    Bevel2: TBevel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  mytype1=array[0..99,0..99] of real;
  mytype2=array[0..99] of real;
var
  Form1: TForm1;
  a6: mytype1;
  b6: mytype2;

implementation

//uses Unit1;

{$R *.dfm}


function m_app:boolean;//Filling source arrays of stringrig
var i,j:integer;
begin
  result:=true;
  try
    for i:=0 to Form1.StringGrid1.RowCount-1 do
      for j:=0 to Form1.StringGrid1.ColCount-1 do
        a6[i,j]:=StrToFloat(Form1.StringGrid1.Cells[j,i]);
    for i:=0 to Form1.StringGrid2.ColCount-1 do
        b6[i]:=StrToFloat(Form1.StringGrid2.Cells[i,0]);
  except
    MessageBox (0, 'Invalid source data!','Attention!', MB_ICONEXCLAMATION);
    result:=false;
    exit;
  end;
end;

function ctrl_deter: boolean;
begin //Check dimension rows\columns of the matrix
  result:=true;
  if Form1.StringGrid1.ColCount<>
    Form1.StringGrid1.RowCount then
      result:=false;
end;

procedure ext_1;//Solution System of linear equations matrix method
const
  eps=0.00001;
type  mas=array[1..100] of Double;
     matr=array[1..100] of mas;
var
  i,j,imx,np,n: integer;
  b,x: mas;
  a,c: matr;
  dt: real;
  ty: boolean;

procedure AddStrings (var a,b:matr; i1,i2:integer; r:real);
var j:integer;
begin
  for j:=1 to n do
    begin
      a [i1,j]:=a [i1,j] +r*a [i2,j] ;
      b [i1,j]:=b [i1,j] +r*b [i2,j] ;
    end;
end;

procedure MultMatr(a,b:matr; var c:matr);
var i,j,k: byte;
s: real;
begin
  for i:=1 to n do
  for j:=1 to n do
  begin
    s:=0;
    for k:=1 to n do
      s:=s+a[i,k]*b[k,j] ;
    c[i,j]:=s;
  end;
end;

procedure MultString (var a,b:matr; i1:integer; r:real);
var j:integer;
begin
  for j:=1 to n do
  begin
    a[i1,j]:=a[i1,j]*r;
    b[i1,j]:=b[i1,j]*r;
  end;
end;

procedure matrica (a:matr; y:mas; n:integer);
var z,a0: matr;
imx,np,i,j: integer;
s: mas;
begin
  for i:=1 to n do
    begin
      for j:=1 to n do z [i,j]:=0;
      z[i, i]:=1;
    end;
  for i:=1 to n do
    for j:=1 to n do
      a0[i,j]:=a[i,j] ;
    for i:=1 to n do
      begin
        for j:=i+1 to n do
          AddStrings (a,z, i,j,sign (a [i, i])*sign (a [j, i]));
        if (abs (a [i,i])>eps) then
          begin
            MultString(a,z,i,1/a[i,i]);
            for j:=i+1 to n do
            AddStrings (a,z,j, i,-a [j, i]);
          end else
            begin
              ty:=true;
              exit;
            end;
      end;
  if ty=true then
    begin
      exit;
      Form1.StaticText1.Caption:='The system can not be solved by this method';
      Form1.StringGrid3.ColCount:=0;
    end;
  if (a [n,n] >eps) then
    begin
      for i:=n downto 1 do
        for j:=1 to i-1 do
          begin
            AddStrings (a,z,j, i,-a [j, i]);
          end;
    end else
      begin
        ty:=true;
        exit;
      end;
  if ty=true then
    begin
      exit;
      Form1.StaticText1.Caption:='The system can not be solved by this method';
      Form1.StringGrid3.ColCount:=0;
    end;
  MultMatr(a0,z,a);
  for i:=1 to n do s [i]:=0;
    for i:=1 to n do
      for j:=1 to n do
        s[i]:=s[i]+z[i,j]*y[j] ;
  for i:=0 to n-1 do
    Form1.StringGrid3.Cells[i,0]:=floattostr(s[i+1]);
end;

begin
  for i:=0 to Form1.StringGrid3.ColCount do
    Form1.StringGrid3.Cols[i].Clear;
  if ctrl_deter=false then
    begin
      Form1.StringGrid3.ColCount:=0;
      Form1.StaticText1.Caption:='The columns are not equal rows';
    end else
      begin
        ty:=false;
        Form1.StaticText1.Caption:='';
        Form1.StringGrid3.ColCount:=Form1.StringGrid2.ColCount;
        n:=Form1.StringGrid1.ColCount;
        for j:=0 to n-1 do
          for i:=0 to n-1 do
            a[i+1,j+1]:=
              StrToFloatDef(Form1.StringGrid1.Cells[j,i],0);
        for i:=0 to n-1 do
          b[i+1]:=StrToFloatDef(Form1.StringGrid2.Cells[i,0],0);
        matrica(a,b,n);
        if ty=true then exit;
      end;
end;

procedure ext_2;//solution System of linear equations Gauss method
type
  Vector = array[1..100] of Double;
  Matrix = array[1..100] of Vector;
var a1: Matrix;
    b1,x: Vector;
    h: Double;
    i,j,k,n:integer;
begin
  for i:=0 to Form1.StringGrid4.ColCount do
    Form1.StringGrid4.Cols[i].Clear;
  if ctrl_deter=false then
    begin
      Form1.StringGrid4.ColCount:=0;
      Form1.StaticText2.Caption:='The columns are not equal rows';
    end else
      begin
        Form1.StaticText2.Caption:='';
        Form1.StringGrid4.ColCount:=Form1.StringGrid2.ColCount;
        n:=Form1.StringGrid1.ColCount;
        for j:=0 to n-1 do
          for i:=0 to n-1 do
            a1[i+1,j+1]:=
              StrToFloatDef(Form1.StringGrid1.Cells[j,i],0);
        for i:=0 to n-1 do
          b1[i+1]:=StrToFloatDef(Form1.StringGrid2.Cells[i,0],0);
        for i:=1 to n-1 do
          for j:=i+1 to n do
            begin
              a1[j,i]:=-a1[j,i]/a1[i,i];
              for k:=i+1 to n do
                a1[j,k]:=a1[j,k]+a1[j,i]*a1[i,k];
              b1[j]:=b1[j]+a1[j,i]*b1[i]
            end;
        x[n]:=b1[n]/a1[n,n];
        for i:=n-1 downto 1 do
          begin
            h:=b1[i];
            for j:=i+1 to n do
              h:=h-x[j]*a1[i,j];
            x[i]:=h/a1[i,i]
          end;
        for i:=0 to n-1 do
          Form1.StringGrid4.Cells[i,0]:=floattostr(x[i+1]);
      end;
end;

procedure ext_3;//Checking solutions
var i,j:integer;
begin
  if Form1.StaticText2.Caption='' then
    begin
      Form1.StringGrid5.ColCount:=
        Form1.StringGrid2.ColCount;
      for j:=0 to Form1.StringGrid4.ColCount-1 do
        begin
          Form1.StringGrid5.Cells[j,0]:='0';
          for i:=0 to Form1.StringGrid1.ColCount-1 do
            Form1.StringGrid5.Cells[j,0]:=
              floattostr(strtofloat(Form1.StringGrid5.Cells[j,0])+
                (strtofloat(Form1.StringGrid1.Cells[i,j])*
                  strtofloat(Form1.StringGrid4.Cells[i,0]))) ;
        end;
    end else
      begin
        for i:=0 to Form1.StringGrid5.ColCount do
          Form1.StringGrid5.Cols[i].Clear;
        Form1.StringGrid5.ColCount:=0;
        exit;
      end;
end;

procedure ctrl_long;
begin //Changing the dimension table and the vector of SpinEdit
  Form1.StringGrid1.ColCount:=Form1.SpinEdit1.Value;
  Form1.StringGrid1.RowCount:=Form1.SpinEdit2.Value;
  Form1.StringGrid2.ColCount:=Form1.SpinEdit2.Value;
  Form1.SpinEdit3.Value:=Form1.SpinEdit2.Value;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin //Clicking on the "Calculate" button
  if m_app=false then
    begin
      MessageBox (0, 'Error data entry!','Attention!', MB_ICONEXCLAMATION);
      exit;
    end;
  ext_1;
  ext_2;
  ext_3;
end;

procedure TForm1.Button2Click(Sender: TObject);
  //Clicking on the button "Random filling"
 var i,j: integer;
begin
  Form1.SpinEdit1.Value:=RandomRange(1,10);
  Form1.SpinEdit2.Value:=RandomRange(1,10);
  ctrl_long;
  for i:=0 to Form1.StringGrid1.RowCount-1 do
    for j:=0 to Form1.StringGrid1.ColCount-1 do
      Form1.StringGrid1.Cells[j,i]:= inttostr(RandomRange(-100,100));
    for i:=0 to Form1.StringGrid2.ColCount-1 do
      Form1.StringGrid2.Cells[i,0]:= inttostr(RandomRange(-100,100));
end;

procedure TForm1.Button3Click(Sender: TObject);
var  //Clicking the button "Read from file"
  fname,s: string;
      f: textfile;
    i,j: integer;
begin
  Form1.OpenDialog1.Title:='Read from file';
  if OpenDialog1.Execute Then
    try
      fname:=OpenDialog1.FileName;
      AssignFile(f,fname);
      Reset(f);
      if not(EOF(f)) then
        ReadLn(f,s);
      Form1.SpinEdit1.Value:=StrToInt(s);
      if not(EOF(f)) then
        ReadLn(f,s);
      Form1.SpinEdit2.Value:=StrToInt(s);
      ctrl_long;
      for i:=0 to Form1.StringGrid1.ColCount-1 do
        for j:=0 to Form1.StringGrid1.RowCount-1 do
          if not (EOF(f)) then
            begin
              ReadLn(f,s);
              Form1.StringGrid1.Cells[i,j]:=s;
            end;
      for i:=0 to Form1.StringGrid2.ColCount-1 do
        if not (EOF(f)) then
          begin
            ReadLn(f,s);
            Form1.StringGrid2.Cells[i,0]:=s;
          end;
      CloseFile(f);
    except
      MessageBox (0, 'There was an error reading the file!','Attention!', MB_ICONEXCLAMATION);
      CloseFile(f);
      exit;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var  //Clicking on the button "file"
  fname: string;
      f: textfile;
    i,j: integer;
begin
  try
    for i:=0 to Form1.StringGrid1.RowCount-1 do
      for j:=0 to Form1.StringGrid1.ColCount-1 do
        a6[i,j]:=StrToFloat(Form1.StringGrid1.Cells[j,i]);
    for i:=0 to Form1.StringGrid2.ColCount-1 do
        b6[i]:=StrToFloat(Form1.StringGrid2.Cells[i,0]);
  except
    MessageBox (0, 'Check the data in the tables!','Attention!', MB_ICONEXCLAMATION);
    exit;
  end;
  Form1.SaveDialog1.Title:='Save to File';
  if SaveDialog1.Execute Then
    Begin
      fname:=SaveDialog1.FileName;
      AssignFile(f,fname);
      Rewrite(f);
      Writeln(f,IntToStr(Form1.StringGrid1.ColCount));
      Writeln(f,IntToStr(Form1.StringGrid1.RowCount));
      for i:=0 to Form1.StringGrid1.ColCount-1 do
        for j:=0 to Form1.StringGrid1.RowCount-1 do
          writeln(f,FloatToStr(A6[j,i]));
      for i:=0 to Form1.StringGrid2.ColCount-1 do
        writeln(f,FloatToStr(B6[i]));
      CloseFile(f);
    end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin  //Clicking on the "about" button
  ShowMessage('Task 4;'+#13+'Developed: student group POIT-21'
    +#13+'Baranov V.F.');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin  //Clicking on the "exit" button
  Form1.Close;
end;

procedure TForm1.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin{Control numbers in the Stringgrid1 + transition on the next cell}
  if Not (Key in ['0'..'9','-',#8,#13])then Key:=#0;
  if key=#13 then
  begin
    if  StringGrid1.Col < StringGrid1.ColCount-1 then
      begin
        StringGrid1.Col:=StringGrid1.Col+1;
      end
        else
          begin
            if  StringGrid1.Row < StringGrid1.RowCount-1 then
              begin
                 StringGrid1.Row:=StringGrid1.Row+1;
                 StringGrid1.Col:=0;
              end
            else
              begin
                 StringGrid1.Col:=0;
                 StringGrid1.Row:=0;
              end;
          end;
  end;
end;

procedure TForm1.StringGrid2KeyPress(Sender: TObject; var Key: Char);
begin   {check input numbers Stringgrid2}
  if Not (Key in ['0'..'9',#8,'-',#13])then Key:=#0;
  if key=#13 then
  begin
    if StringGrid2.Col < StringGrid2.ColCount-1 then
      StringGrid2.Col:= StringGrid2.Col+1 else
      StringGrid2.Col:=0;
  end;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin //Click on the number of columns of a matrix A
ctrl_long;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin //Click on the number of columns of a matrix A
ctrl_long;
end;

end.
