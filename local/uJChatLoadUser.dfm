object LoadUser: TLoadUser
  Left = 0
  Top = 0
  Caption = 'LoadUser'
  ClientHeight = 122
  ClientWidth = 404
  Color = clBtnFace
  Constraints.MaxHeight = 160
  Constraints.MaxWidth = 420
  Constraints.MinHeight = 160
  Constraints.MinWidth = 420
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object editUserID: TLabeledEdit
    Left = 24
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 72
    EditLabel.Height = 13
    EditLabel.Caption = 'Unique User ID'
    NumbersOnly = True
    TabOrder = 0
  end
  object editSecretKey: TLabeledEdit
    Left = 24
    Top = 64
    Width = 372
    Height = 21
    EditLabel.Width = 52
    EditLabel.Height = 13
    EditLabel.Caption = 'Secret Key'
    TabOrder = 1
  end
  object buttonValidate: TButton
    Left = 24
    Top = 91
    Width = 75
    Height = 25
    Caption = 'Validate'
    TabOrder = 2
    OnClick = buttonValidateClick
  end
end
