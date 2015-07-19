unit fImportLevel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, fBattleCity, BCData;

type
  TfrmImportLevel = class(TForm)
    txtFileName: TEdit;
    cmdExport: TButton;
    lblFilename: TLabel;
    cmdBrowse: TButton;
    cbPhase: TComboBox;
    lblPhase: TLabel;
    cmdCancel: TButton;
    OpenDialog: TOpenDialog;
    procedure cmdBrowseClick(Sender: TObject);
    procedure cmdExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _BattleCityROM : TBattleCityROM;
    procedure ImportFile(pFilename: String);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmImportLevel: TfrmImportLevel;

const
  XORKEY : Byte = 11;

implementation

{$R *.dfm}

uses uGlobals;

procedure TfrmImportLevel.cmdBrowseClick(Sender: TObject);
begin
  if opendialog.execute then
  begin
    txtFilename.Text := OpenDialog.FileName;
    txtFilename.SelStart := length(txtFilename.Text);
  end;
end;

procedure TfrmImportLevel.cmdExportClick(Sender: TObject);
begin
  if FileExists(txtFileName.Text) = True then
    ImportFile(txtFileName.Text)
  else
    MessageDlg('The file specified does not exist.', mtError, [mbOK], 0);
end;

constructor TfrmImportLevel.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmImportLevel.ImportFile(pFilename : String);
var
  LevelFile : TMemoryStream;
  TempBuf : Byte;
  i,x : Integer;
begin
  { TODO : Disabled Code }
{  LevelFile := TMemoryStream.Create;
  try
    LevelFile.LoadFromFile(pFilename);

    // Now we check that the data file has a valid header.
    // If it does not, then exit the subroutine, freeing
    // the memorystream in the the process.
    LevelFile.Read(TempBuf,1);
    if TempBuf <> $42 then
    begin
      FreeAndNil(LevelFile);
      Exit;
    end;
    LevelFile.Read(TempBuf,1);
    if TempBuf <> $43 then
    begin
      MessageDlg('Quarrel has detected that this data file has not got a valid header. Aborting import.', mtError, [mbOK], 0);
      FreeAndNil(LevelFile);
      Exit;
    end;
    LevelFile.Read(TempBuf,1);
    if TempBuf <> $44 then
    begin
      MessageDlg('Quarrel has detected that this data file has not got a valid header. Aborting import.', mtError, [mbOK], 0);
      FreeAndNil(LevelFile);
      Exit;
    end;
    LevelFile.Read(TempBuf,1);
    if TempBuf <> $41 then
    begin
      MessageDlg('Quarrel has detected that this data file has not got a valid header. Aborting import.', mtError, [mbOK], 0);
      FreeAndNil(LevelFile);
      Exit;
    end;
    LevelFile.Read(TempBuf,1);
    if TempBuf <> $54 then
    begin
      MessageDlg('Quarrel has detected that this data file has not got a valid header. Aborting import.', mtError, [mbOK], 0);
      FreeAndNil(LevelFile);
      Exit;
    end;
    LevelFile.Read(TempBuf,1);
    if TempBuf <> $41 then
    begin
      MessageDlg('Quarrel has detected that this data file has not got a valid header. Aborting import.', mtError, [mbOK], 0);
      FreeAndNil(LevelFile);
      Exit;
    end;
    // Yay, we've passed the header checks. Now decrypt the data
    // so it can be used.

    for i := 6 to LevelFile.Size -1 do
    begin
      TempBuf :=0;
      LevelFile.Seek(i,soFromBeginning);
      LevelFile.Read(TempBuf,1);
      // First to decrypt the data, we need to
      // rotate the bits back.
      // Next we need to xor it.
      //TempBuf := RotateByte(TempBuf xor XORKEY);
      TempBuf := TempBuf xor XORKEY;
      LevelFile.Seek(i,soFromBeginning);
      // Next we rewrite it to the memorystream for easy access.
      LevelFile.Write(TempBuf,1);
    end;

    // We have decrypted the data successfully.
    // Now load it into memory.
    // First seek to the beginning of the file
    // past the header.
    LevelFile.Seek(6,soFromBeginning);

    // Now load the level data
    For I := 0 To 12 do
    begin

      For X := 0 To 6 do
      begin
        TempBuf := 0;
        LevelFile.Read(TempBuf,1);
        BattleCityROM.ROM[LevelLoc[cbPhase.ItemIndex] + (I * 7) + X] := TempBuf;
      end;

    end;

    // Now read the enemy data
    for i := 0 to 3 do
    begin
      TempBuf := 0;
      LevelFile.Read(TempBuf,1);

      BattleCityROM.ROM[EnemyLoc[cbPhase.ItemIndex] + I] := TempBuf;
    end;

    // Now read the enemy amount data
    for i := 0 to 3 do
    begin
      TempBuf := 0;
      LevelFile.Read(TempBuf,1);
      BattleCityROM.ROM[EnemyNumbersLoc[cbPhase.ItemIndex] + I] := TempBuf;
    end;

    if cbPhase.ItemIndex = frmBattleCity.CurrentLevel then
    begin
      frmBattleCity.LoadLevelData();
      frmBattleCity.DrawLevelData();
      //frmBattleCity.Caption := EDITORNAME + ' ' + VERSIONNUMBER + ' - Level ' + IntToStr(frmBattleCity.CurrentLevel + 1);
    end;
  finally
    FreeAndNil(LevelFile);
  end;
  ModalResult := mrOK;}

end;


procedure TfrmImportLevel.FormShow(Sender: TObject);
var
  I : Integer;
begin
  { TODO : Disabled Code }
{  for i := 0 to NumberOfLevels - 1 do
    cbPhase.Items.Add('Level ' + IntToStr(i+1));
  cbPhase.ItemIndex := 0;}
end;

end.
