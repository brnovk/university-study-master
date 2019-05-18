unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, ComCtrls, Xpman, ActnList, Mask, Spin, Math;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    Panel4: TPanel;
    StaticText3: TStaticText;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    GroupBox3: TGroupBox;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox4: TGroupBox;
    SpinEdit5: TSpinEdit;
    Label5: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    TabSheet8: TTabSheet;
    StringGrid3: TStringGrid;
    Bevel1: TBevel;
    Bevel2: TBevel;
    StringGrid4: TStringGrid;
    Bevel3: TBevel;
    StringGrid5: TStringGrid;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    StringGrid7: TStringGrid;
    StringGrid8: TStringGrid;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    StringGrid9: TStringGrid;
    StringGrid10: TStringGrid;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    StringGrid11: TStringGrid;
    StringGrid12: TStringGrid;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    GroupBox13: TGroupBox;
    StringGrid6: TStringGrid;
    GroupBox14: TGroupBox;
    StringGrid13: TStringGrid;
    Button6: TButton;
    Bevel4: TBevel;
    StaticText8: TStaticText;
    StaticText7: TStaticText;
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  mytype=array[0..99,0..99] of real;
var
  Form1: TForm1;
  a: mytype;
  b: mytype;
implementation

{$R *.dfm}

function m_app:boolean;//Filling out. arrays of stringrig
var i,j:integer;
begin
  result:=true;
  try
    for i:=0 to Form1.StringGrid1.RowCount-1 do
      for j:=0 to Form1.StringGrid1.ColCount-1 do
        a[i,j]:=StrToFloat(Form1.StringGrid1.Cells[j,i]);
    for i:=0 to Form1.StringGrid2.RowCount-1 do
      for j:=0 to Form1.StringGrid2.ColCount-1 do
        b[i,j]:=StrToFloat(Form1.StringGrid2.Cells[j,i]);
  except
    MessageBox (0, 'Incorrect source data!','Attention!', MB_ICONEXCLAMATION);
    result:=false;
    exit;
  end;
end;

procedure ctrl_long;
begin //Change the dimension tables from SpinEdit
  Form1.StringGrid1.ColCount:=Form1.SpinEdit1.Value;
  Form1.StringGrid1.RowCount:=Form1.SpinEdit2.Value;
  Form1.StringGrid2.ColCount:=Form1.SpinEdit3.Value;
  Form1.StringGrid2.RowCount:=Form1.SpinEdit4.Value;
end;

function ctrl_dimension: boolean;
begin //Check the dimension of the original matrices for addition
  result:=true;
  if Form1.StringGrid1.ColCount<>
    Form1.StringGrid2.ColCount then
      result:=false;
  if Form1.StringGrid1.RowCount<>
    Form1.StringGrid2.RowCount then
      result:=false;
end;

function ctrl_multiply: boolean;
begin //Check the dimension of the source matrix for multiplication
  result:=true;
  if Form1.StringGrid1.ColCount<>
    Form1.StringGrid2.RowCount then
      result:=false;
end;

function ctrl_deter_A: boolean;
begin //Checking for matrix A dimension qualifier
  result:=true;
  if Form1.StringGrid1.ColCount<>
    Form1.StringGrid1.RowCount then
      result:=false;
end;

function ctrl_deter_B: boolean;
begin //Check the dimension of the matrix (B) for the determinant
  result:=true;
  if Form1.StringGrid2.ColCount<>
    Form1.StringGrid2.RowCount then
      result:=false;
end;

procedure ext_1; // The procedure for adding matrices
  var i,j:integer;
begin
  if ctrl_dimension=false then
    begin
      Form1.StaticText4.Caption:='Matrices of various sizes. Add not implemented';
      for i:=0 to Form1.StringGrid3.ColCount do
        Form1.StringGrid3.Cols[i].Clear;
      Form1.StringGrid3.ColCount:=0;
      Form1.StringGrid3.RowCount:=0;
    end else
        begin
          Form1.StaticText4.Caption:='The result of the addition of matrices A and B';
          Form1.StringGrid3.ColCount:=Form1.StringGrid1.ColCount;
          Form1.StringGrid3.RowCount:=Form1.StringGrid1.RowCount;
            for i:=0 to Form1.StringGrid3.ColCount-1 do
              for j:=0 to Form1.StringGrid3.RowCount-1 do
                Form1.StringGrid3.Cells[i,j]:=FloatToStr(a[j,i]+b[j,i]);
        end;
end;

procedure ext_2;  //Difference matrix procedure
  var i,j:integer;
begin
  if ctrl_dimension=false then
    begin
      Form1.StaticText5.Caption:='The matrices of different sizes. Operation failed';
      for i:=0 to Form1.StringGrid4.ColCount do
        Form1.StringGrid4.Cols[i].Clear;
      Form1.StringGrid4.ColCount:=0;
      Form1.StringGrid4.RowCount:=0;
    end else
        begin
          Form1.StaticText5.Caption:='The result is the difference between the matrices A and B';
          Form1.StringGrid4.ColCount:=Form1.StringGrid1.ColCount;
          Form1.StringGrid4.RowCount:=Form1.StringGrid1.RowCount;
            for i:=0 to Form1.StringGrid4.ColCount-1 do
              for j:=0 to Form1.StringGrid4.RowCount-1 do
                Form1.StringGrid4.Cells[i,j]:=FloatToStr(a[j,i]-b[j,i]);
        end;
end;

procedure ext_3;  //Procedure matrix product
  var i,j,p:integer;
      buf: mytype;
begin
  if ctrl_multiply=false then
    begin
      Form1.StaticText6.Caption:='Number of columns of matrix A is not equal number rows of B. Multiplication does not hold';
      for i:=0 to Form1.StringGrid5.ColCount do
        Form1.StringGrid5.Cols[i].Clear;
      Form1.StringGrid5.ColCount:=0;
      Form1.StringGrid5.RowCount:=0;
    end else
        begin
          Form1.StaticText6.Caption:='The result of the multiplication of matrices A and B';
          Form1.StringGrid5.ColCount:=Form1.StringGrid2.ColCount;
          Form1.StringGrid5.RowCount:=Form1.StringGrid1.RowCount;
            for i:=0 to Form1.StringGrid5.RowCount-1 do
              for j:=0 to Form1.StringGrid5.ColCount-1 do
                  begin
                    buf[i,j]:=0;
                    for p:=0 to Form1.StringGrid5.RowCount-1 do
                      buf[i,j]:=buf[i,j]+a[i,p]*b[p,j];
                    Form1.StringGrid5.Cells[j,i]:=floattostr(buf[i,j]);
                  end;
        end;
end;

procedure ext_4; //Multiply by the number of matrices
var i,j,buf:integer;
begin
  // A multiplication matrix A of the number N
  Form1.StringGrid6.RowCount:=Form1.StringGrid1.RowCount;
  Form1.StringGrid6.ColCount:=Form1.StringGrid1.ColCount;
  buf:=form1.SpinEdit5.Value;
  for i:=0 to Form1.StringGrid1.RowCount do
    for j:=0 to Form1.StringGrid1.ColCount do
      Form1.StringGrid6.Cells[j,i]:=floattostr(buf*a[i,j]);

  // A multiplication matrix B of the number N
  Form1.StringGrid13.RowCount:=Form1.StringGrid2.RowCount;
  Form1.StringGrid13.ColCount:=Form1.StringGrid2.ColCount;
  for i:=0 to Form1.StringGrid2.RowCount do
    for j:=0 to Form1.StringGrid2.ColCount do
      Form1.StringGrid13.Cells[j,i]:=floattostr(buf*b[i,j]);
end;


procedure ext_5; {Sorting rows linear selection}
var tmp: mytype;
     buf: mytype;
     i,k,j,t_min: integer;
     min: real;
begin

//Sort of a matrix A:
  Form1.StringGrid7.ColCount:= Form1.StringGrid1.ColCount;
  Form1.StringGrid7.RowCount:= Form1.StringGrid1.RowCount;
  tmp:=a;
  for i:=0 to Form1.StringGrid7.RowCount-1 do
    for k:=0 to Form1.StringGrid7.ColCount-1 do
      begin
        min:=tmp[i,k];
        t_min:=k;
           for j:=0 to Form1.StringGrid7.ColCount-1 do
           if tmp[i,j]<min then
             begin
               min:=tmp[i,j];
               t_min:=j;
             end;
              buf[i,k]:=min;
              tmp[i,t_min]:=10000;
      end;

  for i:=0 to Form1.StringGrid7.RowCount-1 do
      for j:=0 to Form1.StringGrid7.ColCount-1 do
        Form1.StringGrid7.Cells[j,i]:=floattostr(buf[i,j]);


//Sort of a matrix B:
  Form1.StringGrid8.ColCount:= Form1.StringGrid2.ColCount;
  Form1.StringGrid8.RowCount:= Form1.StringGrid2.RowCount;
  tmp:=b;
  for i:=0 to Form1.StringGrid8.RowCount-1 do
    for k:=0 to Form1.StringGrid8.ColCount-1 do
      begin
        min:=tmp[i,k];
        t_min:=k;
           for j:=0 to Form1.StringGrid8.ColCount-1 do
           if tmp[i,j]<min then
             begin
               min:=tmp[i,j];
               t_min:=j;
             end;
              buf[i,k]:=min;
              tmp[i,t_min]:=10000;
      end;

 for i:=0 to Form1.StringGrid8.RowCount-1 do
      for j:=0 to Form1.StringGrid8.ColCount-1 do
        Form1.StringGrid8.Cells[j,i]:=floattostr(buf[i,j]);
end;


procedure ext_6; //The procedure for finding Inverse matrices
const t=0.000001;
type mytype_6=array[1..100,1..100]of real;

procedure Per(n,k:integer;a1:mytype_6;var p:integer);{swapping strings with Max. the main element of the}
var z:real;
    j,i:integer;
begin
z:=abs(a1[k,k]);
i:=k;
p:=0;
for j:=k+1 to n do
  begin
    if abs(a1[j,k])>z then
      begin
        z:=abs(a1[j,k]);
        i:=j;
        p:=p+1;
      end;
  end;
if i>k then
for j:=k to n do
   begin
     z:=a1[i,j];
     a1[i,j]:=a1[k,j];
     a1[k,j]:=z;
   end;
end;
function znak(p:integer):integer;{change character when rows of a matrix}
begin
if p mod 2=0 then
znak:=1 else znak:=-1;
end;
function znak1(i,m:integer):integer;{changing sign when adjusting the strings when finding additions}
begin
if (i+m) mod 2=0 then
znak1:=1 else znak1:=-1;
end;
procedure opr(n,p:integer;a1:mytype_6;var det:real;var f:byte);{finding the determinant of the matrix}
var k,i,j:integer;
    r:real;
begin
det:=1.0;f:=0;
for k:=1 to n do
   begin
     if a1[k,k]=0 then per(k,n,a1,p);
     det:=znak(p)*det*a1[k,k];
     if abs(det)<t then f:=1;
     for j:=k+1 to n do
        begin
         r:=a1[j,k]/a1[k,k];
         for i:=k to n do
         a1[j,i]:=a1[j,i]-r*a1[k,i];
        end;
   end;
end;
procedure opr1(n,p:integer;d:mytype_6;var det1:real);{finding definitions for additions}
var k,i,j:integer;
    r:real;
begin
det1:=1.0;
for k:=2 to n do
   begin
     if d[k,k]=0 then per(n,k,d,p);
     det1:=znak(p)*det1*d[k,k];
     for j:=k+1 to n do
       begin
         r:=d[j,k]/d[k,k];
         for i:=k to n do
         d[j,i]:=d[j,i]-r*d[k,i];
       end;
   end;
end;
Procedure Peresch(n,p:integer;var b1:mytype_6;det1:real;var e:mytype_6);{calculation of additions}
var i,m,k,j:integer;
    z:real;
    d,c:mytype_6;
begin
for i:=1 to n do
for m:=1 to n do
   begin
     for j:= 1 to n do {string permutation}
       begin
         z:=b1[i,j];
         for k:=i downto 2 do
         d[k,j]:=b1[k-1,j];
         for k:=i+1 to n do
         d[k,j]:=b1[k,j];
         d[1,j]:=z;
       end;
     for k:=1 to n do {rearrange columns}
       begin
         z:=d[k,m];
         for j:=m downto 2 do
         c[k,j]:=d[k,j-1];
         for j:=m+1 to n do
         c[k,j]:=d[k,j];
         c[k,1]:=z;
       end;
     Opr1(n,p,c,det1);{computation of determinants}
     e[i,m]:=det1*znak1(i,m);{calculation of additions}
   end;
end;
procedure Transp(a1:mytype_6; n:integer;var at:mytype_6);{transpose of a matrix}
var k,j:integer;
begin
for k:= 1 to n do
for j:=1 to n do
at[k,j]:=a1[j,k];
end;

var n,k,j,i,p:integer;{n-dimension matrix, k-counter by row, j-column-counter, p-counter permutations}
    a1,at,b1,c,e:mytype_6;{a-source, at-transposed, b1-additions matrix, e-reverse, ñ-inspection}
    det,det1:real;{det-determinant of the original matrix,det1-determinants-ons}
    f:byte;{a sign of the non-existence of the inverse matrix}
begin

 //For the matrix A
  if ctrl_deter_A=false then
    begin
      Form1.StaticText7.Caption:='The columns are not equal rows';
    end else
      begin
        for i:=0 to Form1.StringGrid1.RowCount-1 do
          for j:=0 to Form1.StringGrid1.RowCount-1 do
            a1[i+1,j+1]:=a[i,j];
        n:=Form1.StringGrid1.RowCount;
        Opr(n,p,a1,det,f);{calc determinant }
        if f=0 then
          begin
            Transp(a1,n,b1);  {transpose matrix}
            Peresch(n,p,b1,det1,e);  {calc Add-ons}
            for k:=1 to n do
              for j:=1 to n do
                begin
                  e[k,j]:=e[k,j]/det; {create the matrix inverse}
                  Form1.StringGrid9.Cells[j-1,k-1]:=FloatToStr(e[k,j]);
                end;
          end else
            begin
              Form1.StaticText7.Caption:='No determinant';
              for i:=0 to Form1.StringGrid5.ColCount do
                Form1.StringGrid9.Cols[i].Clear;
              Form1.StringGrid9.ColCount:=0;
              Form1.StringGrid9.RowCount:=0;
            end;
      end;


 //For the matrix B
  if ctrl_deter_B=false then
    begin
      Form1.StaticText8.Caption:='The columns are not equal rows';
    end else
      begin
        for i:=0 to Form1.StringGrid2.RowCount-1 do
          for j:=0 to Form1.StringGrid2.RowCount-1 do
            a1[i+1,j+1]:=b[i,j];
        n:=Form1.StringGrid2.RowCount;
        Opr(n,p,a1,det,f);{calc determinant}
        if f=0 then
          begin
            Transp(a1,n,b1);  {transpose matrix}
            Peresch(n,p,b1,det1,e);  {calc Add-ons}
            for k:=1 to n do
              for j:=1 to n do
                begin
                  e[k,j]:=e[k,j]/det; {create the matrix inverse}
                  Form1.StringGrid10.Cells[j-1,k-1]:=FloatToStr(e[k,j]);
                end;
          end else
            begin
              Form1.StaticText8.Caption:='No determinant';
              for i:=0 to Form1.StringGrid10.ColCount do
                Form1.StringGrid10.Cols[i].Clear;
              Form1.StringGrid10.ColCount:=0;
              Form1.StringGrid10.RowCount:=0;
            end;
      end;
end;


procedure ext_7; //transpose matrix
var buf: mytype;
    i,j: integer;
begin
  //Transpose matrix A
  Form1.StringGrid11.RowCount:=Form1.StringGrid1.ColCount;
  Form1.StringGrid11.ColCount:=Form1.StringGrid1.RowCount;
  for i:=0 to Form1.StringGrid1.ColCount do
    for j:=0 to Form1.StringGrid1.RowCount do
      buf[i,j]:=a[j,i];
  for i:=0 to Form1.StringGrid1.ColCount do
    for j:=0 to Form1.StringGrid1.RowCount do
      Form1.StringGrid11.Cells[j,i]:=floattostr(buf[i,j]);

 //Transpose matrix B
  Form1.StringGrid12.RowCount:=Form1.StringGrid2.ColCount;
  Form1.StringGrid12.ColCount:=Form1.StringGrid2.RowCount;
  for i:=0 to Form1.StringGrid2.ColCount do
    for j:=0 to Form1.StringGrid2.RowCount do
      buf[i,j]:=b[j,i];
  for i:=0 to Form1.StringGrid2.ColCount do
    for j:=0 to Form1.StringGrid2.RowCount do
      Form1.StringGrid12.Cells[j,i]:=floattostr(buf[i,j]);
end;

procedure ext_8;//procedure of finding the determinant of matrices
type mytype_8=array[1..100,1..100] of longint;
var a1,b1:mytype_8;
    i,j,dt,n:longint;

procedure del(a1:mytype_8; var b1:mytype_8; m,i,j:integer);
var ki,kj,di,dj:integer;
  begin
    di:=0;
    for ki:=1 to m-1 do
      begin
        if (ki=i) then di:=1;
        dj:=0;
        for kj:=1 to m-1 do
          begin
            if (kj=j) then dj:=1;
            b1[ki,kj]:=a1[ki+di,kj+dj];
          end;
      end;
  end;

Function Determinant(a1:mytype_8; n:integer):longint;
var i,j,d,k:integer;
    b1:mytype_8;
  begin
    d:=0;
    k:=1;
    if (n=1) then d:=a1[1,1]
      else if (n=2) then d:=a1[1,1]*a1[2,2]-a1[2,1]*a1[1,2]
        else if (n>2) then
          for i:=1 to n do
            begin
              del(a1,b1,n,i,1);
              d:=d+k*a1[i,1]*Determinant(b1,n-1);
              k:=-k;
            end;
    Determinant:=d;
  end;

begin
  //For the matrix A
  if ctrl_deter_A=false then
    begin
      Form1.LabeledEdit1.Text:='Columns are not equal rows';
    end else
      begin
        for i:=0 to Form1.StringGrid1.RowCount-1 do
          for j:=0 to Form1.StringGrid1.RowCount-1 do
            a1[i+1,j+1]:=round(a[i,j]);
        n:=Form1.StringGrid1.RowCount;
        dt:=Determinant(a1,n);
        Form1.LabeledEdit1.Text:=floattostr(dt);
      end;


  //For the matrix B
  if ctrl_deter_B=false then
    begin
      Form1.LabeledEdit2.Text:='Columns are not equal rows';
    end else
      begin
        for i:=0 to Form1.StringGrid2.RowCount-1 do
          for j:=0 to Form1.StringGrid2.RowCount-1 do
            a1[i+1,j+1]:=round(b[i,j]);
        n:=Form1.StringGrid2.RowCount;
        dt:=Determinant(a1,n);
        Form1.LabeledEdit2.Text:=floattostr(dt);
      end;
end;

procedure TForm1.Button5Click(Sender: TObject);
  begin  //"Exit" button
    Form1.Close;
  end;

procedure TForm1.Button4Click(Sender: TObject);
  begin  //Clicking the "about"
    ShowMessage('Task ¹3;'+#13+'Completed: the student group POIT-21'
      +#13+'Baranov V.F.');
  end;


procedure TForm1.Button1Click(Sender: TObject);
     //Pressing calculate
  begin
    if m_app=false then
      begin
        MessageBox (0, 'Data entry error!','Attention!', MB_ICONEXCLAMATION);
        exit;
      end;
    ext_1;
    ext_2;
    ext_3;
    ext_4;
    ext_5;
    ext_6;
    ext_7;
    ext_8;
  end;

procedure TForm1.Button3Click(Sender: TObject);
var  //Clicking the "save to file"
  fname: string;
      f: textfile;
    i,j: integer;
begin
  try
    for i:=0 to Form1.StringGrid1.ColCount-1 do
      for j:=0 to Form1.StringGrid1.RowCount-1 do
        A[i,j]:=StrToFloat(Form1.StringGrid1.Cells[i,j]);
    for i:=0 to Form1.StringGrid2.ColCount-1 do
      for j:=0 to Form1.StringGrid2.RowCount-1 do
        B[i,j]:=StrToFloat(Form1.StringGrid2.Cells[i,j]);
  except
    MessageBox (0, 'Check the data in the tables!','Attention!', MB_ICONEXCLAMATION);
    exit;
  end;
  Form1.SaveDialog1.Title:='Save to file';
  if SaveDialog1.Execute Then
    Begin
      fname:=SaveDialog1.FileName;
      AssignFile(f,fname);
      Rewrite(f);
      Writeln(f,IntToStr(Form1.StringGrid1.ColCount));
      Writeln(f,IntToStr(Form1.StringGrid1.RowCount));
      Writeln(f,IntToStr(Form1.StringGrid2.ColCount));
      Writeln(f,IntToStr(Form1.StringGrid2.RowCount));
      for i:=0 to Form1.StringGrid1.ColCount-1 do
        for j:=0 to Form1.StringGrid1.RowCount-1 do
          writeln(f,FloatToStr(A[i,j]));
      for i:=0 to Form1.StringGrid2.ColCount-1 do
        for j:=0 to Form1.StringGrid2.RowCount-1 do
          writeln(f,FloatToStr(B[i,j]));
      CloseFile(f);
    end;
end;


procedure TForm1.SpinEdit1Change(Sender: TObject);
begin  //Click on the "number of columns of a matrix A"
  ctrl_long;
end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin  //Click on the "number of rows of a matrix A"
  ctrl_long;
end;

procedure TForm1.SpinEdit3Change(Sender: TObject);
begin  //Click on the "number of columns of a matrix B"
  ctrl_long;
end;

procedure TForm1.SpinEdit4Change(Sender: TObject);
begin  //Click on the "number of rows of a matrix B"
  ctrl_long;
end;



procedure TForm1.FormShow(Sender: TObject);
begin
  ctrl_long;
end;

procedure TForm1.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin{Control numbers in the Stringgrid1 + transition on the trail. cell}
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
begin{Control numbers in the Stringgrid2 + transition on the trail. cell}
  if Not (Key in ['0'..'9','-',#8,#13])then Key:=#0;
  if key=#13 then
  begin
    if  StringGrid2.Col < StringGrid2.ColCount-1 then
      begin
        StringGrid2.Col:=StringGrid2.Col+1;
      end
        else
          begin
            if  StringGrid2.Row < StringGrid2.RowCount-1 then
              begin
                 StringGrid2.Row:=StringGrid2.Row+1;
                 StringGrid2.Col:=0;
              end
            else
              begin
                 StringGrid2.Col:=0;
                 StringGrid2.Row:=0;
              end;
          end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var  //Pressing the "read from file"
  fname,s: string;
      f: textfile;
    i,j: integer;
begin
  Form1.OpenDialog1.Title:='Read from a file';
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
      if not(EOF(f)) then
        ReadLn(f,s);
      Form1.SpinEdit3.Value:=StrToInt(s);
      if not(EOF(f)) then
        ReadLn(f,s);
      Form1.SpinEdit4.Value:=StrToInt(s);
      ctrl_long;
      for i:=0 to Form1.StringGrid1.ColCount-1 do
        for j:=0 to Form1.StringGrid1.RowCount-1 do
          if not (EOF(f)) then
            begin
              ReadLn(f,s);
              Form1.StringGrid1.Cells[i,j]:=s;
            end;
      for i:=0 to Form1.StringGrid2.ColCount-1 do
        for j:=0 to Form1.StringGrid2.RowCount-1 do
          if not (EOF(f)) then
            begin
              ReadLn(f,s);
              Form1.StringGrid2.Cells[i,j]:=s;
            end;
      CloseFile(f);
    except
      MessageBox (0, 'An error occurred reading the file!','Attention!', MB_ICONEXCLAMATION);
      exit;
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
 var i,j: integer;
begin   //Random filling of data
  Form1.SpinEdit1.Value:=RandomRange(1,10);
  Form1.SpinEdit2.Value:=RandomRange(1,10);
  Form1.SpinEdit3.Value:=RandomRange(1,10);
  Form1.SpinEdit4.Value:=RandomRange(1,10);
  ctrl_long;
  Form1.SpinEdit5.Value:=RandomRange(-20,20);
  for i:=0 to Form1.StringGrid1.RowCount-1 do
    for j:=0 to Form1.StringGrid1.ColCount-1 do
      Form1.StringGrid1.Cells[j,i]:= inttostr(RandomRange(-100,100));
  for i:=0 to Form1.StringGrid2.RowCount-1 do
    for j:=0 to Form1.StringGrid2.ColCount-1 do
      Form1.StringGrid2.Cells[j,i]:= inttostr(RandomRange(-100,100));
end;

end.
