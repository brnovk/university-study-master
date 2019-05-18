unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, Grids;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    UpDown1: TUpDown;
    Button3: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    Clear: TButton;
    Label3: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    Button4: TButton;
    Edit3: TEdit;
    Label4: TLabel;
    rz1: TLabel;
    rz3: TLabel;
    rz4: TLabel;
    ListBox1: TListBox;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure ClearClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  f:boolean;

implementation

uses Unit1;

{$R *.dfm}




procedure TForm2.Button1Click(Sender: TObject);
begin          {show edit +updown}
form2.Label1.Visible:=true;
form2.Edit1.Visible:=true;
form2.UpDown1.Visible:=true;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin           {When designing a form}
form2.Label1.Visible:=false;
form2.Edit1.Visible:=false;
form2.UpDown1.Visible:=false;
form2.StringGrid1.Visible:=false;
form2.Label3.Visible:=false;
form2.Clear.Visible:=false;
form2.StringGrid1.Options:=form2.StringGrid1.Options+[goEditing];
end;

procedure s1; {dimension and update the display of items}
begin
form2.StringGrid1.Visible:=true;
form2.Label3.Visible:=true;
form2.Clear.Visible:=true;
form2.StringGrid1.RowCount:=strtoint(form2.Edit1.Text);
form2.StringGrid1.ColCount:=strtoint(form2.Edit1.Text);
end;

procedure TForm2.FormClick(Sender: TObject);
begin    {Click on the form}
s1;
end;

procedure cls;
var i:integer; {clearing values stringgrid }
begin
for i:=0 to form2.StringGrid1.ColCount-1 do
  form2.StringGrid1.Rows[i].Clear;
end;

procedure p1;
var i,j:integer;    {validation of user input in Stringgrid}
    l:boolean;
begin
  l:=true;
  for i:=0 to form2.StringGrid1.ColCount-1 do
    for j:=0 to form2.StringGrid1.RowCount-1 do
      if (form2.StringGrid1.Cells[i, j]='') and (l=true) then
        begin
          f:=false;
          l:=false;
          showmessage('There is no data in the source table');
          s1;
          form2.StringGrid1.SetFocus;
          break;
        end;
end;

procedure p2;
begin
if form2.Edit3.text='' then
  begin
    showmessage('There is no data in the input field(S)');
    f:=false;
    form2.Edit3.SetFocus;
  end;
end;

procedure TForm2.ClearClick(Sender: TObject);
begin
cls;
end;

procedure TForm2.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
s1;
form2.StringGrid1.SetFocus;
end;

procedure TForm2.UpDown2Click(Sender: TObject; Button: TUDBtnType);
begin
s1;
end;

procedure TForm2.Edit1KeyPress(Sender: TObject; var Key: Char);
begin   {check input numbers EDIT1.}
  if Not (Key in ['0'..'9',#8,#13])then Key:=#0;
  if key=#13 then
  begin
    s1;
    form2.StringGrid1.setfocus;
  end;
end;

procedure TForm2.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin   {check input numbers Stringgrid1.}
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

procedure TForm2.Button2Click(Sender: TObject);
var i,j:integer;       {Open in StringGrid}
    s:string;
    x:textfile;
begin
  if opendialog1.Execute then
    begin
      assignfile(x,opendialog1.FileName);
      reset(x);
      cls;
      ReadLn(x,s);
      form2.StringGrid1.RowCount:=strtoint(s);
      ReadLn(x,s);
      form2.StringGrid1.ColCount:=strtoint(s);
      while not EOF(x) do
          begin
            for i:=0 to form2.StringGrid1.RowCount-1 do
              for j:=0 to form2.StringGrid1.ColCount-1 do
                begin
                  ReadLn(x,s);
                  form2.StringGrid1.Cells[j,i]:=s;
                end;
          end;
        CloseFile(x);
    end;
  form2.edit1.text:=inttostr(form2.StringGrid1.ColCount);
  form2.StringGrid1.Visible:=true;
end;



procedure TForm2.Button3Click(Sender: TObject);
var x:TextFile;   {saving stringgrid in txt}
    i,j: Integer;
begin
  if form2.savedialog1.Execute then
    begin
      assignfile(x,form2.savedialog1.FileName);
      rewrite(x);
      Writeln(x,form2.StringGrid1.RowCount);
      Writeln(x,form2.StringGrid1.ColCount);
      for i:=0 to form2.StringGrid1.RowCount-1 do
        for j:=0 to form2.StringGrid1.ColCount-1 do
          Writeln(x,form2.StringGrid1.Cells[j,i]);
      CloseFile(x);
    end;
end;

procedure a1;   {Task 1}
var a:array[1..100,1..100] of integer;
    b:array[1..100] of integer;
    i,j,n,min,min_i,max_j:integer;
    t:boolean;
begin
  n:=strtoint(form2.Edit1.text);
  t:=true;
  for i:=1 to n do
    for j:=1 to n do
      begin
        a[i,j]:=strtoint(form2.StringGrid1.Cells[i-1, j-1]);
        b[i]:=1;
      end;
  min_i:=0;
  max_j:=0;
  for i:=1 to n do
    begin
      min:=a[i,1];
      for j:=1 to n do
        if a[i,j]<min then min:=a[i,j];
      min_i:=min_i+min;
    end;
  for j:=1 to n do
    begin
      max_j:=a[1,j];
      for i:=1 to n do
        if a[i,j]>max_j then max_j:=a[i,j];
      b[j]:=max_j;
    end;
  if max_j>min_i then
    begin
      for i:=1 to n do
        for j:=1 to n do
          if j=n-i+1 then a[i,j]:=a[i,j]+b[j];
      form2.rz1.Caption:='The condition of the task performed. The matrix changed';
      t:=false;
    end;
  form2.StringGrid2.RowCount:=strtoint(form2.Edit1.Text);
  form2.StringGrid2.ColCount:=strtoint(form2.Edit1.Text);
  for i:=1 to n do
    for j:=1 to n do
      form2.StringGrid2.Cells[i-1, j-1]:=inttostr(a[i,j]);
  if t=true then
    form2.rz1.Caption:='Task condition is not met. Matrix not changed';
end;

procedure a2;
var a:array[1..100,1..100] of integer;
    buf:array[0..100] of boolean;
    i,j,n,pr:integer;
begin
  n:=strtoint(form2.Edit1.text);
  buf[0]:=false;
  Form2.ListBox1.Items.Clear;
  for i:=1 to n do
    for j:=1 to n do
      begin
        a[i,j]:=strtoint(form2.StringGrid1.Cells[j-1, i-1]);
        buf[i]:=false;
      end;
  for i:=1 to n do
    if buf[i]=false then
      for j:=1 to n do
        if a[i,j] mod 3=0 then buf [i]:=true;
  for i:=1 to n do
    if buf[i]=false then
      begin
        pr:=1;
        for j:=1 to n do
          pr:=pr*a[i,j];
        buf[0]:=true;
        form2.ListBox1.Items.Add('Product elements '+inttostr(i)+' string: '+inttostr(pr));
      end;
  if buf[0]=false then
    form2.ListBox1.Items.Add('All line items contain multiple 3');
end;

procedure a3; {Task 3}
var a:array[1..100,1..100] of integer;
    i,j,n,s,q:integer;
begin
s:=strtoint(form2.Edit3.text);
n:=strtoint(form2.Edit1.text);
form2.edit2.text:='';
for i:=1 to n do
  for j:=1 to n do
    a[i,j]:=strtoint(form2.StringGrid1.Cells[i-1, j-1]);
for j:=1 to n do
  begin
    q:=0;
    begin
      for i:=1 to n do
        if a[i,j]>=s then
        q:=q+1;
        if q=n then
        form2.edit2.text:=inttostr(j);
    end;
    if q=n then break;
  end;
end;

procedure a4;   {Task 4}
var a,b:array[1..100,1..100] of integer;
    i,j,n,k,ds,us,buf:integer;
begin
  n:=strtoint(form2.Edit1.text);
  for i:=1 to n do
    for j:=1 to n do
      begin
        a[i,j]:=strtoint(form2.StringGrid1.Cells[j-1, i-1]);
        b[i,j]:=1;
        form2.StringGrid3.Rows[i-1].Clear;
      end;
  us:=0;
  ds:=0;
  buf:=n*(n-1);
  for i:=1 to n do
    for j:=1 to n-1 do
      begin
        k:=j+1;
        if a[i,j]<=a[i,k] then us:=us+1;
        if a[i,j]>=a[i,k] then ds:=ds+1;
      end;
  if us=buf then
    begin
      form2.rz4.Caption:='Matrix is ordered in ascending order. Sorting is required.';
      buf:=1;
    end;
  if ds=buf then
    begin
      form2.rz4.Caption:='Matrix is ordered in descending order. Sorting is required.';
      buf:=1;
    end;
  if buf<>1 then
    begin
      for i:=1 to n do
        for j:=1 to n-1 do
          for k:=j+1 to n do
            begin
              if a[i,j]>a[i,k] then b[i,j]:=b[i,j]+1
              else b[i,k]:=b[i,k]+1;
            end;
      form2.rz4.Caption:='Matrix sorted.';
      form2.StringGrid3.RowCount:=strtoint(form2.Edit1.Text);
      form2.StringGrid3.ColCount:=strtoint(form2.Edit1.Text);
      for i:=1 to n do
        for j:=1 to n do
          for k:=1 to n do
            if j=b[i,k] then form2.StringGrid3.Cells[j-1,i-1]:=inttostr(a[i,k]);
    end;
end;


procedure TForm2.Button4Click(Sender: TObject);
begin                 {Calculate}
f:=true;
p1;
p2;
if f=true then
  begin
    a1;
    a2;
    a3;
    a4;
  end;
end;

procedure TForm2.Edit3KeyPress(Sender: TObject; var Key: Char);
begin   {Digit verification EDIT1.}
  if Not (Key in ['0'..'9','-',#8,#13])then Key:=#0;
  if key=#13 then s1;
end;


end.
