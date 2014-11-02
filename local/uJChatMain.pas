unit uJChatMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.StdCtrls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  Vcl.ComCtrls, Vcl.ExtCtrls, StrUtils;

type
  TChatFormMain = class(TForm)
    listboxMainChat: TListBox;
    mainMenu: TMainMenu;
    mainMenuFile: TMenuItem;
    mainMenuFileNew: TMenuItem;
    mainMenuFileNewChat: TMenuItem;
    mainMenuFileNewUser: TMenuItem;
    mainMenuFileLoad: TMenuItem;
    mainMenuFilePrevUser: TMenuItem;
    mainMenuFilePrevChat: TMenuItem;
    HTTP: TIdHTTP;
    progressbChatUpdateIndicator: TProgressBar;
    panelStatus: TPanel;
    lblJChat: TLabel;
    lblCurrentUser: TLabel;
    editSendMessage: TEdit;
    buttonSendMessage: TButton;
    timerRefreshChat: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure mainMenuFilePrevChatClick(Sender: TObject);
    procedure mainMenuFilePrevUserClick(Sender: TObject);
    procedure listboxMainChatDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure buttonSendMessageClick(Sender: TObject);
    procedure timerRefreshChatTimer(Sender: TObject);
  private
    { Private declarations }
  public
    procedure ShowInitMessage;
    function GetPage(aURL: string): string;
    function GetStatusCode(aURL: string): Integer;
    procedure ChatPrint(message: string);
  end;

  TUser = class
  private
    UID: Integer;
    ValidUser: boolean;
    Key: string;
  public
    property UserID: Integer read UID;
    property Valid: boolean read ValidUser;
    property SecretKey: string read Key;
    procedure MakeUserValid;
    constructor Create(UID: Integer; Key: string);
  end;

  TChat = class
  private
    RID: Integer;
  public
    procedure UpdateChat(ListBox: TListBox; Data: string);
    procedure ClearChat(ListBox: TListBox);
    procedure SendMessage(aMessage: string);
    procedure SetRecipientID(ID: Integer);
    property RecipientID: Integer read RID;
  end;

var
  ChatFormMain: TChatFormMain;
  CurrentUser: TUser;
  CurrentChat: TChat;
  Chatting: boolean;

const
  HTTP_RESPONSE_OK = 200;

implementation

{$R *.dfm}

uses uJChatLoadChat, uJChatLoadUser;

procedure TChat.SetRecipientID(ID: Integer);
begin
  RID := ID;
end;

procedure TChat.UpdateChat(ListBox: TListBox; Data: string);
const
  firstCharArrayChatting: array [0 .. 1] of string = ('F', 'B');
var
  Line: string;
  i: Integer;
begin
  ChatFormMain.progressbChatUpdateIndicator.StepBy(25);
  ListBox.Font.Color := ClBlack;
  for i := 0 to length(Data) do
  begin
    if Data[i] <> '~' then
      Line := Line + Data[i]
    else
    begin
      Line.TrimLeft;
      ChatFormMain.ChatPrint(Line);
      Line := '';
    end;
  end;
  ChatFormMain.progressbChatUpdateIndicator.StepBy(50);
end;

procedure TChat.ClearChat(ListBox: TListBox);
begin
  ListBox.Clear;
end;

constructor TUser.Create(UID: Integer; Key: string);
begin
  self.UID := UID;
  self.Key := Key;
  self.ValidUser := false;
end;

procedure TUser.MakeUserValid;
begin
  self.ValidUser := True;
  ChatFormMain.lblCurrentUser.Font.Color := ClGreen;
end;

function TChatFormMain.GetPage(aURL: string): string;
var
  Response: TStringStream;
  HTTP: TIdHTTP;
begin
  Result := '';
  Response := TStringStream.Create('');
  try
    HTTP := TIdHTTP.Create(nil);
    try
      HTTP.Get(aURL, Response);
      if HTTP.ResponseCode = HTTP_RESPONSE_OK then
      begin
        Result := Response.DataString;
      end
      else
      begin
        // TODO -cLogging: add some logging
      end;
    finally
      HTTP.Free;
    end;
  finally
    Response.Free;
  end;
end;

function TChatFormMain.GetStatusCode(aURL: string): Integer;
var
  HTTP: TIdHTTP;
begin
  HTTP := TIdHTTP.Create;
  HTTP.Head(aURL);
  Result := HTTP.Response.ResponseCode;
  HTTP.Free;
end;

procedure TChatFormMain.listboxMainChatDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
const
  firstCharArrayChatting: array [0 .. 1] of string = ('F', 'B');
  firstCharArray: array [0 .. 2] of string = ('#', 'E', 'N');
begin
  with listboxMainChat.Canvas do
  begin
    if not Chatting then
    begin
      case AnsiIndexStr(listboxMainChat.Items[index].Substring(0, 1),
        firstCharArray) of
        0:
          Font.Color := clBlue;
        1:
          Font.Color := clRed;
        2:
          Font.Color := ClGreen;
      else
        Font.Color := ClBlack;
      end;
    end
    else
    begin
      case AnsiIndexStr(listboxMainChat.Items[index].Substring(0, 1),
        firstCharArrayChatting) of
        0:
          Font.Color := clBlue;
        1:
          Font.Color := ClBlack;
      else
        Font.Color := clOlive;
      end;
    end;
    TextOut(Rect.Left + 1, Rect.Top + 1, listboxMainChat.Items[Index]);
  end;
end;

procedure TChatFormMain.buttonSendMessageClick(Sender: TObject);
begin
  if Chatting then
  begin
    with CurrentChat do
    begin
      SendMessage(editSendMessage.Text);
      ClearChat(ChatFormMain.listboxMainChat);
      UpdateChat(ChatFormMain.listboxMainChat,
        ChatFormMain.GetPage('http://178.62.6.6/chat/logs/' +
        inttostr(CurrentUser.UserID) + '-' + inttostr(RID) + '.txt'));
    end;
    editSendMessage.Text := '';
  end
  else
    ChatPrint('Error: No chat open!');
end;

procedure TChatFormMain.ChatPrint(message: string);
var
  ListBox: TListBox;
begin
  ListBox := listboxMainChat;
  ListBox.Items.Add(message);
end;

procedure TChatFormMain.ShowInitMessage;
begin
  ChatPrint('###JCHAT###');
  ChatPrint(
    'Welcome to JChat Version 1.0. Create a new user or log in as an existing one to get started.');
end;

procedure TChatFormMain.timerRefreshChatTimer(Sender: TObject);
begin
  CurrentChat.ClearChat(listboxMainChat);
  progressbChatUpdateIndicator.position := 0;
  progressbChatUpdateIndicator.StepBy(25);
  CurrentChat.UpdateChat(listBoxMainChat, GetPage('http://178.62.6.6/chat/logs/' +
        inttostr(CurrentUser.UserID) + '-' + inttostr(CurrentChat.RecipientID) + '.txt'));
end;

procedure TChatFormMain.mainMenuFilePrevChatClick(Sender: TObject);
begin
  if assigned(CurrentUser) then
  begin
    if CurrentUser.Valid then
      LoadChat.Show;
  end
  else
    ChatPrint('Error: You are currently not signed into an account.');
end;

procedure TChatFormMain.mainMenuFilePrevUserClick(Sender: TObject);
begin
  LoadUser.Show;
end;

procedure TChatFormMain.FormCreate(Sender: TObject);
begin
  ShowInitMessage;
end;

procedure TChat.SendMessage(aMessage: string);
var
  buffer, url, nMessage: string;
  i,offset: Integer;
begin
  i := 0;
  offset := 0;
  nMessage := aMessage;
  //fix spaces (convert to %20)
  for i := 0 to length(aMessage) do
  begin
    if aMessage[i] = ' ' then
    begin
      delete(nMessage,i+offset,1);
      insert('%20',nMessage,i+offset);
      offset := offset + 2;
    end;
  end;
  aMessage := nMessage;
  url := 'http://178.62.6.6/chat/addmessage.php?uid=' +
    inttostr(CurrentUser.UserID) + '&rid=' + inttostr(RID) + '&key=' +
    CurrentUser.SecretKey + '&message=' + aMessage;
  buffer := ChatFormMain.GetPage(url);
end;

end.
