unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    next: TBitBtn;
    Close: TBitBtn;
    procedure nextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2;

{$R *.dfm}


procedure TForm1.nextClick(Sender: TObject);
begin
  Form2.Show;
end;

end.
