unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button3: TButton;
    StaticText1: TStaticText;
    DBGrid1: TDBGrid;
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
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

procedure TForm4.FormShow(Sender: TObject);
begin
  if Form4.Tag=1 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='List of students';
    end;
  if Form4.Tag=2 then
    begin
      Form4.Edit1.Enabled:=true;
      Form4.Edit1.SetFocus;
      Form4.StaticText1.Caption:='Information about student. Enter surname';
    end;
  if Form4.Tag=3 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='List of students of orphans';
    end;
  if Form4.Tag=4 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='Students whose parents work in one place';
    end;
  if Form4.Tag=5 then
    begin
      Form4.Edit1.Enabled:=false;
      Form4.StaticText1.Caption:='Students not living with parents';
    end;
  if Form4.Tag=6 then
    begin
      Form4.Edit1.Enabled:=true;
      Form4.Edit1.SetFocus;
      Form4.StaticText1.Caption:='A list of students who have one parent persioner. Enter the group number';
    end;

  Form4.DBGrid1.DataSource:=Form1.DataSource4;
  Form1.Hide;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form1.Show;
end;

procedure TForm4.Button3Click(Sender: TObject);
begin
  Form4.Close;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
  if Form4.Tag=1 then
    begin //Request a list of students with indication of the surname, group, faculty,
      Form1.Query1.Close;                      //address, phone
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Surname_stud,Gruppa,Fakultet,Adress,PhoneHome');
      Form1.Query1.SQL.Add('FROM "tab_stud"');
      Form1.Query1.Open;
    end;

  if Form4.Tag=2 then
    begin //Information about student on his surname
      if Form4.Edit1.Text='' then
        begin
          ShowMessage('Enter the student last name');
          Form4.Edit1.SetFocus;
          exit;
        end;
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Surname_stud,Gruppa,Fakultet,Adress,PhoneHome');
      Form1.Query1.SQL.Add('FROM "tab_stud"');
      Form1.Query1.SQL.Add('WHERE Surname_stud=:s_stud');
      Form1.Query1.ParamByName('s_stud').AsString:=Form4.Edit1.Text;
      Form1.Query1.Open;
    end;

  if Form4.Tag=3 then
    begin // Requesting a list of students orphans
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Surname_stud');
      Form1.Query1.SQL.Add('FROM "tab_stud"');
      Form1.Query1.SQL.Add('WHERE Surname_stud NOT IN (');
      Form1.Query1.SQL.Add('SELECT Surname_stud');
      Form1.Query1.SQL.Add('FROM "tab_stud","tab_fath","tab_moth"');
      Form1.Query1.SQL.Add('WHERE (tab_stud.Kl_stud=tab_fath.Kl_stud)');
      Form1.Query1.SQL.Add('OR (tab_stud.Kl_stud=tab_moth.Kl_stud))');
      Form1.Query1.Open;
    end;

  if Form4.Tag=4 then
    begin  //Request list of students whose parents are in one place
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Surname_stud, Job_father');
      Form1.Query1.SQL.Add('FROM "tab_stud", "tab_fath", "tab_moth"');
      Form1.Query1.SQL.Add('WHERE (Job_father=Job_mother) AND');
      Form1.Query1.SQL.Add('(tab_stud.kl_stud=tab_fath.Kl_stud AND');
      Form1.Query1.SQL.Add('tab_stud.kl_stud=tab_moth.Kl_stud)');
      Form1.Query1.Open;
    end;

  if Form4.Tag=5 then
    begin  //Request a list of students not living with parents
      Form1.Query1.Close;
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Surname_stud, Adress');
      Form1.Query1.SQL.Add('FROM "tab_stud"');
      Form1.Query1.SQL.Add('WHERE Adress not in (');
      Form1.Query1.SQL.Add('SELECT Adress');
      Form1.Query1.SQL.Add('FROM "tab_stud", "tab_fath", "tab_moth"');
      Form1.Query1.SQL.Add('WHERE ((Adress=Adress_father AND');
      Form1.Query1.SQL.Add('tab_stud.kl_stud=tab_fath.Kl_stud) OR');
      Form1.Query1.SQL.Add('(Adress=Adress_mother AND');
      Form1.Query1.SQL.Add('tab_stud.kl_stud=tab_moth.Kl_stud)))');
      Form1.Query1.Open;
    end;

  if Form4.Tag=6 then
    begin
      if Form4.Edit1.Text='' then
        begin
          ShowMessage('Enter group number');
          Form4.Edit1.SetFocus;
          exit;
        end;               //Request a list of students by group number,
      Form1.Query1.Close;  // in which one parent pensioner
      Form1.Query1.SQL.Clear;
      Form1.Query1.SQL.Add('SELECT Surname_stud');
      Form1.Query1.SQL.Add('FROM "tab_stud"');
      Form1.Query1.SQL.Add('WHERE (Gruppa=:gr) AND (Surname_stud in (');
      Form1.Query1.SQL.Add('SELECT Surname_stud');
      Form1.Query1.SQL.Add('FROM "tab_stud","tab_moth","tab_fath"');
      Form1.Query1.SQL.Add('WHERE ((Age_father > 59) AND(');
      Form1.Query1.SQL.Add('tab_stud.kl_stud=tab_fath.Kl_stud)) OR');
      Form1.Query1.SQL.Add('((Age_mother > 54) AND(');
      Form1.Query1.SQL.Add('tab_stud.kl_stud=tab_moth.Kl_stud))))');
      Form1.Query1.ParamByName('gr').AsString:=Form4.Edit1.Text;
      Form1.Query1.Open;
    end;
end;

procedure TForm4.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then Form4.Button1.SetFocus;
end;

end.
