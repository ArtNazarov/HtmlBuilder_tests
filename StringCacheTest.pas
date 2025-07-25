unit StringCacheTest;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpcunit, testregistry,
  StringCache in '../HTMLBUILDER/stringcache.pas';

type
  { TTestStringCache }
  TTestStringCache = class(TTestCase)
  private
    FCache: TStringCache;
  protected
    procedure SetUp; override; 
    procedure TearDown; override;
  published
    procedure TestInitialState;
    procedure TestIsKeyExists;
    procedure TestGetValueByKey;
    procedure TestStoreKeyValue;
    procedure TestStoreDuplicateKey;
    procedure TestClearPairs;
    procedure TestNonExistentKey;
    procedure TestCacheCount;
  end;

implementation

procedure TTestStringCache.SetUp;
begin
  FCache := TStringCache.Create;
end;

procedure TTestStringCache.TearDown;
begin
  FCache.Free;
end;

procedure TTestStringCache.TestInitialState;
begin
  AssertEquals('Cache should be empty initially', 0, FCache.Count);
end;

procedure TTestStringCache.TestIsKeyExists;
begin
  AssertFalse('Key should not exist in empty cache', FCache.isKeyExists('test'));
  
  FCache.storeKeyValue('name', 'Alice');
  AssertTrue('Key should exist after being added', FCache.isKeyExists('name'));
  AssertFalse('Non-existent key should return false', FCache.isKeyExists('nonexistent'));
end;

procedure TTestStringCache.TestGetValueByKey;
begin
  AssertEquals('Non-existent key should return empty string', '', FCache.getValueByKey('none'));
  
  FCache.storeKeyValue('color', 'blue');
  AssertEquals('Should return correct value for existing key', 'blue', FCache.getValueByKey('color'));
end;

procedure TTestStringCache.TestStoreKeyValue;
begin
  FCache.storeKeyValue('fruit', 'apple');
  AssertTrue('Key should exist after storage', FCache.isKeyExists('fruit'));
  AssertEquals('Value should match stored value', 'apple', FCache.getValueByKey('fruit'));
  AssertEquals('Cache count should be 1 after adding one item', 1, FCache.Count);
end;

procedure TTestStringCache.TestStoreDuplicateKey;
begin
  FCache.storeKeyValue('animal', 'cat');
  FCache.storeKeyValue('animal', 'dog');
  
  AssertEquals('Duplicate key should overwrite value', 'dog', FCache.getValueByKey('animal'));
  AssertTrue('Key should still exist', FCache.isKeyExists('animal'));
  AssertEquals('Cache count should remain 1 after update', 1, FCache.Count);
end;

procedure TTestStringCache.TestClearPairs;
begin
  FCache.storeKeyValue('a', '1');
  FCache.storeKeyValue('b', '2');
  
  AssertEquals('Cache should have 2 items', 2, FCache.Count);
  FCache.clearPairs;
  AssertEquals('Cache should be empty after clear', 0, FCache.Count);
  AssertFalse('Key a should not exist after clear', FCache.isKeyExists('a'));
  AssertFalse('Key b should not exist after clear', FCache.isKeyExists('b'));
end;

procedure TTestStringCache.TestNonExistentKey;
begin
  AssertFalse('Non-existent key should return false', FCache.isKeyExists('ghost'));
  AssertEquals('Non-existent key should return empty string', '', FCache.getValueByKey('ghost'));
end;

procedure TTestStringCache.TestCacheCount;
begin
  AssertEquals('Empty cache count', 0, FCache.Count);
  FCache.storeKeyValue('test', 'value');
  AssertEquals('Count after one addition', 1, FCache.Count);
  FCache.storeKeyValue('test2', 'value2');
  AssertEquals('Count after second addition', 2, FCache.Count);
  FCache.clearPairs;
  AssertEquals('Count after clear', 0, FCache.Count);
end;

initialization
  RegisterTest(TTestStringCache);
end.
