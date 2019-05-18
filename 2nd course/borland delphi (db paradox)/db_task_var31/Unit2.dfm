object Form2: TForm2
  Left = 190
  Top = 147
  Width = 561
  Height = 375
  Caption = 'Edit record'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 404
    Height = 337
    Align = alClient
    Caption = ' '
    TabOrder = 0
    object Label1: TLabel
      Left = 152
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 152
      Top = 48
      Width = 32
      Height = 13
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 152
      Top = 80
      Width = 32
      Height = 13
      Caption = 'Label3'
    end
    object Label4: TLabel
      Left = 152
      Top = 112
      Width = 32
      Height = 13
      Caption = 'Label4'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      OnKeyPress = DBEdit1KeyPress
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 48
      Width = 121
      Height = 21
      TabOrder = 1
      OnKeyPress = DBEdit2KeyPress
    end
    object DBEdit3: TDBEdit
      Left = 16
      Top = 80
      Width = 121
      Height = 21
      TabOrder = 2
      OnKeyPress = DBEdit3KeyPress
    end
    object DBEdit4: TDBEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      ReadOnly = True
      TabOrder = 3
    end
    object Button3: TButton
      Left = 16
      Top = 144
      Width = 121
      Height = 25
      Caption = 'Choise potion'
      TabOrder = 4
      OnClick = Button3Click
    end
  end
  object Panel2: TPanel
    Left = 404
    Top = 0
    Width = 141
    Height = 337
    Align = alRight
    Caption = ' '
    TabOrder = 1
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 121
      Height = 49
      Caption = 'Save'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 64
      Width = 121
      Height = 49
      Caption = 'Cancel'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
end
