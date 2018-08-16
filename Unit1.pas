unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, OverbyteIcsWndControl,
  OverbyteIcsHttpSrv, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.AppEvnts, Vcl.StdCtrls,
  System.Classes, Vcl.Controls,Vcl.Forms,System.SysUtils;

type
  TForm1 = class(TForm)
    HttpServer1: THttpServer;
    TrayIcon1: TTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    Timer1: TTimer;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    CheckBox2: TCheckBox;
    FileOpenDialog1: TFileOpenDialog;
    LabeledEdit5: TLabeledEdit;
    procedure Button1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure LabeledEdit2Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit4KeyPress(Sender: TObject; var Key: Char);
    procedure LabeledEdit4Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FirstRun:Boolean;
implementation

{$R *.dfm}
  uses Winsock;

  function LocalIP: string;
type
  TaPInAddr = array [0..10] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  phe: PHostEnt;
  pptr: PaPInAddr;
  Buffer: array [0..63] of Ansichar;
  i: Integer;
  GInitData: TWSADATA;
begin
  WSAStartup($101, GInitData);
  Result := '';
  GetHostName(Buffer, SizeOf(Buffer));
  phe := GetHostByName(Buffer);
  if phe = nil then
    Exit;
  pptr := PaPInAddr(phe^.h_addr_list);
  i := 0;
  while pptr^[i] <> nil do
  begin
    Result := StrPas(inet_ntoa(pptr^[i]^));
    Inc(i);
  end;
end;

procedure TForm1.ApplicationEvents1Activate(Sender: TObject);
begin
if FirstRun then begin
LabeledEdit1.Text:=LocalIP;
LabeledEdit2.Text:=ExtractFilePath(Application.ExeName);
end;
FirstRun:=False;
end;

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide();
  WindowState := wsMinimized;
  TrayIcon1.Visible := True;
  //TrayIcon1.Animate := True;
  TrayIcon1.ShowBalloonHint;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
try
with HttpServer1 do begin
  Addr:=LabeledEdit1.Text;
  port:=LabeledEdit4.Text;
  DocDir:=LabeledEdit2.Text;
  TemplateDir:=LabeledEdit2.Text;
  MaxClients:=StrToInt(LabeledEdit3.Text);
  if (LabeledEdit5.Text<>'')and(StrToInt(LabeledEdit5.Text)>0) then
  Timer1.Enabled:=True else Timer1.Enabled:=False;

  if checkbox2.Checked then
  HttpServer1.Options:=[hoAllowDirList] else HttpServer1.Options:=[];
  HttpServer1.Start;
  Button1.Enabled:=False;
  Button2.Enabled:=True;
end;
except
   on E : Exception do
      ShowMessage(E.ClassName+' error raised, with message : '+E.Message);
end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  HttpServer1.Stop;
  Button1.Enabled:=True;
  Button2.Enabled:=False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
FirstRun:=True;
end;

procedure TForm1.LabeledEdit2Enter(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do
    try
      Title := 'Select Directory';
      Options := [fdoPickFolders, fdoPathMustExist, fdoForceFileSystem]; // YMMV
      OkButtonLabel := 'Select';
      //DefaultFolder := FDir;
      //FileName := FDir;
      if Execute then
        LabeledEdit2.Text:=FileName;
    finally
      Free;
    end;
   LabeledEdit2.SetFocus;
   // Application.ProcessMessages;
end;

procedure TForm1.LabeledEdit3KeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in [#8, '0'..'9']) then begin
    ShowMessage('Invalid key');
    Key := #0;
  end;
end;

procedure TForm1.LabeledEdit4Change(Sender: TObject);
begin
if LabeledEdit4.Text<>'' then
if (StrToInt(LabeledEdit4.Text)>65535)or(StrToInt(LabeledEdit4.Text)<0) then begin
ShowMessage('Invalid Port Number!');
LabeledEdit4.Text:='8000';
end;
end;

procedure TForm1.LabeledEdit4KeyPress(Sender: TObject; var Key: Char);
begin
 if not (Key in [#8, '0'..'9']) then begin
    ShowMessage('Invalid key: Only 0...9 is accepted!');
    Key := #0;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin

if StrToInt(LabeledEdit5.Text)>-1 then
LabeledEdit5.Text:= IntToStr(StrToInt(LabeledEdit5.Text)-1);
if StrToInt(LabeledEdit5.Text)<1 then begin
  LabeledEdit5.Text:='0';
  Button2Click(nil);
  Timer1.Enabled:=False;
end;
end;

procedure TForm1.TrayIcon1DblClick(Sender: TObject);
begin
  TrayIcon1.Visible := False;
  Show();
  WindowState := wsNormal;
  Application.BringToFront();
end;

end.
