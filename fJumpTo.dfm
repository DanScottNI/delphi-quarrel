object frmJumpTo: TfrmJumpTo
  Left = 625
  Top = 377
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Jump To'
  ClientHeight = 256
  ClientWidth = 226
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lstPhases: TListBox
    Left = 8
    Top = 8
    Width = 209
    Height = 209
    ItemHeight = 13
    TabOrder = 0
  end
  object cmdJump: TButton
    Left = 64
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Jump'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = cmdJumpClick
  end
  object cmdCancel: TButton
    Left = 144
    Top = 224
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 1
  end
end
