program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Pr_z3_var5';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
