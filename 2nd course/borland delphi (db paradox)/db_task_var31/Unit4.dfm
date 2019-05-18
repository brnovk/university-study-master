object Form4: TForm4
  Left = 508
  Top = 342
  Width = 490
  Height = 375
  Caption = 'Queries'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 474
    Height = 97
    Align = alTop
    Caption = ' '
    TabOrder = 0
    object StaticText1: TStaticText
      Left = 1
      Top = 1
      Width = 472
      Height = 17
      Align = alTop
      Caption = ' '
      TabOrder = 0
    end
    object Edit1: TEdit
      Left = 16
      Top = 32
      Width = 289
      Height = 21
      TabOrder = 1
      Text = ' '
      OnKeyPress = Edit1KeyPress
    end
    object Button1: TButton
      Left = 16
      Top = 64
      Width = 113
      Height = 25
      Caption = 'Query'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 136
      Top = 64
      Width = 121
      Height = 25
      Caption = 'Cancel'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 97
    Width = 474
    Height = 240
    Align = alClient
    DataSource = Form1.DataSource4
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
end
