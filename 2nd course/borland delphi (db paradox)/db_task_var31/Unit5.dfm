object Form5: TForm5
  Left = 192
  Top = 114
  Width = 528
  Height = 375
  Caption = 'Choise potion'
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
    Left = 345
    Top = 0
    Width = 167
    Height = 337
    Align = alRight
    Caption = ' '
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 153
      Height = 57
      Caption = 'Save'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 72
      Width = 153
      Height = 57
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 345
    Height = 337
    Align = alClient
    DataSource = Form1.DataSource1
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Kl_potion'
        Title.Caption = 'Code potion'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Potion'
        Visible = True
      end>
  end
end
