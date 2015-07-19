object frmPaletteEditor: TfrmPaletteEditor
  Left = 330
  Top = 236
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Palette Editor'
  ClientHeight = 446
  ClientWidth = 421
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
  object lbl000F: TLabel
    Left = 297
    Top = 9
    Width = 34
    Height = 13
    Caption = '00 - 0F'
  end
  object lbl101F: TLabel
    Left = 297
    Top = 27
    Width = 34
    Height = 13
    Caption = '10 - 1F'
  end
  object lbl202F: TLabel
    Left = 297
    Top = 45
    Width = 34
    Height = 13
    Caption = '20 - 2F'
  end
  object lbl303F: TLabel
    Left = 297
    Top = 63
    Width = 34
    Height = 13
    Caption = '30 - 3F'
  end
  object lblCurrentPalette: TLabel
    Left = 5
    Top = 88
    Width = 133
    Height = 13
    Caption = 'Current Palette Colour: $00'
  end
  object lblPaletteFrame1: TLabel
    Left = 5
    Top = 112
    Width = 334
    Height = 13
    Caption = 
      'Palette Frame 1 (One of two palettes which are alternated betwee' +
      'n):'
  end
  object lblPaletteFrame2: TLabel
    Left = 5
    Top = 162
    Width = 334
    Height = 13
    Caption = 
      'Palette Frame 2 (One of two palettes which are alternated betwee' +
      'n):'
  end
  object lblPaletteFrame3: TLabel
    Left = 5
    Top = 213
    Width = 300
    Height = 13
    Caption = 'Palette Frame 3 (Shown temporarily when the level is loading):'
  end
  object lblSpritePalette: TLabel
    Left = 5
    Top = 264
    Width = 294
    Height = 13
    Caption = 'Sprite Palette (The palette that the sprites (eg. Tanks), use):'
  end
  object lblTitleScreenPalette: TLabel
    Left = 5
    Top = 315
    Width = 97
    Height = 13
    Caption = 'Title Screen Palette:'
  end
  object lblLevelSelectPalette: TLabel
    Left = 5
    Top = 366
    Width = 371
    Height = 13
    Caption = 
      'Level Select Palette (The palette that is used when you are sele' +
      'cting a level):'
  end
  object imgNESColours: TImage32
    Left = 5
    Top = 8
    Width = 286
    Height = 73
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 0
    OnMouseMove = imgNESColoursMouseMove
    OnMouseUp = imgNESColoursMouseUp
  end
  object imgPalFra11: TImage32
    Left = 8
    Top = 131
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 1
    OnMouseUp = imgPalFra11MouseUp
  end
  object imgPalFra12: TImage32
    Tag = 1
    Left = 109
    Top = 129
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 2
    OnMouseUp = imgPalFra11MouseUp
  end
  object imgPalFra13: TImage32
    Tag = 2
    Left = 213
    Top = 129
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 3
    OnMouseUp = imgPalFra11MouseUp
  end
  object imgPalFra14: TImage32
    Tag = 3
    Left = 317
    Top = 129
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 4
    OnMouseUp = imgPalFra11MouseUp
  end
  object imgPalFra21: TImage32
    Left = 5
    Top = 179
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 5
    OnMouseUp = imgPalFra21MouseUp
  end
  object imgPalFra22: TImage32
    Tag = 1
    Left = 109
    Top = 179
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 6
    OnMouseUp = imgPalFra21MouseUp
  end
  object imgPalFra23: TImage32
    Tag = 2
    Left = 213
    Top = 179
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 7
    OnMouseUp = imgPalFra21MouseUp
  end
  object imgPalFra24: TImage32
    Tag = 3
    Left = 317
    Top = 179
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 8
    OnMouseUp = imgPalFra21MouseUp
  end
  object imgPalFra31: TImage32
    Left = 5
    Top = 230
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 9
    OnMouseUp = imgPalFra31MouseUp
  end
  object imgPalFra32: TImage32
    Tag = 1
    Left = 109
    Top = 230
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 10
    OnMouseUp = imgPalFra31MouseUp
  end
  object imgPalFra33: TImage32
    Tag = 2
    Left = 213
    Top = 230
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 11
    OnMouseUp = imgPalFra31MouseUp
  end
  object imgPalFra34: TImage32
    Tag = 3
    Left = 317
    Top = 230
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 12
    OnMouseUp = imgPalFra31MouseUp
  end
  object imgSprPal1: TImage32
    Left = 5
    Top = 281
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 13
    OnMouseUp = imgSprPal1MouseUp
  end
  object imgSprPal2: TImage32
    Tag = 1
    Left = 109
    Top = 281
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 14
    OnMouseUp = imgSprPal1MouseUp
  end
  object imgSprPal3: TImage32
    Tag = 2
    Left = 213
    Top = 281
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 15
    OnMouseUp = imgSprPal1MouseUp
  end
  object imgSprPal4: TImage32
    Tag = 3
    Left = 317
    Top = 281
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 16
    OnMouseUp = imgSprPal1MouseUp
  end
  object imgTitScr1: TImage32
    Left = 5
    Top = 332
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 17
    OnMouseUp = imgTitScr1MouseUp
  end
  object imgTitScr2: TImage32
    Tag = 1
    Left = 109
    Top = 332
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 18
    OnMouseUp = imgTitScr1MouseUp
  end
  object imgTitScr3: TImage32
    Tag = 2
    Left = 213
    Top = 332
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 19
    OnMouseUp = imgTitScr1MouseUp
  end
  object imgTitScr4: TImage32
    Tag = 3
    Left = 317
    Top = 332
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 20
    OnMouseUp = imgTitScr1MouseUp
  end
  object imgLevSel1: TImage32
    Left = 5
    Top = 383
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 21
    OnMouseUp = imgLevSel1MouseUp
  end
  object imgLevSel2: TImage32
    Tag = 1
    Left = 109
    Top = 383
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 22
    OnMouseUp = imgLevSel1MouseUp
  end
  object imgLevSel3: TImage32
    Tag = 2
    Left = 213
    Top = 383
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 23
    OnMouseUp = imgLevSel1MouseUp
  end
  object imgLevSel4: TImage32
    Tag = 3
    Left = 317
    Top = 383
    Width = 100
    Height = 25
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 1.000000000000000000
    ScaleMode = smNormal
    TabOrder = 24
    OnMouseUp = imgLevSel1MouseUp
  end
  object cmdOK: TButton
    Left = 263
    Top = 416
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 25
    OnClick = cmdOKClick
  end
  object cmdCancel: TButton
    Left = 342
    Top = 416
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 26
  end
end
