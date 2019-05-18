unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls;

type
  TForm4 = class(TForm)
    StringGrid1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    Clear: TButton;
    Button1: TButton;
    procedure ClearClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm4.ClearClick(Sender: TObject);
begin
form4.StringGrid1.Rows[0].Clear;
end;

procedure TForm4.Button1Click(Sender: TObject);
var x:TextFile;
    i: Integer;
begin
  if form1.savedialog1.Execute then
    begin
      assignfile(x,form1.savedialog1.FileName);
      rewrite(x);
      Writeln(x,form4.StringGrid1.ColCount);
      for i:=0 to form4.StringGrid1.ColCount-1 do
          Writeln(x,form4.StringGrid1.Cells[i,0]);
      CloseFile(x);
    end;
end;

end.
