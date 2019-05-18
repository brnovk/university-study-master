object Form1: TForm1
  Left = 351
  Top = 358
  Width = 675
  Height = 538
  Caption = 'Form1'
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
  object Label1: TLabel
    Left = 152
    Top = 16
    Width = 123
    Height = 20
    Caption = 'Info about bus:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 40
    Width = 76
    Height = 13
    Caption = 'Bus trip number:'
  end
  object Label3: TLabel
    Left = 8
    Top = 72
    Width = 44
    Height = 13
    Caption = 'Bus type:'
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 82
    Height = 13
    Caption = 'Destination point:'
  end
  object Label5: TLabel
    Left = 8
    Top = 136
    Width = 72
    Height = 13
    Caption = 'Departure time:'
  end
  object Label6: TLabel
    Left = 8
    Top = 168
    Width = 54
    Height = 13
    Caption = 'Arrival time:'
  end
  object Button1: TButton
    Left = 8
    Top = 192
    Width = 273
    Height = 25
    Caption = 'Add info'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 232
    Width = 273
    Height = 25
    Caption = 'Create file'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 272
    Width = 273
    Height = 25
    Caption = 'Open file'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 312
    Width = 273
    Height = 25
    Caption = 'Sorting'
    TabOrder = 3
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 8
    Top = 352
    Width = 273
    Height = 25
    Caption = 'Save result'
    TabOrder = 4
    OnClick = Button5Click
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 464
    Width = 273
    Height = 25
    Caption = 'Exit'
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object Edit1: TEdit
    Left = 104
    Top = 40
    Width = 177
    Height = 21
    TabOrder = 6
    Text = 'Edit1'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 104
    Top = 72
    Width = 177
    Height = 21
    TabOrder = 7
    Text = 'Edit2'
    OnKeyPress = Edit2KeyPress
  end
  object Edit3: TEdit
    Left = 104
    Top = 104
    Width = 177
    Height = 21
    TabOrder = 8
    Text = 'Edit3'
    OnKeyPress = Edit3KeyPress
  end
  object Edit4: TEdit
    Left = 104
    Top = 136
    Width = 177
    Height = 21
    TabOrder = 9
    Text = 'Edit4'
    OnKeyPress = Edit4KeyPress
  end
  object Edit5: TEdit
    Left = 104
    Top = 168
    Width = 177
    Height = 21
    TabOrder = 10
    Text = 'Edit5'
    OnKeyPress = Edit5KeyPress
  end
  object Button6: TButton
    Left = 168
    Top = 392
    Width = 113
    Height = 25
    Caption = 'Query'
    TabOrder = 11
    OnClick = Button6Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 8
    Top = 392
    Width = 153
    Height = 21
    EditLabel.Width = 111
    EditLabel.Height = 13
    EditLabel.Caption = 'Indicating ime of arrival:'
    LabelPosition = lpAbove
    LabelSpacing = 3
    TabOrder = 12
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 424
    Width = 273
    Height = 25
    Caption = 'About'
    TabOrder = 13
    OnClick = BitBtn2Click
  end
  object Button7: TButton
    Left = 288
    Top = 464
    Width = 105
    Height = 25
    Caption = 'Rich -> File'
    TabOrder = 14
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 416
    Top = 464
    Width = 105
    Height = 25
    Caption = 'File -> Rich'
    TabOrder = 15
    OnClick = Button8Click
  end
  object Button9: TButton
    Left = 544
    Top = 464
    Width = 105
    Height = 25
    Caption = 'Rich -> List'
    TabOrder = 16
    OnClick = Button9Click
  end
  object Memo1: TMemo
    Left = 288
    Top = 8
    Width = 361
    Height = 449
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 17
  end
  object OpenDialog1: TOpenDialog
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    Left = 32
    Top = 8
  end
end
