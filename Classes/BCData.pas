unit BCData;

interface

uses GR32, Classes, INIFiles, SysUtils, Graphics, iNESImage,
  OffsetList, BCLevel, BCStartingPos, MemINIHexFile;

type
  TBattleCityROM = class(TiNESImageAccessor)
  private
    _PlayerOneBMP, _PlayerTwoBMP, _EnemyBMP : TBitmap32;
    _Tiles : TBitmap32;
    _PatternTable : Array [0.. 8191] of Byte;
    _CurrentLevel : Integer;
    _AssetDirectory : String;
    procedure LoadDataFile(pDataFile: String);
    function GetChanged() : Boolean;
    procedure SetChanged(Value : Boolean);
    procedure SetLevel(pLevelIndex : Integer);
    function GetFlagTSA(pIndex1, pIndex2 : Byte) : Byte;
    procedure SetFlagTSA(pIndex1, pIndex2 : Byte; pValue : Byte);
    function GetFortifiedFlagTSA(pIndex1, pIndex2 : Byte) : Byte;
    procedure SetFortifiedFlagTSA(pIndex1, pIndex2 : Byte; pValue : Byte);
    procedure LoadAssetBitmaps();
  public
    Palette : Array [0..7,0..3] of Byte;
    // The start of the palette in the ROM
    PaletteStart : Integer;
    // The start of the sprite palette in the ROM
    SpritePal : Integer;
    // The start of the sprite palette in the ROM
    PalFrame1 : Integer;
    // The start of the sprite palette in the ROM
    PalFrame2 : Integer;
    // The start of the sprite palette in the ROM
    LevelSelPal : Integer;
    // The start of the sprite palette in the ROM
    TitleScrPal : Integer;
    TankStatus1, TankStatus2 : Integer;
    // The start of the TSA data in the ROM
    TSADataStart : Integer;
    // The start of the attribute data.
    AttStart : Integer;
    // The location of the starting lives in the ROM
    StartingLives : Integer;
    // The number of levels
    NumberOfLevels : Integer;
    // The Flag TSA location
    FlagTSALoc : Integer;
    // The fortified flag TSA location
    FortTSALoc : Integer;
    // The array that holds the fortified flag TSA
    FortFlagTSAStr : Array [0..3,0..5] of Byte;
    // Locations of the sprite pattern table, and the background pattern table
    SpritePatternTable,BGPatternTable : Integer;
    Levels : TBCLevelList;
    CurrentLevel : TBCLevel;
    procedure Save();
    function GetStartingLives() : Byte;
    procedure SetStartingLives(pStartingLives : Byte);
    constructor Create(pFilename : String; pDataFileName : String;pPaletteFile: String; pAssetDirectory : String);
    destructor Destroy;override;
    procedure DrawLevelData(var pBitmap : TBitmap32; pLevelIndex : Integer; pDisplayItems : Byte);overload;
    procedure DrawLevelData(var pBitmap : TBitmap32; pDisplayItems : Byte);overload;
    procedure LoadPatternTable();
    procedure LoadPalette();
    procedure DrawBGPatternTable(var pBitmap : TBitmap32;pPal : Byte);
    procedure DrawLevelTile(pTileID : Integer);
    procedure DrawTileSelector(var pBitmap : TBitmap32);
    procedure EditTSA(pTileID, pX, pY, pNewTile: Byte);
    procedure IncrementTileAttribute(pTileID : Byte);
    procedure DrawNormalFlag(var pBitmap : TBitmap32);
    procedure DrawLevelTiles;
    procedure LoadPaletteFile(pPaletteFile: String);
    procedure DrawTank(var pBitmap : TBitmap32;pIndex : Byte);
    property Level : Integer read _CurrentLevel write SetLevel;
    property Changed : Boolean read GetChanged write SetChanged;
    property FlagTSA[index1, index2 : byte] : Byte read GetFlagTSA write SetFlagTSA;
    property FortifiedFlagTSA[index1, index2 : byte] : Byte read GetFortifiedFlagTSA write SetFortifiedFlagTSA;
  end;

var
  { The list of palettes that loaded in so the user
  can select what palette to use.}
  Palettes : TStringList;

implementation

uses uGlobals;

const
  BGPATTERNTABLEOFFSET : Integer = 4096;
  SPRPATTERNTABLEOFFSET : Integer = 0;

constructor TBattleCityROM.Create(pFilename: String; pDataFileName : String;pPaletteFile: String; pAssetDirectory : String);
begin
  TiNESImageAccessor.ROM := TiNESImage.Create(pFilename);
  _AssetDirectory := pAssetDirectory;
  _CurrentLevel := -1;
  if FileExists(pPaletteFile) then
    ROM.LoadPaletteFile(pPaletteFile)
  else
    ROM.LoadDefaultPalette;
  LoadDataFile(pDataFileName);
  // Load in the background pattern table.
  LoadPatternTable();
  // Load in the palette
  LoadPalette();
  // Draw all the level tiles.
  DrawLevelTiles();
end;

procedure TBattleCityROM.DrawLevelData(var pBitmap: TBitmap32;
  pLevelIndex: Integer; pDisplayItems : Byte);
var
  i, x: Integer;
begin
  for i := 0 to 12 do
    begin
      for x := 0 to 12 do
      begin
        pBitmap.Draw(bounds(x*16,i*16,16,16),bounds(CurrentLevel.LevelData[i,x] * 16,0,16,16),_Tiles);
      end;
    end;

  // load in the bitmaps that represent the objects.
  LoadAssetBitmaps;

  // If the user has chosen to render the enemy start positions, loop through
  // each one, and display them.
  if pDisplayItems and uGlobals.VIEWENEMYSTARTPOS = uGlobals.VIEWENEMYSTARTPOS then
  begin
    for i := 0 to CurrentLevel.StartingLocations.Count - 1 do
    begin
      if CurrentLevel.StartingLocations[i].StartPositionType = uGlobals.STARTINGPOSTYPEENEMY then
        pBitmap.Draw((CurrentLevel.StartingLocations[i].X * 16),CurrentLevel.StartingLocations[i].Y *16,_EnemyBMP)
    end;
  end;

  // If the user has chosen to render the player start positions, loop through
  // each player, and display them.
  if pDisplayItems and uGlobals.VIEWPLAYERSTARTPOS = uGlobals.VIEWPLAYERSTARTPOS then
  begin
    for i := 0 to CurrentLevel.StartingLocations.Count - 1 do
    begin
      if CurrentLevel.StartingLocations[i].StartPositionType = uGlobals.STARTINGPOSTYPEPLAYERONE then
        pBitmap.Draw((CurrentLevel.StartingLocations[i].X * 16),CurrentLevel.StartingLocations[i].Y *16,_PlayerOneBMP)
      else if CurrentLevel.StartingLocations[i].StartPositionType = uGlobals.STARTINGPOSTYPEPLAYERTWO then
        pBitmap.Draw((CurrentLevel.StartingLocations[i].X * 16),CurrentLevel.StartingLocations[i].Y *16,_PlayerTwoBMP);
    end;
  end;

  // If the pRenderFlag variable has been set to true, then
  if pDisplayItems and uGlobals.VIEWNORMALFLAG = uGlobals.VIEWNORMALFLAG then
  begin
    DrawNormalFlag(pBitmap);
  end;
end;

destructor TBattleCityROM.Destroy;
begin
  FreeAndNil(_PlayerOneBMP);
  FreeAndNil(_PlayerTwoBMP);
  FreeAndNil(_EnemyBMP);
end;

procedure TBattleCityROM.DrawLevelData(var pBitmap : TBitmap32; pDisplayItems : Byte);
begin
  DrawLevelData(pBitmap, _CurrentLevel,  pDisplayItems);
end;

// Draw all the level tiles.
procedure TBattleCityROM.DrawLevelTiles();
var
  i : Integer;
begin

  if Assigned(_Tiles) = False then
    _Tiles := TBitmap32.Create;

  _Tiles.Width := 256;
  _Tiles.Height := 16;

  for i := 0 to 15 do
    DrawLevelTile(i);
  //_Tiles.SaveToFile('c:\test.bmp');
end;

procedure TBattleCityROM.DrawBGPatternTable(var pBitmap: TBitmap32;pPal : Byte);
var
  i,x : Integer;
begin
  for i := 0 to 15 do
    for x := 0 to 15 do
      ROM.DrawNESTile(@_PatternTable[BGPATTERNTABLEOFFSET + ((i*16 + x) * 16)],pBitmap,x*8,i*8,@Palette[pPal,0]);
end;

procedure TBattleCityROM.DrawTank(var pBitmap: TBitmap32; pIndex: Byte);
begin
  ROM.DrawNESTile(@_PatternTable[SPRPATTERNTABLEOFFSET + ((pIndex * $20)*16)] , pBitmap, 0,0,@Palette[4,0]);
  ROM.DrawNESTile(@_PatternTable[SPRPATTERNTABLEOFFSET + ((pIndex * $20)*16) + $10] , pBitmap, 0,8,@Palette[4,0]);
  ROM.DrawNESTile(@_PatternTable[SPRPATTERNTABLEOFFSET + ((pIndex * $20)*16) + $20] , pBitmap, 8,0,@Palette[4,0]);
  ROM.DrawNESTile(@_PatternTable[SPRPATTERNTABLEOFFSET + ((pIndex * $20)*16) + $30] , pBitmap, 8,8,@Palette[4,0]);
end;

procedure TBattleCityROM.DrawTileSelector(var pBitmap: TBitmap32);
var
  i,x : Integer;
begin
  for i := 0 to 7 do
      for x := 0 to 1 do
        pBitmap.Draw(bounds(x*16,i*16,16,16),bounds((i*2+x) * 16,0,16,16),_Tiles);
end;

procedure TBattleCityROM.DrawNormalFlag(var pBitmap : TBitmap32);
var
  i,x, InitialX, InitialY : Integer;
begin
  InitialX := 80;
  InitialY := 176;
  
  for i := 0 to 3 do
    for x := 0 to 5 do
      ROM.DrawNESTile(@_PatternTable[BGPATTERNTABLEOFFSET + (FlagTSA[i,x]* $10)], pBitmap, InitialX + (x*8),InitialY + (i*8),@palette[0,0]);
end;

procedure TBattleCityROM.DrawLevelTile(pTileID: Integer);
var
  TileDataOffset : Integer;
  Pal : Pointer;
begin
  TileDataOffset := TSADataStart + (pTileID * 4);
  // Work out which attribute to use.
  pal := @palette[ROM[AttStart + pTileID],0];
  // Draw the tile.
  ROM.DrawNESTile(@_PatternTable[BGPATTERNTABLEOFFSET + (ROM[TileDataOffset] * $10)], _Tiles, pTileID*16, 0,Pal);
  ROM.DrawNESTile(@_PatternTable[BGPATTERNTABLEOFFSET + (ROM[TileDataOffset + 1] * $10)], _Tiles, pTileID*16 +8, 0,Pal);
  ROM.DrawNESTile(@_PatternTable[BGPATTERNTABLEOFFSET + (ROM[TileDataOffset + 2] * $10)], _Tiles, (pTileID*16), 8,Pal);
  ROM.DrawNESTile(@_PatternTable[BGPATTERNTABLEOFFSET + (ROM[TileDataOffset + 3] * $10)], _Tiles, (pTileID*16) + 8, 8,Pal);
end;

function TBattleCityROM.GetChanged: Boolean;
begin
  result := ROM.Changed;
end;

function TBattleCityROM.GetFlagTSA(pIndex1, pIndex2: Byte): Byte;
begin
  result :=  ROM[FlagTSALoc + (pIndex1 * 7) + pIndex2];
end;

function TBattleCityROM.GetFortifiedFlagTSA(pIndex1, pIndex2: Byte): Byte;
begin
  result :=  ROM[FortTSALoc + (pIndex1 * 7) + pIndex2];
end;

procedure TBattleCityROM.SetFlagTSA(pIndex1, pIndex2, pValue: Byte);
begin
  ROM[FlagTSALoc + (pIndex1 * 7) + pIndex2] := pValue;
end;

procedure TBattleCityROM.SetFortifiedFlagTSA(pIndex1, pIndex2, pValue: Byte);
begin
  ROM[FortTSALoc + (pIndex1 * 7) + pIndex2] := pValue;
end;

function TBattleCityROM.GetStartingLives: Byte;
begin
  GetStartingLives := self.ROM[self.StartingLives] - 1;
end;

procedure TBattleCityROM.IncrementTileAttribute(pTileID: Byte);
var
  CurAtt : Byte;
begin
  // Take the current attribute, and if it's 3 (as 3 is the NES's max), then
  // reset it back to zero. Otherwise, increment it by 1.
  CurAtt := ROM[AttStart + pTileID];
  if CurAtt = 3 then
    CurAtt := 0
  else
    inc(CurAtt);
  ROM[AttStart + pTileID] := CurAtt;
  // Now redraw the tile.
  DrawLevelTile(pTileID);
end;

procedure TBattleCityROM.SetChanged(Value: Boolean);
begin
  ROM.Changed := Value;
end;

procedure TBattleCityROM.SetLevel(pLevelIndex: Integer);
begin

  // If the current level is set, then
  // save the starting positions.
  if _CurrentLevel > -1 then
  begin
    CurrentLevel.SaveStartingPositions;
  end;

  // Set the current level to the new level index.
  self._CurrentLevel := pLevelIndex;
  CurrentLevel := Levels[_CurrentLevel];

  // Load the starting positions for the specific level.
  CurrentLevel.LoadStartingPositions;

  if Assigned(_Tiles) = False then
    _Tiles := TBitmap32.Create;

  _Tiles.Width := 256;
  _Tiles.Height := 16;

  LoadPalette();
end;

procedure TBattleCityROM.SetStartingLives(pStartingLives: Byte);
begin
  self.ROM[self.StartingLives] := pStartingLives + 1;
end;

procedure TBattleCityROM.Save;
begin
  ROM.Save;
end;

procedure TBattleCityROM.LoadAssetBitmaps;
begin
  // Load in all the player/enemy images.
  // If the bitmap that represents player one isn't loaded, then
  // create the object, and load in the bitmap.
  if Assigned(_PlayerOneBMP) = false then
  begin
    _PlayerOneBMP := TBitmap32.Create;
    _PlayerOneBMP.Width := 16;
    _PlayerOneBMP.Height := 16;
    _PlayerOneBMP.LoadFromFile(_AssetDirectory + '\playerone.bmp');
  end;

  // If the bitmap that represents player two isn't loaded, then
  // create the object, and load in the bitmap.
  if Assigned(_PlayerTwoBMP) = false then
  begin
    _PlayerTwoBMP := TBitmap32.Create;
    _PlayerTwoBMP.Width := 16;
    _PlayerTwoBMP.Height := 16;
    _PlayerTwoBMP.LoadFromFile(_AssetDirectory + '\playertwo.bmp');
  end;

  // If the bitmap that represents the enemy isn't loaded, then
  // create the object, and load in the bitmap.
  if Assigned(_EnemyBMP) = false then
  begin
    _EnemyBMP := TBitmap32.Create;
    _EnemyBMP.Width := 16;
    _EnemyBMP.Height := 16;
    _EnemyBMP.LoadFromFile(_AssetDirectory + '\enemy.bmp');
  end;

end;

procedure TBattleCityROM.LoadPalette;
var
  i,x : Integer;
begin
  for i := 0 to 3 do
    for x := 0 to 3 do
      Palette[i,x]:=ROM[PaletteStart + (i*4) + x];

  for i := 4 to 7 do
    for x := 0 to 3 do
      Palette[i,x]:=ROM[SpritePal + ((i-4) *4) + x];
end;

procedure TBattleCityROM.LoadPatternTable;
var
  i, CHRBankOffset : Integer;
begin
  CHRBankOffset := BGPatternTable;
  for i := 0 to 4095 do
  begin
    _PatternTable[i + BGPATTERNTABLEOFFSET] := ROM[CHRBankOffset + i];
  end;

  CHRBankOffset := SpritePatternTable;
  for i := 0 to 4095 do
  begin
    _PatternTable[i + SPRPATTERNTABLEOFFSET] := ROM[CHRBankOffset + i];
  end;

end;

procedure TBattleCityROM.EditTSA(pTileID,pX,pY,pNewTile : Byte);
begin
  ROM[TSADataStart + (pTileID * 4) + ((pY * 2) + pX)] := pNewTile;
  // Redraw the tile.
  DrawLevelTile(pTileID);
end;

procedure TBattleCityROM.LoadDataFile(pDataFile : String);
var
  ini : TMemINIHexFile;
  i, x : Integer;
  Lvl : TBCLevel;
  StartPos : TBCStartPosition;
begin
  ini := TMemINIHexFile.Create(pDataFile);
  try
    // Load the number of levels into memory
    NumberOfLevels := ini.ReadInteger('General','NumberOfLevels',0);

    Levels := TBCLevelList.Create(true);

    // If the number of levels is 0, then don't bother to
    // loop through loading all the level locations into memory
    if NumberOfLevels > 0 then
    begin
      for i := 0 to NumberOfLevels -1 do
      begin
        Levels.Add(TBCLevel.Create);
        Lvl := Levels.Last;
        // Load in the data for the enemies.
        Lvl.LevelDataOffset := INI.ReadHexValue('Level' + IntToStr(i),'Offset');
        Lvl.EnemyDataOffset := INI.ReadHexValue('Level' + IntToStr(i),'Enemy');
        Lvl.EnemyAmountOffset := INI.ReadHexValue('Level' + IntToStr(i),'Amount');
        // Create enemy objects.
        Lvl.CreateEnemy();

        // If the ini file section 'TanksStartingPost' exists,
        // load in all the
        if INI.SectionExists('TanksStartingPos') then
        begin
          // Load in the tank's starting position.
          lvl.StartingLocations := TBCStartPositionList.Create(true);

          for x := 0 to 2 do
          begin
            lvl.StartingLocations.Add(TBCStartPosition.Create());
            StartPos := lvl.StartingLocations.Last;
            StartPos.ID := x;
            StartPos.XLoc := INI.ReadHexValue('TanksStartingPos','Tank' + IntToStr(x+1) + 'X');
            StartPos.YLoc := INI.ReadHexValue('TanksStartingPos','Tank' + IntToStr(x+1) + 'Y');
            StartPos.StartPositionType := uGlobals.STARTINGPOSTYPEENEMY;
          end;

          // Load in player one.
          lvl.StartingLocations.Add(TBCStartPosition.Create());
          StartPos := lvl.StartingLocations.Last;
          StartPos.ID := 3;
          StartPos.XLoc := INI.ReadHexValue('TanksStartingPos','P1X');
          StartPos.YLoc := INI.ReadHexValue('TanksStartingPos','P1Y');
          StartPos.StartPositionType := uGlobals.STARTINGPOSTYPEPLAYERONE;

          // Load in player two.
          lvl.StartingLocations.Add(TBCStartPosition.Create());
          StartPos := lvl.StartingLocations.Last;
          StartPos.ID := 4;
          StartPos.XLoc := INI.ReadHexValue('TanksStartingPos','P2X');
          StartPos.YLoc := INI.ReadHexValue('TanksStartingPos','P2Y');
          StartPos.StartPositionType := uGlobals.STARTINGPOSTYPEPLAYERTWO;
        end;
      end;
    end;

    // Now load the palette location into memory
    PaletteStart := INI.ReadHexValue('Palette','LevelPalette');
    // Now load the sprite palette location into memory
    SpritePal := INI.ReadHexValue('Palette','PaletteSpr');

    // Now load the first palette frame location into memory
    PalFrame1 := INI.ReadHexValue('Palette','PaletteFrame1');

    // Now load the second palette frame location into memory
    PalFrame2 := INI.ReadHexValue('Palette','PaletteFrame2');

    // Now load the level select palette location into memory
    LevelSelPal := INI.ReadHexValue('Palette','LevelSelPalette');

    // Now load the title screen palette location into memory
    TitleScrPal := INI.ReadHexValue('Palette','TitleScrPalette');

    // Load the pattern table location into memory
    BGPatternTable := INI.ReadHexValue('PatternTable','PatternTableStart');

    // Load the flag TSA location into memory
    FlagTSALoc := INI.ReadHexValue('FlagTSA','FlagTSA');

    // Load the fortified flag TSA location into memory
    FortTSALoc := INI.ReadHexValue('FlagTSA','FortTSA');

    // Load the sprite pattern table location into memory
    SpritePatternTable := INI.ReadHexValue('PatternTable','SpritePatternTable');

    // Load the starting lives location into memory
    StartingLives := INI.ReadHexValue('General','StartingLives');

    // Now load all the TSA data into memory.
    TSADataStart := INI.ReadHexValue('General','TSADataStart');

    // Now load all the attribute data into memory.
    AttStart := INI.ReadHexValue('General','BlockAtts');

    // Now load in the tank starting type
//    TankStatus1 := StrToInt('$' + INI.ReadString('TankStatus','TankStatus1','2374'));
    TankStatus2 := INI.ReadHexValue('TankStatus','TankStatus2');
   
  finally
    FreeAndNil(INI);
  end;
end;

procedure TBattleCityROM.LoadPaletteFile(pPaletteFile : String);
begin
  ROM.LoadPaletteFile(pPaletteFile);
end;


end.
