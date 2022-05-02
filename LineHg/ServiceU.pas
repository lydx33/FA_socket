unit ServiceU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.SvcMgr, Vcl.Dialogs,
  WorkerThreadU;

type
  Tm33server = class(TService)
    procedure ServiceExecute(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceAfterInstall(Sender: TService);
  private
    FWorkerThread: TWorkerThread;
    { Private declarations }
  public
    function GetServiceController: TServiceController; override;
    { Public declarations }
  end;

{$R *.dfm}


var
  m33server: Tm33server;

implementation

uses
  System.Win.Registry;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  m33server.Controller(CtrlCode);
end;

function Tm33server.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure Tm33server.ServiceAfterInstall(Sender: TService);
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\SYSTEM\CurrentControlSet\Services\' + name, false) then
    begin
      Reg.WriteString('Description', 'Service Version');
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

procedure Tm33server.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  FWorkerThread.Continue;
  Continued := True;
end;

procedure Tm33server.ServicePause(Sender: TService; var Paused: Boolean);
begin
  FWorkerThread.Pause;
  Paused := True;
end;

procedure Tm33server.ServiceStart(Sender: TService; var Started: Boolean);
begin
  FWorkerThread := TWorkerThread.Create(True);
  FWorkerThread.Start;
  Started := True;
end;

procedure Tm33server.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  FWorkerThread.Terminate;
  FWorkerThread.WaitFor;
  FreeAndNil(FWorkerThread);
  Stopped := True;
end;

procedure Tm33server.ServiceExecute(Sender: TService);
begin
  while not Terminated do
  begin
    ServiceThread.ProcessRequests(false);
    TThread.Sleep(1000);
  end;
end;

end.
