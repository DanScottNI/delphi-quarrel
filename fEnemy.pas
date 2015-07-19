unit fEnemy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GR32_Image, GR32, BCData;

type

  TfrmEnemyEditor = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
    imgLevelTanks: TImage32;
    grpEnemy1: TGroupBox;
    imgEnemy1: TImage32;
    lblEnemyType1: TLabel;
    lblShieldStrength1: TLabel;
    chkGivePowerup1: TCheckBox;
    lblAmount1: TLabel;
    grpEnemy2: TGroupBox;
    lblEnemyType2: TLabel;
    lblShieldStrength2: TLabel;
    lblAmount2: TLabel;
    imgEnemy2: TImage32;
    chkGivePowerup2: TCheckBox;
    grpEnemy3: TGroupBox;
    lblEnemyType3: TLabel;
    lblShieldStrength3: TLabel;
    lblAmount3: TLabel;
    imgEnemy3: TImage32;
    chkGivePowerup3: TCheckBox;
    grpEnemy4: TGroupBox;
    lblEnemyType4: TLabel;
    lblShieldStrength4: TLabel;
    lblAmount4: TLabel;
    imgEnemy4: TImage32;
    chkGivePowerup4: TCheckBox;
    lblLevelTanks: TLabel;
    txtEnemy1Type: TEdit;
    txtAmount1: TEdit;
    txtShieldStrength1: TEdit;
    txtEnemyType2: TEdit;
    txtAmount2: TEdit;
    txtShieldStrength2: TEdit;
    txtEnemyType3: TEdit;
    txtShieldStrength3: TEdit;
    txtAmount3: TEdit;
    txtEnemyType4: TEdit;
    txtShieldStrength4: TEdit;
    txtAmount4: TEdit;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure txtEnemy1TypeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtEnemyType2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtEnemyType3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtEnemyType4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtAmount1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtAmount2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtAmount3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtAmount4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    _BattleCityROM : TBattleCityROM;
    procedure DisplayEnemy;
    procedure SaveEnemy;
    procedure LoadEnemy;
    procedure DrawAllTanks;
    procedure DisplayTankGFX(pIndex: Integer);
    procedure DrawEnemyList;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmEnemyEditor: TfrmEnemyEditor;
  TanksGFX : TBitmap32;
//  TankList : Array [0..19] of Byte;

implementation

{$R *.dfm}

uses fBattleCity, uGlobals;

procedure TfrmEnemyEditor.DisplayEnemy();
begin
  // Display the first enemy
{  txtEnemy1Type.Text :=  IntToStr(EnemyTypes[0].EnemyType);
  txtAmount1.Text := IntToStr(EnemyTypes[0].Amount);
  txtShieldStrength1.Text := IntToStr(EnemyTypes[0].ShieldStrength);
  if EnemyTypes[0].Powerups > 0 then
    chkGivePowerup1.Checked := true
  else
    chkGivePowerup1.Checked := false;

  // Display the second enemy
  txtEnemyType2.Text := IntToStr(EnemyTypes[1].EnemyType);
  txtAmount2.Text := IntToStr(EnemyTypes[1].Amount);
  txtShieldStrength2.Text := IntToStr(EnemyTypes[1].ShieldStrength);
  if EnemyTypes[1].Powerups > 0 then
    chkGivePowerup2.Checked := true
  else
    chkGivePowerup2.Checked := false;

  // Display the third enemy
  txtEnemyType3.Text :=  IntToStr(EnemyTypes[2].EnemyType);
  txtAmount3.Text := IntToStr(EnemyTypes[2].Amount);
  txtShieldStrength3.Text := IntToStr(EnemyTypes[2].ShieldStrength);
  if EnemyTypes[2].Powerups > 0 then
    chkGivePowerup3.Checked := true
  else
    chkGivePowerup3.Checked := false;

  // Display the fourth enemy
  txtEnemyType4.Text :=  IntToStr(EnemyTypes[3].EnemyType);
  txtAmount4.Text := IntToStr(EnemyTypes[3].Amount);
  txtShieldStrength4.Text := IntToStr(EnemyTypes[3].ShieldStrength);
  if EnemyTypes[3].Powerups > 0 then
    chkGivePowerup4.Checked := true
  else
    chkGivePowerup4.Checked := false;}

end;

procedure TfrmEnemyEditor.LoadEnemy();
var
  EnemyByte : Byte;
begin
  // Load the first enemy
{  EnemyByte :=BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]];
  EnemyTypes[0].EnemyType := EnemyByte Shr 5;
  EnemyTypes[0].Unused1 := (Enemybyte Shr 4) and 1;
  EnemyTypes[0].Unused2 := (Enemybyte Shr 3) and 1;
  EnemyTypes[0].Powerups := (EnemyByte Shr 2) and 1;
  EnemyTypes[0].ShieldStrength := EnemyByte and 3;
  EnemyTypes[0].Amount :=BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]];
  // Load the second enemy
  EnemyByte :=BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]+1];
  EnemyTypes[1].EnemyType := EnemyByte Shr 5;
  EnemyTypes[1].Unused1 := (Enemybyte Shr 4) and 1;
  EnemyTypes[1].Unused2 := (Enemybyte Shr 3) and 1;
  EnemyTypes[1].Powerups := (EnemyByte Shr 2) and 1;
  EnemyTypes[1].ShieldStrength := EnemyByte and 3;
  EnemyTypes[1].Amount :=BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]+1];
  // Load the third enemy
  EnemyByte :=BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]+2];
  EnemyTypes[2].EnemyType := EnemyByte Shr 5;
  EnemyTypes[2].Unused1 := (Enemybyte Shr 4) and 1;
  EnemyTypes[2].Unused2 := (Enemybyte Shr 3) and 1;
  EnemyTypes[2].Powerups := (EnemyByte Shr 2) and 1;
  EnemyTypes[2].ShieldStrength := EnemyByte and 3;
  EnemyTypes[2].Amount :=BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]+2];
  // Load the fourth enemy
  EnemyByte :=BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]+3];
  EnemyTypes[3].EnemyType := EnemyByte Shr 5;
  EnemyTypes[3].Unused1 := (Enemybyte Shr 4) and 1;
  EnemyTypes[3].Unused2 := (Enemybyte Shr 3) and 1;
  EnemyTypes[3].Powerups := (EnemyByte Shr 2) and 1;
  EnemyTypes[3].ShieldStrength := EnemyByte and 3;
  EnemyTypes[3].Amount :=BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]+3];}

end;

procedure TfrmEnemyEditor.SaveEnemy();
var
  EnemyByte : Byte;
begin

  // Display the first enemy
{  EnemyTypes[0].EnemyType := StrToInt(txtEnemy1Type.Text);
  EnemyTypes[0].Amount := StrToInt(txtAmount1.Text);
  EnemyTypes[0].ShieldStrength := StrToInt(txtShieldStrength1.Text);
  if chkGivePowerup1.Checked = true  then
    EnemyTypes[0].Powerups := 1
  else
    EnemyTypes[0].Powerups := 0;

  // Display the first enemy
  EnemyTypes[1].EnemyType := StrToInt(txtEnemyType2.Text);
  EnemyTypes[1].Amount := StrToInt(txtAmount2.Text);
  EnemyTypes[1].ShieldStrength := StrToInt(txtShieldStrength2.Text);
  if chkGivePowerup2.Checked = true  then
    EnemyTypes[1].Powerups := 1
  else
    EnemyTypes[1].Powerups := 0;

  // Display the first enemy
  EnemyTypes[2].EnemyType := StrToInt(txtEnemyType3.Text);
  EnemyTypes[2].Amount := StrToInt(txtAmount3.Text);
  EnemyTypes[2].ShieldStrength := StrToInt(txtShieldStrength3.Text);
  if chkGivePowerup3.Checked = true  then
    EnemyTypes[2].Powerups := 1
  else
    EnemyTypes[2].Powerups := 0;

  // Display the first enemy
  EnemyTypes[3].EnemyType := StrToInt(txtEnemyType4.Text);
  EnemyTypes[3].Amount := StrToInt(txtAmount4.Text);
  EnemyTypes[3].ShieldStrength := StrToInt(txtShieldStrength4.Text);
  if chkGivePowerup4.Checked = true  then
    EnemyTypes[3].Powerups := 1
  else
    EnemyTypes[3].Powerups := 0;



  // Save the first enemy
  EnemyByte := EnemyTypes[0].EnemyType shl 5;
  EnemyByte := EnemyByte + EnemyTypes[0].Unused1 shl 4;
  EnemyByte := EnemyByte + EnemyTypes[0].Unused2 shl 3;
  EnemyByte := EnemyByte + EnemyTypes[0].Powerups shl 2;
  EnemyByte := EnemyByte + EnemyTypes[0].ShieldStrength;
  BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]] := EnemyByte;
  BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]] := EnemyTypes[0].Amount;
  // Save the second enemy
  EnemyByte := EnemyTypes[1].EnemyType shl 5;
  EnemyByte := EnemyByte + EnemyTypes[1].Unused1 shl 4;
  EnemyByte := EnemyByte + EnemyTypes[1].Unused2 shl 3;
  EnemyByte := EnemyByte + EnemyTypes[1].Powerups shl 2;
  EnemyByte := EnemyByte + EnemyTypes[1].ShieldStrength;
  BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]+1] := EnemyByte;
  BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]+1] := EnemyTypes[1].Amount;

  // Save the third enemy
  EnemyByte := EnemyTypes[2].EnemyType shl 5;
  EnemyByte := EnemyByte + EnemyTypes[2].Unused1 shl 4;
  EnemyByte := EnemyByte + EnemyTypes[2].Unused2 shl 3;
  EnemyByte := EnemyByte + EnemyTypes[2].Powerups shl 2;
  EnemyByte := EnemyByte + EnemyTypes[2].ShieldStrength;
  BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]+2] := EnemyByte;
  BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]+2] := EnemyTypes[2].Amount;

  // Save the fourth enemy
  EnemyByte := EnemyTypes[3].EnemyType shl 5;
  EnemyByte := EnemyByte + EnemyTypes[3].Unused1 shl 4;
  EnemyByte := EnemyByte + EnemyTypes[3].Unused2 shl 3;
  EnemyByte := EnemyByte + EnemyTypes[3].Powerups shl 2;
  EnemyByte := EnemyByte + EnemyTypes[3].ShieldStrength;
  BattleCityROM.ROM[EnemyLoc[frmBattleCity.CurrentLevel]+3] := EnemyByte;
  BattleCityROM.ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]+3] := EnemyTypes[3].Amount;}

{  EnemyTypes[0].EnemyType := EnemyByte Shr 5;
  EnemyTypes[0].Unused1 := (Enemybyte Shr 4) and 1;
  EnemyTypes[0].Unused1 := (Enemybyte Shr 3) and 1;
  EnemyTypes[0].Powerups := (EnemyByte Shr 2) and 1;
  EnemyTypes[0].ShieldStrength := EnemyByte and 3;
  EnemyTypes[0].Amount :=ROM[EnemyNumbersLoc[frmBattleCity.CurrentLevel]];}
end;

procedure TfrmEnemyEditor.DrawAllTanks();
var
  i : Integer;
begin

{  if TanksGFX = nil then
    TanksGFX := TBitmap32.Create;
  try
    TanksGFX.Width := 128;
    TanksGFX.Height := 16;

    // Draw tank type 1
    for i := 0 to 7 do
    begin
      DrawNESTile(SpritePatternTable + ((i*$20)*16), TanksGFX,(i*16) + 0,0,2);
      DrawNESTile(SpritePatternTable + ((i*$20)*16) + 16, TanksGFX,(i*16) + 0,8,2);
      DrawNESTile(SpritePatternTable + ((i*$20)*16) + 32, TanksGFX,(i*16) + 8,0,2);
      DrawNESTile(SpritePatternTable + ((i*$20)*16) + 48, TanksGFX,(i*16) + 8,8,2);
    end;
//    TanksGFX.SaveToFile('C:\test.bmp');

  except
    ShowMessage('An unknown error occurred');
  end;}
end;

procedure TfrmEnemyEditor.DisplayTankGFX(pIndex : Integer);
var
  TankBitmap : TBitmap32;
begin
  TankBitmap := TBitmap32.Create;
  try
    TankBitmap.Width := 16;
    TankBitmap.Height := 16;

    if pIndex = 0 then
    begin
      TankBitmap.Draw(bounds(0,0,16,16),bounds(StrToInt(txtEnemy1Type.Text)*16,0,16,16),TanksGFX);
      imgEnemy1.Bitmap := TankBitmap;
    end
    else if pIndex = 1 then
    begin
      TankBitmap.Draw(bounds(0,0,16,16),bounds(StrToInt(txtEnemyType2.Text)*16,0,16,16),TanksGFX);
      imgEnemy2.Bitmap := TankBitmap;
    end
    else if pIndex = 2 then
    begin
      TankBitmap.Draw(bounds(0,0,16,16),bounds(StrToInt(txtEnemyType3.Text)*16,0,16,16),TanksGFX);
      imgEnemy3.Bitmap := TankBitmap;
    end
    else if pIndex = 3 then
    begin
      TankBitmap.Draw(bounds(0,0,16,16),bounds(StrToInt(txtEnemyType4.Text) *16,0,16,16),TanksGFX);
      imgEnemy4.Bitmap := TankBitmap;
    end;

  finally
    FreeAndNil(TankBitmap);
  end;
end;

procedure TfrmEnemyEditor.DrawEnemyList();
var
  Position : Integer;
  TankList : TBitmap32;
  TankListArr : Array Of Byte;
  NumberOfTanks, EndTank, i : Integer;
  Amount1, Amount2, Amount3, Amount4 : Integer;
begin

  Position := 0;

  Amount1 := StrToInt(txtAmount1.Text);
  Amount2 := StrToInt(txtAmount2.Text);
  Amount3 := StrToInt(txtAmount3.Text);
  Amount4 := StrToInt(txtAmount4.Text);

  NumberOfTanks := Amount1 + Amount2 + Amount3 + Amount4;

  SetLength(TankListArr,NumberOfTanks);

  for i := 0 to Amount1 -1 do
    TankListArr[i] := StrToInt(txtEnemy1Type.Text);

  for i := Amount1 to Amount1+Amount2 - 1 do
    TankListArr[i] := StrToInt(txtEnemyType2.Text);

  for i := Amount1+Amount2 to Amount1 + Amount2 + Amount3 - 1 do
    TankListArr[i] := StrToInt(txtEnemyType3.Text);

  for i := Amount1+Amount2 + Amount3 to Amount1 + Amount2 + Amount3 + Amount4 - 1 do
    TankListArr[i] := StrToInt(txtEnemyType4.Text);

  TankList := TBitmap32.Create;
  try

    TankList.Width := 32;
    TankList.Height := 160;

    if NumberOfTanks < 20 then
      EndTank := NumberOfTanks
    else
      EndTank := 20;

    while (Position < EndTank) do
    begin
      TankList.Draw(bounds((Position mod 2)*16,(Position div 2)*16,16,16),bounds(TankListArr[Position]*16,0,16,16),TanksGFX);
//      TanksGFX Position div 2

      inc(Position);
    end;
    imgLevelTanks.Bitmap := TankList;
  finally
    SetLength(TankListArr,0);
    FreeAndNil(TankList);
  end;

end;

procedure TfrmEnemyEditor.FormShow(Sender: TObject);
begin
  LoadEnemy();
  DrawAllTanks();
  DisplayEnemy();
  DisplayTankGFX(0);
  DisplayTankGFX(1);
  DisplayTankGFX(2);
  DisplayTankGFX(3);
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.cmdOKClick(Sender: TObject);
begin
  SaveEnemy();
  FreeAndNil(TanksGFX);
end;

constructor TfrmEnemyEditor.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmEnemyEditor.txtEnemy1TypeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if StrToInt(txtEnemy1Type.Text) > 7 then txtEnemy1Type.Text := '7';
  if StrToInt(txtEnemy1Type.Text) < 0 then txtEnemy1Type.Text := '0';
  DisplayTankGFX(0);
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtEnemyType2KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if StrToInt(txtEnemyType2.Text) > 7 then txtEnemyType2.Text := '7';
  if StrToInt(txtEnemyType2.Text) < 0 then txtEnemyType2.Text := '0';
  DisplayTankGFX(1);
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtEnemyType3KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if StrToInt(txtEnemyType3.Text) > 7 then txtEnemyType3.Text := '7';
  if StrToInt(txtEnemyType3.Text) < 0 then txtEnemyType3.Text := '0';
  DisplayTankGFX(2);
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtEnemyType4KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if StrToInt(txtEnemyType4.Text) > 7 then txtEnemyType4.Text := '7';
  if StrToInt(txtEnemyType4.Text) < 0 then txtEnemyType4.Text := '0';
  DisplayTankGFX(3);
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtAmount1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if StrToInt(txtAmount1.Text) > 20 then txtAmount1.Text := '20';
  if StrToInt(txtAmount1.Text) < 0 then txtAmount1.Text := '0';
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtAmount2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if StrToInt(txtAmount2.Text) > 20 then txtAmount2.Text := '20';
  if StrToInt(txtAmount2.Text) < 0 then txtAmount2.Text := '0';
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtAmount3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if StrToInt(txtAmount3.Text) > 20 then txtAmount3.Text := '20';
  if StrToInt(txtAmount3.Text) < 0 then txtAmount3.Text := '0';
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.txtAmount4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if StrToInt(txtAmount4.Text) > 20 then txtAmount4.Text := '20';
  if StrToInt(txtAmount4.Text) < 0 then txtAmount4.Text := '0';
  DrawEnemyList();
end;

procedure TfrmEnemyEditor.cmdCancelClick(Sender: TObject);
begin
  FreeAndNil(TanksGFX);
end;

procedure TfrmEnemyEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(TanksGFX);
end;

end.
