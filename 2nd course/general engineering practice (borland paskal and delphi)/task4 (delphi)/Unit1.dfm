object Form1: TForm1
  Left = 290
  Top = 275
  Width = 690
  Height = 411
  Caption = 'Task 4. Var 5. Baranov, POIT-21'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 337
    Height = 384
    Align = alLeft
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 335
      Height = 302
      Align = alClient
      Caption = 'Matrix A:'
      TabOrder = 0
      object StringGrid1: TStringGrid
        Left = 2
        Top = 15
        Width = 331
        Height = 285
        Align = alClient
        FixedCols = 0
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnKeyPress = StringGrid1KeyPress
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 303
      Width = 335
      Height = 80
      Align = alBottom
      Caption = 'Vector B:'
      TabOrder = 1
      object StringGrid2: TStringGrid
        Left = 2
        Top = 15
        Width = 331
        Height = 63
        Align = alClient
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnKeyPress = StringGrid2KeyPress
      end
    end
  end
  object Panel2: TPanel
    Left = 337
    Top = 0
    Width = 345
    Height = 384
    Align = alClient
    TabOrder = 1
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 343
      Height = 200
      Align = alTop
      Caption = 'Task options:'
      TabOrder = 0
      object GroupBox4: TGroupBox
        Left = 8
        Top = 16
        Width = 193
        Height = 97
        Caption = 'Matrix A:'
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 27
          Width = 43
          Height = 13
          Caption = 'Columns:'
        end
        object Label2: TLabel
          Left = 24
          Top = 59
          Width = 30
          Height = 13
          Caption = 'Rows:'
        end
        object SpinEdit1: TSpinEdit
          Left = 64
          Top = 24
          Width = 121
          Height = 22
          EditorEnabled = False
          MaxLength = 20
          MaxValue = 20
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = SpinEdit1Change
        end
        object SpinEdit2: TSpinEdit
          Left = 64
          Top = 56
          Width = 121
          Height = 22
          EditorEnabled = False
          MaxLength = 20
          MaxValue = 20
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = SpinEdit2Change
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 120
        Width = 193
        Height = 73
        Caption = 'Vector B:'
        TabOrder = 1
        object Label3: TLabel
          Left = 8
          Top = 28
          Width = 61
          Height = 13
          Caption = 'Count elems:'
        end
        object SpinEdit3: TSpinEdit
          Left = 72
          Top = 24
          Width = 113
          Height = 22
          Enabled = False
          MaxValue = 0
          MinValue = 0
          ReadOnly = True
          TabOrder = 0
          Value = 0
        end
      end
      object Button1: TButton
        Left = 208
        Top = 8
        Width = 129
        Height = 25
        Caption = 'Calculate'
        TabOrder = 2
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 208
        Top = 40
        Width = 129
        Height = 25
        Caption = 'Random filling'
        TabOrder = 3
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 208
        Top = 72
        Width = 129
        Height = 25
        Caption = 'Read from file'
        TabOrder = 4
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 208
        Top = 104
        Width = 129
        Height = 25
        Caption = 'Write in file'
        TabOrder = 5
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 208
        Top = 136
        Width = 129
        Height = 25
        Caption = 'About'
        TabOrder = 6
        OnClick = Button5Click
      end
      object Button6: TButton
        Left = 208
        Top = 168
        Width = 129
        Height = 25
        Caption = 'Exit'
        TabOrder = 7
        OnClick = Button6Click
      end
    end
    object GroupBox6: TGroupBox
      Left = 1
      Top = 201
      Width = 343
      Height = 182
      Align = alClient
      Caption = 'Result:'
      TabOrder = 1
      object PageControl1: TPageControl
        Left = 2
        Top = 15
        Width = 339
        Height = 165
        ActivePage = TabSheet3
        Align = alClient
        TabOrder = 0
        object TabSheet1: TTabSheet
          Caption = 'block method'
          object Bevel2: TBevel
            Left = 0
            Top = 0
            Width = 331
            Height = 25
            Align = alTop
          end
          object StringGrid3: TStringGrid
            Left = 0
            Top = 25
            Width = 331
            Height = 112
            Align = alClient
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            TabOrder = 0
          end
          object StaticText1: TStaticText
            Left = 8
            Top = 5
            Width = 4
            Height = 4
            TabOrder = 1
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'by Gauss'
          ImageIndex = 1
          object Bevel1: TBevel
            Left = 0
            Top = 0
            Width = 331
            Height = 25
            Align = alTop
          end
          object StringGrid4: TStringGrid
            Left = 0
            Top = 25
            Width = 331
            Height = 112
            Align = alClient
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            TabOrder = 0
          end
          object StaticText2: TStaticText
            Left = 8
            Top = 5
            Width = 4
            Height = 4
            TabOrder = 1
          end
        end
        object TabSheet3: TTabSheet
          Caption = 'checked'
          ImageIndex = 2
          object StringGrid5: TStringGrid
            Left = 0
            Top = 0
            Width = 331
            Height = 137
            Align = alClient
            FixedCols = 0
            RowCount = 1
            FixedRows = 0
            TabOrder = 0
          end
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.txt'
    Filter = 'txt|*.txt'
    Left = 458
    Top = 1
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'txt|*.txt'
    Left = 490
    Top = 1
  end
end
