unit CM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TCMDHG = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CMDHG: TCMDHG;

implementation
uses
Unit1,Unit7,Unit15;
{$R *.dfm}

procedure TCMDHG.Button1Click(Sender: TObject);
var
tm:ansistring;
begin

  sendFA.flag:=FAHG;
  sendFA.ID:=66;
  sendFA.name:=NAME_HG;
  tm:=Edit1.Text;
  memo1.Lines.Add('<<<'+tm);
  Edit1.Text:='';
  sendFA.sendTI:=inttostr(length(tm));
  move(tm[1],sendFA.zi[0],length(tm));
  form1.SENDDATAT(Form1.ClientSocket1.Socket,sendFA);
end;

procedure TCMDHG.Button2Click(Sender: TObject);
var
tm:ansistring;
begin

  sendFA.flag:=FAHG;
  sendFA.ID:=67;
  sendFA.name:=NAME_HG;
  tm:=Edit1.Text;
  memo1.Lines.Add('shell<<<'+tm);
  Edit1.Text:='';
  sendFA.sendTI:=inttostr(length(tm));
  move(tm[1],sendFA.zi[0],length(tm));
  form1.SENDDATAT(Form1.ClientSocket1.Socket,sendFA);
end;


procedure TCMDHG.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Edit1.Text<>'' then
begin
if (Key = 13) then
begin
Button1Click(Sender);
end;
end;
end;

procedure TCMDHG.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action := caFree;
end;

procedure TCMDHG.FormDestroy(Sender: TObject);
begin
CMDHG := nil;
end;

end.
