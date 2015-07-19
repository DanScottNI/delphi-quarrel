unit fBattleCity;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  GR32, GR32_Image, StdCtrls, idGlobal, INIFiles, Menus, iNESImage, Dialogs,
  GR32_Layers, ToolWin, ComCtrls, ImgList, ActnList, BCData, Configuration,
  FileCtrl;

type
  TfrmBattleCity = class(TForm)
    imgLevel: TImage32;
    imgTiles: TImage32;
    tlbToolbar: TToolBar;
    ImageList: TImageList;
    tlbOpenROM: TToolButton;
    tlbSaveROM: TToolButton;
    tlbCloseROM: TToolButton;
    tlbSep: TToolButton;
    tlbJumpTo: TToolButton;
    tlbGridlines: TToolButton;
    tlbStartingLives: TToolButton;
    ActionList: TActionList;
    actCreateAbout: TAction;
    actCreateExport: TAction;
    actCreateImport: TAction;
    actCreateJumpTo: TAction;
    actCreatePreferences: TAction;
    actCreateStartingLives: TAction;
    actOpenROM: TAction;
    actSaveROM: TAction;
    actCloseROM: TAction;
    actCreateSwapLevels: TAction;
    tlbRubLevel: TToolButton;
    actRubLevel: TAction;
    actCreatePaletteEditor: TAction;
    actCreateTSAEditor: TAction;
    tlbTSAEditor: TToolButton;
    tlbPaletteEditor: TToolButton;
    actCreateEnemy: TAction;
    SpecialRub: TPopupMenu;
    actCreateFlagTSAEditor: TAction;
    actCreateYourTankStatus: TAction;
    StatusBar: TStatusBar;
    lblBlockType: TLabel;
    mnuRubWithCurrentBlock: TMenuItem;
    MainMenu1: TMainMenu;
    mnuFile: TMenuItem;
    mnuOpenROM: TMenuItem;
    mnuSaveROM: TMenuItem;
    mnuCloseROM: TMenuItem;
    N1: TMenuItem;
    mnuPreferences: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    mnuEdit: TMenuItem;
    mnuMapEditingMode: TMenuItem;
    mnuObjectEditingMode: TMenuItem;
    mnuTools: TMenuItem;
    mnuHelp: TMenuItem;
    SAEditor1: TMenuItem;
    PaletteEditor1: TMenuItem;
    EnemyEditor1: TMenuItem;
    FlagTSAEditor1: TMenuItem;
    PlayerStartingType1: TMenuItem;
    StartingLivesEditor1: TMenuItem;
    View1: TMenuItem;
    About1: TMenuItem;
    mnuGridlines: TMenuItem;
    mnuViewPlayerStart: TMenuItem;
    mnuViewEnemyStart: TMenuItem;
    ImportLevel1: TMenuItem;
    ExportLevel1: TMenuItem;
    N3: TMenuItem;
    SwapLevels1: TMenuItem;
    mnuRecentMenu: TMenuItem;
    mnuRecentMenu1: TMenuItem;
    mnuRecentMenu2: TMenuItem;
    mnuRecentMenu3: TMenuItem;
    mnuRecentMenu4: TMenuItem;
    mnuRecentMenu5: TMenuItem;
    actMapEditingMode: TAction;
    actObjEditingMode: TAction;
    actViewGridlines: TAction;
    mnuViewFlagPosition: TMenuItem;
    actViewPlayer: TAction;
    actViewEnemy: TAction;
    actViewFlag: TAction;
    tlbMapEditingMode: TToolButton;
    tlbObjEditingMode: TToolButton;
    ToolButton1: TToolButton;
    procedure imgTilesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure imgLevelMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer; Layer: TCustomLayer);
    procedure imgLevelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    // Exit the form.
    procedure mnuExitClick(Sender: TObject);
    // Called when the form shows :)
    procedure FormShow(Sender: TObject);
    // Creates the about dialog.
    procedure actCreateAboutExecute(Sender: TObject);
    // Creates the Export dialog.
    procedure actCreateExportExecute(Sender: TObject);
    procedure actCreateImportExecute(Sender: TObject);
    procedure actCreateJumpToExecute(Sender: TObject);
    procedure actCreatePreferencesExecute(Sender: TObject);
    procedure actOpenROMExecute(Sender: TObject);
    procedure actCreateExportSaveStateExecute(Sender: TObject);
    // Creates the starting lives editor.
    procedure actCreateStartingLivesExecute(Sender: TObject);
    // Closes the ROM.
    procedure actCloseROMExecute(Sender: TObject);
    // Saves the ROM, and the level.
    procedure actSaveROMExecute(Sender: TObject);
    procedure actCreateSwapLevelsExecute(Sender: TObject);
    procedure actRubLevelExecute(Sender: TObject);
    procedure actCreateTSAEditorExecute(Sender: TObject);
    procedure actCreatePaletteEditorExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actCreateEnemyExecute(Sender: TObject);
    procedure actCreateFlagTSAEditorExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure actCreateYourTankStatusExecute(Sender: TObject);
    procedure mnuRubWithCurrentBlockClick(Sender: TObject);
    procedure mnuRecentMenu1Click(Sender: TObject);
    procedure actViewGridlinesExecute(Sender: TObject);
    procedure actMapEditingModeExecute(Sender: TObject);
    procedure actObjEditingModeExecute(Sender: TObject);
    procedure actViewPlayerExecute(Sender: TObject);
  private
    // The iNESImage representing the Battle City ROM.
    _BattleCityROM : TBattleCityROM;
    _Config : TConfiguration;
    // The TSA form.
    _TSA : TForm;
    _EditingMode : Byte;
    _MouseDown : Boolean;
    _ObjUnderMouse : Integer;
    { Private declarations }
    // A function to draw a NES tile to a bitmap 32.
    procedure RubLevel(pBlock: Integer);
    procedure SetEnabledStatus(pEnabled: Boolean);
    procedure CreateRecentMenu;
    procedure LoadROM(pFilename, pDataFile: String);
    procedure ClearImageIndex;
    procedure UpdateTitleCaption;
    procedure CloseROM(pDisableCancel: Boolean);
    procedure DisplayGridlines;
  public
    // The current block to use when TSA editing.
    CurTSABlock : Integer;
    // This procedure draws the tile selector
    procedure DrawTileSelector;
    // A procedure that draws the level data to a bitmap 32.
    Procedure DrawLevelData();
  end;

var
  // The current form.
  frmBattleCity: TfrmBattleCity;
  // The currently selected tile.
  CurrentTile : Integer;

implementation

uses fStartLive, fPreferences, fJumpTo, fExportLevel, fAbout, fImportLevel,
  fSwapLevels, iNESHeaderChecks,fSaveStateImport, fPalette, fEnemy, fFlagTSA,
  fTankStatus, fOpenDialog, fTSA, Resources, uGlobals;

{$R *.dfm}

{ TfrmBattleCity }

procedure TfrmBattleCity.DrawLevelData;
var
  LevelDataBMP : Tbitmap32;
  i, x : Integer;
  ViewObjects : Byte;
begin
  LevelDataBMP := TBitmap32.Create;
  try
    LevelDataBMP.Width := 208;
    LevelDataBMP.Height := 208;
    // Reset the variable that holds the objects that need to be
    // displayed to zero.
    ViewObjects :=0;

    // If the menu item for displaying the player is checked,
    // display them.
    if actViewPlayer.Checked then
      ViewObjects := ViewObjects + uGlobals.VIEWPLAYERSTARTPOS;
    // If the menu item for displaying the enemy is checked,
    // display them.
    if actViewEnemy.Checked then
      ViewObjects := ViewObjects + uGlobals.VIEWENEMYSTARTPOS;
    // If the menu item for displaying the flag is checked, then
    // display them.
    if actViewFlag.Checked then
      ViewObjects := ViewObjects + uGlobals.VIEWNORMALFLAG;

   _BattleCityROM.DrawLevelData(LevelDataBMP, ViewObjects);

    // Now draw the gridlines.
    if actViewGridlines.Checked = true then
    begin

      for i := 1 to 12 do
      begin
        for x :=1 to 12 do
        begin
          LevelDataBMP.Line(x*16,0,x*16,LevelDataBMP.Height, _Config.GridlineColour);
          LevelDataBMP.Line(0,i*16,LevelDataBMP.Width,i*16, _Config.GridlineColour);
        end;
      end;
    end;
    imgLevel.Bitmap := LevelDataBMP;
  finally
    FreeAndNil(LevelDataBMP);
  end;
end;

procedure TfrmBattleCity.DrawTileSelector();
var
  TilesBMP : Tbitmap32;
  TempX, TempY : Integer;
begin
  TilesBMP := TBitmap32.Create;
  try
    TilesBMP.Width := 32;
    TilesBMP.Height := 128;
    _BattleCityROM.DrawTileSelector(TilesBMP);
    // Work out the current X, Y of the currently selected tile
    TempX := (CurrentTile mod 2) * 16;
    TempY := (CurrentTile div 2) * 16;
    TilesBMP.FrameRectS(TempX,TempY,TempX+16, TempY+16,clRed32);
    imgTiles.Bitmap := TilesBMP;

    lblBlockType.Caption := 'Block Type:' + Chr(13) + Chr(10) + IntToHex(CurrentTile,2);
  finally
    FreeAndNil(TilesBMP);
  end;
end;

procedure TfrmBattleCity.imgTilesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  TileX1, TileY1 : Integer;
begin
  CurrentTile := (X div 32) + ((Y div 32)*2);

  If CurTSABlock > -1 then
  begin
    if Button = mbLeft then
    begin
      TileX1 := (X mod 32);
      TileY1 := (y mod 32);
      _BattleCityROM.EditTSA( CurrentTile, (TileX1 div 16), TileY1 div 16, CurTSABlock);
    end
    else if Button = mbRight then
    begin
      _BattleCityROM.IncrementTileAttribute(CurrentTile);
    end;
    DrawLevelData();
  end;
  DrawTileSelector();
end;

procedure TfrmBattleCity.imgLevelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
begin
  if _EditingMode = uGlobals.EDITINGMODEMAP then
  begin
    if Button = mbRight then
    begin
      CurrentTile := _BattleCityROM.CurrentLevel.LevelData[ y div 32,x div 32];
      DrawTileSelector();
    end
    else
    begin
      _BattleCityROM.CurrentLevel.LevelData[ y div 32,x div 32] := CurrentTile;
      DrawLevelData();
    end;
  end
  else if _EditingMode = uGlobals.EDITINGMODEOBJ then
  begin
    _MouseDown := False;
    _ObjUnderMouse := -1;
  end;
end;

procedure TfrmBattleCity.imgLevelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer; Layer: TCustomLayer);
begin
  If _EditingMode = uGlobals.EDITINGMODEMAP then
  begin
    if (ssLeft in Shift) then
    begin
      _BattleCityROM.CurrentLevel.LevelData[ y div 32,x div 32] := CurrentTile;
      DrawLevelData();
    end;
  end
  else if _EditingMode = uGlobals.EDITINGMODEOBJ then
  begin
    if _MouseDown = true then
    begin
      if (X >= imgLevel.Width) or (Y >= imgLevel.Height) then exit;
      if _BattleCityROM.CurrentLevel.StartingLocations[_ObjUnderMouse].X <> X div 32 then
      begin
        _BattleCityROM.CurrentLevel.StartingLocations[_ObjUnderMouse].X := X div 32;
        _BattleCityROM.Changed := true;
      end;

      if _BattleCityROM.CurrentLevel.StartingLocations[_ObjUnderMouse].Y <> Y div 32 then
      begin
        _BattleCityROM.CurrentLevel.StartingLocations[_ObjUnderMouse].Y := Y div 32;
        _BattleCityROM.Changed := true;
      end;

      DrawLevelData();
      // Update the title caption text to take account of the changed ROM.
      UpdateTitleCaption();
    end;
  end;
end;

procedure TfrmBattleCity.imgLevelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer;
  Layer: TCustomLayer);
var
  i : Integer;
begin
  if _EditingMode = uGlobals.EDITINGMODEMAP then
  begin
    if Button = mbRight then
    begin
      CurrentTile := _BattleCityROM.CurrentLevel.LevelData[ y div 32,x div 32];
      DrawTileSelector();
    end
    else
    begin
      _BattleCityROM.CurrentLevel.LevelData[ y div 32,x div 32] := CurrentTile;
      DrawLevelData();
    end;
  end
  else if _EditingMode = uGlobals.EDITINGMODEOBJ then
  begin
    _ObjUnderMouse := -1;
    _MouseDown := True;
    for i := 0 to 4 do
    begin
      if (X div 32 = _BattleCityROM.CurrentLevel.StartingLocations[i].X) and (Y div 32 = _BattleCityROM.CurrentLevel.StartingLocations[i].Y) then
      begin
        _ObjUnderMouse := i;
        break;
      end;
    end;
  end;
end;

procedure TfrmBattleCity.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // If the level is available, run all the key checks listed
  // below.
  if imgLevel.Visible = True then
  begin
    // If the key pressed is the Page Up key,
    // check if the current Level variable is 23.
    // 23 is the last level, so loop round to the
    // beginning (0). If it is not 23, increment the
    // current level variable by 1.
    if Key = VK_PRIOR	then
    begin
      if _BattleCityROM.Level = _BattleCityROM.Levels.Count -1 then
        _BattleCityROM.Level := 0
      else
        _BattleCityROM.Level := _BattleCityROM.Level + 1;
    end
    // If the key pressed is the Page Down key,
    // check if the current Level variable is 0.
    // If it is, then set the current Level variable
    // to 23. If it is not 0, decrement the current
    // level variable by 1.
    else if Key = VK_NEXT	then
    begin
      if _BattleCityROM.Level = 0 then
        _BattleCityROM.Level := _BattleCityROM.Levels.Count-1
      else
        _BattleCityROM.Level := _BattleCityROM.Level - 1;
    end
    // If the key pressed is neither Page Up or Page Down
    // exit the subroutine.
    else
      exit;
    // Set the caption of the form to say Demolition v1.0 plus
    // the level name.
    UpdateTitleCaption;
    // Draw the new level.
    DrawLevelData();
  end;
end;

procedure TfrmBattleCity.mnuExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmBattleCity.FormShow(Sender: TObject);
begin
  if FileExists(ExtractFileDir(ParamStr(0)) + '\Resources\BattleCityJ.ini') = false then
  begin
    ShowMessage( 'The data directories do not exist. The program will now exit.');
    application.terminate;
  end;
  UpdateTitleCaption();
  ClearImageIndex;
end;

procedure TfrmBattleCity.actCreateAboutExecute(Sender: TObject);
var
  About : TfrmAbout;
begin
  About := TfrmAbout.Create(self);
  try
    About.ShowModal;
  finally
    FreeAndNil(About);
  end;
end;

procedure TfrmBattleCity.actCreateExportExecute(Sender: TObject);
var
  frmExport : TfrmExportLevel;
begin
  frmExport := TfrmExportLevel.Create(self, _BattleCityROM);
  try
    frmExport.ShowModal;
  finally
    FreeAndNil(frmExport);
  end;
end;

procedure TfrmBattleCity.actCreateImportExecute(Sender: TObject);
var
  frmImport : TfrmImportLevel;
begin
  frmImport := TfrmImportLevel.Create(self, _BattleCityROM);
  try
    frmImport.ShowModal;
  finally
    FreeAndNil(frmImport);
  end;
end;

procedure TfrmBattleCity.actCreateJumpToExecute(Sender: TObject);
var
  JumpTo : TfrmJumpTo;
begin
  JumpTo := TfrmJumpTo.Create(self, _BattleCityROM);
  try
    JumpTo.ShowModal;
  finally
    FreeAndNil(JumpTo);
  end;
end;

procedure TfrmBattleCity.actMapEditingModeExecute(Sender: TObject);
begin
  Statusbar.Panels[1].Text := MAPEDITTEXT;
  _EditingMode := uGlobals.EDITINGMODEMAP;
  mnuMapEditingMode.Checked :=  True;
  mnuObjectEditingMode.Checked := False;
  tlbMapEditingMode.Down := True;
  tlbObjEditingMode.Down := False;
end;

procedure TfrmBattleCity.actObjEditingModeExecute(Sender: TObject);
begin
  Statusbar.Panels[1].Text := OBJEDITTEXT;
  _EditingMode := uGlobals.EDITINGMODEOBJ;
  mnuMapEditingMode.Checked := False;
  mnuObjectEditingMode.Checked := True;
  tlbMapEditingMode.Down := False;
  tlbObjEditingMode.Down := True;  
end;

procedure TfrmBattleCity.actOpenROMExecute(Sender: TObject);
var
  OpDlg : TfrmOpenDialog;
begin
  OpDlg := TfrmOpenDialog.Create(self);
  try
    if FileExists(_Config.RecentFile[0]) = true then
      opDlg.OpenDir := ExtractFileDir(_Config.RecentFile[0]);

    OpDlg.ShowModal;

    if opDlg.ModalResult = mrOk then
  // Bring up the open dialog
//  if OpenDialog.Execute Then
    begin
      LoadROM(OpDlg.Filename,'');
    end;
  finally
    FreeAndNil(OpDlg);
  end;
end;

procedure TfrmBattleCity.LoadROM(pFilename : String; pDataFile : String);
begin
  // Add the recent file to the configuration file.
  _Config.AddRecentFile(pFilename);
  CreateRecentMenu();
  Statusbar.Panels[0].Text := pFilename;
  // First, we load the NES rom into memory
  CheckiNESHeader();
  _BattleCityROM := TBattleCityROM.Create(pFilename,
    ExtractFileDir(ParamStr(0)) + '\Resources\BattleCityJ.ini', _Config.PaletteFilename,
    ExtractFileDir(Application.ExeName) + '\Resources');
  // Set the current level to be the first level
  _BattleCityROM.Level :=0;
  SetEnabledStatus(true);
  // Set the caption of the form to say Battle City Editor version whatever  plus
  // the level name.
  UpdateTitleCaption;
  // Set the gridline defaults.
  DisplayGridlines;

  // Finally, we draw the level data onto the image32 control.
  DrawLevelData();
  DrawTileSelector();
  _Config.Save();
end;

procedure TfrmBattleCity.UpdateTitleCaption();
var
  CaptionText : String;
begin
  if _BattleCityROM = nil then
  begin
    self.Caption := EDITORNAME + ' ' + VERSIONNUMBER;
  end
  else
  begin
    CaptionText := EDITORNAME + ' ' + VERSIONNUMBER + ' - Level ' + IntToStr(_BattleCityROM.Level + 1);
    if _BattleCityROM.Changed then CaptionText := CaptionText + ' *';
    self.Caption := CaptionText;
  end;
end;

procedure TfrmBattleCity.actCloseROMExecute(Sender: TObject);
begin
  CloseROM(false);
end;

procedure TfrmBattleCity.CloseROM(pDisableCancel : Boolean);
var
  MsgRes : Integer;
begin
  if _Config.Changed = True then
    _Config.Save;

  FreeAndNil(Palettes);

  if Assigned(_BattleCityROM) then
  begin
    if _BattleCityROM.Changed = True then
    begin
      if pDisableCancel = True then
        MsgRes := MessageDlg('This ROM has some changes. Do you wish to save?',mtConfirmation,[mbYes, mbNo],0)
      else
        MsgRes := MessageDlg('This ROM has some changes. Do you wish to save?',mtConfirmation,[mbYes, mbNo,mbCancel],0);
      if MsgRes = mrYes then
        _BattleCityROM.Save;

      if MsgRes <> mrCancel then
      begin
        if CurTSABlock > -1 then
          FreeAndNil(_TSA);
        CurTSABlock := -1;
        FreeAndNil(_BattleCityROM);
        UpdateTitleCaption;
        if pDisableCancel = False then
          SetEnabledStatus(False);
      end;
    end
    else
    begin
      if CurTSABlock > -1 then
        FreeAndNil(_TSA);
      CurTSABlock := -1;
      FreeAndNil(_BattleCityROM);
      UpdateTitleCaption;
      if pDisableCancel = False then
        SetEnabledStatus(False);
    end;
  end;
end;

procedure TfrmBattleCity.SetEnabledStatus(pEnabled : Boolean);
begin
  // Set the visibility of the tile selector, and main viewing image.
  imgLevel.Visible := pEnabled;
  imgTiles.Visible := pEnabled;
  lblBlockType.Visible := pEnabled;

  actSaveROM.Enabled := pEnabled;
  actCloseROM.Enabled := pEnabled;
  actCreateImport.Enabled := pEnabled;
  actCreateExport.Enabled := pEnabled;
  actCreateEnemy.Enabled := pEnabled;
  actCreateFlagTSAEditor.Enabled := pEnabled;
  tlbGridlines.Enabled := pEnabled;
  actCreateJumpTo.Enabled := pEnabled;
  actCreateYourTankStatus.Enabled := pEnabled;
  actCreateStartingLives.Enabled := pEnabled;
  actCreateTSAEditor.Enabled := pEnabled;
  actCreatePaletteEditor.Enabled := pEnabled;
  actMapEditingMode.Enabled := pEnabled;
  actObjEditingMode.Enabled := pEnabled;
  actCreateSwapLevels.Enabled := pEnabled;
  actRubLevel.Enabled := pEnabled;
  actViewGridlines.Enabled := pEnabled;
  actViewPlayer.Enabled := pEnabled;
  actViewEnemy.Enabled := pEnabled;
  actViewFlag.Enabled := pEnabled;
  
  if pEnabled = False then
  begin
    Statusbar.Panels[0].Text := 'ROM not loaded.';
    Statusbar.Panels[0].Width := self.ClientWidth;
    Statusbar.Panels[1].Width := 0;
    tlbMapEditingMode.Down := false;
    tlbObjEditingMode.Down := false;
  end
  else
  begin
    Statusbar.Panels[0].Width := 250;
    Statusbar.Panels[1].Width := 50;
    if _EditingMode = EDITINGMODEMAP then
      tlbMapEditingMode.Down := true
    else
      tlbObjEditingMode.Down := true;
  end;
end;

procedure TfrmBattleCity.actSaveROMExecute(Sender: TObject);
begin
  // Save the NES ROM.
  _BattleCityROM.Save();
  // Tell the user that the changes have been saved.
  MessageDlg('Changes saved.', mtInformation, [mbOK], 0);
end;

procedure TfrmBattleCity.actViewGridlinesExecute(Sender: TObject);
begin
  _Config.EnableGridlines := not _Config.EnableGridlines;
  DisplayGridlines;
end;

procedure TfrmBattleCity.actViewPlayerExecute(Sender: TObject);
begin
  // Invert the checked status of this action.
  TAction(Sender).Checked := not TAction(Sender).Checked;
  // Redraw the level data.
  DrawLevelData();
end;

procedure TfrmBattleCity.DisplayGridlines;
begin
  actViewGridlines.Checked := _Config.EnableGridlines;
  tlbGridlines.Down := actViewGridlines.Checked;
  DrawLevelData();
end;

procedure TfrmBattleCity.actCreateSwapLevelsExecute(Sender: TObject);
var
  SwapLevels : TfrmSwapLevels;
begin
  SwapLevels := TfrmSwapLevels.Create(self, _BattleCityROM);
  try
    SwapLevels.ShowModal;
  finally
    FreeAndNil(SwapLevels);
  end;
end;

procedure TfrmBattleCity.actRubLevelExecute(Sender: TObject);
begin
  RubLevel(13);
end;

procedure TfrmBattleCity.RubLevel(pBlock : Integer);
var
  i,x : Integer;
begin

  if (MessageDlg('Are you sure that you wish to erase the level?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    for i := 0 to 12 do
      for x := 0 to 12 do
        _BattleCityROM.CurrentLevel.LevelData[i,x] := pBlock;

    DrawLevelData();
    // Update the title's caption to reflect the now changed status.
    UpdateTitleCaption;
  end;

end;

procedure TfrmBattleCity.actCreateTSAEditorExecute(Sender: TObject);
begin
  if (_TSA = nil) or (CurTSABlock = -1) then
  begin
//    FreeAndNil(TSA);
    _TSA := TfrmTSAEditor.Create(self, _BattleCityROM);
    _TSA.Show;
  end;
end;

procedure TfrmBattleCity.FormCreate(Sender: TObject);
begin
  CurTSABlock := -1;
  _ObjUnderMouse := -1;
  // Set the default to map editing mode.
  actMapEditingMode.Execute;
  // Create a new instance of the application's configuration class.
  _Config := TConfiguration.Create(ExtractFileDir(ParamStr(0)) + '\options.ini');
  CreateRecentMenu();
  SetEnabledStatus(false);	
end;

procedure TfrmBattleCity.actCreateEnemyExecute(Sender: TObject);
var
  Enemy : TfrmEnemyEditor;
begin
  Enemy := TfrmEnemyEditor.Create(self, _BattleCityROM);
  try
    Enemy.ShowModal;
  finally
    FreeAndNil(Enemy);
  end;
end;

procedure TfrmBattleCity.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  CloseROM(true);
  if Assigned(_Config) then
  begin
    if _Config.Changed = True then
      _Config.Save;

    FreeAndNil(_Config);
  end;
end;

procedure TfrmBattleCity.mnuRecentMenu1Click(Sender: TObject);
begin
  LoadROM(_Config.RecentFile[TMenuItem(sender).Tag],'');
end;

procedure TfrmBattleCity.mnuRubWithCurrentBlockClick(Sender: TObject);
begin
  RubLevel(CurrentTile);
end;



procedure TfrmBattleCity.actCreateExportSaveStateExecute(
  Sender: TObject);
var
  SSEImport : TfrmSaveStateImport;
begin
  SSEImport := TfrmSaveStateImport.Create(self, _BattleCityROM);
  try
    SSEImport.ShowModal;
  finally
    FreeAndNil(SSEImport);
  end;

end;

procedure TfrmBattleCity.CreateRecentMenu();
var
  Bitmap : TBitmap;
begin
  if _Config.NumberOfRecentlyOpenedFiles = 0 then
    mnuRecentMenu.Visible := False
  else
    mnuRecentMenu.Visible := True;

  if _Config.RecentFile[0] = '' then
    mnuRecentMenu1.Visible := False
  else
    mnuRecentMenu1.Visible := True;

  if _Config.RecentFile[1] = '' then
    mnuRecentMenu2.Visible := False
  else
    mnuRecentMenu2.Visible := True;

  if _Config.RecentFile[2] = '' then
    mnuRecentMenu3.Visible := False
  else
    mnuRecentMenu3.Visible := True;

  if _Config.RecentFile[3] = '' then
    mnuRecentMenu4.Visible := False
  else
    mnuRecentMenu4.Visible := True;

  if _Config.RecentFile[4] = '' then
    mnuRecentMenu5.Visible := False
  else
    mnuRecentMenu5.Visible := True;

  Bitmap := TBitmap.Create;
  try
    Bitmap.Width := 400;
    Bitmap.Height :=  40;
//    self.FindChildControl()
    mnuRecentMenu1.Caption := MinimizeName('1. ' + _Config.RecentFile[0],Bitmap.Canvas,400);
    mnuRecentMenu2.Caption := MinimizeName('2. ' + _Config.RecentFile[1],Bitmap.Canvas,400);
    mnuRecentMenu3.Caption := MinimizeName('3. ' + _Config.RecentFile[2],Bitmap.Canvas,400);
    mnuRecentMenu4.Caption := MinimizeName('4. ' + _Config.RecentFile[3],Bitmap.Canvas,400);
    mnuRecentMenu5.Caption := MinimizeName('5. ' + _Config.RecentFile[4],Bitmap.Canvas,400);
  finally
    FreeAndNil(Bitmap);
  end;
end;


procedure TfrmBattleCity.actCreateStartingLivesExecute(Sender: TObject);
var
  Lives : TfrmLives;
begin
  Lives := TfrmLives.Create(self, _BattleCityROM);
  try
    Lives.ShowModal;
  finally
    FreeAndNil(Lives);
  end;

end;

procedure TfrmBattleCity.actCreateYourTankStatusExecute(Sender: TObject);
var
  TankStat : TfrmYourTankStatus;
begin
  TankStat := TfrmYourTankStatus.Create(self, _BattleCityROM);
  try
    TankStat.ShowModal;
  finally
    FreeAndNil(TankStat);
  end;

end;

procedure TfrmBattleCity.actCreateFlagTSAEditorExecute(Sender: TObject);
var
  FlagTSA : TfrmFlagTSAEditor;
begin
  FlagTSA := TfrmFlagTSAEditor.Create(self, _BattleCityROM);
  try
    FlagTSA.ShowModal;
  finally
    FreeAndNil(FlagTSA);
  end;
  DrawLevelData();
end;

procedure TfrmBattleCity.actCreatePaletteEditorExecute(Sender: TObject);
var
  Palette : TfrmPaletteEditor;
begin
  Palette := TfrmPaletteEditor.Create(self, _BattleCityROM);
  try
    Palette.ShowModal;
    DrawLevelData();
    DrawTileSelector();
  finally
    FreeAndNil(Palette);
  end;
end;

procedure TfrmBattleCity.actCreatePreferencesExecute(Sender: TObject);
var
  Preferences : TfrmPreferences;
  TempPalette : String;
  TempColour : Byte;
begin
  Preferences := TfrmPreferences.Create(self, _Config);
  try
    if (Preferences.ShowModal = mrOK) and (Assigned(_BattleCityROM)) then
    begin
      _BattleCityROM.LoadPaletteFile(_Config.PaletteFilename);
      _BattleCityROM.DrawLevelTiles;
      DrawTileSelector;
      DrawLevelData;
    end;
  finally
    FreeAndNil(Preferences);
  end;
end;

procedure TfrmBattleCity.ClearImageIndex;
begin
  mnuMapEditingMode.ImageIndex := -1;
  mnuObjectEditingMode.ImageIndex := -1;
  mnuGridlines.ImageIndex := -1;
end;

end.
