object Form1: TForm1
  Left = 391
  Top = 151
  Width = 525
  Height = 527
  Caption = 'Task 2 (POIT-31, Variant 4, Baranov. V.)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 7
    Top = 7
    Width = 22
    Height = 16
    Caption = 'X1='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 7
    Top = 33
    Width = 22
    Height = 16
    Caption = 'X2='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 176
    Top = 7
    Width = 17
    Height = 16
    Caption = 'N='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 179
    Top = 33
    Width = 15
    Height = 16
    Caption = 'e='
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 33
    Top = 7
    Width = 128
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 33
    Top = 33
    Width = 128
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object Edit3: TEdit
    Left = 200
    Top = 7
    Width = 169
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Memo1: TMemo
    Left = 0
    Top = 61
    Width = 509
    Height = 428
    Align = alBottom
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object Button1: TButton
    Left = 376
    Top = 8
    Width = 129
    Height = 45
    Caption = 'Calculate'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Edit4: TEdit
    Left = 200
    Top = 33
    Width = 169
    Height = 21
    TabOrder = 5
    Text = 'Edit1'
  end
end
