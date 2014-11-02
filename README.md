jchat
=====
Welcome to the readme for JChat. It's probably going to be just me and it might get a little lonely. 

JChat is a program I wrote to send messages to another computer. So it's a chat program. It consists of a local user part stored in /local/ and a remote server stored in /remote/. 

Local Code
-----
There are three main units in the code so far. ujChatMain, ujChatLoadChat and uJChatLoadUser

ujChatMain is the main chat file (Obviously) and contains most of the code for updating the main user interface of the program. It also implements the units TUser and TChat which are neccecary for the program to run. Additionally it contains the TChatFormMain class which is the main chat form and contains a couple of procedures like GetPage and GetStatusCode that utilise the Indy I/O. 

ujChatLoadChat and ujChatLoadUser load chats and users respectively and do this by communicating with the remote part of my code. 

Remote Code
-----
The remote code is a simple API that I wrote to return simple values from parsed parameters. Vuser.php deals with user login and verification issues, returning a 1 if the user is valid. addmessage.php deals with adding a new message to a chat. global.php contains global functions and variables.

**THIS IS VERY MUCH A WORK IN PROGRESS**
