object frmFlagTSAEditor: TfrmFlagTSAEditor
  Left = 391
  Top = 322
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Flag TSA Editor'
  ClientHeight = 303
  ClientWidth = 373
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
  object imgFlagTSA: TImage32
    Left = 8
    Top = 8
    Width = 96
    Height = 64
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 0
    OnMouseUp = imgFlagTSAMouseUp
  end
  object imgFortFlagTSA: TImage32
    Left = 8
    Top = 80
    Width = 96
    Height = 64
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 1
    OnMouseUp = imgFortFlagTSAMouseUp
  end
  object imgTSA: TImage32
    Left = 112
    Top = 8
    Width = 256
    Height = 256
    Bitmap.ResamplerClassName = 'TNearestResampler'
    BitmapAlign = baTopLeft
    Scale = 2.000000000000000000
    ScaleMode = smScale
    TabOrder = 2
    OnMouseUp = imgTSAMouseUp
  end
  object cmdOK: TButton
    Left = 214
    Top = 272
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
  end
  object cmdCancel: TButton
    Left = 294
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
end
