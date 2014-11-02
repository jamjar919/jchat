program pJChat;

uses
  Vcl.Forms,
  uJChatMain in 'uJChatMain.pas' {ChatFormMain},
  uJChatLoadChat in 'uJChatLoadChat.pas' {LoadChat},
  uJChatLoadUser in 'uJChatLoadUser.pas' {LoadUser};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TChatFormMain, ChatFormMain);
  Application.CreateForm(TLoadChat, LoadChat);
  Application.CreateForm(TLoadUser, LoadUser);
  Application.Run;
end.
