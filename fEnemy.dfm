object frmEnemyEditor: TfrmEnemyEditor
  Left = 470
  Top = 246
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Level Enemy Editor'
  ClientHeight = 392
  ClientWidth = 374
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
  object lblLevelTanks: TLabel
    Left = 304
    Top = 8
    Width = 60
    Height = 13
    Caption = 'Level Tanks:'
  end
  object cmdOK: TButton
    Left = 216
    Top = 360
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 296
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 1
    OnClick = cmdCancelClick
  end
  object imgLevelTanks: TImage32
    Left = 304
    Top = 24
    Width = 64
    Height = 320
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 2
  end
  object grpEnemy1: TGroupBox
    Left = 8
    Top = 8
    Width = 289
    Height = 81
    Caption = 'Enemy Type 1'
    TabOrder = 3
    object lblEnemyType1: TLabel
      Left = 48
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object lblShieldStrength1: TLabel
      Left = 152
      Top = 16
      Width = 77
      Height = 13
      Caption = 'Shield Strength:'
    end
    object lblAmount1: TLabel
      Left = 48
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Amount:'
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
    object chkGivePowerup1: TCheckBox
      Left = 152
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Give Powerups'
      TabOrder = 1
    end
    object txtEnemy1Type: TEdit
      Left = 96
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 2
    end
    object txtAmount1: TEdit
      Left = 95
      Top = 43
      Width = 50
      Height = 21
      TabOrder = 3
    end
    object txtShieldStrength1: TEdit
      Left = 235
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 4
    end
  end
  object grpEnemy2: TGroupBox
    Left = 9
    Top = 97
    Width = 289
    Height = 81
    Caption = 'Enemy Type 2'
    TabOrder = 4
    object lblEnemyType2: TLabel
      Left = 48
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object lblShieldStrength2: TLabel
      Left = 152
      Top = 16
      Width = 77
      Height = 13
      Caption = 'Shield Strength:'
    end
    object lblAmount2: TLabel
      Left = 48
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Amount:'
    end
    object imgEnemy2: TImage32
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
    object chkGivePowerup2: TCheckBox
      Left = 152
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Give Powerups'
      TabOrder = 1
    end
    object txtEnemyType2: TEdit
      Left = 96
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 2
    end
    object txtAmount2: TEdit
      Left = 96
      Top = 43
      Width = 50
      Height = 21
      TabOrder = 3
    end
    object txtShieldStrength2: TEdit
      Left = 234
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 4
    end
  end
  object grpEnemy3: TGroupBox
    Left = 8
    Top = 184
    Width = 289
    Height = 81
    Caption = 'Enemy Type 3'
    TabOrder = 5
    object lblEnemyType3: TLabel
      Left = 48
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object lblShieldStrength3: TLabel
      Left = 152
      Top = 16
      Width = 77
      Height = 13
      Caption = 'Shield Strength:'
    end
    object lblAmount3: TLabel
      Left = 48
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Amount:'
    end
    object imgEnemy3: TImage32
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
    object chkGivePowerup3: TCheckBox
      Left = 152
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Give Powerups'
      TabOrder = 1
    end
    object txtEnemyType3: TEdit
      Left = 96
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 2
    end
    object txtShieldStrength3: TEdit
      Left = 235
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 3
    end
    object txtAmount3: TEdit
      Left = 96
      Top = 43
      Width = 50
      Height = 21
      TabOrder = 4
    end
  end
  object grpEnemy4: TGroupBox
    Left = 8
    Top = 272
    Width = 289
    Height = 81
    Caption = 'Enemy Type 4'
    TabOrder = 6
    object lblEnemyType4: TLabel
      Left = 48
      Top = 16
      Width = 28
      Height = 13
      Caption = 'Type:'
    end
    object lblShieldStrength4: TLabel
      Left = 152
      Top = 16
      Width = 77
      Height = 13
      Caption = 'Shield Strength:'
    end
    object lblAmount4: TLabel
      Left = 48
      Top = 48
      Width = 41
      Height = 13
      Caption = 'Amount:'
    end
    object imgEnemy4: TImage32
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
    object chkGivePowerup4: TCheckBox
      Left = 152
      Top = 48
      Width = 97
      Height = 17
      Caption = 'Give Powerups'
      TabOrder = 1
    end
    object txtEnemyType4: TEdit
      Left = 96
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 2
    end
    object txtShieldStrength4: TEdit
      Left = 235
      Top = 16
      Width = 50
      Height = 21
      TabOrder = 3
    end
    object txtAmount4: TEdit
      Left = 95
      Top = 43
      Width = 50
      Height = 21
      TabOrder = 4
    end
  end
end
