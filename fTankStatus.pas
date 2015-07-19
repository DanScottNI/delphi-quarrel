unit fTankStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image, GR32, StdCtrls, BCData;

type
  TfrmYourTankStatus = class(TForm)
    imgEnemy1: TImage32;
    lblEnemyType1: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    txtStartType: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdOKClick(Sender: TObject);
    procedure txtStartTypeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    _BattleCityROM : TBattleCityROM;
    CurTankStatus : Byte;
    procedure DisplayTankGFX(pIndex: Integer);
    procedure DrawAllTanks;
    procedure LoadTankStatus;
    procedure SaveTankStatus;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmYourTankStatus: TfrmYourTankStatus;
  TanksGFX : TBitmap32;

implementation

{$R *.dfm}

procedure TfrmYourTankStatus.DrawAllTanks();
var
  i : Integer;
begin

  if TanksGFX = nil then
    TanksGFX := TBitmap32.Create;
  try
    TanksGFX.Width := 128;
    TanksGFX.Height := 16;

    // Draw tank type 1
    for i := 0 to 7 do
    begin
      {DrawNESTile(SpritePatternTable + ((i*$20)*16), TanksGFX,(i*16) + 0,0,2);
      DrawNESTile(SpritePatternTable + ((i*$20)*16) + 16, TanksGFX,(i*16) + 0,8,2);
      DrawNESTile(SpritePatternTable + ((i*$20)*16) + 32, TanksGFX,(i*16) + 8,0,2);
      DrawNESTile(SpritePatternTable + ((i*$20)*16) + 48, TanksGFX,(i*16) + 8,8,2);}
    end;
//    TanksGFX.SaveToFile('C:\test.bmp');

  except
    ShowMessage('An unknown error occurred');
  end;
end;

constructor TfrmYourTankStatus.Create(AOwner: TComponent;
  ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmYourTankStatus.DisplayTankGFX(pIndex : Integer);
var
  TankBitmap : TBitmap32;
begin
  TankBitmap := TBitmap32.Create;
  try
    TankBitmap.Width := 16;
    TankBitmap.Height := 16;
    //BattleCityROM.SpritePal
    _BattleCityROM.DrawTank(TankBitmap,StrToInt(txtStartType.Text));
//    TankBitmap.Draw(bounds(0,0,16,16),bounds(StrToInt(txtStartType.Text) *16,0,16,16),TanksGFX);
    imgEnemy1.Bitmap := TankBitmap;
  finally
    FreeAndNil(TankBitmap);
  end;
end;

procedure TfrmYourTankStatus.LoadTankStatus();
begin
  //CurTankStatus := BattleCityROM.ROM[TankStatus2] shr 5;
  txtStartType.Text := IntToStr(CurTankStatus);
end;

procedure TfrmYourTankStatus.SaveTankStatus();
begin
  CurTankStatus := StrToInt(txtStartType.Text);
  //BattleCityROM.ROM[TankStatus2] := CurTankStatus shl 5;
//  ROM[TankStatus2] := CurTankStatus shl 5;
end;

procedure TfrmYourTankStatus.FormShow(Sender: TObject);
begin
  LoadTankStatus();
  DrawAllTanks();
  DisplayTankGFX(0);
end;

procedure TfrmYourTankStatus.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(TanksGFX);
end;

procedure TfrmYourTankStatus.cmdOKClick(Sender: TObject);
begin
  SaveTankStatus();
end;

procedure TfrmYourTankStatus.txtStartTypeKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if StrToInt(txtStartType.Text) > 7 then txtStartType.Text := '7';
  DisplayTankGFX(0);
end;

end.
