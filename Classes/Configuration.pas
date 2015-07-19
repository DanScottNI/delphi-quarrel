unit Configuration;

interface

uses gr32, INIFiles, SysUtils, Classes, Forms;

type

  TPatchConfiguration = class
  public

  end;

  TConfiguration = class
  private
    _Filename : String;
    _Changed : Boolean;
    _RecentlyOpenedFiles : TStringlist;
    _GridlineColour : TColor32;
    // Whether or not to enable the gridlines by default.
    _EnableGridlinesDef : Boolean;
    // The filename of the palette essentially.
    _CurrentPalette : String;
    procedure LoadDefaultOptions;
    function GetNumberOfRecentlyOpenedFiles: Integer;
    function GetRecentFile(index: Integer): String;
    procedure SetRecentFile(index: Integer; const Value: String);
    procedure SetCurrentPalette(pCurrentPalette : String);
    procedure SetGridlineColour(pValue : TColor32);
    procedure SetEnableGridlines(pValue : Boolean);
    procedure SetupMRU;
    procedure CleanupMRU;
    function GetPaletteFilename: String;
  public

    // A procedure to load the options file into the program
    procedure Load();
    // A procedure to save the settings that are currently in the
    // program to the disk
    procedure AddRecentFile(pNewFile : String);
    procedure Save();
    constructor Create(pFilename : String);
    destructor Destroy; override;
    property NumberOfRecentlyOpenedFiles : Integer read GetNumberOfRecentlyOpenedFiles;
    property RecentFile [index : Integer] : String read GetRecentFile write SetRecentFile;
    property PaletteName : String read _CurrentPalette write SetCurrentPalette;
    property PaletteFilename : String read GetPaletteFilename;
    property GridlineColour : TColor32 read _GridlineColour write SetGridlineColour;
    property EnableGridlines : Boolean read _EnableGridlinesDef write SetEnableGridlines;
    property Changed : Boolean read _Changed write _Changed;
  end;

implementation

procedure TConfiguration.Load();
var
  INI : TMemINIFile;
begin
  // Open the ini file.
  INI := TMemINIFile.Create(_Filename);
  try
    _GridlineColour := (INI.ReadInteger('Gridline','A',$FF) shl 24) + (INI.ReadInteger('Gridline','R',$FF) shl 16)
      + (INI.ReadInteger('Gridline','G',$FF) shl 8) + (INI.ReadInteger('Gridline','B',$FF));
    _EnableGridlinesDef := INI.ReadBool('Options','EnableGridlinesDef',True);
    _CurrentPalette := ini.ReadString('General','Palette','matrx21f.pal');    
    SetupMRU();
    _RecentlyOpenedFiles[0] := (INI.ReadString('Recent','RecentFile0',''));
    _RecentlyOpenedFiles[1] := (INI.ReadString('Recent','RecentFile1',''));
    _RecentlyOpenedFiles[2] := (INI.ReadString('Recent','RecentFile2',''));
    _RecentlyOpenedFiles[3] := (INI.ReadString('Recent','RecentFile3',''));
    _RecentlyOpenedFiles[4] := (INI.ReadString('Recent','RecentFile4',''));
    CleanupMRU();
  finally
    FreeAndNil(INI);
  end;
end;

procedure TConfiguration.Save();
var
  INI : TMemINIFile;
begin
  // Open the ini file.
  INI := TMemINIFile.Create(_Filename);

  try
      // Write the gridline settings
    INI.WriteInteger('Gridline','R',(_GridlineColour and $00FF0000) shr 16);
    INI.WriteInteger('Gridline','G',(_GridlineColour and $0000FF00) shr 8);
    INI.WriteInteger('Gridline','B',_GridlineColour and $0000FF);
    INI.WriteInteger('Gridline','A',_GridlineColour shr 24);
    ini.WriteString('General','Palette',_CurrentPalette);
    INI.WriteBool('Options','EnableGridlinesDef',_EnableGridlinesDef);
    SetupMRU();
    INI.WriteString('Recent','RecentFile0',_RecentlyOpenedFiles[0]);
    INI.WriteString('Recent','RecentFile1',_RecentlyOpenedFiles[1]);
    INI.WriteString('Recent','RecentFile2',_RecentlyOpenedFiles[2]);
    INI.WriteString('Recent','RecentFile3',_RecentlyOpenedFiles[3]);
    INI.WriteString('Recent','RecentFile4',_RecentlyOpenedFiles[4]);
    INI.UpdateFile;
  finally
    FreeAndNil(INI);
  end;
end;

procedure TConfiguration.LoadDefaultOptions();
begin
  _EnableGridlinesDef := True;
  _GridlineColour := $FFFFFFFF;
  _CurrentPalette := 'matrx21f.pal';
end;

function TConfiguration.GetNumberOfRecentlyOpenedFiles: Integer;
var
  i : Integer;
  count : Integer;
begin
  if Assigned(_RecentlyOpenedFiles) = True then
  begin
    count := 0;
    for i := 0 to _RecentlyOpenedFiles.Count - 1 do
    begin
      if _RecentlyOpenedFiles[i] <> '' then
        inc(Count);
    end;
    result := count;
  end
  else
    result := -1;
end;

function TConfiguration.GetPaletteFilename: String;
begin
  result := ExtractFileDir(Application.ExeName) + '\Resources\Palette\' + _CurrentPalette;
end;

function TConfiguration.GetRecentFile(index: Integer): String;
begin
  result := _RecentlyOpenedFiles[index];
end;

procedure TConfiguration.SetCurrentPalette(pCurrentPalette: String);
begin
  _CurrentPalette := pCurrentPalette;
  _Changed := true;
end;

procedure TConfiguration.SetEnableGridlines(pValue: Boolean);
begin
  _EnableGridlinesDef := pValue;
  _Changed := true;
end;

procedure TConfiguration.SetGridlineColour(pValue: TColor32);
begin
  _GridlineColour := pValue;
  _Changed := true;
end;

procedure TConfiguration.SetRecentFile(index: Integer; const Value: String);
begin
  _RecentlyOpenedFiles[index] := Value;
  _Changed := True;
end;

procedure TConfiguration.SetupMRU;
var
  i, initcount : Integer;
begin
  if Assigned(_RecentlyOpenedFiles) = false then
    _RecentlyOpenedFiles := TStringList.Create;

  if _RecentlyOpenedFiles.Count < 5 then
  begin
    initcount := _RecentlyOpenedFiles.Count;
    for i := initcount to 4 do
      _RecentlyOpenedFiles.Add('');
  end;

end;

destructor TConfiguration.Destroy;
begin
  if Assigned(_RecentlyOpenedFiles) = true then
    FreeAndNil(_RecentlyOpenedFiles);

  inherited;
end;

procedure TConfiguration.AddRecentFile(pNewFile : String);
var
  i,index : Integer;
  TempString : String;
begin
  index := _RecentlyOpenedFiles.IndexOf(pNewFile);
  if index = -1 then
  begin
    for i := 3 downto 0 do
    begin
      _RecentlyOpenedFiles[i+1] := _RecentlyOpenedFiles[i];
    end;
    _RecentlyOpenedFiles[0] := pNewFile;
  end
  else
  begin
    if index > 0 then
    begin
      TempString := _RecentlyOpenedFiles[index];
      for i := index downto 1  do
      begin
        _RecentlyOpenedFiles[i] := _RecentlyOpenedFiles[i - 1];
      end;
      _RecentlyOpenedFiles[0] := TempString;
    end;
  end;
  _Changed := True;

end;

procedure TConfiguration.CleanupMRU();
var
  i : Integer;
begin
  for i := 4 downto 0 do
  begin
    if FileExists(_RecentlyOpenedFiles[i]) = False then
    begin
      _RecentlyOpenedFiles[i] := '';
      _Changed := True;
    end;
  end;

end;


constructor TConfiguration.Create(pFilename: String);
begin
  _Filename := pFilename;
  if FileExists(_Filename) then
  begin
    Load();
  end
  else
  begin
    LoadDefaultOptions();
  end;
end;

end.
