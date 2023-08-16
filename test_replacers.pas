unit test_replacers;

{$mode objfpc}{$H+}

interface

uses
   Classes, SysUtils, fpcunit, testutils, testregistry,   replacers in
  '../HTMLBUILDER/replacers.pas';

type

  { TTestReplacers }

  TTestReplacers =  class(TTestCase)
  published
    procedure TestFileLink;
    procedure TestApplyVar;
    procedure TestApplyImage;
  end;

implementation

procedure TTestReplacers.TestFileLink;
var
  fact, expected : String;
  success : Boolean;
begin
  expected := 'Download from <a href="https://site.com/file.txt" download>description</a>';
  fact:=applyFileLink('Download from ||download_link||', 'download_link', 'https://site.com/file.txt', 'description');
  success:= (fact = expected);
  if (not success) then Fail('failed fileLink '+ fact, nil);
end;

procedure TTestReplacers.TestApplyVar;
var
  fact, expected : String;
  success : Boolean;
begin
  expected := 'test var_value';
  fact:=applyVar('test {var_name}', 'var_name', 'var_value');
  success:= (fact = expected);
  if (not success) then Fail('failed applyVar '+ fact, nil);
end;

procedure TTestReplacers.TestApplyImage;
var
  fact, expected : String;
  success : Boolean;
begin
expected := 'Picture <img src="https://site.com/image.png" alt="Image alt" >';
  fact:=applyImage('Picture ((image_tag))', 'image_tag', 'https://site.com/image.png', 'Image alt');
  success:= (fact = expected);
  if (not success) then Fail('failed fileLink '+ fact, nil);
end;

initialization
  RegisterTest(TTestReplacers);
end.

