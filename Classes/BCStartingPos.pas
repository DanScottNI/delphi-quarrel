unit BCStartingPos;

interface

uses Contnrs, iNESImage;

  type TBCStartPosition = class(TiNESImageAccessor)
  public
    ID : Byte;
    RealX : Byte;
    RealY : Byte;
    XLoc : Integer;
    YLoc : Integer;
    StartPositionType : Byte;
    X : Byte;
    Y : Byte;
  end;

{ This is a class that will be used to store the
    starting positions. This is a descendant of the TObjectList class.
    The reason that I am not using a TObjectList, is that
    for every access, you have to explicitly cast your objects
    to their correct type.}
  TBCStartPositionList = class(TObjectList)
  protected
    function GetItem(Index: Integer) : TBCStartPosition;
    procedure SetItem(Index: Integer; const Value: TBCStartPosition);
  public
    function Add(AObject: TBCStartPosition) : Integer;
    property Items[Index: Integer] : TBCStartPosition read GetItem write SetItem;default;
    function Last : TBCStartPosition;
  end;

implementation

{ TBCStartPositionList }

function TBCStartPositionList.Add(AObject: TBCStartPosition): Integer;
begin
  Result := inherited Add(AObject);
end;

function TBCStartPositionList.GetItem(Index: Integer): TBCStartPosition;
begin
  Result := TBCStartPosition(inherited Items[Index]);
end;

function TBCStartPositionList.Last: TBCStartPosition;
begin
  result := TBCStartPosition(inherited Last);
end;

procedure TBCStartPositionList.SetItem(Index: Integer; const Value: TBCStartPosition);
begin
  inherited Items[Index] := Value;
end;

end.
