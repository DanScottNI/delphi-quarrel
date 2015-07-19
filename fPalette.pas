unit fPalette;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32, GR32_Layers,GR32_Image, StdCtrls, BCData;

type
  TfrmPaletteEditor = class(TForm)
    lbl000F: TLabel;
    lbl101F: TLabel;
    lbl202F: TLabel;
    lbl303F: TLabel;
    lblCurrentPalette: TLabel;
    imgNESColours: TImage32;
    imgPalFra11: TImage32;
    imgPalFra12: TImage32;
    imgPalFra13: TImage32;
    imgPalFra14: TImage32;
    imgPalFra21: TImage32;
    imgPalFra22: TImage32;
    imgPalFra23: TImage32;
    imgPalFra24: TImage32;
    imgPalFra31: TImage32;
    imgPalFra32: TImage32;
    imgPalFra33: TImage32;
    imgPalFra34: TImage32;
    imgSprPal1: TImage32;
    imgSprPal2: TImage32;
    imgSprPal3: TImage32;
    imgSprPal4: TImage32;
    imgTitScr1: TImage32;
    imgTitScr2: TImage32;
    imgTitScr3: TImage32;
    imgTitScr4: TImage32;
    imgLevSel1: TImage32;
    imgLevSel2: TImage32;
    imgLevSel3: TImage32;
    imgLevSel4: TImage32;
    lblPaletteFrame1: TLabel;
    lblPaletteFrame2: TLabel;
    lblPaletteFrame3: TLabel;
    lblSpritePalette: TLabel;
    lblTitleScreenPalette: TLabel;
    lblLevelSelectPalette: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure imgNESColoursMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgNESColoursMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer; Layer: TCustomLayer);
    procedure imgPalFra11MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgPalFra21MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgPalFra31MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure cmdOKClick(Sender: TObject);
    procedure imgSprPal1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgTitScr1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevSel1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
  private
    _BattleCityROM : TBattleCityROM;
    TileX, TileY, CurColour : Integer;
    procedure DrawNESColours;
    procedure DisplayPalette();
    procedure LoadEditingPalettes;
    procedure SaveEditingPalettes;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmPaletteEditor: TfrmPaletteEditor;
  PaletteFrame1, PaletteFrame2, PaletteFrame3,SprPal,TitScrPal,LevSelPal :
  Array [0..3,0..3] of Byte;

implementation

uses fBattleCity;

{$R *.dfm}

procedure TfrmPaletteEditor.DrawNESColours();
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 287;
    TempBitmap.Height := 74;

    _BattleCityROM.ROM.DrawNESColours(TempBitmap);

    if TileX = 0 then
      TempBitmap.FrameRectS(TileX,TileY,TileX+18,TileY+19,clRed32)

    else
      TempBitmap.FrameRectS(TileX-1,TileY,TileX+18,TileY+19,clRed32);

    imgNESColours.Bitmap := TempBitmap;
  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmPaletteEditor.FormShow(Sender: TObject);
begin
  DrawNESColours();
  LoadEditingPalettes();
  DisplayPalette();
end;

procedure TfrmPaletteEditor.LoadEditingPalettes();
var
  i,x : integer;
begin
  for i := 0 to 3 do
    for x := 0 to 3 do
      PaletteFrame2[i,x] := _BattleCityROM.Palette[i,x];

  for i := 0 to 3 do
    for x := 0 to 3 do
      PaletteFrame2[i,x] := _BattleCityROM.ROM[_BattleCityROM.PalFrame1+(i*4+x)];

  for i := 0 to 3 do
    for x := 0 to 3 do
      PaletteFrame3[i,x] := _BattleCityROM.ROM[_BattleCityROM.PalFrame2+(i*4+x)];

  for i := 0 to 3 do
    for x := 0 to 3 do
      SprPal[i,x] := _BattleCityROM.ROM[_BattleCityROM.SpritePal+(i*4+x)];

  for i := 0 to 3 do
    for x := 0 to 3 do
      LevSelPal[i,x] := _BattleCityROM.ROM[_BattleCityROM.LevelSelPal+(i*4+x)];

  for i := 0 to 3 do
    for x := 0 to 3 do
      TitScrPal[i,x] := _BattleCityROM.ROM[_BattleCityROM.TitleScrPal+(i*4+x)];

end;

procedure TfrmPaletteEditor.SaveEditingPalettes();
var
  i,x : integer;
begin
{  for i := 0 to 3 do
    for x := 0 to 3 do
      BattleCityROM.ROM[PaletteStart+(i*4+x)] := frmBattleCity.PaletteData[i,x];

  for i := 0 to 3 do
    for x := 0 to 3 do
      BattleCityROM.ROM[PalFrame1+(i*4+x)] := PaletteFrame2[i,x];

  for i := 0 to 3 do
    for x := 0 to 3 do
      BattleCityROM.ROM[PalFrame2+(i*4+x)] := PaletteFrame3[i,x];

  for i := 0 to 3 do
    for x := 0 to 3 do
      BattleCityROM.ROM[SpritePal+(i*4+x)] := SprPal[i,x];

  for i := 0 to 3 do
    for x := 0 to 3 do
      BattleCityROM.ROM[LevelSelPal+(i*4+x)] := LevSelPal[i,x];

  for i := 0 to 3 do
    for x := 0 to 3 do
      BattleCityROM.ROM[TitleScrPal+(i*4+x)] := TitScrPal[i,x];}

end;

procedure TfrmPaletteEditor.imgNESColoursMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  CurColour := ((X div 18) + (Y div 18) * 16);
  TileX := (X div 18) * 18;
  TileY := (y div 18) * 18;
  DrawNESColours();
end;

constructor TfrmPaletteEditor.Create(AOwner: TComponent;
  ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmPaletteEditor.DisplayPalette();
var
  TempBitmap : TBitmap32;
//  i,TempIndex,TempColour : Integer;
begin
{  TempBitmap := TBitmap32.Create;
  try
    with TempBitmap do
    begin
      Width := 100;
      Height := 25;
      // Draw the first frame palette 1
      FillRect(0,0,25,25,NESPal[frmBattleCity.PaletteData[0,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette 2
      FillRect(25,0,50,25,NESPal[frmBattleCity.PaletteData[0,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette 3
      FillRect(50,0,75,25,NESPal[frmBattleCity.PaletteData[0,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette 4
      FillRect(75,0,100,25,NESPal[frmBattleCity.PaletteData[0,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra11.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[frmBattleCity.PaletteData[1,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[frmBattleCity.PaletteData[1,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[frmBattleCity.PaletteData[1,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[frmBattleCity.PaletteData[1,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra12.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[frmBattleCity.PaletteData[2,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[frmBattleCity.PaletteData[2,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[frmBattleCity.PaletteData[2,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[frmBattleCity.PaletteData[2,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra13.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[frmBattleCity.PaletteData[3,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[frmBattleCity.PaletteData[3,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[frmBattleCity.PaletteData[3,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[frmBattleCity.PaletteData[3,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra14.Bitmap := TempBitmap;

      // Draw the first frame palette 1
      FillRect(0,0,25,25,NESPal[PaletteFrame2[0,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette 2
      FillRect(25,0,50,25,NESPal[PaletteFrame2[0,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette 3
      FillRect(50,0,75,25,NESPal[PaletteFrame2[0,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette 4
      FillRect(75,0,100,25,NESPal[PaletteFrame2[0,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra21.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[PaletteFrame2[1,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[PaletteFrame2[1,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[PaletteFrame2[1,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[PaletteFrame2[1,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra22.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[PaletteFrame2[2,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[PaletteFrame2[2,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[PaletteFrame2[2,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[PaletteFrame2[2,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra23.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[PaletteFrame2[3,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[PaletteFrame2[3,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[PaletteFrame2[3,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[PaletteFrame2[3,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra24.Bitmap := TempBitmap;

      // Draw the first frame palette 1
      FillRect(0,0,25,25,NESPal[PaletteFrame3[0,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette 2
      FillRect(25,0,50,25,NESPal[PaletteFrame3[0,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette 3
      FillRect(50,0,75,25,NESPal[PaletteFrame3[0,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette 4
      FillRect(75,0,100,25,NESPal[PaletteFrame3[0,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra31.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[PaletteFrame3[1,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[PaletteFrame3[1,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[PaletteFrame3[1,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[PaletteFrame3[1,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra32.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[PaletteFrame3[2,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[PaletteFrame3[2,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[PaletteFrame3[2,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[PaletteFrame3[2,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra33.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[PaletteFrame3[3,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[PaletteFrame3[3,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[PaletteFrame3[3,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[PaletteFrame3[3,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgPalFra34.Bitmap := TempBitmap;

      // Draw the first frame palette 1
      FillRect(0,0,25,25,NESPal[SprPal[0,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette 2
      FillRect(25,0,50,25,NESPal[SprPal[0,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette 3
      FillRect(50,0,75,25,NESPal[SprPal[0,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette 4
      FillRect(75,0,100,25,NESPal[SprPal[0,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgSprPal1.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[SprPal[1,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[SprPal[1,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[SprPal[1,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[SprPal[1,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgSprPal2.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[SprPal[2,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[SprPal[2,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[SprPal[2,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[SprPal[2,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgSprPal3.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[SprPal[3,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[SprPal[3,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[SprPal[3,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[SprPal[3,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgSprPal4.Bitmap := TempBitmap;

      // Draw the first frame palette 1
      FillRect(0,0,25,25,NESPal[TitScrPal[0,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette 2
      FillRect(25,0,50,25,NESPal[TitScrPal[0,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette 3
      FillRect(50,0,75,25,NESPal[TitScrPal[0,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette 4
      FillRect(75,0,100,25,NESPal[TitScrPal[0,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgTitScr1.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[TitScrPal[1,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[TitScrPal[1,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[TitScrPal[1,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[TitScrPal[1,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgTitScr2.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[TitScrPal[2,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[TitScrPal[2,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[TitScrPal[2,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[TitScrPal[2,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgTitScr3.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[TitScrPal[3,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[TitScrPal[3,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[TitScrPal[3,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[TitScrPal[3,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgTitScr4.Bitmap := TempBitmap;

      // Draw the first frame palette 1
      FillRect(0,0,25,25,NESPal[LevSelPal[0,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette 2
      FillRect(25,0,50,25,NESPal[LevSelPal[0,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette 3
      FillRect(50,0,75,25,NESPal[LevSelPal[0,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette 4
      FillRect(75,0,100,25,NESPal[LevSelPal[0,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgLevSel1.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[LevSelPal[1,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[LevSelPal[1,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[LevSelPal[1,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[LevSelPal[1,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgLevSel2.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[LevSelPal[2,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[LevSelPal[2,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[LevSelPal[2,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[LevSelPal[2,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgLevSel3.Bitmap := TempBitmap;

      // Draw the first frame palette
      FillRect(0,0,25,25,NESPal[LevSelPal[3,0]]);
      FrameRectS(0,0,25,25,clBlack32);
      // Draw the first frame palette
      FillRect(25,0,50,25,NESPal[LevSelPal[3,1]]);
      FrameRectS(24,0,50,25,clBlack32);
      // Draw the first frame palette
      FillRect(50,0,75,25,NESPal[LevSelPal[3,2]]);
      FrameRectS(49,0,75,25,clBlack32);
      // Draw the first frame palette
      FillRect(75,0,100,25,NESPal[LevSelPal[3,3]]);
      FrameRectS(74,0,100,25,clBlack32);

      imgLevSel4.Bitmap := TempBitmap;

    end;
  finally
    FreeAndNil(TempBitmap);
  end;}
end;

procedure TfrmPaletteEditor.imgNESColoursMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  lblCurrentPalette.Caption := 'Current Palette Colour: $' + IntToHex(((X div 18) + (Y div 18) * 16),2);
end;

procedure TfrmPaletteEditor.imgPalFra11MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  _BattleCityROM.Palette[TImage32(sender).Tag, x div 25] := CurColour;
  DisplayPalette();
  frmBattleCity.DrawLevelData();
  frmBattleCity.DrawTileSelector();
end;

procedure TfrmPaletteEditor.imgPalFra21MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  PaletteFrame2[TImage32(sender).Tag, x div 25] := CurColour;
  DisplayPalette();
end;

procedure TfrmPaletteEditor.imgPalFra31MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  PaletteFrame3[TImage32(sender).Tag, x div 25] := CurColour;
  DisplayPalette();
end;

procedure TfrmPaletteEditor.cmdOKClick(Sender: TObject);
begin
  SaveEditingPalettes();
end;

procedure TfrmPaletteEditor.imgSprPal1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  SprPal[TImage32(sender).Tag, x div 25] := CurColour;
  DisplayPalette();
end;

procedure TfrmPaletteEditor.imgTitScr1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  TitScrPal[TImage32(sender).Tag, x div 25] := CurColour;
  DisplayPalette();
end;

procedure TfrmPaletteEditor.imgLevSel1MouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  LevSelPal[TImage32(sender).Tag, x div 25] := CurColour;
  DisplayPalette();
end;

end.
