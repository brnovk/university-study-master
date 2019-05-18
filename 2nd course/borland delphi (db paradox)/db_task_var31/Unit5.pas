unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, ExtCtrls, XpMan;

type
  TForm5 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

procedure TForm5.Button2Click(Sender: TObject);
begin    // Press "Cancel"
 Form5.Close;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin    //Press "Ok"
  if Form5.Tag=0 then
    Form1.Table2['Kl_potion']:=Form1.Table1['Kl_potion'];
  if Form5.Tag=1 then
    Form1.Table3['Kl_potion']:=Form1.Table1['Kl_potion'];
  Form5.Close;
  Form2.Button1.SetFocus;

end;

end.
 