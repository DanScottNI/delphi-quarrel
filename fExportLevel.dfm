object frmExportLevel: TfrmExportLevel
  Left = 418
  Top = 371
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Export Level'
  ClientHeight = 104
  ClientWidth = 431
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
  object lblFilename: TLabel
    Left = 8
    Top = 8
    Width = 46
    Height = 13
    Caption = 'Filename:'
  end
  object lblPhase: TLabel
    Left = 8
    Top = 40
    Width = 33
    Height = 13
    Caption = 'Phase:'
  end
  object txtOutputFileName: TEdit
    Left = 64
    Top = 8
    Width = 281
    Height = 21
    TabOrder = 0
  end
  object cmdExport: TButton
    Left = 272
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Export'
    Default = True
    ModalResult = 1
    TabOrder = 1
    OnClick = cmdExportClick
  end
  object cmdBrowse: TButton
    Left = 352
    Top = 8
    Width = 75
    Height = 21
    Caption = 'Browse'
    TabOrder = 2
    OnClick = cmdBrowseClick
  end
  object cbPhase: TComboBox
    Left = 64
    Top = 40
    Width = 281
    Height = 21
    Style = csDropDownList
    ItemHeight = 0
    TabOrder = 3
  end
  object cmdCancel: TButton
    Left = 352
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 4
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'wcd'
    Filter = 'Battle City Data Files (*.bcd)|*.bcd'
    Left = 256
    Top = 40
  end
end
