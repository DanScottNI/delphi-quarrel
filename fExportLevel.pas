unit fExportLevel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BCData;

type
  TfrmExportLevel = class(TForm)
    txtOutputFileName: TEdit;
    cmdExport: TButton;
    lblFilename: TLabel;
    cmdBrowse: TButton;
    cbPhase: TComboBox;
    lblPhase: TLabel;
    SaveDialog: TSaveDialog;
    cmdCancel: TButton;
    procedure cmdExportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmdBrowseClick(Sender: TObject);
  private
    _BattleCityROM : TBattleCityROM;
    procedure ExportFile(pFilename: String);
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmExportLevel: TfrmExportLevel;

implementation

{$R *.dfm}

uses uGlobals;

procedure TfrmExportLevel.ExportFile(pFilename : String);
var
  LevelFile : TMemoryStream;
  TempBuf : Byte;
  i,x : Integer;
begin
  { TODO : Disabled Code }
  {LevelFile := TMemoryStream.Create;
  try
    // Write the header.
    TempBuf := $42;
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
    For I := 0 To 12 do
    begin

      For X := 0 To 6 do
      begin
        TempBuf := BattleCityROM.ROM[LevelLoc[cbPhase.ItemIndex] + (I * 7) + X];

        LevelFile.Write(TempBuf,1);
      end;

    end;

    // Now write the enemy data
    for i := 0 to 3 do
    begin
      TempBuf := BattleCityROM.ROM[EnemyLoc[cbPhase.ItemIndex] + I];

      LevelFile.Write(TempBuf,1);
    end;

    // Now write the enemy amount data
    for i := 0 to 3 do
    begin
      TempBuf := BattleCityROM.ROM[EnemyNumbersLoc[cbPhase.ItemIndex] + I];

      LevelFile.Write(TempBuf,1);
    end;

    LevelFile.SaveToFile(pFilename);
  finally
    FreeAndNil(LevelFile);
  end;}

end;

procedure TfrmExportLevel.cmdExportClick(Sender: TObject);
begin
  ExportFile(txtOutputFilename.text);
  MessageDlg('Quarrel has successfully exported the level.', mtInformation, [mbOK], 0);
end;

constructor TfrmExportLevel.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin

end;

procedure TfrmExportLevel.FormShow(Sender: TObject);
var
  I : Integer;
begin
{ TODO : Disabled Code }
{  for i := 0 to NumberOfLevels - 1 do
    cbPhase.Items.Add('Level ' + IntToStr(i+1));
  cbPhase.ItemIndex := 0;}
end;

procedure TfrmExportLevel.cmdBrowseClick(Sender: TObject);
begin
  if SaveDialog.Execute then
  begin
    txtOutputFilename.Text := SaveDialog.Filename;
    txtOutputFilename.SelStart := length(txtOutputFilename.Text);
  end;
end;

end.
