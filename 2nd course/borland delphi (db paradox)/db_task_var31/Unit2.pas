unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XpMan, StdCtrls, ExtCtrls, Mask, DBCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  av:integer;// Active PageControl

implementation

uses Unit1, Unit5;

{$R *.dfm}

procedure zav;{Active PageControl}
begin
  av:=Form1.PageControl1.ActivePageIndex+1;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Form2.BorderIcons:=[biMinimize,biMaximize];
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Show;
end;

procedure imp;{Impopt storage in DBEdit}
begin
if av=1 then
  begin
    Form2.DBEdit1.datafield:='';
    Form2.DBEdit1.DataSource:=Form1.DataSource1;
    Form2.DBEdit1.DataField:='Potion';
    Form2.Label1.Caption:='Potion';
    Form2.DBEdit2.datafield:='';
    Form2.DBEdit2.DataSource:=Form1.DataSource1;
    Form2.DBEdit2.DataField:='Term_realization';
    Form2.Label2.Caption:='Implementation period';
    Form2.DBEdit3.datafield:='';
    Form2.DBEdit3.DataSource:=Form1.DataSource1;
    Form2.DBEdit3.DataField:='Kl_potion';
    Form2.Label3.Caption:='Potion code';
    Form2.DBEdit4.Visible:=false;
    Form2.DBEdit4.Enabled:=false;
    Form2.Label4.Caption:='';
    Form2.Button3.Visible:=false;
  end;
if av=2 then
  begin
    Form2.DBEdit1.datafield:='';
    Form2.DBEdit1.DataSource:=Form1.DataSource2;
    Form2.DBEdit1.DataField:='Cost';
    Form2.Label1.Caption:='Cost';
    Form2.DBEdit2.datafield:='';
    Form2.DBEdit2.DataSource:=Form1.DataSource2;
    Form2.DBEdit2.DataField:='Receipt_amount';
    Form2.Label2.Caption:='Amount';
    Form2.DBEdit3.datafield:='';
    Form2.DBEdit3.DataSource:=Form1.DataSource2;
    Form2.DBEdit3.DataField:='Receipt_date';
    Form2.Label3.Caption:='Date of receipt';
    Form2.DBEdit4.Enabled:=true;
    Form2.DBEdit4.Datafield:='';
    Form2.DBEdit4.Visible:=true;
    Form2.DBEdit4.DataSource:=Form1.DataSource2;
    Form2.DBEdit4.DataField:='Kl_potion';
    Form2.Label4.Caption:='Potion code';
    Form2.Button3.Visible:=true;
  end;
if av=3 then
  begin
    Form2.DBEdit1.datafield:='';
    Form2.DBEdit1.DataSource:=Form1.DataSource3;
    Form2.DBEdit1.DataField:='Sale_amount';
    Form2.Label1.Caption:='Number of sold potion';
    Form2.DBEdit2.datafield:='';
    Form2.DBEdit2.DataSource:=Form1.DataSource3;
    Form2.DBEdit2.DataField:='Sale_date';
    Form2.Label2.Caption:='Date of sale';
    Form2.DBEdit3.datafield:='';
    Form2.DBEdit3.DataSource:=Form1.DataSource3;
    Form2.DBEdit3.DataField:='Kl_potion';
    Form2.Label3.Caption:='Potion code';
    Form2.DBEdit4.Visible:=false;
    Form2.DBEdit4.Enabled:=false;
    Form2.Label4.Caption:='';
    Form2.Button3.Visible:=true;
  end;
end;


procedure rcan;{Cancel change field}
begin
  if av=1 then Form1.Table1.Cancel;
  if av=2 then Form1.Table2.Cancel;
  if av=3 then Form1.Table3.Cancel;
end;

procedure rsav;{Save change field}
begin
  if av=1 then Form1.Table1.Post;
  if av=2 then Form1.Table2.Post;
  if av=3 then Form1.Table3.Post;
end;


procedure TForm2.Button2Click(Sender: TObject);
begin      // Press Cancel
  rcan; //Cancel change field
  Form2.Close;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  zav;
  if Form2.Tag=1 then
    begin
      if av=1 then Form1.Table1.Edit;
      if av=2 then Form1.Table2.Edit;
      if av=3 then Form1.Table3.Edit;
      imp;

    end;
  if Form2.Tag=2 then
    begin
      if av=1 then Form1.Table1.Append;
      if av=2 then Form1.Table2.Append;
      if av=3 then Form1.Table3.Append;
      imp;

    end;
  if Form2.Tag=3 then
    begin
      if av=1 then Form1.Table1.Insert;
      if av=2 then Form1.Table2.Insert;
      if av=3 then Form1.Table3.Insert;
      imp;
    end;
  Form1.Hide;
  Form2.DBEdit1.SetFocus;
end;


procedure TForm2.Button3Click(Sender: TObject);
begin // Press Change potion
  Form5.Show;
  if av=2 then Form5.Tag:=0;
  if av=3 then Form5.Tag:=1;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin   //Press save
  if av=1 then
    begin
      Form2.Close;
      rsav;
      exit;
    end;
  if ((Form1.Table2.FieldByName('Kl_potion').IsNull) and (av=2)) or
    ((Form1.Table3.FieldByName('Kl_potion').IsNull) and (av=3)) then
      begin
        showmessage('Do not select potion!');
        Form2.Button3.SetFocus;
      end else
        begin
          Form2.Close;
          rsav;
        end;
end;

procedure TForm2.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit2.SetFocus;
end;

procedure TForm2.DBEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if ((av=3) and (not (Key in ['0'..'9', #13,'.',#8]))) then
        Key:=#0;
if ((key=#13) and (av=2)) then Form2.DBEdit3.SetFocus
  else if key=#13 then Form2.Button1.SetFocus;
end;

procedure TForm2.DBEdit3KeyPress(Sender: TObject; var Key: Char);
begin
  if ((av=2) and (not (Key in ['0'..'9', #13,'.',#8]))) then
        Key:=#0;
if ((key=#13) and ((av=2) or (av=3))) then Form2.Button1.SetFocus;
end;

end.
