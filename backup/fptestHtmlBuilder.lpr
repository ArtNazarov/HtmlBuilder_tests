program fptestHtmlBuilder;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, test_replacers_filelink  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

