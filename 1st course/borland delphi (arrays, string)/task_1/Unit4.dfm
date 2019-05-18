object Form4: TForm4
  Left = 270
  Top = 393
  Width = 458
  Height = 165
  Caption = 'Subtask 3'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 64
    Top = 48
    Width = 99
    Height = 20
    Caption = 'Sorted vector:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 277
    Height = 16
    Caption = 'Sorting method for linear computation of choice'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -14
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 72
    Width = 385
    Height = 49
    ColCount = 1
    Enabled = False
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
  end
  object Clear: TButton
    Left = 280
    Top = 40
    Width = 65
    Height = 25
    Caption = 'Clear'
    TabOrder = 1
    OnClick = ClearClick
  end
  object Button1: TButton
    Left = 352
    Top = 40
    Width = 89
    Height = 25
    Caption = 'Write in file'
    TabOrder = 2
    OnClick = Button1Click
  end
end
