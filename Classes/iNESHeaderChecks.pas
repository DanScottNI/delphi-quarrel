unit iNESHeaderChecks;

interface

uses BCData;

function LoadiNESHeader(): Boolean;
function CheckiNESHeader(): Integer;

type
  TRomHeader = record
    RomType : array[0..2] of Byte;
    Ctrl,
    PRGROM,
    CHRRAM,
    ROMctrl1,
    ROMctrl2 : Byte;
    Expansion : array[0..7] of Byte;
  end;

var
  ROMHeader : TROMheader;
    ROMSize,
    VROMSize,
    ROMType,
    MMCType,
    Mirroring,
  PRGBytes,
  CHRBytes,
  CartSize,
    MirrorXor : Integer;
const
  ROM_MIRROR  = 1;
  ROM_WRAM    = 2;
  ROM_TRAINER = 4;
  ROM_FOUR    = 8;

implementation

uses uGlobals;

// This function is editor independent. It
// works without any editing at all.
function LoadiNESHeader(): Boolean;
var
  i: integer;
begin

  // Load the iNES Header information in
  // from the byte array
{  with ROMHeader do
  begin
    for i := 0 to 2 do
      RomType[i] := ROM[i];

    Ctrl := ROM[3];
    PRGROM := ROM[4];
    CHRRAM := ROM[5];
    ROMctrl1 := ROM[6];
    ROMctrl2 := ROM[7];

    for i:= 0 to 7 do
      Expansion[i] := ROM[8+i];
  end;

  if ((ROMHeader.RomType[0] <> $4E) or (ROMHeader.RomType[1] <> $45) or (ROMHeader.RomType[2] <> $53)) then
  begin

   Result := false;
   Exit;
  end;

  ROMSize  := Ord(ROMHeader.PRGROM);
  VROMSize := Ord(ROMHeader.CHRRAM);
  ROMType  := Ord(ROMHeader.ROMctrl1);
  MMCType  := (Ord(ROMHeader.ROMctrl1) shr 4);
  CartSize := ROMSize shl 4 + VROMSize * 8;}

{  if ROMHeader.Expansion[0]=$0 then
    MMCType := MMCType or (Ord(ROMHeader.ROMctrl2) and $F0);

  Mirroring := (Ord(ROMHeader.ROMctrl1) and ROM_MIRROR);

  MirrorXor := $400 shl Mirroring; }{ Horizontal : $400; Vertical : $800}

{  PRGBytes := $4000 * ROMSize;
  CHRBytes := $2000 * VROMSize;}

  Result := true;
end; { LoadNES }

// This is really editor dependent. You need
// to set up the precise mapper type, PRG, and CHR
// that you are looking for. The Integer value returns
// a number of error codes. Here they are:
// 0 - All checks successfully completed.
// 1 - NES text was missing.
// 2 - The PRG that is specified is wrong.
// 3 - The CHR that is specified is wrong.
// 4 - The MMC Type is incorrect.
// 5 - The mirroring that is specified is incorrect.
// 6 - There is a trainer present when there shouldn't be.
// 7 - There is SRAM present, when there shouldn't be. 
// Stick to these error codes please!
function CheckiNESHeader(): Integer;
begin
  if LoadiNESHeader() = true then
  begin
    // First we check for the size of the PRG.
//    if
  end
  else
  begin
    // For some odd reason, there is no NES text!
    // Are you sure that it is a NES ROM in the
    // iNES format?
    Result := 1;
    exit;
  end;
  // Yay, we passed all the tests fine!
  Result := 0;
end;

end.
