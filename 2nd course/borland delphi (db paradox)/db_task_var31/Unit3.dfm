object Form3: TForm3
  Left = 188
  Top = 114
  Width = 523
  Height = 187
  Caption = 'Search (locate)'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 256
    Top = 32
    Width = 217
    Height = 21
    EditLabel.Width = 62
    EditLabel.Height = 13
    EditLabel.Caption = 'LabeledEdit1'
    LabelPosition = lpLeft
    TabOrder = 0
    OnKeyPress = LabeledEdit1KeyPress
  end
  object BitBtn1: TBitBtn
    Left = 256
    Top = 88
    Width = 217
    Height = 41
    Caption = 'Exit'
    TabOrder = 1
    Kind = bkClose
  end
  object CheckBox1: TCheckBox
    Left = 256
    Top = 64
    Width = 161
    Height = 17
    Caption = 'Filter'
    TabOrder = 2
  end
  object Button1: TButton
    Left = 32
    Top = 88
    Width = 217
    Height = 41
    Caption = 'Search'
    TabOrder = 3
    OnClick = Button1Click
  end
end
