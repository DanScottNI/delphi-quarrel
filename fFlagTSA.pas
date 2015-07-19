unit fFlagTSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32, GR32_Layers,GR32_Image, StdCtrls, BCData;

type
  TfrmFlagTSAEditor = class(TForm)
    imgFlagTSA: TImage32;
    imgFortFlagTSA: TImage32;
    imgTSA: TImage32;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgTSAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgFlagTSAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgFortFlagTSAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    CurTSABlock : Integer;
    CurPalette : Byte;
    TSAGFX : TBitmap32;
    TileX, TileY : Integer;
    _BattleCityROM : TBattleCityROM;    
    procedure DrawPatternTable;
    procedure DrawTileSelector;
    procedure DrawFlags;
    procedure DrawFortFlags;
    { Private declarations }
  public
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
    { Public declarations }

  end;

var
  frmFlagTSAEditor: TfrmFlagTSAEditor;

implementation

uses fBattleCity;

{$R *.dfm}

constructor TfrmFlagTSAEditor.Create(AOwner: TComponent;
  ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmFlagTSAEditor.DrawTileSelector();
var
  TempBitmap : TBitmap32;
  i,x : Integer;
begin
  TempBitmap := TBitmap32.Create;
  try

    TempBitmap.Width := 128;
    TempBitmap.Height := 128;
    For X := 0 To 15 do
      For I := 0 To 15 do
        TempBitmap.Draw(bounds(i*8,x*8,8,8), bounds((I + (X * 16)) * 8,0,8,8),TSAGFX);

    // Draw the box around the currently selected TSA block
    tempbitmap.FrameRectS(TileX,TileY,TileX+8,TileY + 8,clRed32);
    imgTSA.Bitmap := TempBitmap;

  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmFlagTSAEditor.DrawPatternTable();
var
  i: Integer;
begin
  if TSAGFX = nil then
    TSAGFX := TBitmap32.Create;
  try
    TSAGFX.Width :=2048;
    TSAGFX.Height :=  8;
  except
    FreeAndNil(TSAGFX);
  end;

  if TSAGFX <> nil then
  begin
    for i := 0 to 255 do
      //DrawNESTile(BGPatternTable + (i*16),TSAGFX,i*8,0,CurPalette);
  end;

end;

procedure TfrmFlagTSAEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  TileX := 0;
  TileY := 0;
  FreeAndNil(TSAGfx);

end;

procedure TfrmFlagTSAEditor.FormShow(Sender: TObject);
begin
  CurTSABlock := 0;
  DrawPatternTable();
  DrawTileSelector();
  DrawFlags();
  DrawFortFlags();
end;

procedure TfrmFlagTSAEditor.DrawFlags();
var
  FlagBMP : TBitmap32;
  i,x : Integer;
begin
  FlagBMP := TBitmap32.Create;
  try
    FlagBMP.Width := 48;
    FlagBMP.Height := 32;
    for i := 0 to 3 do
      for x := 0 to 5 do
        //DrawNESTile(BGPatternTable+ (FlagTSAStr[i,x]*16),FlagBMP,x*8,i*8,0);
    imgFlagTSA.Bitmap := FlagBMP;
//    LevelDataBMP.Draw(81,177,FlagBMP);

  finally
    FreeAndNil(FlagBMP);
  end;

end;

procedure TfrmFlagTSAEditor.DrawFortFlags();
var
  FlagBMP : TBitmap32;
  i,x : Integer;
begin
  FlagBMP := TBitmap32.Create;
  try
    FlagBMP.Width := 48;
    FlagBMP.Height := 32;
    for i := 0 to 3 do
      for x := 0 to 5 do
        //DrawNESTile(BGPatternTable+ (FortFlagTSAStr[i,x]*16),FlagBMP,x*8,i*8,3);
  imgFortFlagTSA.Bitmap := FlagBMP;
//    LevelDataBMP.Draw(81,177,FlagBMP);

  finally
    FreeAndNil(FlagBMP);
  end;

end;

procedure TfrmFlagTSAEditor.imgTSAMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  Tile : Integer;
begin
  if button = mbLeft then
  begin
    Tile := ((y div 16) * 16 * 16) + ((X div 16) * 16);
    TileX := (X div 16) * 8;
    TileY := (y div 16) * 8;
    //showmessage(IntToStr(Y));
    CurTSABlock := Tile div 16;
  end
  else if button = mbRight then
  begin
    if CurPalette = 3 then
      CurPalette := 0
    else
      inc(CurPalette);
    DrawPatternTable();
  end;

  DrawTileSelector();

end;

procedure TfrmFlagTSAEditor.imgFlagTSAMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  //FlagTSAStr[y div 16,x div 16] := CurTSABlock;
  DrawFlags();
end;

procedure TfrmFlagTSAEditor.imgFortFlagTSAMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  //FortFlagTSAStr[y div 16,x div 16] := CurTSABlock;
  DrawFortFlags();
end;

end.
