object MainForm: TMainForm
  Left = 374
  Top = 364
  Width = 800
  Height = 533
  Caption = 'Database "Warehouse" [vers. 2]'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 352
    ActivePage = TabSheet1
    Align = alClient
    TabIndex = 0
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 776
        Height = 324
        Align = alClient
        ColCount = 4
        FixedColor = clScrollBar
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 776
        Height = 323
        Align = alClient
        ColCount = 3
        FixedColor = clScrollBar
        FixedCols = 0
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
      object LabeledEdit1: TLabeledEdit
        Left = 180
        Top = 40
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit1'
        EditLabel.Color = clBtnFace
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentColor = False
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit2: TLabeledEdit
        Left = 180
        Top = 145
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit2'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 1
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit3: TLabeledEdit
        Left = 180
        Top = 250
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit3'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 2
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit4: TLabeledEdit
        Left = 180
        Top = 360
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit4'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 3
        OnKeyPress = LabeledEdit1KeyPress
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      ImageIndex = 3
      object LabeledEdit5: TLabeledEdit
        Left = 180
        Top = 40
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit5'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit6: TLabeledEdit
        Left = 180
        Top = 200
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit6'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 1
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit7: TLabeledEdit
        Left = 180
        Top = 360
        Width = 585
        Height = 28
        EditLabel.Width = 107
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit7'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'MS Sans Serif'
        EditLabel.Font.Style = [fsBold]
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 2
        OnKeyPress = LabeledEdit1KeyPress
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'TabSheet5'
      ImageIndex = 4
      object StringGrid3: TStringGrid
        Left = 0
        Top = 0
        Width = 776
        Height = 282
        Align = alClient
        ColCount = 3
        FixedColor = clScrollBar
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
      end
      object Panel4: TPanel
        Left = 0
        Top = 282
        Width = 776
        Height = 41
        Align = alBottom
        Caption = ' '
        TabOrder = 1
        object Label1: TLabel
          Left = 16
          Top = 8
          Width = 9
          Height = 20
          Caption = ' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -17
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 392
          Top = 8
          Width = 9
          Height = 20
          Caption = ' '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clTeal
          Font.Height = -17
          Font.Name = 'Consolas'
          Font.Style = []
          ParentFont = False
        end
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 352
    Width = 784
    Height = 41
    Align = alBottom
    Caption = ' '
    TabOrder = 1
    object Button1: TButton
      Left = 12
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 168
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 320
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 472
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button4'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 624
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button5'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 393
    Width = 784
    Height = 41
    Align = alBottom
    Caption = ' '
    TabOrder = 2
    object Button6: TButton
      Left = 12
      Top = 4
      Width = 377
      Height = 33
      Caption = 'Button6'
      TabOrder = 0
      OnClick = Button6Click
    end
    object Button7: TButton
      Left = 396
      Top = 4
      Width = 377
      Height = 33
      Caption = 'Button7'
      TabOrder = 1
      OnClick = Button7Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 434
    Width = 784
    Height = 41
    Align = alBottom
    Caption = ' '
    TabOrder = 3
    object Button8: TButton
      Left = 208
      Top = 4
      Width = 181
      Height = 33
      Caption = 'Button8'
      TabOrder = 0
      OnClick = Button8Click
    end
    object Button9: TButton
      Left = 396
      Top = 4
      Width = 377
      Height = 33
      Caption = 'Button9'
      TabOrder = 1
      OnClick = Button9Click
    end
    object ComboBox1: TComboBox
      Left = 12
      Top = 4
      Width = 189
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clTeal
      Font.Height = -19
      Font.Name = 'Consolas'
      Font.Style = []
      ItemHeight = 22
      ParentFont = False
      TabOrder = 2
      Text = ' '
    end
  end
  object MainMenu1: TMainMenu
    Left = 8
    Top = 312
    object N1: TMenuItem
      Caption = 'Menu'
      object N2: TMenuItem
        Caption = 'File'
        object N5: TMenuItem
          Caption = 'Load list copy from file'
          OnClick = N5Click
        end
        object N6: TMenuItem
          Caption = 'Save list copy in file'
          OnClick = N6Click
        end
      end
      object N3: TMenuItem
        Caption = 'About'
        OnClick = N3Click
      end
      object N4: TMenuItem
        Caption = 'Exit'
        OnClick = N4Click
      end
    end
  end
end
