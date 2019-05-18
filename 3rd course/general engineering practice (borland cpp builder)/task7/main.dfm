object Form1: TForm1
  Left = 720
  Top = 132
  Width = 528
  Height = 310
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 37
    Height = 16
    Caption = 'Rows:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 40
    Top = 40
    Width = 30
    Height = 16
    Caption = 'Cols:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 168
    Top = 8
    Width = 170
    Height = 16
    Caption = 'Number of special elements:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 344
    Top = 8
    Width = 17
    Height = 16
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 168
    Top = 40
    Width = 209
    Height = 17
    Caption = 'Change size'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 232
    Width = 185
    Height = 33
    Caption = 'Calculate'
    TabOrder = 1
    OnClick = Button2Click
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 64
    Width = 497
    Height = 161
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object Edit1: TEdit
    Left = 80
    Top = 8
    Width = 81
    Height = 21
    TabOrder = 3
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 80
    Top = 40
    Width = 81
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object Button3: TButton
    Left = 200
    Top = 232
    Width = 169
    Height = 33
    Caption = 'About'
    TabOrder = 5
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 376
    Top = 232
    Width = 129
    Height = 33
    Caption = 'Exit'
    TabOrder = 6
    OnClick = Button4Click
  end
end
