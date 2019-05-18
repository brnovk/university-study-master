object Form1: TForm1
  Left = 425
  Top = 203
  Width = 633
  Height = 417
  Caption = 'BD_var31'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 359
    Align = alClient
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 329
      Width = 520
      Height = 30
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel3'
      TabOrder = 0
      object DBNavigator1: TDBNavigator
        Left = 0
        Top = 0
        Width = 520
        Height = 30
        DataSource = DataSource1
        Align = alClient
        TabOrder = 0
      end
    end
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 520
      Height = 329
      ActivePage = TabSheet3
      Align = alClient
      TabOrder = 1
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = 'Finished potions'
        object DBGrid1: TDBGrid
          Left = 0
          Top = 0
          Width = 512
          Height = 301
          Align = alClient
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Delivery potions'
        ImageIndex = 1
        object DBGrid2: TDBGrid
          Left = 0
          Top = 0
          Width = 512
          Height = 301
          Align = alClient
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Sale potions'
        ImageIndex = 2
        object DBGrid3: TDBGrid
          Left = 0
          Top = 0
          Width = 512
          Height = 301
          Align = alClient
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 520
    Top = 0
    Width = 97
    Height = 359
    Align = alRight
    BevelOuter = bvNone
    Caption = ' '
    TabOrder = 1
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 97
      Height = 25
      Caption = 'Edit'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 0
      Top = 24
      Width = 97
      Height = 25
      Caption = 'Add'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 0
      Top = 48
      Width = 97
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 0
      Top = 72
      Width = 97
      Height = 25
      Caption = 'Insert'
      TabOrder = 3
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 0
      Top = 96
      Width = 97
      Height = 25
      Caption = 'Exit'
      TabOrder = 4
      OnClick = Button5Click
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 32
    Top = 248
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 64
    Top = 248
  end
  object DataSource3: TDataSource
    DataSet = Table3
    Left = 96
    Top = 248
  end
  object Table1: TTable
    DatabaseName = 'STANDARD2'
    Left = 32
    Top = 280
  end
  object Table2: TTable
    OnCalcFields = Table2CalcFields
    DatabaseName = 'STANDARD2'
    TableName = 'tab_receipt.db'
    Left = 64
    Top = 280
    object Table2Kl_potion: TIntegerField
      FieldName = 'Kl_potion'
    end
    object Table2Cost: TCurrencyField
      FieldName = 'Cost'
    end
    object Table2Receipt_amount: TIntegerField
      FieldName = 'Receipt_amount'
    end
    object Table2Receipt_date: TDateField
      FieldName = 'Receipt_date'
    end
    object Table2Summa: TIntegerField
      FieldKind = fkCalculated
      FieldName = 'Summa'
      ReadOnly = True
      Calculated = True
    end
  end
  object Table3: TTable
    DatabaseName = 'STANDARD2'
    MasterSource = DataSource2
    Left = 96
    Top = 280
  end
  object MainMenu1: TMainMenu
    Left = 32
    Top = 312
    object N1: TMenuItem
      Caption = 'Tables'
      object N5: TMenuItem
        Caption = 'Edit record'
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = 'Add record'
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = 'Delete record'
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = 'Insert record'
        OnClick = N8Click
      end
      object N9: TMenuItem
        Caption = 'View tables'
        object N25: TMenuItem
          Caption = 'Finished potions'
          OnClick = N25Click
        end
        object N26: TMenuItem
          Caption = 'Delivery potions'
          OnClick = N26Click
        end
        object N27: TMenuItem
          Caption = 'Sale potions'
          OnClick = N27Click
        end
      end
      object N10: TMenuItem
        Caption = 'Search'
        object N14: TMenuItem
          Caption = 'Finished potions'
          object N17: TMenuItem
            Caption = 'Potion code'
            OnClick = N17Click
          end
          object N18: TMenuItem
            Caption = 'Potion name'
            OnClick = N18Click
          end
          object N19: TMenuItem
            Caption = 'Implementation period'
            OnClick = N19Click
          end
        end
        object N15: TMenuItem
          Caption = 'Delivery potions'
          object N20: TMenuItem
            Caption = 'Potion cost'
            OnClick = N20Click
          end
          object N21: TMenuItem
            Caption = 'Amount received'
            OnClick = N21Click
          end
          object N22: TMenuItem
            Caption = 'Date of arrivals'
            OnClick = N22Click
          end
        end
        object N16: TMenuItem
          Caption = 'Sale potions'
          object N23: TMenuItem
            Caption = 'Number of sold'
            OnClick = N23Click
          end
          object N24: TMenuItem
            Caption = 'Date sold'
            OnClick = N24Click
          end
        end
      end
      object N11: TMenuItem
        Caption = 'Exit'
        OnClick = N11Click
      end
    end
    object N2: TMenuItem
      Caption = 'Sort and Query'
      object N12: TMenuItem
        Caption = 'Sorting'
        object N28: TMenuItem
          Caption = 'Potion code (ascending)'
          OnClick = N28Click
        end
        object N29: TMenuItem
          Caption = 'Potion code (descending)'
          OnClick = N29Click
        end
        object N30: TMenuItem
          Caption = 'Potion name'
          OnClick = N30Click
        end
      end
      object N13: TMenuItem
        Caption = 'Query'
        object N32: TMenuItem
          Caption = 'Potions list'
          OnClick = N32Click
        end
        object N33: TMenuItem
          Caption = 'Potions indicated in table delivery'
          OnClick = N33Click
        end
        object N34: TMenuItem
          Caption = 'Potions indicated in table sale'
          OnClick = N34Click
        end
        object C1: TMenuItem
          Caption = 'Request delivery potion by code'
          OnClick = C1Click
        end
        object C2: TMenuItem
          Caption = 'Request saled potion by code'
          OnClick = C2Click
        end
        object N35: TMenuItem
          Caption = 'Potions list, which cost higher than value'
          OnClick = N35Click
        end
      end
    end
    object N3: TMenuItem
      Caption = 'Report'
      object N36: TMenuItem
        Caption = 'Potions list'
        OnClick = N36Click
      end
      object N37: TMenuItem
        Caption = 'List potions on timeline'
        OnClick = N37Click
      end
      object N38: TMenuItem
        Caption = 'List potions on sale dates'
        OnClick = N38Click
      end
    end
    object N4: TMenuItem
      Caption = 'About'
      OnClick = N4Click
    end
    object N31: TMenuItem
      Caption = 'Reset filter'
      OnClick = N31Click
    end
  end
  object DataSource4: TDataSource
    DataSet = Query1
    Left = 68
    Top = 312
  end
  object Query1: TQuery
    DatabaseName = 'STANDARD2'
    DataSource = DataSource1
    SQL.Strings = (
      'SELECT Kl_potion, Potion, Sale_amount, Sale_date'
      'FROM "tab_ready","tab_sale"'
      'GROUP BY Sale_date, Kl_potion, Potion, Sale_amount')
    Left = 100
    Top = 312
  end
  object RvProject1: TRvProject
    Left = 36
    Top = 208
  end
  object RvDataSetConnection1: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = Query1
    Left = 68
    Top = 208
  end
end
