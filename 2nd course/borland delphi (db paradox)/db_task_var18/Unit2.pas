unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Xpman, Mask, DBCtrls, dbcgrids, db;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Panel1: TPanel;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;
    DBEdit7: TDBEdit;
    Label7: TLabel;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    DBEdit9: TDBEdit;
    Button4: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button4Click(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit5KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit6KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit8KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  av:integer;//Var active PageControl
  bufs:string;
implementation

uses Unit1, Unit5;

{$R *.dfm}

procedure zav;{definition of the active tab PageControl}
begin
  av:=Form1.PageControl1.ActivePageIndex+1;
end;

procedure imp;{Import data DBEdit}
begin
if av=1 then
  begin
    Form2.DBEdit1.datafield:='';
    Form2.DBEdit1.DataSource:=Form1.DataSource1;
    Form2.DBEdit1.DataField:='Surname_stud';
    Form2.Label1.Caption:='Student surname';
    Form2.DBEdit2.datafield:='';
    Form2.DBEdit2.DataSource:=Form1.DataSource1;
    Form2.DBEdit2.DataField:='Fakultet';
    Form2.Label2.Caption:='Faculty';
    Form2.DBEdit3.datafield:='';
    Form2.DBEdit3.DataSource:=Form1.DataSource1;
    Form2.DBEdit3.DataField:='Gruppa';
    Form2.Label3.Caption:='Group';
    Form2.DBEdit4.datafield:='';
    Form2.DBEdit4.DataSource:=Form1.DataSource1;
    Form2.DBEdit4.DataField:='Adress';
    Form2.Label4.Caption:='Address';
    Form2.DBEdit5.datafield:='';
    Form2.DBEdit5.DataSource:=Form1.DataSource1;
    Form2.DBEdit5.DataField:='BirthDay';
    Form2.Label5.Caption:='Date of birth';
    Form2.DBEdit6.Enabled:=true;
    Form2.DBEdit6.datafield:='';
    Form2.DBEdit6.Visible:=true;
    Form2.DBEdit6.DataSource:=Form1.DataSource1;
    Form2.DBEdit6.DataField:='PhoneHome';
    Form2.Label6.Caption:='Phone';
    Form2.DBEdit7.Enabled:=true;
    Form2.DBEdit7.Datafield:='';
    Form2.DBEdit7.Visible:=true;
    Form2.DBEdit7.DataSource:=Form1.DataSource1;
    Form2.DBEdit7.DataField:='Cost';
    Form2.Label7.Caption:='Cost of training(per year)';
    Form2.DBEdit8.Enabled:=true;
    Form2.DBEdit8.Datafield:='';
    Form2.DBEdit8.Visible:=true;
    Form2.DBEdit8.DataSource:=Form1.DataSource1;
    Form2.DBEdit8.DataField:='Kurs_stud';
    Form2.Label8.Caption:='Course';
    Form2.DBEdit9.Visible:=false;
    Form2.DBEdit9.Enabled:=false;
    Form2.Button4.Visible:=false;
  end;
if av=2 then
  begin
    Form2.DBEdit1.datafield:='';
    Form2.DBEdit1.DataSource:=Form1.DataSource2;
    Form2.DBEdit1.DataField:='Surname_father';
    Form2.Label1.Caption:='Surname father of student';
    Form2.DBEdit2.datafield:='';
    Form2.DBEdit2.DataSource:=Form1.DataSource2;
    Form2.DBEdit2.DataField:='Age_father';
    Form2.Label2.Caption:='Age father';
    Form2.DBEdit3.datafield:='';
    Form2.DBEdit3.DataSource:=Form1.DataSource2;
    Form2.DBEdit3.DataField:='Job_father';
    Form2.Label3.Caption:='Place of work';
    Form2.DBEdit4.datafield:='';
    Form2.DBEdit4.DataSource:=Form1.DataSource2;
    Form2.DBEdit4.DataField:='Phone_father';
    Form2.Label4.Caption:='Phone';
    Form2.DBEdit5.Datafield:='';
    Form2.DBEdit5.DataSource:=Form1.DataSource2;
    Form2.DBEdit5.DataField:='Adress_father';
    Form2.Label5.Caption:='Address';
    Form2.DBEdit6.Visible:=false;
    Form2.DBEdit6.Enabled:=false;
    Form2.Label6.Caption:='';
    Form2.DBEdit7.Visible:=false;
    Form2.DBEdit7.Enabled:=false;
    Form2.Label7.Caption:='';
    Form2.DBEdit8.Visible:=false;
    Form2.DBEdit8.Enabled:=false;
    Form2.Label8.Caption:='';
    Form2.DBEdit9.Enabled:=true;
    Form2.DBEdit9.Datafield:='';
    Form2.DBEdit9.Visible:=true;
    Form2.DBEdit9.DataSource:=Form1.DataSource2;
    Form2.DBEdit9.DataField:='Kl_stud';
    Form2.Button4.Visible:=true;
  end;
if av=3 then
  begin
    Form2.DBEdit1.datafield:='';
    Form2.DBEdit1.DataSource:=Form1.DataSource3;
    Form2.DBEdit1.DataField:='Surname_mother';
    Form2.Label1.Caption:='Surname mother of student';
    Form2.DBEdit2.datafield:='';
    Form2.DBEdit2.DataSource:=Form1.DataSource3;
    Form2.DBEdit2.DataField:='Age_mother';
    Form2.Label2.Caption:='Age mother';
    Form2.DBEdit3.datafield:='';
    Form2.DBEdit3.DataSource:=Form1.DataSource3;
    Form2.DBEdit3.DataField:='Job_mother';
    Form2.Label3.Caption:='Place of work';
    Form2.DBEdit4.datafield:='';
    Form2.DBEdit4.DataSource:=Form1.DataSource3;
    Form2.DBEdit4.DataField:='Phone_mother';
    Form2.Label4.Caption:='Phone';
    Form2.DBEdit5.DataField:='';
    Form2.DBEdit5.DataSource:=Form1.DataSource3;
    Form2.DBEdit5.DataField:='Adress_mother';
    Form2.Label5.Caption:='Address';
    Form2.DBEdit6.Visible:=false;
    Form2.DBEdit6.Enabled:=false;
    Form2.Label6.Caption:='';
    Form2.DBEdit7.Visible:=false;
    Form2.DBEdit7.Enabled:=false;
    Form2.Label7.Caption:='';
    Form2.DBEdit8.Visible:=false;
    Form2.DBEdit8.Enabled:=false;
    Form2.Label8.Caption:='';
    Form2.DBEdit9.Enabled:=true;
    Form2.DBEdit9.Datafield:='';
    Form2.DBEdit9.Visible:=true;
    Form2.DBEdit9.DataSource:=Form1.DataSource3;
    Form2.DBEdit9.DataField:='Kl_stud';
    Form2.Button4.Visible:=true;
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

function pr_st:boolean;
begin   //check 
  if av=2 then
    begin
      result:=false;
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT tab_fath.Kl_stud');
      Form1.Query1.SQL.Add('FROM "tab_fath"');
      Form1.Query1.SQL.Add('WHERE tab_fath.Kl_stud=:temp');
      Form1.Query1.ParamByName('temp').AsInteger:=strtoint(Form2.DBEdit9.Text);
      Form1.Query1.Open;
      if Form1.Query1.RecordCount <> 0 then result:=true;
      if (Form1.Query1.RecordCount = 1) and
        (form2.DBEdit9.Text=inttostr(Form2.DBEdit9.Tag)) then
          result:=false;
    end;
  if av=3 then
    begin
      result:=false;
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT tab_moth.Kl_stud');
      Form1.Query1.SQL.Add('FROM "tab_moth"');
      Form1.Query1.SQL.Add('WHERE tab_moth.Kl_stud=:temp');
      Form1.Query1.ParamByName('temp').AsInteger:=strtoint(Form2.DBEdit9.Text);
      Form1.Query1.Open;
      if Form1.Query1.RecordCount <> 0 then result:=true;
      if (Form1.Query1.RecordCount = 1) and
        (form2.DBEdit9.Text=inttostr(Form2.DBEdit9.Tag)) then
          result:=false;
    end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin  //Conclusion of data in an editing form
  zav;   //find active PageControl
  if Form2.Tag=1 then
    begin
      if av=1 then Form1.Table1.Edit;
      if av=2 then Form1.Table2.Edit;
      if av=3 then Form1.Table3.Edit;
      imp;  //Impopt data in DBEdit

    end;
  if Form2.Tag=2 then
    begin
      if av=1 then Form1.Table1.Append;
      if av=2 then Form1.Table2.Append;
      if av=3 then Form1.Table3.Append;
      imp;  //Impopt data in DBEdit

    end;
  if Form2.Tag=3 then
    begin
      if av=1 then Form1.Table1.Insert;
      if av=2 then Form1.Table2.Insert;
      if av=3 then Form1.Table3.Insert;
      imp;  //Impopt data in DBEdit
    end;
  Form2.DBEdit9.Tag:=-1;
  if (av=2) and (form1.Table2['kl_stud']<>null)
    then Form2.DBEdit9.Tag:=form1.Table2['kl_stud'];
  if (av=3) and (form1.Table3['kl_stud']<>null)
    then Form2.DBEdit9.Tag:=form1.Table3['kl_stud'];
  Form1.Hide;
  Form2.DBEdit1.SetFocus;
end;


procedure TForm2.Button1Click(Sender: TObject);
begin //Press "Save"
  if av=1 then
    begin
      Form2.Close;
      rsav;
    end;
  if ((Form1.Table2.FieldByName('Kl_stud').IsNull) and (av=2)) or
    ((Form1.Table3.FieldByName('Kl_stud').IsNull) and (av=3)) then
      begin
        Form2.Close;
        rsav;
      end else if (av=2) or (av=3) then
        begin
          if (pr_st=false) then
          begin
            Form2.Close;
            rsav;
          end else
            begin
              if av=2 then
                showmessage('In this students father has already been selected!!!!');
              if av=3 then
                showmessage('In this students mother is already selected!!!!');
            end;
        end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin   //Press "Cancel"
  rcan; //Cancel change fields
  Form2.Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Form2.BorderIcons:=[biMinimize,biMaximize];
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Show;
end;




procedure TForm2.Button4Click(Sender: TObject);
begin  //Press "Select student"
  Form5.Show;
  if av=2 then Form5.Tag:=0;
  if av=3 then Form5.Tag:=1;
end;

procedure TForm2.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit2.SetFocus;
end;

procedure TForm2.DBEdit2KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit3.SetFocus;
end;

procedure TForm2.DBEdit3KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit4.SetFocus;
end;

procedure TForm2.DBEdit4KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit5.SetFocus;
end;

procedure TForm2.DBEdit5KeyPress(Sender: TObject; var Key: Char);
begin
if (key=#13) and ((av=2) or (av=3)) then Form2.Button4.SetFocus
  else
    if key=#13 then Form2.DBEdit6.SetFocus;
end;

procedure TForm2.DBEdit6KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit7.SetFocus;
end;

procedure TForm2.DBEdit7KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.DBEdit8.SetFocus;
end;

procedure TForm2.DBEdit8KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form2.Button1.SetFocus;
end;

end.
