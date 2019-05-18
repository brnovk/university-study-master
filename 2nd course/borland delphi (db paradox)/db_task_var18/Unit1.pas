unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Xpman, ComCtrls, DB, Grids, DBGrids, DBTables, StdCtrls,
  ExtCtrls, DBCtrls, DateUtils, Menus, RpCon, RpConDS, RpDefine, RpRave;

type
  TForm1 = class(TForm)
    Table1: TTable;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Table2: TTable;
    Table3: TTable;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    DBGrid2: TDBGrid;
    TabSheet3: TTabSheet;
    DBGrid3: TDBGrid;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    Button6: TButton;
    Table1Kl_stud: TAutoIncField;
    Table1Surname_stud: TStringField;
    Table1Fakultet: TStringField;
    Table1Gruppa: TStringField;
    Table1Adress: TStringField;
    Table1BirthDay: TDateField;
    Table1PhoneHome: TStringField;
    Table1Kurs_stud: TSmallintField;
    Table1Cost: TCurrencyField;
    Table2Kl_stud: TIntegerField;
    Table2Surname_father: TStringField;
    Table2Age_father: TSmallintField;
    Table2Job_father: TStringField;
    Table2Phone_father: TStringField;
    Table2Adress_father: TStringField;
    Table3Kl_stud: TIntegerField;
    Table3Surname_mother: TStringField;
    Table3Age_mother: TSmallintField;
    Table3Job_mother: TStringField;
    Table3Phone_mother: TStringField;
    Table3Adress_mother: TStringField;
    Table1Amount: TCurrencyField;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N33: TMenuItem;
    RvProject1: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    Query1: TQuery;
    DataSource4: TDataSource;
    N32: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Table1CalcFields(DataSet: TDataSet);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure N43Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

procedure russian_z;
begin    //Change header DBGrid
  Form1.DBGrid1.Columns[0].Title.Caption:='Student code';
  Form1.DBGrid1.Columns[1].Title.Caption:='Surname student';
  Form1.DBGrid1.Columns[2].Title.Caption:='Faculty';
  Form1.DBGrid1.Columns[3].Title.Caption:='Group';
  Form1.DBGrid1.Columns[4].Title.Caption:='Address';
  Form1.DBGrid1.Columns[5].Title.Caption:='Date of Birth';
  Form1.DBGrid1.Columns[6].Title.Caption:='Phone';
  Form1.DBGrid1.Columns[7].Title.Caption:='Course';
  Form1.DBGrid1.Columns[8].Title.Caption:='Price of training';
  Form1.DBGrid1.Columns[9].Title.Caption:='Amount of the tuition fees';

  Form1.DBGrid2.Columns[0].Title.Caption:='Student code';
  Form1.DBGrid2.Columns[1].Title.Caption:='Surname father';
  Form1.DBGrid2.Columns[2].Title.Caption:='Age father';
  Form1.DBGrid2.Columns[3].Title.Caption:='Place of work father';
  Form1.DBGrid2.Columns[4].Title.Caption:='Phone';
  Form1.DBGrid2.Columns[5].Title.Caption:='Home address';

  Form1.DBGrid3.Columns[0].Title.Caption:='Student code';
  Form1.DBGrid3.Columns[1].Title.Caption:='Surname mother';
  Form1.DBGrid3.Columns[2].Title.Caption:='Age mother';
  Form1.DBGrid3.Columns[3].Title.Caption:='Place of work mother';
  Form1.DBGrid3.Columns[4].Title.Caption:='Phone';
  Form1.DBGrid3.Columns[5].Title.Caption:='Home address';
end;

procedure TForm1.FormCreate(Sender: TObject);
begin    {Created form}
    //Connection table "Student"
  Form1.DataSource1.DataSet:=Form1.Table1;
  Form1.Table1.TableName:='tab_stud.DB';
  Form1.Table1.Active:=true;
  Form1.DBGrid1.DataSource:=Form1.DataSource1;

    //Connection table "Father"
  Form1.DataSource2.DataSet:=Form1.Table2;
  Form1.Table2.TableName:='tab_fath.DB';
  Form1.Table2.Active:=true;
  Form1.DBGrid2.DataSource:=Form1.DataSource2;

    //Connection table "Mother"
  Form1.DataSource3.DataSet:=Form1.Table3;
  Form1.Table3.TableName:='tab_moth.DB';
  Form1.Table3.Active:=true;
  Form1.DBGrid3.DataSource:=Form1.DataSource3;

    //Connection query
  Form1.DataSource4.DataSet:=Form1.Query1;

  russian_z;
end;


function Insp_null_field:boolean;
begin
  result:=false;
  if (Form1.PageControl1.ActivePageIndex+1)=1 then
    if Form1.Table1.FieldByName('Kl_stud').IsNull=true then
        result:=true;
end;

procedure prnav;
  begin //linking DBNavigator to the desired DataSource
    if Form1.PageControl1.ActivePageIndex=0 then
      Form1.DBNavigator1.DataSource:=Form1.DataSource1;
    if Form1.PageControl1.ActivePageIndex=1 then
      Form1.DBNavigator1.DataSource:=Form1.DataSource2;
    if Form1.PageControl1.ActivePageIndex=2 then
      Form1.DBNavigator1.DataSource:=Form1.DataSource3;
  end;
procedure TForm1.Button1Click(Sender: TObject);
begin  //Press "Change"
  if Insp_null_field=true then
    showmessage('Not record for change!!')
  else
  begin
    Form2.Tag:=1;
    Form2.show;
  end;
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
  prnav;  //linking DBNavigator to the desired DataSource
end;


procedure TForm1.Button2Click(Sender: TObject);
begin     //Press "Add"
  Form2.Tag:=2;
  Form2.Show;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin     //Press "Delete"
  if Insp_null_field=true then
    showmessage('Not record for delete!!')
  else
  begin
    if (Form1.PageControl1.ActivePageIndex+1)=1 then
      if Form1.Table1.State=dsBrowse then
        if Messagedlg('Are you sure you want to delete this record?',mtconfirmation,[mbNo,mbYes],0)=mrYes then
          Form1.Table1.Delete;
    if (Form1.PageControl1.ActivePageIndex+1)=2 then
      if Form1.Table2.State=dsBrowse then
        if Messagedlg('Are you sure you want to delete this record?',mtconfirmation,[mbNo,mbYes],0)=mrYes then
          Form1.Table2.Delete;
    if (Form1.PageControl1.ActivePageIndex+1)=3 then
      if Form1.Table3.State=dsBrowse then
        if Messagedlg('Are you sure you want to delete this record?',mtconfirmation,[mbNo,mbYes],0)=mrYes then
          Form1.Table3.Delete;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin     //Press "Insert"
  Form2.Tag:=3;
  Form2.show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  Form1.Close;
end;


procedure TForm1.Button6Click(Sender: TObject);
begin
   ShowMessage('Today = '+DateToStr(Date));
end;



procedure TForm1.FormShow(Sender: TObject);
begin
Form2.Hide;
Form3.Hide;
Form4.Hide;
end;

procedure TForm1.Table1CalcFields(DataSet: TDataSet);
begin     {Event calculate fields}
  Form1.Table1.FieldByName('Amount').Value:=
    Form1.Table1.FieldByName('Kurs_stud').Value*
    Form1.Table1.FieldByName('Cost').Value;
end;

procedure TForm1.N4Click(Sender: TObject);
begin  //"Edit record" in Main Menu
  Form1.Button1.Click;
end;

procedure TForm1.N5Click(Sender: TObject);
begin  //"Add rerord" in Main Menu
  Form1.Button2.Click;
end;

procedure TForm1.N6Click(Sender: TObject);
begin  //"Delete rerord" in Main Menu
  Form1.Button3.Click;
end;

procedure TForm1.N7Click(Sender: TObject);
begin  //"Insert rerord" in Main Menu
  Form1.Button4.Click;
end;

procedure TForm1.N10Click(Sender: TObject);
begin  //"Exit" in Main Menu
  Form1.Button5.Click;
end;

procedure TForm1.N15Click(Sender: TObject);
begin  //"students Table" in Main Menu
  Form1.PageControl1.ActivePageIndex:=0;
end;

procedure TForm1.N16Click(Sender: TObject);
begin  //"Table fathers" in Main Menu
  Form1.PageControl1.ActivePageIndex:=1;
end;

procedure TForm1.N17Click(Sender: TObject);
begin  //"mothers Table" in Main Menu
  Form1.PageControl1.ActivePageIndex:=2;
end;

procedure TForm1.N14Click(Sender: TObject);
begin  //"Search" -> "students table" -> "student surname"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=11;
  Form3.LabeledEdit1.EditLabel.Caption:='student surname';
  Form3.Show;
end;

procedure TForm1.N18Click(Sender: TObject);
begin  //"Search" -> "students table" -> "Student address"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=12;
  Form3.LabeledEdit1.EditLabel.Caption:='Student address';
  Form3.Show;
end;

procedure TForm1.N19Click(Sender: TObject);
begin  //"Search" -> "students table" -> "Date of Birth"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=13;
  Form3.LabeledEdit1.EditLabel.Caption:='Date of Birth(**.**.****)';
  Form3.Show;
end;

procedure TForm1.N20Click(Sender: TObject);
begin  //"Search" -> "students table" -> "Phone"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=14;
  Form3.LabeledEdit1.EditLabel.Caption:='Phone';
  Form3.Show;
end;

procedure TForm1.N21Click(Sender: TObject);
begin  //"Search" -> "Fathers table" -> "Fathers surname"
  Form1.PageControl1.ActivePageIndex:=1;
  Form3.Tag:=21;
  Form3.LabeledEdit1.EditLabel.Caption:='Fathers surname';
  Form3.Show;
end;

procedure TForm1.N22Click(Sender: TObject);
begin  //"Search" -> "Fathers table" -> "Fathers address"
  Form1.PageControl1.ActivePageIndex:=1;
  Form3.Tag:=22;
  Form3.LabeledEdit1.EditLabel.Caption:='Fathers address';
  Form3.Show;
end;

procedure TForm1.N23Click(Sender: TObject);
begin  //"Search" -> "Fathers table" -> "Place of work"
  Form1.PageControl1.ActivePageIndex:=1;
  Form3.Tag:=23;
  Form3.LabeledEdit1.EditLabel.Caption:='Place of work';
  Form3.Show;
end;

procedure TForm1.N24Click(Sender: TObject);
begin  //"Search" -> "Mothers table" -> "Mothers surname"
  Form1.PageControl1.ActivePageIndex:=2;
  Form3.Tag:=31;
  Form3.LabeledEdit1.EditLabel.Caption:='Mothers surname';
  Form3.Show;
end;

procedure TForm1.N25Click(Sender: TObject);
begin  //"Search" -> "Mothers table" -> "Mothers address"
  Form1.PageControl1.ActivePageIndex:=2;
  Form3.Tag:=32;
  Form3.LabeledEdit1.EditLabel.Caption:='Mothers address';
  Form3.Show;
end;

procedure TForm1.N26Click(Sender: TObject);
begin  //"Search" -> "Mothers table" -> "Place of work"
  Form1.PageControl1.ActivePageIndex:=2;
  Form3.Tag:=33;
  Form3.LabeledEdit1.EditLabel.Caption:='Place of work';
  Form3.Show;
end;

procedure TForm1.N27Click(Sender: TObject);
begin  //"Search" -> "students table" -> "student code"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=10;
  Form3.LabeledEdit1.EditLabel.Caption:='Student code';
  Form3.Show;
end;

procedure TForm1.N29Click(Sender: TObject);
begin  //Sorting -> student code (ascending)
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.IndexFieldNames:='Kl_stud';
end;

procedure TForm1.N30Click(Sender: TObject);
begin  //Sorting -> student code (descending)
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.Active:=false;
  Form1.Table1.Exclusive:=true;
  Form1.Table1.AddIndex('Kl_stud_in','Kl_stud',[ixunique,ixdescending]);
  Form1.Table1.Exclusive:=false;
  Form1.Table1.IndexName:='Kl_stud_in';
  Form1.Table1.Active:=true;
end;

procedure TForm1.N31Click(Sender: TObject);
begin   //Sorting -> groups
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.IndexName:='Gruppa';
end;

procedure TForm1.N33Click(Sender: TObject);
begin    //Sorting -> Student surname (descending)
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.Active:=false;
  Form1.Table1.Exclusive:=true;
  Form1.Table1.AddIndex('Surname_d','Surname_stud',[ixdescending]);
  Form1.Table1.Exclusive:=false;
  Form1.Table1.IndexName:='Surname_d';
  Form1.Table1.Active:=true;
end;

procedure TForm1.N32Click(Sender: TObject);
begin   //Report -> List of students(Surname, course, group, faculty)
  Form1.RvProject1.Close;
  Form1.RvDataSetConnection1.DataSet:=Form1.Table1;
  Form1.RvProject1.ProjectFile:=ExtractFilePath(Application.ExeName)+'spis_stud.rav';
  Form1.RvProject1.Execute;
end;

procedure TForm1.N35Click(Sender: TObject);
begin   //Query -> Students list
  Form4.Tag:=1;
  Form4.Show;
end;

procedure TForm1.N36Click(Sender: TObject);
begin   //Query -> Information about student
  Form4.Tag:=2;
  Form4.Show;
end;

procedure TForm1.N37Click(Sender: TObject);
begin   //Query -> List of students of orphans
  Form4.Tag:=3;
  Form4.Show;
end;

procedure TForm1.N38Click(Sender: TObject);
begin   //Query -> Students whose parents work in one place
  Form4.Tag:=4;
  Form4.Show;
end;

procedure TForm1.N39Click(Sender: TObject);
begin   //Query -> Students who do not live with their parents
  Form4.Tag:=5;
  Form4.Show;
end;

procedure TForm1.N40Click(Sender: TObject);
begin  //Query -> Students who have one parent pensioner
  Form4.Tag:=6;
  Form4.Show;
end;

procedure TForm1.N41Click(Sender: TObject);
begin  //Report -> Students into groups
  Form1.RvProject1.Close;
  Form1.Query1.SQL.Clear;
  Form1.Query1.SQL.Add('SELECT Surname_stud, Gruppa, Kurs_stud, Cost');
  Form1.Query1.SQL.Add('FROM "tab_stud"');
  Form1.Query1.SQL.Add('GROUP BY Gruppa, Surname_stud, Kurs_stud, Cost');
  Form1.Query1.SQL.Add('');
  Form1.RvDataSetConnection1.DataSet:=Form1.Query1;
  Form1.RvProject1.ProjectFile:=ExtractFilePath(Application.ExeName)+'spis_gr.rav';
  Form1.RvProject1.Execute;
end;

procedure TForm1.N42Click(Sender: TObject);
begin   //Report -> Students into faculties
  Form1.RvProject1.Close;
  Form1.Query1.SQL.Clear;
  Form1.Query1.SQL.Add('SELECT Surname_stud, Fakultet, Kurs_stud, Gruppa, Cost, AVG(Cost)');
  Form1.Query1.SQL.Add('FROM "tab_stud"');
  Form1.Query1.SQL.Add('GROUP BY Fakultet, Surname_stud, Kurs_stud, Gruppa, Cost');
  Form1.RvDataSetConnection1.DataSet:=Form1.Query1;
  Form1.RvProject1.ProjectFile:=ExtractFilePath(Application.ExeName)+'spis_fak1.rav';
  Form1.RvProject1.Execute;
end;

procedure TForm1.N43Click(Sender: TObject);
begin    //About 
showmessage('Var 18;'+#13+'Database: "Parents of students";'
  +#13+'Developed: student group POIT-21'
    +#13+'Baranov V.');
end;

procedure TForm1.N44Click(Sender: TObject);
begin   //Reset filter
  if (Form1.PageControl1.ActivePageIndex=0) and
    (Form1.Table1.Filtered=true) then
      Form1.Table1.Filtered:=false;
  if (Form1.PageControl1.ActivePageIndex=1) and
    (Form1.Table2.Filtered=true) then
      Form1.Table2.Filtered:=false;
  if (Form1.PageControl1.ActivePageIndex=2) and
    (Form1.Table3.Filtered=true) then
      Form1.Table3.Filtered:=false;
end;

end.
