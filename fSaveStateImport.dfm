object frmSaveStateImport: TfrmSaveStateImport
  Left = 346
  Top = 310
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Save State Export'
  ClientHeight = 184
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblSaveState: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Save State:'
  end
  object lblLevels: TLabel
    Left = 8
    Top = 40
    Width = 34
    Height = 13
    Caption = 'Levels:'
  end
  object lblExportFile: TLabel
    Left = 8
    Top = 120
    Width = 55
    Height = 13
    Caption = 'Export File:'
  end
  object lstLevels: TListBox
    Left = 72
    Top = 40
    Width = 353
    Height = 73
    ItemHeight = 13
    Items.Strings = (
      'Designer Level 1'
      'Designer Level 2'
      'Designer Level 3'
      'Designer Level 4')
    TabOrder = 0
  end
  object txtFilename: TEdit
    Left = 72
    Top = 8
    Width = 273
    Height = 21
    ReadOnly = True
    TabOrder = 1
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
  object txtExport: TEdit
    Left = 72
    Top = 120
    Width = 273
    Height = 21
    TabOrder = 3
  end
  object cmdBrowseExport: TButton
    Left = 352
    Top = 120
    Width = 75
    Height = 21
    Caption = 'Browse'
    TabOrder = 4
    OnClick = cmdBrowseExportClick
  end
  object cmdOK: TButton
    Left = 272
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Export'
    Default = True
    ModalResult = 1
    TabOrder = 5
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 352
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 6
  end
  object OpenDialog: TOpenDialog
    Filter = 'FCE Ultra (*.fc*)|*.fc*'
    Left = 48
    Top = 96
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'wcd'
    Filter = 'Wrecking Crew Data File (*.wcd)|*.wcd'
    Left = 16
    Top = 96
  end
end
