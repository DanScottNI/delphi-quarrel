object frmOpenDialog: TfrmOpenDialog
  Left = 394
  Top = 308
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Open Dialog'
  ClientHeight = 374
  ClientWidth = 494
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
  object lblFilter: TLabel
    Left = 8
    Top = 304
    Width = 28
    Height = 13
    Caption = 'Filter:'
  end
  object DriveComboBox: TDriveComboBox
    Left = 8
    Top = 8
    Width = 257
    Height = 19
    DirList = DirectoryListBox
    TabOrder = 0
    TextCase = tcUpperCase
  end
  object DirectoryListBox: TDirectoryListBox
    Left = 8
    Top = 32
    Width = 257
    Height = 265
    FileList = FileListBox
    ItemHeight = 16
    TabOrder = 1
  end
  object FileListBox: TFileListBox
    Left = 272
    Top = 8
    Width = 217
    Height = 289
    BevelInner = bvLowered
    ItemHeight = 13
    Mask = '*.nes'
    TabOrder = 2
    OnDblClick = FileListBoxDblClick
  end
  object FilterComboBox: TFilterComboBox
    Left = 8
    Top = 320
    Width = 481
    Height = 21
    FileList = FileListBox
    Filter = 'iNES ROM Images (*.nes)|*.nes|All Files (*.*)|*.*'
    TabOrder = 3
  end
  object cmdOK: TButton
    Left = 336
    Top = 344
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 414
    Top = 344
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
end
