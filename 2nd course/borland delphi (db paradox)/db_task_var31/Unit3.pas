unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XpMan, StdCtrls, Buttons, ExtCtrls;

type
  TForm3 = class(TForm)
    LabeledEdit1: TLabeledEdit;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  fn:string;

implementation

uses Unit1;

{$R *.dfm}

procedure pf;(*Filter processing*)
begin
  if Form3.CheckBox1.Checked=true then
    begin
      if (Form3.Tag=(10)) or (Form3.Tag=(11)) or (Form3.Tag=(12)) or (Form3.Tag=(13)) or (Form3.Tag=(14)) then
        begin
          Form1.Table1.Filtered:=true;
          Form1.Table1.Filter:=fn+' = '''+Form3.LabeledEdit1.Text+'''';
        end;
      if (Form3.Tag=(21)) or (Form3.Tag=(22)) then
        begin
          Form1.Table2.Filtered:=true;
          Form1.Table2.Filter:=fn+' = '''+Form3.LabeledEdit1.Text+'''';
        end;
      if (Form3.Tag=(31)) or (Form3.Tag=(32)) then
        begin
          Form1.Table3.Filtered:=true;
          Form1.Table3.Filter:=fn+' = '''+Form3.LabeledEdit1.Text+'''';
        end;
      Form1.N31.Visible:=true;
    end;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form3.LabeledEdit1.Text:='';
  Form3.LabeledEdit1.EditLabel.Caption:='';
  Form3.CheckBox1.Checked:=false;
  Form1.Show;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin   //Press search
  if Form3.LabeledEdit1.Text=''then
    begin
      Messagedlg('Enter the search parameter',mtconfirmation,[mbOk],0);
      Form3.LabeledEdit1.SetFocus;
      Exit;
    end;
  if Form3.Tag=10 then
    begin
      fn:='Kl_potion';
      pf;
      if (Form1.Table1.Locate('Kl_potion',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('No such record',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=11 then
    begin
      fn:='Potion';
      pf;
      if (Form1.Table1.Locate('Potion',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('No such record',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=12 then
    begin
      fn:='Term_realization';
      pf;
      if (Form1.Table1.Locate('Term_realization',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('No such record',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=21 then
    begin
      fn:='Cost';
      pf;
      if (Form1.Table2.Locate('Cost',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('No such record',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=22 then
    begin
      fn:='Receipt_amount';
      pf;
      if (Form1.Table2.Locate('Receipt_amount',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('No such record',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=23 then
    begin
      fn:='Receipt_date';
      pf;
      if length(Form3.LabeledEdit1.Text)=10 then
        begin
          if (Form3.LabeledEdit1.Text[3]='.') and
            (Form3.LabeledEdit1.Text[6]='.') then
               begin
                 if (Form1.Table2.Locate('Receipt_date',Form3.LabeledEdit1.Text,[]))=true then
                   Form3.Close else
                     Messagedlg('No such record',mtconfirmation,[mbOk],0);
               end else
                 showmessage('Invalid date!! Example input: 14.01.2010');
        end else showmessage('Invalid date!! Example input: 14.01.2010');
    end;
  if Form3.Tag=31 then
    begin
      fn:='Sale_amount';
      pf;
      if (Form1.Table3.Locate('Sale_amount',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('No such record',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=32 then
    begin
      fn:='Sale_date';
      pf;
      if length(Form3.LabeledEdit1.Text)=10 then
        begin
          if (Form3.LabeledEdit1.Text[3]='.') and
            (Form3.LabeledEdit1.Text[6]='.') then
               begin
                 if (Form1.Table3.Locate('Sale_date',Form3.LabeledEdit1.Text,[]))=true then
                   Form3.Close else
                     Messagedlg('No such record',mtconfirmation,[mbOk],0);
               end else
                 showmessage('Invalid date!! Example input: 14.01.2010');
        end else showmessage('Invalid date!! Example input: 14.01.2010');
    end;

end;

procedure TForm3.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin  //input field
  if (Form3.Tag=10) then
      if not (Key in ['0'..'9', #13, #8]) then
        Key:=#0;

  if ((Form3.Tag=23) or (Form3.Tag=32)) then
      if not (Key in ['0'..'9', #13,'.',#8]) then
        Key:=#0;
  if key=#13 then Form3.Button1.Click;

end;

end.
