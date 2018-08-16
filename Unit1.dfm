object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Hadid Web Server'
  ClientHeight = 225
  ClientWidth = 330
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 330
    Height = 225
    Align = alClient
    Caption = 'Server Setting'
    TabOrder = 0
    object Button1: TButton
      Left = 2
      Top = 173
      Width = 326
      Height = 25
      Align = alBottom
      Caption = 'Active'
      TabOrder = 6
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 2
      Top = 198
      Width = 326
      Height = 25
      Align = alBottom
      Caption = 'Deactive'
      Enabled = False
      TabOrder = 7
      OnClick = Button2Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 11
      Top = 40
      Width = 178
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Server IP'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 11
      Top = 92
      Width = 310
      Height = 21
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'Root Path'
      TabOrder = 2
      OnEnter = LabeledEdit2Enter
    end
    object LabeledEdit3: TLabeledEdit
      Left = 11
      Top = 144
      Width = 86
      Height = 21
      EditLabel.Width = 77
      EditLabel.Height = 13
      EditLabel.Caption = 'Max Connection'
      TabOrder = 3
      Text = '1'
      OnKeyPress = LabeledEdit3KeyPress
    end
    object LabeledEdit4: TLabeledEdit
      Left = 195
      Top = 40
      Width = 126
      Height = 21
      EditLabel.Width = 55
      EditLabel.Height = 13
      EditLabel.Caption = 'Server Port'
      TabOrder = 1
      Text = '80'
      OnChange = LabeledEdit4Change
      OnKeyPress = LabeledEdit4KeyPress
    end
    object CheckBox2: TCheckBox
      Left = 230
      Top = 146
      Width = 97
      Height = 17
      Caption = 'Allow Dir List'
      TabOrder = 5
    end
    object LabeledEdit5: TLabeledEdit
      Left = 111
      Top = 144
      Width = 86
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'Disable Time'
      TabOrder = 4
      Text = '600'
      OnKeyPress = LabeledEdit3KeyPress
    end
  end
  object HttpServer1: THttpServer
    ListenBacklog = 5
    MultiListenSockets = <>
    Port = '80'
    Addr = '0.0.0.0'
    SocketFamily = sfIPv4
    MaxClients = 0
    DocDir = 'c:\a'
    TemplateDir = 'c:\a'
    DefaultDoc = 'index.html'
    LingerOnOff = wsLingerNoSet
    LingerTimeout = 0
    Options = []
    KeepAliveTimeSec = 10
    KeepAliveTimeXferSec = 300
    MaxRequestsKeepAlive = 100
    SizeCompressMin = 5000
    SizeCompressMax = 5000000
    MaxBlkSize = 8192
    BandwidthLimit = 0
    BandwidthSampling = 1000
    ServerHeader = 'Server: ICS-HttpServer-8.37'
    AuthTypes = []
    AuthRealm = 'ics'
    SocketErrs = wsErrTech
    ExclusiveAddr = True
    Left = 24
    Top = 64
  end
  object TrayIcon1: TTrayIcon
    Hint = #1608#1576' '#1587#1585#1608#1585' '#1583#1585' '#1581#1575#1604' '#1575#1580#1585#1575#1587#1578
    BalloonHint = #1608#1576' '#1587#1585#1608#1585' '#1583#1585' '#1581#1575#1604' '#1575#1580#1585#1575#1587#1578
    BalloonTitle = #1608#1576' '#1587#1585#1608#1585' '#1581#1583#1740#1583
    BalloonTimeout = 3000
    BalloonFlags = bfInfo
    OnDblClick = TrayIcon1DblClick
    Left = 24
    Top = 112
  end
  object ApplicationEvents1: TApplicationEvents
    OnActivate = ApplicationEvents1Activate
    OnMinimize = ApplicationEvents1Minimize
    Left = 24
    Top = 168
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer1Timer
    Left = 104
    Top = 72
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = []
    Left = 208
    Top = 72
  end
end
