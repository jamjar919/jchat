unit uJChatLoadChat;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TLoadChat = class(TForm)
    editRecipientID: TLabeledEdit;
    buttonConnect: TButton;
    procedure buttonConnectClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadChat: TLoadChat;

implementation

{$R *.dfm}

uses uJChatMain;

procedure TLoadChat.buttonConnectClick(Sender: TObject);
var
  recipientID: integer;
  url: string;
begin
  url := 'http://178.62.6.6/chat/logs/' + inttostr(CurrentUser.UserID) + '-' +
    editRecipientID.Text + '.txt';
  try
  if ChatFormMain.GetStatusCode(url) = 200 then
  begin
    Chatting := True;
    recipientID := strtoint(editRecipientID.Text);
    CurrentChat := TChat.Create;
    CurrentChat.SetRecipientID(recipientID);
    CurrentChat.ClearChat(ChatFormMain.listboxMainChat);
    ChatFormMain.ChatPrint('Loading chat with user ID: ' +
      editRecipientID.Text);
    CurrentChat.UpdateChat(ChatFormMain.listboxMainChat, ChatFormMain.GetPage(url));
    ChatFormMain.timerRefreshChat.Enabled := True;
    self.Hide;
  end
  else
  begin
    ChatFormMain.ChatPrint('Chat doesn''t exist. Please use the New Chat command to start a new chat.');
    self.Hide;
  end;
  except
    MessageDlg('Chat does not exist.',mtError, [mbOK], 0);
  end;
end;

end.
