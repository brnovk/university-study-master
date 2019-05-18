unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    Label3: TLabel;
    StaticText1: TStaticText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    RadioGroup1: TRadioGroup;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Memo1: TMemo;
    procedure ComboBox1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  f:boolean;

implementation

{$R *.dfm}

procedure ppv;
begin  {Checking text in Memo}
  f:=true;
  if Form1.Memo1.Lines[0]='' then
    begin
      showmessage('Enter text in the "Source text"!!!');
      f:=false;
      Form1.RadioGroup1.ItemIndex:=-1;
    end;
end;

procedure clme;
begin
  Form1.listbox1.Items.Clear;
end;



procedure a1;   {Task 1}
const
  z:string='|\/ ,.#:;?!"-{}()_&<>';
var
  ft,g:boolean;
  b:char;
  s:string ;
  buf:string;
  e,i,j,w,ns,ds,d,bufr:integer;
begin
  ft:=true;
  g:=true;
  b:='.';
  for e:=1 to form1.Memo1.Lines.Count do
  begin
    s:=Form1.Memo1.Lines[e-1];
    d:=length(s);
    s:=s+'.';
    ns:=1;
    for i:=1 to d+1 do
      for j:=1 to 21 do
        if s[i]=z[j] then
          begin
            ds:=i-ns;
            ns:=i+1;
              if ds<>0 then
                if ft=true then
                  begin
                    w:=i-1;
                    b:=s[w];
                    ft:=false;
                    Form1.ListBox1.Items.Add('The first word in the text ends with the letter: ('+b+')');
                  end;
                if ft=false then
                  begin
                    bufr:=ns-(ds+1);
                    buf:=copy(s,bufr,ds);
                    w:=length(buf);
                    if buf[w]=b then
                      if g=true then
                        begin
                          Form1.ListBox1.Items.Add('In this text to ('+b+') end words:');
                          g:=false;
                          Form1.ListBox1.Items.Add(buf);
                        end
                        else
                        Form1.ListBox1.Items.Add(buf);
                  end;
          end;
  end;
end;



procedure a2;   {Task 2}
const
  z:string='|\/ ,.#:;?!"-{}()_&<>';
  b:char='è';
var
  fk:boolean;
  s,buf,max_i:string;
  e,i,j,w,ns,ds,d,x,k,tmp:integer;
begin
  buf:='.';
  fk:=true;
  for e:=1 to form1.Memo1.Lines.Count do
    begin
      s:=Form1.Memo1.Lines[e-1];
      d:=length(s);
      s:=s+'.';
      ns:=1;
      for i:=1 to d+1 do
        for j:=1 to 21 do
          if s[i]=z[j] then
            begin
              ds:=i-ns;
              ns:=i+1;
              if ds<>0 then
                begin
                  x:=ns-(ds+1);
                  buf:=copy(s,x,ds);
                  w:=length(buf);
                  x:=0;
                  for k:=1 to w do
                    if buf[k]=b then x:=x+1;
                      if (fk=true) and (x<>0) then
                        begin
                          fk:=false;
                          max_i:=buf;
                          tmp:=x;
                        end;
                      if (fk=false) and (x>tmp)  then
                        begin
                          max_i:=buf;
                          tmp:=x;
                        end;
                end;
            end;
    end;
  if fk=true then
    Form1.ListBox1.Items.Add('In the text there are no words with the letter ('+b+')')
  else
    Form1.ListBox1.Items.Add('The first word with the greatest number of letters ('+b+'): '+max_i);
end;



procedure pt;
begin     {value assignment StaticText}
  Form1.StaticText1.Visible:=true;
  if Form1.ComboBox1.ItemIndex=0 then
    Form1.StaticText1.Caption:='1.In the given text to find words that end with the same letter as the first word.';
  if Form1.ComboBox1.ItemIndex=1 then
    Form1.StaticText1.Caption:='2.Select the word in the text of the first order with the highest number of entries in his letter, "è".';
end;

procedure pr;
begin    {Task execution}
  if form1.RadioGroup1.ItemIndex=0 then
    begin
      Form1.ComboBox1.ItemIndex:=0;
      pt;
      ppv;
      if f=true then
        begin
          clme;
          a1;
        end;
    end;
  if form1.RadioGroup1.ItemIndex=1 then
    begin
      Form1.ComboBox1.ItemIndex:=1;
      pt;
      ppv;
      if f=true then
        begin
          clme;
          a2;
        end;
    end;
end;


procedure TForm1.ComboBox1Change(Sender: TObject);
begin   {When choosing conditions ComboBox}
  pt;
end;



procedure TForm1.RadioGroup1Click(Sender: TObject);
begin       {Clicking on RadioGroup}
pr;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin       {Open the file in Memo}
  if Form1.OpenDialog1.Execute then
    Form1.Memo1.Lines.LoadFromFile(OpenDialog1.FileName);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin       {save ListBox in file}
  if SaveDialog1.Execute then
    begin
      Form1.ListBox1.Items.SaveToFile(OpenDialog1.FileName);
      Form1.OpenDialog1.FileName:=SaveDialog1.FileName;
    end;
end;

procedure TForm1.Memo1KeyPress(Sender: TObject; var Key: Char);
begin  {Removal of the pointer RadioGroup you press Backspice in Memo}
  if Key=#8 then Form1.RadioGroup1.ItemIndex:=-1;
end;

end.
