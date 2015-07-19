unit fSwapLevels;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BCData;

type
  TfrmSwapLevels = class(TForm)
    lblLevel1: TLabel;
    lblLevel2: TLabel;
    cbLevel1: TComboBox;
    cbLevel2: TComboBox;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
    _BattleCityROM : TBattleCityROM;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmSwapLevels: TfrmSwapLevels;
  LevelData1 : Array [0 .. 12, 0..6] of Byte;
  LevelData2 : Array [0 .. 12, 0..6] of Byte;
  EnemyData1 : Array [0..3] of byte;
  EnemyAmountData1 : Array [0..3] of byte;
  EnemyData2 : Array [0..3] of byte;
  EnemyAmountData2 : Array [0..3] of byte;
implementation

uses fBattleCity,uGlobals;

{$R *.dfm}

constructor TfrmSwapLevels.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmSwapLevels.FormShow(Sender: TObject);
var
  i : Integer;
begin
{  for i := 0 to NumberOfLevels - 1 do
  begin
    cbLevel1.Items.Add('Level ' + IntToStr(i+1));
    cbLevel2.Items.Add('Level ' + IntToStr(i+1));
  end;
  cbLevel1.ItemIndex := 0;
  cbLevel2.ItemIndex := 0;}
end;

procedure TfrmSwapLevels.cmdOKClick(Sender: TObject);
var
  i,x : Integer;
begin
{  if cbLevel1.ItemIndex = cbLevel2.ItemIndex then
  begin
    MessageDlg('The levels cannot be the same.', mtError, [mbOK], 0);
    exit;
  end;
  for i := 0 to 12 do
    for x := 0 to 6 do
      LevelData1[i,x] := BattleCityROM.ROM[LevelLoc[cbLevel1.ItemIndex] + i*7 + x];

  for i := 0 to 12 do
    for x := 0 to 6 do
      LevelData2[i,x] := BattleCityROM.ROM[LevelLoc[cbLevel2.ItemIndex] + i*7 + x];

  for i := 0 to 3 do
    EnemyData1[i] := BattleCityROM.ROM[EnemyLoc[cbLevel1.ItemIndex] + i];

  for i := 0 to 3 do
    EnemyAmountData1[i] := BattleCityROM.ROM[EnemyNumbersLoc[cbLevel1.ItemIndex] + i];

  for i := 0 to 3 do
    EnemyData2[i] := BattleCityROM.ROM[EnemyLoc[cbLevel2.ItemIndex] + i];

  for i := 0 to 3 do
    EnemyAmountData2[i] := BattleCityROM.ROM[EnemyNumbersLoc[cbLevel2.ItemIndex] + i];

  for i := 0 to 12 do
    for x := 0 to 6 do
      BattleCityROM.ROM[LevelLoc[cbLevel2.ItemIndex] + i*7 + x] := LevelData1[i,x];

  for i := 0 to 12 do
    for x := 0 to 6 do
      BattleCityROM.ROM[LevelLoc[cbLevel1.ItemIndex] + i*7 + x] := LevelData2[i,x];

  for i := 0 to 3 do
    BattleCityROM.ROM[EnemyLoc[cbLevel1.ItemIndex] + i] := EnemyData1[i];

  for i := 0 to 3 do
    BattleCityROM.ROM[EnemyNumbersLoc[cbLevel1.ItemIndex] + i] := EnemyAmountData1[i];

  for i := 0 to 3 do
    BattleCityROM.ROM[EnemyLoc[cbLevel2.ItemIndex] + i] := EnemyData2[i] ;

  for i := 0 to 3 do
    BattleCityROM.ROM[EnemyNumbersLoc[cbLevel2.ItemIndex] + i] := EnemyAmountData2[i];

  if (frmBattleCity.CurrentLevel = cbLevel2.ItemIndex) or (frmBattleCity.CurrentLevel = cbLevel1.ItemIndex) then
  begin
    with frmBattleCity do
    begin
      LoadLevelData();
      DrawLevelData();
    end;
  end;}

end;

end.
