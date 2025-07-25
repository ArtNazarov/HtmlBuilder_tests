program fptestHtmlBuilder;

{$mode objfpc}{$H+}

uses
  Interfaces, Forms, GuiTestRunner, test_replacers, uRepeatExpressionTests,
  StringCacheTest;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
end.

