unit fSaveStateImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BCData;

type
  TfrmSaveStateImport = class(TForm)
    lstLevels: TListBox;
    txtFilename: TEdit;
    cmdBrowse: TButton;
    lblSaveState: TLabel;
    lblLevels: TLabel;
    txtExport: TEdit;
    cmdBrowseExport: TButton;
    lblExportFile: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cmdBrowseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
    procedure cmdBrowseExportClick(Sender: TObject);
  private
    SaveStateOffsets : Array [0 ..1,0..3] of Integer;
    SaveState : Array Of Byte;
    CurrentSaveState : Byte;
    _BattleCityROM : TBattleCityROM;
    procedure LoadSaveState(pFilename: String);
    procedure ExportFile(pFilename: String);
    { Private declarations }
  public
    { Public declarations }
    
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmSaveStateImport: TfrmSaveStateImport;

implementation

{$R *.dfm}

const
  XORKEY : Byte = 63;

procedure TfrmSaveStateImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmSaveStateImport := nil;
  Action := caFree;
end;


procedure TfrmSaveStateImport.LoadSaveState(pFilename: String);
var
  Mem : TMemoryStream;
  i : Integer;
begin

  Mem := TMemoryStream.Create;
  try
    Mem.LoadFromFile(pFilename);

    Mem.Position :=0;
    setlength(SaveState, Mem.Size);
    for i := 0 to mem.Size do
      Mem.Read(SaveState[i],1);
  finally
    FreeAndNil(Mem);
  end;

end;

procedure TfrmSaveStateImport.cmdBrowseClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    txtFilename.Text := OpenDialog.FileName;
    txtFilename.SelStart := Length(txtFilename.text);
    CurrentSaveState := OpenDialog.FilterIndex - 1;

  end;
end;

procedure TfrmSaveStateImport.FormShow(Sender: TObject);
begin
  // Load in the FCE Ultra stats
  SaveStateOffsets[0,0] := $3D4;
  SaveStateOffsets[0,1] := $654;
  SaveStateOffsets[0,2] := $6D4;
  SaveStateOffsets[0,3] := $714;
end;

procedure TfrmSaveStateImport.cmdOKClick(Sender: TObject);
begin
  LoadSaveState(txtFilename.Text);
  ExportFile(txtExport.Text);
  messagebox(Handle,'Demolition has successfully exported the level from the save state.',
  PChar(Application.Title),0);
end;

constructor TfrmSaveStateImport.Create(AOwner: TComponent;
  ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmSaveStateImport.ExportFile(pFilename : String);
var
  LevelFile : TMemoryStream;
  TempBuf : Byte;
  i,x : Integer;
begin
  LevelFile := TMemoryStream.Create;
  try
    // Write the header.
    TempBuf := $57;
    LevelFile.Write(TempBuf,1);
    TempBuf := $43;
    LevelFile.Write(TempBuf,1);
    TempBuf := $44;
    LevelFile.Write(TempBuf,1);
    TempBuf := $41;
    LevelFile.Write(TempBuf,1);
    TempBuf := $54;
    LevelFile.Write(TempBuf,1);
    TempBuf := $41;
    LevelFile.Write(TempBuf,1);

    // Now write the actual level data
    For I := 0 To 7 do
    begin

      For X := 0 To 5 do
      begin
        TempBuf := SaveState[SaveStateOffsets[CurrentSaveState,lstLevels.Itemindex] + (I * 6) + X] xor XORKEY;
        LevelFile.Write(TempBuf,1);
      end;

    end;
    LevelFile.SaveToFile(pFilename);
  finally
    FreeAndNil(LevelFile);
  end;

end;

procedure TfrmSaveStateImport.cmdBrowseExportClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    txtExport.Text := SaveDialog.FileName;
    txtExport.SelStart := Length(txtExport.text);
  end;
end;

end.
