program BattleCityEditor;

uses
  Forms,
  fBattleCity in 'fBattleCity.pas' {frmBattleCity},
  fPreferences in 'fPreferences.pas' {frmPreferences},
  fExportLevel in 'fExportLevel.pas' {frmExportLevel},
  fImportLevel in 'fImportLevel.pas' {frmImportLevel},
  fAbout in 'fAbout.pas' {frmAbout},
  fJumpTo in 'fJumpTo.pas' {frmJumpTo},
  fStartLive in 'fStartLive.pas' {frmLives},
  fSwapLevels in 'fSwapLevels.pas' {frmSwapLevels},
  fTSA in 'fTSA.pas' {frmTSAEditor},
  fPalette in 'fPalette.pas' {frmPaletteEditor},
  fEnemy in 'fEnemy.pas' {frmEnemyEditor},
  fFlagTSA in 'fFlagTSA.pas' {frmFlagTSAEditor},
  fTankStatus in 'fTankStatus.pas' {frmYourTankStatus},
  fOpenDialog in 'fOpenDialog.pas' {frmOpenDialog},
  BCData in 'Classes\BCData.pas',
  iNESHeaderChecks in 'Classes\iNESHeaderChecks.pas',
  fSaveStateImport in 'fSaveStateImport.pas' {frmSaveStateImport},
  uGlobals in 'Classes\uGlobals.pas',
  Configuration in 'Classes\Configuration.pas',
  BCLevel in 'Classes\BCLevel.pas',
  BCEnemy in 'Classes\BCEnemy.pas',
  BCStartingPos in 'Classes\BCStartingPos.pas',
  Resources in 'Classes\Resources.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Battle City Editor';
  Application.CreateForm(TfrmBattleCity, frmBattleCity);
  Application.CreateForm(TfrmSaveStateImport, frmSaveStateImport);
  Application.Run;
end.
