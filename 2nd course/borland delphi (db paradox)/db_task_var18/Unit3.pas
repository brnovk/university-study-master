unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DBtables, db, Xpman;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    LabeledEdit1: TLabeledEdit;
    Button1: TButton;
    BitBtn1: TBitBtn;
    CheckBox1: TCheckBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
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
    end;
end;


procedure TForm3.BitBtn1Click(Sender: TObject);
begin    //Press "Exit"
Form3.Close;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin    //Press "Search"
  if Form3.LabeledEdit1.Text=''then
    begin
      Messagedlg('Enter a search parameter',mtconfirmation,[mbOk],0);
      Form3.LabeledEdit1.SetFocus;
      Exit;
    end;
  if Form3.Tag=10 then
    begin
      fn:='Kl_stud';
      pf;
      if (Form1.Table1.Locate('Kl_stud',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=11 then
    begin
      fn:='Surname_stud';
      pf;
      if (Form1.Table1.Locate('Surname_stud',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=12 then
    begin
      fn:='Adress';
      pf;
      if (Form1.Table1.Locate('Adress',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=13 then
    begin
      fn:='BirthDay';
      pf;
      if length(Form3.LabeledEdit1.Text)=10 then
        begin
          if (Form3.LabeledEdit1.Text[3]='.') and
            (Form3.LabeledEdit1.Text[6]='.') then
               begin
                 if (Form1.Table1.Locate('BirthDay',Form3.LabeledEdit1.Text,[]))=true then
                   Form3.Close else
                     Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
               end else
                 showmessage('Wrong date entered!! Example input: 14.01.2010');
        end else showmessage('Wrong date entered!! Example input: 14.01.2010');
    end;
  if Form3.Tag=14 then
    begin
      fn:='PhoneHome';
      pf;
      if (Form1.Table1.Locate('PhoneHome',strtodate(Form3.LabeledEdit1.Text),[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=21 then
    begin
      fn:='Surname_father';
      pf;
      if (Form1.Table2.Locate('Surname_father',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=22 then
    begin
      fn:='Adress_father';
      pf;
      if (Form1.Table2.Locate('Adress_father',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=31 then
    begin
      fn:='Surname_mother';
      pf;
      if (Form1.Table3.Locate('Surname_mother',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
  if Form3.Tag=32 then
    begin
      fn:='Adress_mother';
      pf;
      if (Form1.Table3.Locate('Adress_mother',Form3.LabeledEdit1.Text,[]))=true then
        Form3.Close else
          Messagedlg('There is no such entry',mtconfirmation,[mbOk],0);
    end;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin   //Form closing
  Form3.LabeledEdit1.Text:='';
  Form3.LabeledEdit1.EditLabel.Caption:='';
  Form3.CheckBox1.Checked:=false;
  Form1.Show;
end;

procedure TForm3.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
begin   //Press Enter in Edit
  if (Form3.Tag=10) then
      if not (Key in ['0'..'9', #13, #8]) then
        Key:=#0;
  if key=#13 then Form3.Button1.Click;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  Form1.Hide;
end;

end.
