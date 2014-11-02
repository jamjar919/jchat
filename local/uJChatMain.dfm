object ChatFormMain: TChatFormMain
  Left = 0
  Top = 0
  Caption = 'Chat '
  ClientHeight = 379
  ClientWidth = 431
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mainMenu
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    431
    379)
  PixelsPerInch = 96
  TextHeight = 13
  object listboxMainChat: TListBox
    Left = 0
    Top = 8
    Width = 433
    Height = 305
    Style = lbOwnerDrawFixed
    AutoComplete = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    BorderStyle = bsNone
    Enabled = False
    ExtendedSelect = False
    ItemHeight = 13
    TabOrder = 0
    OnDrawItem = listboxMainChatDrawItem
  end
  object panelStatus: TPanel
    Left = -10
    Top = 352
    Width = 443
    Height = 29
    Anchors = [akLeft, akRight, akBottom]
    BevelEdges = [beTop]
    TabOrder = 1
    DesignSize = (
      443
      29)
    object lblJChat: TLabel
      Left = 18
      Top = 8
      Width = 66
      Height = 13
      Caption = 'JChat v1.0   |'
    end
    object lblCurrentUser: TLabel
      Left = 96
      Top = 8
      Width = 78
      Height = 13
      Caption = 'No Current User'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object progressbChatUpdateIndicator: TProgressBar
      Left = 333
      Top = 5
      Width = 100
      Height = 17
      Anchors = [akRight, akBottom]
      MarqueeInterval = 5
      TabOrder = 0
    end
  end
  object editSendMessage: TEdit
    Left = 8
    Top = 319
    Width = 337
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
    TextHint = 'Enter a message to send here...'
  end
  object buttonSendMessage: TButton
    Left = 348
    Top = 319
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Send'
    TabOrder = 3
    OnClick = buttonSendMessageClick
  end
  object mainMenu: TMainMenu
    Left = 288
    Top = 16
    object mainMenuFile: TMenuItem
      Caption = 'File'
      object mainMenuFileNew: TMenuItem
        Caption = 'New'
        object mainMenuFileNewChat: TMenuItem
          Caption = 'Chat With User'
        end
        object mainMenuFileNewUser: TMenuItem
          Caption = 'User'
        end
      end
      object mainMenuFileLoad: TMenuItem
        Caption = 'Load'
        object mainMenuFilePrevUser: TMenuItem
          Caption = 'Previous User'
          OnClick = mainMenuFilePrevUserClick
        end
        object mainMenuFilePrevChat: TMenuItem
          Caption = 'Previous Chat'
          OnClick = mainMenuFilePrevChatClick
        end
      end
    end
  end
  object HTTP: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 248
    Top = 80
  end
  object timerRefreshChat: TTimer
    Enabled = False
    Interval = 5000
    OnTimer = timerRefreshChatTimer
    Left = 336
    Top = 96
  end
end
