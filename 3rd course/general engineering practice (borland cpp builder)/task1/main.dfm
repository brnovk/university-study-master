object Form1: TForm1
  Left = 317
  Top = 124
  Width = 502
  Height = 230
  Caption = 'Task 1, POIT-31, Variant 4, Baranov.V.'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    486
    192)
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 360
    Top = 6
    Width = 121
    Height = 21
    Anchors = [akLeft]
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Value X:'
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 360
    Top = 32
    Width = 121
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Value Y:'
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 360
    Top = 56
    Width = 121
    Height = 21
    EditLabel.Width = 40
    EditLabel.Height = 13
    EditLabel.Caption = 'Value Z:'
    LabelPosition = lpLeft
    LabelSpacing = 3
    TabOrder = 2
  end
  object LabeledEdit4: TLabeledEdit
    Left = 8
    Top = 96
    Width = 473
    Height = 21
    EditLabel.Width = 86
    EditLabel.Height = 13
    EditLabel.Caption = 'Calculation result: '
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 3
  end
  object Button1: TButton
    Left = 8
    Top = 120
    Width = 473
    Height = 65
    Caption = 'Calculate'
    TabOrder = 4
    OnClick = Button1Click
  end
end
