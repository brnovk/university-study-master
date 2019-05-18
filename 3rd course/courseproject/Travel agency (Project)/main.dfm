object Form1: TForm1
  Left = 347
  Top = 231
  Width = 800
  Height = 533
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Travel agency database'
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
  object Panel1: TPanel
    Left = 0
    Top = 393
    Width = 784
    Height = 41
    Align = alBottom
    Caption = ' '
    TabOrder = 0
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
      Left = 167
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button2'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 322
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 477
      Top = 4
      Width = 148
      Height = 33
      Caption = 'Button4'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 632
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
    Top = 434
    Width = 784
    Height = 41
    Align = alBottom
    Caption = ' '
    TabOrder = 1
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
      Left = 404
      Top = 4
      Width = 377
      Height = 33
      Caption = 'Button7'
      TabOrder = 1
      OnClick = Button7Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 784
    Height = 393
    ActivePage = TabSheet2
    Align = alClient
    TabIndex = 1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'List of flights'
      object StringGrid1: TStringGrid
        Left = 0
        Top = 0
        Width = 784
        Height = 377
        Align = alClient
        DefaultColWidth = 135
        FixedColor = clScrollBar
        FixedCols = 0
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'List of clients'
      ImageIndex = 1
      object StringGrid2: TStringGrid
        Left = 0
        Top = 0
        Width = 776
        Height = 365
        Align = alClient
        DefaultColWidth = 116
        FixedColor = clScrollBar
        FixedCols = 0
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Consolas'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      object LabeledEdit1: TLabeledEdit
        Left = 192
        Top = 40
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit1'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit2: TLabeledEdit
        Left = 192
        Top = 104
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit2'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 1
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit3: TLabeledEdit
        Left = 192
        Top = 168
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit3'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 2
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit4: TLabeledEdit
        Left = 192
        Top = 232
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit4'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 3
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit5: TLabeledEdit
        Left = 192
        Top = 296
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit5'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 4
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit6: TLabeledEdit
        Left = 192
        Top = 360
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit6'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 5
        OnKeyPress = LabeledEdit1KeyPress
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'TabSheet4'
      ImageIndex = 3
      object LabeledEdit7: TLabeledEdit
        Left = 192
        Top = 24
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit7'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 0
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit8: TLabeledEdit
        Left = 192
        Top = 80
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit8'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 1
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit9: TLabeledEdit
        Left = 192
        Top = 136
        Width = 585
        Height = 28
        EditLabel.Width = 108
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit9'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 2
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit10: TLabeledEdit
        Left = 192
        Top = 192
        Width = 585
        Height = 28
        EditLabel.Width = 117
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit10'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 3
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit11: TLabeledEdit
        Left = 192
        Top = 248
        Width = 585
        Height = 28
        EditLabel.Width = 117
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit11'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 4
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit12: TLabeledEdit
        Left = 192
        Top = 304
        Width = 585
        Height = 28
        EditLabel.Width = 117
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit12'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 5
        OnKeyPress = LabeledEdit1KeyPress
      end
      object LabeledEdit13: TLabeledEdit
        Left = 192
        Top = 360
        Width = 585
        Height = 28
        EditLabel.Width = 117
        EditLabel.Height = 20
        EditLabel.Caption = 'LabeledEdit13'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clTeal
        EditLabel.Font.Height = -17
        EditLabel.Font.Name = 'Consolas'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clTeal
        Font.Height = -17
        Font.Name = 'Consolas'
        Font.Style = []
        LabelPosition = lpLeft
        LabelSpacing = 3
        ParentFont = False
        TabOrder = 6
        OnKeyPress = LabeledEdit1KeyPress
      end
    end
  end
  object MainMenu1: TMainMenu
    Top = 496
    object N1: TMenuItem
      Caption = 'Menu'
      object SaveLists: TMenuItem
        Caption = 'File'
        object N2: TMenuItem
          Caption = 'Save list copy in file'
          OnClick = N2Click
        end
        object N5: TMenuItem
          Caption = 'Load list copy from file'
          OnClick = N5Click
        end
      end
      object LoadLists: TMenuItem
        Caption = 'Sorting'
        object N6: TMenuItem
          Caption = 'List of flights'
          object N8: TMenuItem
            Caption = 'Departure date'
            OnClick = N8Click
          end
          object N10: TMenuItem
            Caption = 'Flight number'
            OnClick = N10Click
          end
          object N11: TMenuItem
            Caption = 'Departure airport'
            OnClick = N11Click
          end
          object N12: TMenuItem
            Caption = 'Arrival airport'
            OnClick = N12Click
          end
        end
        object N7: TMenuItem
          Caption = 'List of clients'
          object N13: TMenuItem
            Caption = 'Client surname'
            OnClick = N13Click
          end
          object N14: TMenuItem
            Caption = 'Departure date'
            OnClick = N14Click
          end
          object N15: TMenuItem
            Caption = 'Resting place'
            OnClick = N15Click
          end
          object N16: TMenuItem
            Caption = 'Arrival airport'
            OnClick = N16Click
          end
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
