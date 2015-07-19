object frmPreferences: TfrmPreferences
  Left = 393
  Top = 322
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Preferences'
  ClientHeight = 290
  ClientWidth = 514
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
  object cmdOK: TButton
    Left = 349
    Top = 255
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 430
    Top = 255
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 1
    TabOrder = 1
  end
  object pgcOptions: TPageControl
    Left = 9
    Top = 8
    Width = 496
    Height = 241
    ActivePage = TabSheet2
    TabOrder = 2
    object General: TTabSheet
      Caption = 'General'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPalettes: TLabel
        Left = 8
        Top = 8
        Width = 43
        Height = 13
        Caption = 'Palettes:'
      end
      object lblGridlinesColour: TLabel
        Left = 8
        Top = 35
        Width = 78
        Height = 13
        Caption = 'Gridlines Colour:'
      end
      object cbPaletteFile: TComboBox
        Left = 92
        Top = 8
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 0
      end
      object imgGridlineColour: TImage32
        Left = 92
        Top = 35
        Width = 25
        Height = 25
        Bitmap.ResamplerClassName = 'TNearestResampler'
        BitmapAlign = baTopLeft
        Scale = 1.000000000000000000
        ScaleMode = smNormal
        TabOrder = 1
      end
      object btnBrowseColour: TButton
        Left = 123
        Top = 35
        Width = 30
        Height = 25
        Caption = '...'
        TabOrder = 2
        OnClick = btnBrowseColourClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Patch'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lblPatchType: TLabel
        Left = 3
        Top = 3
        Width = 58
        Height = 13
        Caption = 'Patch Type:'
      end
      object lblPatchCommandLine: TLabel
        Left = 3
        Top = 32
        Width = 137
        Height = 13
        Caption = 'Patch Create Command-line:'
      end
      object Label1: TLabel
        Left = 3
        Top = 59
        Width = 311
        Height = 65
        Caption = 
          'Variables:'#13#10#13#10'%ORIGROM% - The filename of the original ROM'#13#10'%MOD' +
          'IFIEDROM% - The filename of the modified ROM.'#13#10'%PATCHOUTPUT% - T' +
          'he filename of the patch to be outputted.'
      end
      object cbPatchType: TComboBox
        Left = 146
        Top = 5
        Width = 145
        Height = 21
        Style = csDropDownList
        ItemHeight = 0
        TabOrder = 0
      end
      object txtPatchCommandLine: TEdit
        Left = 146
        Top = 32
        Width = 335
        Height = 21
        TabOrder = 1
      end
    end
  end
  object ColorDialog1: TColorDialog
    Options = [cdFullOpen]
    Left = 8
    Top = 256
  end
end
