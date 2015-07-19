unit fJumpTo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DanHexEdit, fBattleCity, BCData;

type
  TfrmJumpTo = class(TForm)
    lstPhases: TListBox;
    cmdJump: TButton;
    cmdCancel: TButton;
    procedure FormShow(Sender: TObject);
    procedure cmdJumpClick(Sender: TObject);
  private
    { Private declarations }
    _BattleCityROM : TBattleCityROM;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmJumpTo: TfrmJumpTo;

implementation

{$R *.dfm}

uses Resources;

constructor TfrmJumpTo.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmJumpTo.FormShow(Sender: TObject);
var
  i : Integer;
begin
  for i := 0 to _BattleCityROM.Levels.Count - 1 do
    lstPhases.Items.Add('Level ' + IntToStr(i+1));
end;



procedure TfrmJumpTo.cmdJumpClick(Sender: TObject);
begin
  _BattleCityROM.Level := lstPhases.ItemIndex;
  frmBattleCity.DrawLevelData();
  frmBattleCity.Caption := EDITORNAME + ' ' + VERSIONNUMBER + ' - Level ' + IntToStr(_BattleCityROM.Level + 1);
end;

end.
