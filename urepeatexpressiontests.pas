
unit uRepeatExpressionTests;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testutils, testregistry, uRepeatExpression in
   '../HTMLBUILDER/uRepeatExpression.pas';

type

  TRepeatExpressionTests= class(TTestCase)
  published
    procedure TestSimpleColorExample;
    procedure TestMultipleVariables;
    procedure TestComplexTemplate;
    procedure TestMultipleRepeatBlocks;
    procedure TestNoRepeatBlock;
    procedure TestMalformedRepeatBlock;
  end;

implementation

procedure TRepeatExpressionTests.TestSimpleColorExample;
var
  input, expected, actual: string;
begin
  input := '@repeat { color = red|green|blue } [[Color: &color; ]]';
  expected := 'Color: red Color: green Color: blue'; // because trimmed!
  actual := ProcessRepeatExpression(input);
  AssertEquals('Test1', expected, actual);
end;

procedure TRepeatExpressionTests.TestMultipleVariables;
var
  input, expected, actual: string;
begin
  input := 'Prefix @repeat { item = apples|oranges|bananas } [[ &item; ]] suffix';
  expected := 'Prefix apples oranges bananas suffix';
  actual := ProcessRepeatExpression(input);
  AssertEquals('Test2', expected, actual);
end;

procedure TRepeatExpressionTests.TestComplexTemplate;
var
  input, expected, actual: string;
begin
  input := '@repeat { num = 1|2|3 } [[Item #&num;: Product-&num; ]]';
  expected := 'Item #1: Product-1 Item #2: Product-2 Item #3: Product-3';
  actual := ProcessRepeatExpression(input);
  AssertEquals('Test 3', expected, actual);
end;

procedure TRepeatExpressionTests.TestMultipleRepeatBlocks;
var
  input, expected, actual: string;
begin
  input := '@repeat { a = 1|2 } [[A&a;]] @repeat { b = X|Y } [[B&b;]]';
  expected := 'A1 A2 BX BY';
  actual := ProcessRepeatExpression(input);
  AssertEquals('Test 4', expected, actual);
end;

procedure TRepeatExpressionTests.TestNoRepeatBlock;
var
  input, expected, actual: string;
begin
  input := 'Just a normal string without repeat blocks';
  expected := input;
  actual := ProcessRepeatExpression(input);
  AssertEquals('Test 5', expected, actual);
end;

procedure TRepeatExpressionTests.TestMalformedRepeatBlock;
var
  input, expected, actual: string;
begin
  input := 'A @repeat { malformed } [[ &var; ]] B';
  expected := 'A &var; B'; // no substitution
  actual := ProcessRepeatExpression(input);
  AssertEquals('Test 5', expected, actual);
end;

initialization
  RegisterTest(TRepeatExpressionTests);
end.
