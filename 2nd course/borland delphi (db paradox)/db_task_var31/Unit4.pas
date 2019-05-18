unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XpMan, Grids, DBGrids, StdCtrls, ExtCtrls;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    StaticText1: TStaticText;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
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

procedure TForm4.Button1Click(Sender: TObject);
begin   //Click "Query"

  if Form4.Tag=1 then
    begin //Query potion list with indication implementation period
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Kl_potion,Potion,Term_realization');
      Form1.Query1.SQL.Add('FROM "tab_ready"');
      Form1.Query1.Open;
    end;

  if Form4.Tag=2 then
    begin //Query potion indicated in table delivery
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT DISTINCT Kl_potion,Potion');
      Form1.Query1.SQL.Add('FROM "tab_ready","tab_receipt"');
      Form1.Query1.SQL.Add('WHERE (tab_ready.Kl_potion=tab_receipt.Kl_potion)');
      Form1.Query1.Open;
    end;

  if Form4.Tag=3 then
    begin //Query potion indicated in table sale
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT DISTINCT Kl_potion,Potion');
      Form1.Query1.SQL.Add('FROM "tab_ready","tab_sale"');
      Form1.Query1.SQL.Add('WHERE (tab_ready.Kl_potion=tab_sale.Kl_potion)');
      Form1.Query1.Open;
    end;

  if Form4.Tag=4 then
    begin //Query potion delivery by code
      if Form4.Edit1.Text='' then
        begin
          ShowMessage('Enter code potion');
          Form4.Edit1.SetFocus;
          exit;
        end;
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Potion,Receipt_amount,Receipt_date');
      Form1.Query1.SQL.Add('FROM "tab_ready","tab_receipt"');
      Form1.Query1.SQL.Add('WHERE (Kl_potion=:s1) AND (tab_ready.Kl_potion=tab_receipt.Kl_potion)');
      Form1.Query1.ParamByName('s1').AsInteger:=strtoint(Form4.Edit1.Text);
      Form1.Query1.Open;
    end;

  if Form4.Tag=5 then
    begin //Query potion sale by code
      if Form4.Edit1.Text='' then
        begin
          ShowMessage('Enter code potion');
          Form4.Edit1.SetFocus;
          exit;
        end;
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Potion,Sale_amount,Sale_date');
      Form1.Query1.SQL.Add('FROM "tab_ready","tab_sale"');
      Form1.Query1.SQL.Add('WHERE (Kl_potion=:s2) AND (tab_ready.Kl_potion=tab_sale.Kl_potion)');
      Form1.Query1.ParamByName('s2').AsInteger:=strtoint(Form4.Edit1.Text);
      Form1.Query1.Open;
    end;

  if Form4.Tag=6 then
    begin //Query potion list, witch cost higher that value
      if Form4.Edit1.Text='' then
        begin
          ShowMessage('Enter cost potion');
          Form4.Edit1.SetFocus;
          exit;
        end;
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Kl_potion,Potion,Cost');
      Form1.Query1.SQL.Add('FROM "tab_ready","tab_receipt"');
      Form1.Query1.SQL.Add('WHERE (Cost>:s3) AND (tab_ready.Kl_potion=tab_receipt.Kl_potion)');
      Form1.Query1.ParamByName('s3').AsInteger:=strtoint(Form4.Edit1.Text);
      Form1.Query1.Open;
    end;

end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.Show;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin    //Press Cancel
  Form4.Close;
end;

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
   if key=#13 then Form4.Button1.SetFocus;
   if ((form4.Tag=4) and (not (Key in ['0'..'9']))) then
     Key:=#0;
end;

procedure TForm4.FormShow(Sender: TObject);
begin
  if Form4.Tag=1 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='Potion list';
    end;

  if Form4.Tag=2 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='Potion indicated in table delivery';
    end;

  if Form4.Tag=3 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='Potion indicated in table sale';
    end;

  if Form4.Tag=4 then
    begin
      Form4.Edit1.Enabled:=true;
      Form4.Edit1.Text:='';
      Form4.StaticText1.Caption:='Potion delivery by code.'+
      'Enter code potion';
    end;

  if Form4.Tag=5 then
    begin
      Form4.Edit1.Enabled:=true;
      Form4.Edit1.Text:='';
      Form4.StaticText1.Caption:='Potion sale by code.'+
      'Enter code potion';
    end;

  if Form4.Tag=6 then
    begin
      Form4.Edit1.Enabled:=true;
      Form4.Edit1.Text:='';
      Form4.StaticText1.Caption:='Potion list, witch cost higher that value';
    end;

  Form4.DBGrid1.DataSource:=Form1.DataSource4;
  Form1.Hide;
end;

end.
 