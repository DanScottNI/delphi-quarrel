unit BCLevel;

interface
uses iNESImage, contnrs, BCEnemy, sysutils, BCStartingPos;

  type
    TBCLevel = class(TiNESImageAccessor)
    private
      procedure SetLevelData(pYCoord,pXCoord : Integer; pValue : Byte);
      function GetLevelData(pYCoord, pXCoord : Integer) : Byte;
    public
      LevelDataOffset : Integer;
      EnemyDataOffset : Integer;
      EnemyAmountOffset : Integer;
      EnemyList : TBCEnemyList;
      StartingLocations : TBCStartPositionList;
      constructor Create();
      destructor Destroy();override;
      procedure CreateEnemy();
      procedure SaveStartingPositions();
      procedure LoadStartingPositions();
      property LevelData[index1, index2 : Integer] : Byte read GetLevelData write SetLevelData;
    end;

{ This is a class that will be used to store the
    levels. This is a descendant of the TObjectList class.
    The reason that I am not using a TObjectList, is that
    for every access, you have to explicitly cast your objects
    to their correct type.}
  TBCLevelList = class(TObjectList)
  protected
    function GetLevelItem(Index: Integer) : TBCLevel;
    procedure SetLevelItem(Index: Integer; const Value: TBCLevel);
  public
    function Add(AObject: TBCLevel) : Integer;
    property Items[Index: Integer] : TBCLevel read GetLevelItem write SetLevelItem;default;
    function Last : TBCLevel;
  end;

implementation

{ TBCLevelList }

function TBCLevelList.Add(AObject: TBCLevel): Integer;
begin
  Result := inherited Add(AObject);
end;

function TBCLevelList.GetLevelItem(Index: Integer): TBCLevel;
begin
  Result := TBCLevel(inherited Items[Index]);
end;

function TBCLevelList.Last: TBCLevel;
begin
  result := TBCLevel(inherited Last);
end;

procedure TBCLevelList.SetLevelItem(Index: Integer; const Value: TBCLevel);
begin
  inherited Items[Index] := Value;
end;

{ TBCLevel }

constructor TBCLevel.Create;
begin
  EnemyList := TBCEnemyList.Create();
end;

// Creates objects representing the data of the four enemys in the level.
procedure TBCLevel.CreateEnemy;
begin
  if EnemyList = nil then
    EnemyList := TBCEnemyList.Create();

  EnemyList.Add(TBCEnemy.Create(self.EnemyDataOffset,self.EnemyAmountOffset));
  EnemyList.Add(TBCEnemy.Create(self.EnemyDataOffset+1,self.EnemyAmountOffset+1));
  EnemyList.Add(TBCEnemy.Create(self.EnemyDataOffset+2,self.EnemyAmountOffset+2));
  EnemyList.Add(TBCEnemy.Create(self.EnemyDataOffset+3,self.EnemyAmountOffset+3));
end;

destructor TBCLevel.Destroy;
begin
  FreeAndNil(EnemyList);
end;

function TBCLevel.GetLevelData(pYCoord, pXCoord: Integer): Byte;
var
  LevelByte : Byte;
begin
  LevelByte := ROM[self.LevelDataOffset + (pYCoord * 7) + (pXCoord div 2)];

  if (pXCoord mod 2 = 1) then
  begin
    LevelByte := (LevelByte) and $0F;
  end
  else
  begin
    LevelByte := (LevelByte shr 4) and $0F;
  end;

  result := LevelByte;
end;

procedure TBCLevel.LoadStartingPositions;
var
  x : integer;
begin
  for x := 0 to 4 do
  begin
    StartingLocations[x].RealX := ROM[StartingLocations[x].XLoc];
    StartingLocations[x].RealY := ROM[StartingLocations[x].YLoc];
    StartingLocations[x].X := (StartingLocations[x].RealX shr 4) - 1;
    StartingLocations[x].Y := (StartingLocations[x].RealY shr 4) - 1;
  end;
end;

procedure TBCLevel.SaveStartingPositions;
var
  x : Integer;
begin
  for x := 0 to 4 do
  begin
    StartingLocations[x].RealX := ((StartingLocations[x].X + 1) shl 4) + (StartingLocations[x].RealX and $0F);
    StartingLocations[x].RealY := ((StartingLocations[x].Y + 1) shl 4) + (StartingLocations[x].RealY and $0F);
    ROM[StartingLocations[x].XLoc] := StartingLocations[x].RealX;
    ROM[StartingLocations[x].YLoc] := StartingLocations[x].RealY;
  end;

end;

procedure TBCLevel.SetLevelData(pYCoord, pXCoord: Integer; pValue: Byte);
var
  LevelByte : Byte;
  Offset : Integer;
begin
  Offset := self.LevelDataOffset + (pYCoord * 7) + (pXCoord div 2);
  LevelByte := ROM[Offset];

  if (pXCoord mod 2 = 1) then
  begin
    LevelByte := (LevelByte and $F0) + (pValue and $0F);
  end
  else
  begin
    LevelByte := (LevelByte and $0F) + ((pValue and $0F) shl 4);
  end;

  ROM[Offset] := LevelByte;
end;

end.
