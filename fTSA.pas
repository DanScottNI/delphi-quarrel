unit fTSA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GR32_Image, GR32,GR32_Layers, BCData;

type
  TfrmTSAEditor = class(TForm)
    imgTSA: TImage32;
    procedure FormShow(Sender: TObject);
    procedure imgTSAMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    CurPalette : Byte;
    TileX, TileY : Integer;
    _BattleCityROM : TBattleCityROM;    
    procedure DrawTileSelector;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmTSAEditor: TfrmTSAEditor;

implementation

uses fBattleCity;

{$R *.dfm}

constructor TfrmTSAEditor.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmTSAEditor.DrawTileSelector();
var
  TempBitmap : TBitmap32;
begin
  TempBitmap := TBitmap32.Create;
  try
    TempBitmap.Width := 128;
    TempBitmap.Height := 128;

    _BattleCityROM.DrawBGPatternTable(TempBitmap,CurPalette);

    // Draw the box around the currently selected TSA block
    tempbitmap.FrameRectS(TileX,TileY,TileX+8,TileY + 8,clRed32);
    imgTSA.Bitmap := TempBitmap;

  finally
    FreeAndNil(TempBitmap);
  end;
end;

procedure TfrmTSAEditor.FormShow(Sender: TObject);
begin
  frmBattleCity.CurTSABlock := 0;
  DrawTileSelector();
end;

procedure TfrmTSAEditor.imgTSAMouseUp(Sender: TObject;
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
    frmBattleCity.CurTSABlock := Tile div 16;
  end
  else if button = mbRight then
  begin
    if CurPalette = 3 then
      CurPalette := 0
    else
      inc(CurPalette);
  end;
  DrawTileSelector();
end;

procedure TfrmTSAEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmBattleCity.CurTSABlock :=-1;
  TileX := 0;
  TileY := 0;
  Action := caFree;
  Release;
end;

end.

