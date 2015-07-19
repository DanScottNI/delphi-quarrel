object frmYourTankStatus: TfrmYourTankStatus
  Left = 563
  Top = 406
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Your Tank Status'
  ClientHeight = 96
  ClientWidth = 182
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblEnemyType1: TLabel
    Left = 48
    Top = 16
    Width = 28
    Height = 13
    Caption = 'Type:'
  end
  object imgEnemy1: TImage32
    Left = 8
    Top = 16
    Width = 32
    Height = 32
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 0
  end
  object cmdOK: TButton
    Left = 24
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 104
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object txtStartType: TEdit
    Left = 93
    Top = 16
    Width = 68
    Height = 21
    TabOrder = 3
  end
end
