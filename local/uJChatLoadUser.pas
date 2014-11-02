unit uJChatLoadUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TLoadUser = class(TForm)
    editUserID: TLabeledEdit;
    editSecretKey: TLabeledEdit;
    buttonValidate: TButton;
    procedure buttonValidateClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadUser: TLoadUser;

implementation

{$R *.dfm}

uses uJChatMain;

function validateCredentials(userID:integer; secretKey:string):boolean;
var
  url : string;
  getResult : string;
begin
  url := 'http://178.62.6.6/chat/vuser.php?key='+secretKey+'&uid='+inttostr(userID);
  getResult := ChatFormMain.GetPage(url);
  if getResult = '1' then
    result := true
  else
    result := false;
end;

procedure TLoadUser.buttonValidateClick(Sender: TObject);
var
  userID : integer;
  secretKey: string;
begin
  userID := strtoint(editUserId.Text);
  secretKey:= editSecretKey.Text;
  if validateCredentials(userID,secretKey) then
  begin
    currentUser := TUser.Create(userID,secretKey);
    currentUser.MakeUserValid;
    ChatFormMain.lblCurrentUser.Caption := 'UserID: '+inttostr(userID);
    ChatFormMain.ChatPrint('Notification: Logged in with ID: '+inttostr(userID));
    self.Hide;
  end;
end;

end.
