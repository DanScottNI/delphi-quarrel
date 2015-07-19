unit fPreferences;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, BCData, ComCtrls, Configuration, ExtCtrls, GR32_Image, GR32;

type
  TfrmPreferences = class(TForm)
    cmdOK: TButton;
    cmdCancel: TButton;
    pgcOptions: TPageControl;
    General: TTabSheet;
    TabSheet2: TTabSheet;
    lblPalettes: TLabel;
    lblGridlinesColour: TLabel;
    lblPatchType: TLabel;
    cbPatchType: TComboBox;
    lblPatchCommandLine: TLabel;
    txtPatchCommandLine: TEdit;
    Label1: TLabel;
    cbPaletteFile: TComboBox;
    ColorDialog1: TColorDialog;
    imgGridlineColour: TImage32;
    btnBrowseColour: TButton;
    procedure cmdOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBrowseColourClick(Sender: TObject);
  private
		_Config : TConfiguration;
    procedure PopulatePalettes;
    procedure LoadPreferences;
    procedure SavePreferences;
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner : TComponent; Config : TConfiguration);
  end;

var
  frmPreferences: TfrmPreferences;

implementation

{$R *.dfm}

uses PatchProgManager;

procedure TfrmPreferences.PopulatePalettes();
var
  sr: TSearchRec;
begin
  cbPaletteFile.Items.BeginUpdate;
  cbPaletteFile.Items.Clear;

  if FindFirst(ExtractFileDir(Application.ExeName)+ '\Resources\Palette\*.pal', faAnyFile, sr) = 0 then
  begin
    repeat
      cbPaletteFile.Items.Add(sr.Name);
    until FindNext(sr) <> 0;
    FindClose(sr);
  end;
  cbPaletteFile.Items.EndUpdate;
end;

procedure TfrmPreferences.btnBrowseColourClick(Sender: TObject);
begin
  if  (ColorDialog1.Execute()) then
  begin
     imgGridlineColour.Color := ColorDialog1.Color;
  end;
end;

procedure TfrmPreferences.cmdOKClick(Sender: TObject);
begin
  SavePreferences;
end;


constructor TfrmPreferences.Create(AOwner: TComponent; Config: TConfiguration);
begin
  inherited Create(Aowner);
  _Config := Config;
end;

procedure TfrmPreferences.FormShow(Sender: TObject);
begin
  LoadPreferences;
end;

procedure TfrmPreferences.LoadPreferences;
begin
  PopulatePalettes;
  cbPaletteFile.ItemIndex := cbPaletteFile.Items.IndexOf(_Config.PaletteName);
  if cbPaletteFile.ItemIndex = -1 then
    cbPaletteFile.ItemIndex := 0;
  imgGridlineColour.Color := WinColor(_Config.GridlineColour);
end;


procedure TfrmPreferences.SavePreferences;
begin
  _Config.GridlineColour := Color32(imgGridlineColour.Color);
  _Config.PaletteName := cbPaletteFile.Items[cbPaletteFile.ItemIndex];
  _Config.Save;
end;
end.

