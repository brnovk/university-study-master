object Form1: TForm1
  Left = 216
  Top = 141
  Width = 560
  Height = 480
  Caption = '3.Strings - Var 6'
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
    Left = 8
    Top = 224
    Width = 49
    Height = 16
    Caption = 'Result:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 82
    Height = 16
    Caption = 'Source text:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 376
    Top = 8
    Width = 163
    Height = 16
    Caption = 'Show the condition task'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ListBox1: TListBox
    Left = 8
    Top = 240
    Width = 361
    Height = 201
    ItemHeight = 13
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 376
    Top = 24
    Width = 169
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 1
    OnChange = ComboBox1Change
    Items.Strings = (
      'Subtask condition 1'
      'Subtask condition 2')
  end
  object StaticText1: TStaticText
    Left = 376
    Top = 56
    Width = 169
    Height = 129
    AutoSize = False
    BorderStyle = sbsSunken
    TabOrder = 2
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 376
    Top = 352
    Width = 169
    Height = 25
    Caption = 'Open'
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 375
    Top = 384
    Width = 169
    Height = 25
    Caption = 'Save'
    TabOrder = 4
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 375
    Top = 416
    Width = 169
    Height = 25
    Caption = 'Exit'
    TabOrder = 5
    Kind = bkClose
  end
  object RadioGroup1: TRadioGroup
    Left = 376
    Top = 240
    Width = 169
    Height = 105
    Caption = 'Tasks'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Items.Strings = (
      'Subtask 1'
      'Subtask 2')
    ParentFont = False
    TabOrder = 6
    OnClick = RadioGroup1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 24
    Width = 361
    Height = 161
    ScrollBars = ssVertical
    TabOrder = 7
    OnKeyPress = Memo1KeyPress
  end
  object OpenDialog1: TOpenDialog
    Filter = 'txt|*.txt;*.pas'
    Left = 8
    Top = 192
  end
  object SaveDialog1: TSaveDialog
    Left = 40
    Top = 192
  end
end
