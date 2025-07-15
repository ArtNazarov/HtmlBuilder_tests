program fptestHtmlBuilder;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, test_replacers, uRepeatExpressionTests  ;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

