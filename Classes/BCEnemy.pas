unit BCEnemy;

interface

uses iNESImage, contnrs;

// Used to store information about the enemy.
type
  TBCEnemy = class(TiNESImageAccessor)
  public
    EnemyType : Byte;
    Unused1 : Byte;
    Unused2 : Byte;
    Powerups : Byte;
    ShieldStrength : Byte;
    Amount : Byte;
    constructor Create(pDataOffset : Integer;pAmountOffset : Integer);
  end;

  { This is a class that will be used to store the
    levels. This is a descendant of the TObjectList class.
    The reason that I am not using a TObjectList, is that
    for every access, you have to explicitly cast your objects
    to their correct type.}
  TBCEnemyList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TBCEnemy;
    procedure SetItem(Index: Integer; const Value: TBCEnemy);
  public
    function Add(AObject: TBCEnemy) : Integer;
    property Items[Index: Integer] : TBCEnemy read GetItem write SetItem;default;
    function Last : TBCEnemy;
  end;

implementation

{ TBCEnemy }
constructor TBCEnemy.Create(pDataOffset : Integer;pAmountOffset : Integer);
var
  EnemyByte : Byte;
begin
  EnemyByte :=ROM[pDataOffset];
  self.EnemyType := EnemyByte Shr 5;
  self.Unused1 := (Enemybyte Shr 4) and 1;
  self.Unused2 := (Enemybyte Shr 3) and 1;
  self.Powerups := (EnemyByte Shr 2) and 1;
  self.ShieldStrength := EnemyByte and 3;
  self.Amount :=ROM[pAmountOffset];
end;

{ TBCEnemyList }

function TBCEnemyList.Add(AObject: TBCEnemy): Integer;
begin
  Result := inherited Add(AObject);
end;

function TBCEnemyList.GetItem(Index: Integer): TBCEnemy;
begin
  Result := TBCEnemy(inherited Items[Index]);
end;

function TBCEnemyList.Last: TBCEnemy;
begin
  result := TBCEnemy(inherited Last);
end;

procedure TBCEnemyList.SetItem(Index: Integer; const Value: TBCEnemy);
begin
  inherited Items[Index] := Value;
end;

end.
