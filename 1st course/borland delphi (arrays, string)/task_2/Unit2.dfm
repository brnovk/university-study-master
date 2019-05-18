object Form2: TForm2
  Left = 395
  Top = 437
  Width = 452
  Height = 442
  Caption = '2.Matrix'
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
    Left = 336
    Top = 32
    Width = 56
    Height = 13
    Caption = 'Rows(Cols):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 80
    Top = 8
    Width = 118
    Height = 13
    Caption = '        Source matrix          '
  end
  object Label4: TLabel
    Left = 296
    Top = 96
    Width = 104
    Height = 13
    Caption = 'Number S(Subtask 3):'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 331
    Top = 64
    Width = 105
    Height = 25
    Caption = 'Set length'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 331
    Top = 280
    Width = 105
    Height = 25
    Caption = 'Read from file'
    TabOrder = 1
    OnClick = Button2Click
  end
  object BitBtn1: TBitBtn
    Left = 331
    Top = 344
    Width = 102
    Height = 25
    Caption = 'Exit'
    TabOrder = 2
    Kind = bkClose
    Style = bsNew
  end
  object Edit1: TEdit
    Left = 395
    Top = 32
    Width = 25
    Height = 21
    TabOrder = 3
    Text = '1'
    OnKeyPress = Edit1KeyPress
  end
  object UpDown1: TUpDown
    Left = 420
    Top = 32
    Width = 16
    Height = 21
    Associate = Edit1
    Min = 1
    Position = 1
    TabOrder = 4
    OnClick = UpDown1Click
  end
  object Button3: TButton
    Left = 331
    Top = 312
    Width = 105
    Height = 25
    Caption = 'Write to file'
    TabOrder = 5
    OnClick = Button3Click
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 24
    Width = 273
    Height = 129
    ColCount = 1
    DefaultColWidth = 50
    DefaultRowHeight = 20
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 6
    OnKeyPress = StringGrid1KeyPress
  end
  object Clear: TButton
    Left = 8
    Top = 8
    Width = 65
    Height = 15
    Caption = 'Clear'
    TabOrder = 7
    OnClick = ClearClick
  end
  object PageControl1: TPageControl
    Left = 32
    Top = 176
    Width = 297
    Height = 225
    ActivePage = TabSheet4
    TabOrder = 8
    object TabSheet1: TTabSheet
      Caption = 'Subtask 1'
      object rz1: TLabel
        Left = 10
        Top = 144
        Width = 3
        Height = 13
      end
      object StringGrid2: TStringGrid
        Left = 8
        Top = 4
        Width = 273
        Height = 129
        ColCount = 1
        DefaultColWidth = 50
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        TabOrder = 0
        OnKeyPress = StringGrid1KeyPress
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Subtask 2'
      ImageIndex = 1
      object ListBox1: TListBox
        Left = 8
        Top = 8
        Width = 273
        Height = 177
        ItemHeight = 13
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Subtask 3'
      ImageIndex = 2
      object rz3: TLabel
        Left = 40
        Top = 8
        Width = 120
        Height = 39
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Number of the first column does not contain elements less S:'
        ParentBiDiMode = False
        WordWrap = True
      end
      object Edit2: TEdit
        Left = 168
        Top = 32
        Width = 25
        Height = 21
        Enabled = False
        TabOrder = 0
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Subtask 4'
      ImageIndex = 3
      object rz4: TLabel
        Left = 8
        Top = 144
        Width = 3
        Height = 13
        WordWrap = True
      end
      object StringGrid3: TStringGrid
        Left = 8
        Top = 4
        Width = 273
        Height = 129
        ColCount = 1
        DefaultColWidth = 50
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        TabOrder = 0
        OnKeyPress = StringGrid1KeyPress
      end
    end
  end
  object Button4: TButton
    Left = 344
    Top = 168
    Width = 89
    Height = 41
    Caption = 'Calculate'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Edit3: TEdit
    Left = 400
    Top = 96
    Width = 33
    Height = 21
    TabOrder = 10
    OnKeyPress = Edit3KeyPress
  end
  object OpenDialog1: TOpenDialog
    Top = 336
  end
  object SaveDialog1: TSaveDialog
    Top = 304
  end
end
