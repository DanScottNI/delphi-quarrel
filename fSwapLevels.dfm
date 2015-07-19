object frmSwapLevels: TfrmSwapLevels
  Left = 513
  Top = 375
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Swap Levels'
  ClientHeight = 104
  ClientWidth = 244
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblLevel1: TLabel
    Left = 8
    Top = 16
    Width = 34
    Height = 13
    Caption = 'Level 1'
  end
  object lblLevel2: TLabel
    Left = 8
    Top = 40
    Width = 38
    Height = 13
    Caption = 'Level 2:'
  end
  object cbLevel1: TComboBox
    Left = 56
    Top = 16
    Width = 185
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object cbLevel2: TComboBox
    Left = 56
    Top = 40
    Width = 185
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
  end
  object cmdOK: TButton
    Left = 88
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Swap'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 168
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
