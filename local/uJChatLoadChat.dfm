object LoadChat: TLoadChat
  Left = 0
  Top = 0
  Caption = 'Load Chat'
  ClientHeight = 112
  ClientWidth = 404
  Color = clBtnFace
  Constraints.MaxHeight = 150
  Constraints.MaxWidth = 420
  Constraints.MinHeight = 150
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object editRecipientID: TLabeledEdit
    Left = 24
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 58
    EditLabel.Height = 13
    EditLabel.Caption = 'Recipient ID'
    NumbersOnly = True
    TabOrder = 0
  end
  object buttonConnect: TButton
    Left = 24
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 1
    OnClick = buttonConnectClick
  end
end
