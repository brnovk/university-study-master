object Form1: TForm1
  Left = 331
  Top = 173
  Width = 491
  Height = 405
  BorderIcons = [biSystemMenu]
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
  object Button1: TButton
    Left = 8
    Top = 312
    Width = 241
    Height = 49
    Caption = 'Calculate'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 376
    Top = 312
    Width = 89
    Height = 49
    Caption = 'Exit'
    TabOrder = 1
    OnClick = Button2Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 16
    Width = 361
    Height = 21
    EditLabel.Width = 65
    EditLabel.Height = 13
    EditLabel.Caption = 'Source string:'
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 2
    OnKeyPress = LabeledEdit1KeyPress
  end
  object Button3: TButton
    Left = 376
    Top = 8
    Width = 89
    Height = 33
    Caption = 'Clear'
    TabOrder = 3
    OnClick = Button3Click
  end
  object ListBox1: TListBox
    Left = 8
    Top = 48
    Width = 457
    Height = 257
    ItemHeight = 13
    TabOrder = 4
  end
  object Button4: TButton
    Left = 256
    Top = 312
    Width = 113
    Height = 49
    Caption = 'About'
    TabOrder = 5
    OnClick = Button4Click
  end
end
