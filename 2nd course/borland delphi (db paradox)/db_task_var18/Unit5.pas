unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1, Unit2;

{$R *.dfm}

procedure TForm5.Button1Click(Sender: TObject);
begin   //Press "Ok"
  if Form5.Tag=0 then
    Form1.Table2['Kl_stud']:=Form1.Table1['Kl_stud'];
  if Form5.Tag=1 then
    Form1.Table3['Kl_stud']:=Form1.Table1['Kl_stud'];
  Form5.Close;
  Form2.Button1.SetFocus;
end;

procedure TForm5.Button2Click(Sender: TObject);
begin  //Press "Cancel"
  Form5.Close;
end;

end.
