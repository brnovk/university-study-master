object Form1: TForm1
  Left = 229
  Top = 118
  BorderStyle = bsToolWindow
  Caption = 'Task 3. Var 5. Baranov, POIT-21'
  ClientHeight = 570
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 689
    Height = 265
    Align = alTop
    Caption = ' '
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 352
      Height = 263
      Align = alLeft
      TabOrder = 0
      object StringGrid1: TStringGrid
        Left = 1
        Top = 18
        Width = 350
        Height = 113
        Align = alClient
        ColCount = 2
        FixedCols = 0
        RowCount = 3
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 0
        OnKeyPress = StringGrid1KeyPress
      end
      object StringGrid2: TStringGrid
        Left = 1
        Top = 148
        Width = 350
        Height = 114
        Align = alBottom
        ColCount = 4
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goEditing]
        TabOrder = 1
        OnKeyPress = StringGrid2KeyPress
      end
      object StaticText1: TStaticText
        Left = 1
        Top = 1
        Width = 350
        Height = 17
        Align = alTop
        BorderStyle = sbsSunken
        Caption = 'Matrix A:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 2
      end
      object StaticText2: TStaticText
        Left = 1
        Top = 131
        Width = 350
        Height = 17
        Align = alBottom
        BorderStyle = sbsSunken
        Caption = 'Matrix B:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 3
      end
    end
    object Panel3: TPanel
      Left = 353
      Top = 1
      Width = 335
      Height = 263
      Align = alClient
      TabOrder = 1
      object GroupBox1: TGroupBox
        Left = 2
        Top = 1
        Width = 332
        Height = 261
        Align = alRight
        Caption = 'Task options:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
        TabOrder = 0
        object GroupBox2: TGroupBox
          Left = 8
          Top = 24
          Width = 209
          Height = 73
          Caption = 'Matrix A:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          object Label1: TLabel
            Left = 16
            Top = 20
            Width = 43
            Height = 13
            Caption = 'Columns:'
          end
          object Label2: TLabel
            Left = 32
            Top = 44
            Width = 30
            Height = 13
            Caption = 'Rows:'
          end
          object SpinEdit1: TSpinEdit
            Left = 80
            Top = 16
            Width = 121
            Height = 22
            MaxValue = 99
            MinValue = 1
            TabOrder = 0
            Value = 1
            OnChange = SpinEdit1Change
          end
          object SpinEdit2: TSpinEdit
            Left = 80
            Top = 40
            Width = 121
            Height = 22
            MaxValue = 99
            MinValue = 1
            TabOrder = 1
            Value = 1
            OnChange = SpinEdit2Change
          end
        end
        object Button1: TButton
          Left = 224
          Top = 16
          Width = 97
          Height = 33
          Caption = 'Calculate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = Button1Click
        end
        object Button2: TButton
          Left = 224
          Top = 96
          Width = 97
          Height = 33
          Caption = 'From file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = Button2Click
        end
        object Button3: TButton
          Left = 224
          Top = 136
          Width = 97
          Height = 33
          Caption = 'To file'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = Button3Click
        end
        object Button4: TButton
          Left = 224
          Top = 176
          Width = 97
          Height = 33
          Caption = 'About'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = Button4Click
        end
        object Button5: TButton
          Left = 224
          Top = 216
          Width = 97
          Height = 33
          Caption = 'Exit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = Button5Click
        end
        object GroupBox3: TGroupBox
          Left = 8
          Top = 112
          Width = 209
          Height = 73
          Caption = 'Matrix B:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          object Label3: TLabel
            Left = 16
            Top = 20
            Width = 43
            Height = 13
            Caption = 'Columns:'
          end
          object Label4: TLabel
            Left = 32
            Top = 44
            Width = 30
            Height = 13
            Caption = 'Rows:'
          end
          object SpinEdit3: TSpinEdit
            Left = 80
            Top = 16
            Width = 121
            Height = 22
            MaxValue = 99
            MinValue = 1
            TabOrder = 0
            Value = 1
            OnChange = SpinEdit3Change
          end
          object SpinEdit4: TSpinEdit
            Left = 80
            Top = 40
            Width = 121
            Height = 22
            MaxValue = 99
            MinValue = 1
            TabOrder = 1
            Value = 1
            OnChange = SpinEdit4Change
          end
        end
        object GroupBox4: TGroupBox
          Left = 8
          Top = 200
          Width = 209
          Height = 49
          Caption = 'N:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          object Label5: TLabel
            Left = 24
            Top = 20
            Width = 51
            Height = 13
            Caption = 'Number N:'
          end
          object SpinEdit5: TSpinEdit
            Left = 80
            Top = 16
            Width = 121
            Height = 22
            MaxValue = 1000
            MinValue = -1000
            TabOrder = 0
            Value = 0
          end
        end
        object Button6: TButton
          Left = 224
          Top = 56
          Width = 97
          Height = 33
          Caption = 'Random fill'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = Button6Click
        end
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 265
    Width = 689
    Height = 305
    Align = alClient
    TabOrder = 1
    object StaticText3: TStaticText
      Left = 1
      Top = 1
      Width = 687
      Height = 17
      Align = alTop
      BorderStyle = sbsSunken
      Caption = 'Result:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
      TabOrder = 0
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 18
      Width = 687
      Height = 286
      ActivePage = TabSheet1
      Align = alClient
      TabOrder = 1
      object TabSheet1: TTabSheet
        Caption = 'A + B'
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 679
          Height = 25
          Align = alTop
        end
        object StringGrid3: TStringGrid
          Left = 0
          Top = 25
          Width = 679
          Height = 233
          Align = alClient
          FixedCols = 0
          FixedRows = 0
          TabOrder = 0
        end
        object StaticText4: TStaticText
          Left = 8
          Top = 8
          Width = 4
          Height = 4
          TabOrder = 1
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'A - B'
        ImageIndex = 1
        object Bevel2: TBevel
          Left = 0
          Top = 0
          Width = 679
          Height = 25
          Align = alTop
        end
        object StringGrid4: TStringGrid
          Left = 0
          Top = 25
          Width = 679
          Height = 233
          Align = alClient
          FixedCols = 0
          FixedRows = 0
          TabOrder = 0
        end
        object StaticText5: TStaticText
          Left = 8
          Top = 8
          Width = 4
          Height = 4
          TabOrder = 1
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'A * B'
        ImageIndex = 2
        object Bevel3: TBevel
          Left = 0
          Top = 0
          Width = 679
          Height = 25
          Align = alTop
        end
        object StringGrid5: TStringGrid
          Left = 0
          Top = 25
          Width = 679
          Height = 233
          Align = alClient
          FixedCols = 0
          FixedRows = 0
          TabOrder = 0
        end
        object StaticText6: TStaticText
          Left = 8
          Top = 8
          Width = 4
          Height = 4
          TabOrder = 1
        end
      end
      object TabSheet4: TTabSheet
        Caption = '(A * N) and (B*N)'
        ImageIndex = 3
        object GroupBox13: TGroupBox
          Left = 0
          Top = 0
          Width = 337
          Height = 258
          Align = alLeft
          Caption = 'Matrix A * N'
          TabOrder = 0
          object StringGrid6: TStringGrid
            Left = 2
            Top = 15
            Width = 333
            Height = 241
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
        object GroupBox14: TGroupBox
          Left = 336
          Top = 0
          Width = 343
          Height = 258
          Align = alRight
          Caption = 'Matrix B * N'
          TabOrder = 1
          object StringGrid13: TStringGrid
            Left = 2
            Top = 15
            Width = 339
            Height = 241
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = 'Sort rows'
        ImageIndex = 4
        object GroupBox5: TGroupBox
          Left = 0
          Top = 0
          Width = 337
          Height = 258
          Align = alLeft
          Caption = 'Matrix A:'
          TabOrder = 0
          object StringGrid7: TStringGrid
            Left = 2
            Top = 15
            Width = 333
            Height = 241
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
        object GroupBox6: TGroupBox
          Left = 336
          Top = 0
          Width = 343
          Height = 258
          Align = alRight
          Caption = 'Matrix B:'
          TabOrder = 1
          object StringGrid8: TStringGrid
            Left = 2
            Top = 15
            Width = 339
            Height = 241
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
      end
      object TabSheet6: TTabSheet
        Caption = 'Inverse matrix'
        ImageIndex = 5
        object Bevel4: TBevel
          Left = 0
          Top = 0
          Width = 679
          Height = 25
          Align = alTop
        end
        object GroupBox7: TGroupBox
          Left = 0
          Top = 25
          Width = 337
          Height = 233
          Align = alLeft
          Caption = 'Matrix A:'
          TabOrder = 0
          object StringGrid9: TStringGrid
            Left = 2
            Top = 15
            Width = 333
            Height = 216
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
        object GroupBox8: TGroupBox
          Left = 336
          Top = 25
          Width = 343
          Height = 233
          Align = alRight
          Caption = 'Matrix B:'
          TabOrder = 1
          object StringGrid10: TStringGrid
            Left = 2
            Top = 15
            Width = 339
            Height = 216
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
        object StaticText8: TStaticText
          Left = 344
          Top = 8
          Width = 4
          Height = 4
          TabOrder = 2
        end
        object StaticText7: TStaticText
          Left = 16
          Top = 8
          Width = 4
          Height = 4
          TabOrder = 3
        end
      end
      object TabSheet7: TTabSheet
        Caption = 'Transpose'
        ImageIndex = 6
        object GroupBox9: TGroupBox
          Left = 0
          Top = 0
          Width = 337
          Height = 258
          Align = alLeft
          Caption = 'Matrix A:'
          TabOrder = 0
          object StringGrid11: TStringGrid
            Left = 2
            Top = 15
            Width = 333
            Height = 241
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
        object GroupBox10: TGroupBox
          Left = 336
          Top = 0
          Width = 343
          Height = 258
          Align = alRight
          Caption = 'Matrix B:'
          TabOrder = 1
          object StringGrid12: TStringGrid
            Left = 2
            Top = 15
            Width = 339
            Height = 241
            Align = alClient
            FixedCols = 0
            FixedRows = 0
            TabOrder = 0
          end
        end
      end
      object TabSheet8: TTabSheet
        Caption = 'Determinant'
        ImageIndex = 7
        object GroupBox11: TGroupBox
          Left = 0
          Top = 0
          Width = 337
          Height = 258
          Align = alLeft
          Caption = 'Matrix A:'
          TabOrder = 0
          object LabeledEdit1: TLabeledEdit
            Left = 152
            Top = 32
            Width = 169
            Height = 21
            EditLabel.Width = 100
            EditLabel.Height = 13
            EditLabel.Caption = 'Determinant matrix A:'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 0
          end
        end
        object GroupBox12: TGroupBox
          Left = 336
          Top = 0
          Width = 343
          Height = 258
          Align = alRight
          Caption = 'Matrix B:'
          TabOrder = 1
          object LabeledEdit2: TLabeledEdit
            Left = 160
            Top = 32
            Width = 169
            Height = 21
            EditLabel.Width = 100
            EditLabel.Height = 13
            EditLabel.Caption = 'Determinant matrix B:'
            LabelPosition = lpLeft
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.txt'
    Filter = 'txt-file|*.txt'
    Left = 474
    Top = 2
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '.txt'
    Filter = 'txt-file|*.txt'
    Left = 506
    Top = 2
  end
end
