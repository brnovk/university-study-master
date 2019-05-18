unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DB, DBTables, Menus, DBCtrls, StdCtrls, XpMan, Grids,
  DBGrids, ComCtrls, RpCon, RpConDS, RpDefine, RpRave;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Table1: TTable;
    Table2: TTable;
    Table3: TTable;
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
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBGrid3: TDBGrid;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
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
    Table2Kl_potion: TIntegerField;
    Table2Cost: TCurrencyField;
    Table2Receipt_amount: TIntegerField;
    Table2Receipt_date: TDateField;
    Table2Summa: TIntegerField;
    N31: TMenuItem;
    DataSource4: TDataSource;
    Query1: TQuery;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    C1: TMenuItem;
    C2: TMenuItem;
    N35: TMenuItem;
    RvProject1: TRvProject;
    RvDataSetConnection1: TRvDataSetConnection;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure Table2CalcFields(DataSet: TDataSet);
    procedure N31Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
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
begin    //Change headers DBGrid
  Form1.DBGrid1.Columns[0].Title.Caption:='Potion code';
  Form1.DBGrid1.Columns[1].Title.Caption:='potion name';
  Form1.DBGrid1.Columns[2].Title.Caption:='Implementation period (months)';

  Form1.DBGrid2.Columns[0].Title.Caption:='Potion code';
  Form1.DBGrid2.Columns[1].Title.Caption:='Cost';
  Form1.DBGrid2.Columns[2].Title.Caption:='Amount (tablets)';
  Form1.DBGrid2.Columns[3].Title.Caption:='Date';
  Form1.DBGrid2.Columns[4].Title.Caption:='Total cost';

  Form1.DBGrid3.Columns[0].Title.Caption:='Potion code';
  Form1.DBGrid3.Columns[1].Title.Caption:='Number of sold (tablets)';
  Form1.DBGrid3.Columns[2].Title.Caption:='Date';
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
    //Connection table "Finished potions"
  Form1.DataSource1.DataSet:=Form1.Table1;
  Form1.Table1.TableName:='tab_ready.DB';
  Form1.Table1.Active:=true;
  Form1.DBGrid1.DataSource:=Form1.DataSource1;

    //Connection table "Delivery potions"
  Form1.DataSource2.DataSet:=Form1.Table2;
  Form1.Table2.TableName:='tab_receipt.DB';
  Form1.Table2.Active:=true;
  Form1.DBGrid2.DataSource:=Form1.DataSource2;

    //Connection table "Sale potions"
  Form1.DataSource3.DataSet:=Form1.Table3;
  Form1.Table3.TableName:='tab_sale.DB';
  Form1.Table3.Active:=true;
  Form1.DBGrid3.DataSource:=Form1.DataSource3;

    //Connection queries
  Form1.DataSource4.DataSet:=Form1.Query1;

  
  Form1.N31.Visible:=false;
  russian_z;
end;

function Insp_null_field:boolean;
begin     //Checking exist records in tables
  result:=false;
  if (Form1.PageControl1.ActivePageIndex+1)=1 then
    if Form1.Table1.FieldByName('Kl_potion').IsNull=true then
        result:=true;
  if (Form1.PageControl1.ActivePageIndex+1)=2 then
    if Form1.Table2.FieldByName('Kl_potion').IsNull=true then
        result:=true;
  if (Form1.PageControl1.ActivePageIndex+1)=3 then
    if Form1.Table3.FieldByName('Kl_potion').IsNull=true then
        result:=true;
end;


procedure prnav;
  begin //Binding DBNavigator to the desired DataSource
    if Form1.PageControl1.ActivePageIndex=0 then
      Form1.DBNavigator1.DataSource:=Form1.DataSource1;
    if Form1.PageControl1.ActivePageIndex=1 then
      Form1.DBNavigator1.DataSource:=Form1.DataSource2;
    if Form1.PageControl1.ActivePageIndex=2 then
      Form1.DBNavigator1.DataSource:=Form1.DataSource3;
  end;



procedure TForm1.PageControl1Change(Sender: TObject);
begin
prnav; //Binding DBNavigator to the desired DataSource
end;

procedure TForm1.Button1Click(Sender: TObject);
begin      //Press "Edit"
  if Insp_null_field=true then
    showmessage('No records for changes!!')
  else
    begin
      Form2.Tag:=1;
      Form2.show;
    end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin  // Press About
showmessage('Variant 31;'+#13+'Database: "Potions kiosk";'
  +#13+'Complied: student group POIT-31'
    +#13+'FName LName');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin    //Press "Add"
  Form2.Tag:=2;
  Form2.Show;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin    //Press "Delete"
  if Insp_null_field=true then
    showmessage('No records for delete!!')
  else
  begin
    if (Form1.PageControl1.ActivePageIndex+1)=1 then
      if Form1.Table1.State=dsBrowse then
        if Messagedlg('Are you sure you want to delete the record?',mtconfirmation,[mbNo,mbYes],0)=mrYes then
          Form1.Table1.Delete;
    if (Form1.PageControl1.ActivePageIndex+1)=2 then
      if Form1.Table2.State=dsBrowse then
        if Messagedlg('Are you sure you want to delete the record?',mtconfirmation,[mbNo,mbYes],0)=mrYes then
          Form1.Table2.Delete;
    if (Form1.PageControl1.ActivePageIndex+1)=3 then
      if Form1.Table3.State=dsBrowse then
        if Messagedlg('Are you sure you want to delete the record?',mtconfirmation,[mbNo,mbYes],0)=mrYes then
          Form1.Table3.Delete;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin   //Press "Insert"
  Form2.Tag:=3;
  Form2.show;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin   //Press "Exit"
  Form1.Close;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Form2.Hide;
  Form3.Hide;
  Form4.Hide;
end;

procedure TForm1.N17Click(Sender: TObject);
begin //"Search" -> "Finished potions" -> "Potion code"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=10;
  Form3.LabeledEdit1.EditLabel.Caption:='Potion code';
  Form3.Show;
end;

procedure TForm1.N18Click(Sender: TObject);
begin //"Search" -> "Finished potions" -> "Potion name"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=11;
  Form3.LabeledEdit1.EditLabel.Caption:='Potion name';
  Form3.Show;
end;

procedure TForm1.N19Click(Sender: TObject);
begin //"Search" -> "Finished potions" -> "Implementation period"
  Form1.PageControl1.ActivePageIndex:=0;
  Form3.Tag:=12;
  Form3.LabeledEdit1.EditLabel.Caption:='Implementation period';
  Form3.Show;
end;

procedure TForm1.N20Click(Sender: TObject);
begin  //"Search" -> "Delivery potions" -> "Potion cost"
  Form1.PageControl1.ActivePageIndex:=1;
  Form3.Tag:=21;
  Form3.LabeledEdit1.EditLabel.Caption:='Potion cost';
  Form3.Show;
end;

procedure TForm1.N21Click(Sender: TObject);
begin //"Search" -> "Delivery potions" -> "Amount received"
  Form1.PageControl1.ActivePageIndex:=1;
  Form3.Tag:=22;
  Form3.LabeledEdit1.EditLabel.Caption:='Amount received';
  Form3.Show;
end;

procedure TForm1.N22Click(Sender: TObject);
begin   //"Search" -> "Delivery potions" -> "Date of arrivals"
  Form1.PageControl1.ActivePageIndex:=1;
  Form3.Tag:=23;
  Form3.LabeledEdit1.EditLabel.Caption:='Date of arrivals';
  Form3.Show;
end;

procedure TForm1.N23Click(Sender: TObject);
begin //"Search" -> "Sale potions" -> "Number of sold"
  Form1.PageControl1.ActivePageIndex:=2;
  Form3.Tag:=31;
  Form3.LabeledEdit1.EditLabel.Caption:='Number of sold';
  Form3.Show;
end;

procedure TForm1.N24Click(Sender: TObject);
begin    //"Search" -> "Sale potions" -> "Date sold"
  Form1.PageControl1.ActivePageIndex:=2;
  Form3.Tag:=32;
  Form3.LabeledEdit1.EditLabel.Caption:='Date sold';
  Form3.Show;
end;

procedure TForm1.N5Click(Sender: TObject);
begin   //"Tables" -> "Edit record"
  Form1.Button1.Click;
end;

procedure TForm1.N6Click(Sender: TObject);
begin  //"Tables" -> "Add record"
  Form1.Button2.Click;
end;

procedure TForm1.N7Click(Sender: TObject);
begin  //"Tables" -> "Delete record"
  Form1.Button3.Click;
end;

procedure TForm1.N8Click(Sender: TObject);
begin  //"Tables" -> "Insert record"
  Form1.Button4.Click;
end;

procedure TForm1.N11Click(Sender: TObject);
begin  //"Tables" -> "Exit"
  Form1.Close;
end;

procedure TForm1.N25Click(Sender: TObject);
begin //"Tables" -> "View tables" -> "Finished potions"
  Form1.PageControl1.ActivePageIndex:=0;
end;

procedure TForm1.N26Click(Sender: TObject);
begin //"Tables" -> "View tables" -> "Delievery potions"
  Form1.PageControl1.ActivePageIndex:=1;
end;

procedure TForm1.N27Click(Sender: TObject);
begin //"Tables" -> "View tables" -> "Sale potions"
  Form1.PageControl1.ActivePageIndex:=2;
end;

procedure TForm1.N28Click(Sender: TObject);
begin  //Sort and Query -> Sorting ->
       //Potion code (ascending)
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.IndexFieldNames:='Kl_potion';
end;

procedure TForm1.N29Click(Sender: TObject);
begin   //Sort and Query -> Sorting ->
       //Potion code (descending)
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.Active:=false;
  Form1.Table1.Exclusive:=true;
  Form1.Table1.AddIndex('Kl_potion_in','Kl_potion',[ixunique,ixdescending]);
  Form1.Table1.Exclusive:=false;
  Form1.Table1.IndexName:='Kl_potion_in';
  Form1.Table1.Active:=true;
  russian_z;
end;

procedure TForm1.N30Click(Sender: TObject);
begin   //Sort and Query -> Sorting ->
        //Potion name 
  Form1.PageControl1.ActivePageIndex:=0;
  Form1.Table1.Active:=false;
  Form1.Table1.Exclusive:=true;
  Form1.Table1.AddIndex('Potion_d','Potion',[ixdescending]);
  Form1.Table1.Exclusive:=false;
  Form1.Table1.IndexName:='Potion_d';
  Form1.Table1.Active:=true;
  russian_z;
end;



procedure TForm1.Table2CalcFields(DataSet: TDataSet);
begin   {Event field calculate}
  Form1.Table2.FieldByName('Summa').Value:=
    Form1.Table2.FieldByName('Receipt_amount').Value*
    Form1.Table2.FieldByName('Cost').Value;
end;

procedure TForm1.N31Click(Sender: TObject);
begin   //Filter reset
  if (Form1.PageControl1.ActivePageIndex=0) and
    (Form1.Table1.Filtered=true) then
      Form1.Table1.Filtered:=false;
  if (Form1.PageControl1.ActivePageIndex=1) and
    (Form1.Table2.Filtered=true) then
      Form1.Table2.Filtered:=false;
  if (Form1.PageControl1.ActivePageIndex=2) and
    (Form1.Table3.Filtered=true) then
      Form1.Table3.Filtered:=false;
  form1.N31.Visible:=false;
end;

procedure TForm1.N32Click(Sender: TObject);
begin  //Sort and Query -> Query ->
        //Potion list
  Form4.Tag:=1;
  Form4.Show;
end;

procedure TForm1.N33Click(Sender: TObject);
begin  //Sort and Query -> Query ->
       //Potion indicated in table delivery
  Form4.Tag:=2;
  Form4.Show;
end;

procedure TForm1.N34Click(Sender: TObject);
begin  //Sort and Query -> Query ->
       //Potion indicated in table sale
  Form4.Tag:=3;
  Form4.Show;

end;

procedure TForm1.C1Click(Sender: TObject);
begin   //Sort and Query -> Query ->
        //Potion delivery potion by code
  Form4.Tag:=4;
  Form4.Show;
end;

procedure TForm1.C2Click(Sender: TObject);
begin   //Sort and Query -> Query ->
        //Potion sale potion by code
  Form4.Tag:=5;
  Form4.Show;
end;

procedure TForm1.N35Click(Sender: TObject);
begin //Sort and Query -> Query ->
      //Potion list, witch cost higher that value
  Form4.Tag:=6;
  Form4.Show;
end;

procedure TForm1.N36Click(Sender: TObject);
begin  //Report -> Potion list
  Form1.RvProject1.Close;
  Form1.RvDataSetConnection1.DataSet:=Form1.Table1;
  Form1.RvProject1.ProjectFile:=ExtractFilePath(Application.ExeName)+'spis_potion.rav';
  Form1.RvProject1.Execute;
end;

procedure TForm1.N37Click(Sender: TObject);
begin  //Report ->  List potions on timeline
  Form1.RvProject1.Close;
  Form1.Query1.SQL.Clear;
  Form1.Query1.SQL.Add('SELECT Kl_potion, Potion, Term_realization');
  Form1.Query1.SQL.Add('FROM "tab_ready"');
  Form1.Query1.SQL.Add('GROUP BY Term_realization, Kl_potion, Potion');
  Form1.RvDataSetConnection1.DataSet:=Form1.Query1;
  Form1.RvProject1.ProjectFile:=ExtractFilePath(Application.ExeName)+'spis_sr.rav';
  Form1.RvProject1.Execute;
end;

procedure TForm1.N38Click(Sender: TObject);
begin  //Report ->  List potions on sale dates
  Form1.RvProject1.Close;
  Form1.Query1.SQL.Clear;
  Form1.Query1.SQL.Add('SELECT Kl_potion, Potion, Sale_amount, Sale_date, AVG(Sale_amount)');
  Form1.Query1.SQL.Add('FROM "tab_ready","tab_sale"');
  Form1.Query1.SQL.Add('WHERE (tab_ready.Kl_potion=tab_sale.Kl_potion)');
  Form1.Query1.SQL.Add('GROUP BY Sale_date, Kl_potion, Potion, Sale_amount');
  Form1.RvDataSetConnection1.DataSet:=Form1.Query1;
  Form1.RvProject1.ProjectFile:=ExtractFilePath(Application.ExeName)+'spis_sl.rav';
  Form1.RvProject1.Execute;

end;

end.
