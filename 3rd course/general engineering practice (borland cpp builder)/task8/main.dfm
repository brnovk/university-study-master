object Form1: TForm1
  Left = 524
  Top = 322
  Width = 355
  Height = 163
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 9
    Height = 16
    Caption = '8'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 208
    Top = 16
    Width = 17
    Height = 16
    Caption = '16'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 160
    Top = 56
    Width = 17
    Height = 16
    Caption = '=>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object Button1: TButton
    Left = 8
    Top = 88
    Width = 105
    Height = 25
    Caption = 'Convert'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 120
    Top = 88
    Width = 105
    Height = 25
    Caption = 'About'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 232
    Top = 88
    Width = 97
    Height = 25
    Caption = 'Exit'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 208
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
end
