object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'GUI Version'
  ClientHeight = 575
  ClientWidth = 310
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object btnStart: TButton
    Left = 24
    Top = 24
    Width = 121
    Height = 49
    Caption = 'btnStart'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 151
    Top = 24
    Width = 121
    Height = 49
    Caption = 'btnStop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object btnPause: TButton
    Left = 24
    Top = 104
    Width = 121
    Height = 49
    Caption = 'btnPause'
    TabOrder = 2
    OnClick = btnPauseClick
  end
  object btnContinue: TButton
    Left = 151
    Top = 104
    Width = 121
    Height = 49
    Caption = 'btnContinue'
    TabOrder = 3
    OnClick = btnContinueClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 208
    Width = 294
    Height = 359
    Lines.Strings = (
      'Memo1')
    TabOrder = 4
  end
  object Button1: TButton
    Left = 24
    Top = 168
    Width = 123
    Height = 25
    Caption = 'Button1'
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 153
    Top = 168
    Width = 119
    Height = 25
    Caption = 'Button2'
    TabOrder = 6
    OnClick = Button2Click
  end
  object ApplicationEvents1: TApplicationEvents
    OnIdle = ApplicationEvents1Idle
    Left = 136
    Top = 72
  end
  object OpenDialog1: TOpenDialog
    Left = 248
    Top = 168
  end
end
