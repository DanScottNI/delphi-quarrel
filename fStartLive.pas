unit fStartLive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DanHexEdit, BCData;

type
  TfrmLives = class(TForm)
    lblLives: TLabel;
    cmdOK: TButton;
    cmdCancel: TButton;
    txtLives: TEdit;
    procedure FormShow(Sender: TObject);
    procedure cmdOKClick(Sender: TObject);
  private
    { Private declarations }
    _BattleCityROM : TBattleCityROM;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; ROMData: TBattleCityROM);
  end;

var
  frmLives: TfrmLives;

implementation

{$R *.dfm}

constructor TfrmLives.Create(AOwner: TComponent; ROMData: TBattleCityROM);
begin
  inherited Create(AOwner);
  _BattleCityROM := ROMData;
end;

procedure TfrmLives.FormShow(Sender: TObject);
begin
  txtLives.Text := IntToStr(_BattleCityROM.GetStartingLives());
end;

procedure TfrmLives.cmdOKClick(Sender: TObject);
begin
  _BattleCityROM.SetStartingLives(StrToInt(txtLives.Text));
end;

end.
