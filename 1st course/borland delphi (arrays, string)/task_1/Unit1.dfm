object Form1: TForm1
  Left = 295
  Top = 156
  BorderStyle = bsSingle
  Caption = '1.Vectors - Var 6'
  ClientHeight = 197
  ClientWidth = 583
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 8
    Width = 98
    Height = 20
    Caption = 'Source vector'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object StringGrid1: TStringGrid
    Left = 32
    Top = 32
    Width = 385
    Height = 49
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
    OnKeyPress = StringGrid1KeyPress
  end
  object Button1: TButton
    Left = 424
    Top = 48
    Width = 105
    Height = 25
    Caption = 'Lenght'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 424
    Top = 80
    Width = 105
    Height = 25
    Caption = 'Read from file'
    TabOrder = 2
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 512
    Top = 160
    Width = 65
    Height = 25
    Caption = 'Exit'
    TabOrder = 3
    Kind = bkClose
    Style = bsNew
  end
  object Edit1: TEdit
    Left = 536
    Top = 48
    Width = 25
    Height = 21
    TabOrder = 4
    Text = '1'
    OnKeyPress = Edit1KeyPress
  end
  object UpDown1: TUpDown
    Left = 561
    Top = 48
    Width = 16
    Height = 21
    Associate = Edit1
    Min = 1
    Position = 1
    TabOrder = 5
    OnClick = UpDown1Click
  end
  object Clear: TButton
    Left = 176
    Top = 8
    Width = 65
    Height = 17
    Caption = 'Clear'
    TabOrder = 6
    OnClick = ClearClick
  end
  object Panel1: TPanel
    Left = 32
    Top = 152
    Width = 385
    Height = 33
    TabOrder = 7
    object answer1: TButton
      Left = 8
      Top = 8
      Width = 105
      Height = 17
      Caption = 'Subtask 1'
      TabOrder = 0
      OnClick = answer1Click
    end
    object answer2: TButton
      Left = 128
      Top = 8
      Width = 97
      Height = 17
      Caption = 'Subtask 2'
      TabOrder = 1
      OnClick = answer2Click
    end
    object answer3: TButton
      Left = 240
      Top = 8
      Width = 129
      Height = 17
      Caption = 'Subtask 3'
      TabOrder = 2
      OnClick = answer3Click
    end
  end
  object Button3: TButton
    Left = 424
    Top = 112
    Width = 105
    Height = 25
    Caption = 'Write in file'
    TabOrder = 8
    OnClick = Button3Click
  end
  object OpenDialog1: TOpenDialog
    Filter = 'txt|*.txt;*.pas'
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Top = 40
  end
end
