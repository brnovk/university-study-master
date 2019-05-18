unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, ComCtrls, StdCtrls, Buttons, ExtCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Label1: TLabel;
    Clear: TButton;
    Panel1: TPanel;
    answer1: TButton;
    answer2: TButton;
    answer3: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure answer1Click(Sender: TObject);
    procedure answer2Click(Sender: TObject);
    procedure answer3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  f:boolean;

implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
form1.StringGrid1.Visible:=false;
form1.Label1.Visible:=false;
form1.Edit1.Visible:=false;
form1.UpDown1.Visible:=false;
form1.Panel1.Visible:=false;
form1.Clear.Visible:=false;
StringGrid1.Options:=StringGrid1.Options+[goEditing];
end;

procedure s1;{Update dimensions and display elements}
begin
form1.StringGrid1.Visible:=true;
form1.Label1.Visible:=true;
form1.Panel1.Visible:=true;
form1.Clear.Visible:=true;
form1.StringGrid1.ColCount:=strtoint(form1.Edit1.Text);
end;

procedure p1;
var i:integer;    {check data entry Stringgrid}
begin
  for i:=0 to form1.StringGrid1.ColCount-1 do
    if form1.StringGrid1.Cells[i, 0]='' then
      begin
        f:=false;
        showmessage('There are no data in the table');
        break;
      end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin          {edit show + Updown}
form1.Edit1.Visible:=true;
form1.UpDown1.Visible:=true;
end;

procedure TForm1.FormClick(Sender: TObject);
begin            {Click on forms1}
s1;
end;

procedure TForm1.ClearClick(Sender: TObject);
begin            {clearing values stringgrid }
form1.StringGrid1.Rows[0].Clear;
end;

procedure TForm1.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
s1;
end;

procedure TForm1.answer1Click(Sender: TObject);
  var a:array[1..100] of integer;  {Task ¹1}
      max,i,n,q:integer;
begin
  f:=true;
  p1;
  if f=true then
  begin
    Form2.Show;
    n:=strtoint(form1.Edit1.text);
    for i:=1 to n do
      a[i]:=strtoint(form1.StringGrid1.Cells[i-1, 0]);
    max:=a[1];
    for i:=1 to n do
      if a[i]>max then max:=a[i];
    q:=0;
    for i:=1 to n do
      if a[i]=max then q:=q+1;
    form2.edit1.text:=inttostr(max);
    form2.edit2.text:=inttostr(q);
  end;
end;

procedure TForm1.answer2Click(Sender: TObject);
  var a:array[1..100] of integer;  {Task ¹2}
      max,i,n,q:integer;
begin
  f:=true;
  p1;
  if f=true then
  begin
    Form3.Show;
    n:=strtoint(form1.Edit1.text);
    for i:=1 to n do
      a[i]:=strtoint(form1.StringGrid1.Cells[i-1, 0]);
    max:=a[1];
    for i:=1 to n do
      if a[i]>max then
      if a[i] mod 2 =0 then
         max:=a[i];
    q:=0;
    for i:=1 to n do
      if a[i] mod 2<>0 then
         q:=q+1;
    form3.edit1.text:=inttostr(max);
    form3.edit2.text:=inttostr(q);
  end;
end;

procedure TForm1.answer3Click(Sender: TObject);
  var a,b,c:array [1..100]of integer; {Task ¹3}
    n,i,j:integer;
begin
  f:=true;
  p1;
  if f=true then
  begin
    Form4.Show;
    n:=strtoint(form1.Edit1.text);
    for i:=1 to n do
      begin
        a[i]:=strtoint(form1.StringGrid1.Cells[i-1, 0]);
        b[i]:=1;
      end;
    for i:=1 to n-1 do
      for j:=i+1 to n do
        if a[i]>a[j] then b[i]:=b[i]+1 else
          if a[i]<=a[j] then b[j]:=b[j]+1;
    for i:=1 to n do
    for j:=1 to n do
      if i=b[j] then c[i]:=a[j];
    form4.StringGrid1.ColCount:=strtoint(form1.Edit1.Text);
    for i:=1 to n do
      form4.StringGrid1.Cells[i-1, 0]:=inttostr(c[i]);
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
var i:integer;            {Open in StringGrid}
    s:string;
    x:textfile;
begin
  if opendialog1.Execute then
    begin
      assignfile(x,opendialog1.FileName);
      reset(x);
      form1.StringGrid1.Rows[0].Clear;
      ReadLn(x,s);
      form1.StringGrid1.ColCount:=strtoint(s);
      while not EOF(x) do
          begin
            for i:=0 to form1.StringGrid1.ColCount-1 do
              begin
                ReadLn(x,s);
                form1.StringGrid1.Cells[i,0]:=s;
              end;
          end;
        CloseFile(x);
    end;
  form1.edit1.text:=inttostr(form1.StringGrid1.ColCount);
end;



procedure TForm1.Button3Click(Sender: TObject);
var x:TextFile;   {saving stringgrid in txt}
    i: Integer;
begin
  if form1.savedialog1.Execute then
    begin
      assignfile(x,form1.savedialog1.FileName);
      rewrite(x);
      Writeln(x,form1.StringGrid1.ColCount);
      for i:=0 to form1.StringGrid1.ColCount-1 do
          Writeln(x,form1.StringGrid1.Cells[i,0]);
      CloseFile(x);
    end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin   {check input numbers EDIT1.}
  if Not (Key in ['0'..'9',#8,#13])then Key:=#0;
  if key=#13 then
  begin
    s1;
    form1.StringGrid1.setfocus;
  end;
end;

procedure TForm1.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin   {check input numbers Stringgrid1.}
  if Not (Key in ['0'..'9',#8,'-',#13])then Key:=#0;
  if key=#13 then
  begin
    if StringGrid1.Col < StringGrid1.ColCount-1 then
      StringGrid1.Col:= StringGrid1.Col+1 else
      StringGrid1.Col:=0;
  end;
end;

end.
