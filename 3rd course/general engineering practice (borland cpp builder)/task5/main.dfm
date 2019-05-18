object Form1: TForm1
  Left = 384
  Top = 292
  Width = 673
  Height = 521
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 241
    Height = 483
    Align = alLeft
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 6
      Top = 416
      Width = 227
      Height = 57
      Caption = 'Add one struct'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 8
      Top = 32
      Width = 225
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit1'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 1
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit2: TLabeledEdit
      Left = 8
      Top = 72
      Width = 225
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit2'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 2
      OnKeyPress = LabeledEdit2KeyPress
    end
    object LabeledEdit3: TLabeledEdit
      Left = 8
      Top = 112
      Width = 225
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit3'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 3
      OnKeyPress = LabeledEdit3KeyPress
    end
    object LabeledEdit4: TLabeledEdit
      Left = 8
      Top = 152
      Width = 225
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit4'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 4
      OnKeyPress = LabeledEdit4KeyPress
    end
    object LabeledEdit5: TLabeledEdit
      Left = 8
      Top = 192
      Width = 225
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'LabeledEdit5'
      LabelPosition = lpAbove
      LabelSpacing = 3
      TabOrder = 5
      OnKeyPress = LabeledEdit5KeyPress
    end
  end
  object Panel2: TPanel
    Left = 241
    Top = 0
    Width = 416
    Height = 483
    Align = alClient
    TabOrder = 1
    object BitBtn2: TBitBtn
      Left = 8
      Top = 440
      Width = 129
      Height = 33
      Caption = 'Query'
      TabOrder = 0
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 144
      Top = 440
      Width = 129
      Height = 33
      Caption = 'About'
      ModalResult = 2
      TabOrder = 1
      OnClick = BitBtn3Click
    end
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 414
      Height = 352
      Align = alTop
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 280
      Top = 440
      Width = 129
      Height = 33
      Caption = 'Exit'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object LabeledEdit6: TLabeledEdit
      Left = 8
      Top = 416
      Width = 121
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = 'LabeledEdit6'
      EditLabel.ParentBiDiMode = False
      LabelPosition = lpRight
      LabelSpacing = 3
      TabOrder = 4
    end
    object Button1: TButton
      Left = 8
      Top = 360
      Width = 129
      Height = 33
      Caption = 'Memo -> file'
      TabOrder = 5
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 144
      Top = 360
      Width = 129
      Height = 33
      Caption = 'File -> Memo'
      TabOrder = 6
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 280
      Top = 360
      Width = 129
      Height = 33
      Caption = 'Memo -> List'
      TabOrder = 7
      OnClick = Button3Click
    end
  end
end
