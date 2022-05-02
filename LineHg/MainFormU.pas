unit MainFormU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, WorkerThreadU,
  Vcl.AppEvnts,SvcMgr,winsvc;

type
  TMainForm = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    btnPause: TButton;
    btnContinue: TButton;
    ApplicationEvents1: TApplicationEvents;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure btnStartClick(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure btnStopClick(Sender: TObject);
    procedure btnPauseClick(Sender: TObject);
    procedure btnContinueClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    FWorkerThread: TWorkerThread;
    { Private declarations }
  public
    { Public declarations }
  end;

{$R *.dfm}


var
  MainForm: TMainForm;
  function InstallService(ServiceName, DisplayName, FileName: string): boolean;
  function UninstallService(ServiceName: string):boolean;
implementation

procedure TMainForm.btnStartClick(Sender: TObject);
begin
  FWorkerThread := TWorkerThread.Create(true);
  FWorkerThread.Start;
end;

procedure TMainForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
begin
  btnStart.Enabled := not Assigned(FWorkerThread);
  btnStop.Enabled := Assigned(FWorkerThread);
  btnPause.Enabled := Assigned(FWorkerThread) and (not FWorkerThread.IsPaused);
  btnContinue.Enabled := Assigned(FWorkerThread) and FWorkerThread.IsPaused;
end;

procedure TMainForm.btnStopClick(Sender: TObject);
begin
  FWorkerThread.Terminate;
  FWorkerThread.WaitFor;
  FreeAndNil(FWorkerThread);
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
opendialog1.Execute();
if opendialog1.FileName<>'' then
InstallService('m33', 'm33', opendialog1.FileName);

end;

procedure TMainForm.Button2Click(Sender: TObject);
begin
UninstallService('m33');
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FWorkerThread) then
  begin
    FWorkerThread.Terminate;
    FWorkerThread.WaitFor;
    FreeAndNil(FWorkerThread);
  end;
end;

procedure TMainForm.btnPauseClick(Sender: TObject);
begin
  FWorkerThread.Pause;
end;

procedure TMainForm.btnContinueClick(Sender: TObject);
begin
  FWorkerThread.Continue;
end;
function InstallService(ServiceName, DisplayName, FileName: string): boolean;
var
  SCManager,Service: THandle;
  Args: pchar;
begin
  Result := False;
  SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);
  if SCManager = 0 then Exit;
  try
   Service := CreateService(SCManager,  //句柄
                    PChar(ServiceName), //服务名称
                    PChar(DisplayName), //显示服务名
                    SERVICE_ALL_ACCESS, //服务访问类型
                    SERVICE_WIN32_OWN_PROCESS or SERVICE_INTERACTIVE_PROCESS, //服务类型  or SERVICE_WIN32_OWN_PROCESS,//
                    SERVICE_AUTO_START, //自动启动服务
                    SERVICE_ERROR_IGNORE, //忽略错误
                    PChar(FileName),  //启动的文件名
                    nil,  //name of load ordering group (载入组名) &#39;LocalSystem&#39;
                    nil,  //标签标识符
                    nil,  //相关性数组名
                    nil,  //帐户(当前)
                    nil); //密码(当前)

   Args := nil;
   if Service = 0 then exit;
   if StartService(Service, 0, Args) then
     MainForm.memo1.Lines.Add(DisplayName+' 服务已经启动')
   else
     MainForm.memo1.Lines.Add(DisplayName+' 服务启动失败！');
   CloseServiceHandle(Service);
   CloseServiceHandle(SCManager);
  except on E: Exception do
    begin
      CloseServiceHandle(SCManager);
      MainForm.Memo1.Lines.Add('失败原因是：' + E.Message);
    end;
  end;
  Result := True;
end;

function UninstallService(ServiceName: string):boolean;
var
   SCManager,Service: THandle;
   ServiceStatus: SERVICE_STATUS;
   ss: LongBool;
begin
  Result:=false;
   SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);//获得SC管理器句柄
   if SCManager = 0 then Exit;
   try
     Service := OpenService(SCManager, PChar(ServiceName), SERVICE_ALL_ACCESS);

     //以最高权限打开指定服务名的服务,并返回句柄
     ss := ControlService(Service, SERVICE_CONTROL_STOP, ServiceStatus);
     MainForm.Memo1.Lines.Add('停止服务结果：' + BoolToStr(ss));

     //向服务器发送控制命令,停止工作, ServiceStatus 保存服务的状态
     ss := DeleteService(Service);
     MainForm.Memo1.Lines.Add('卸载服务结果：' + BoolToStr(ss));
     //从SC ManGer 中删除服务
     CloseServiceHandle(Service);
     result:=true;
     //关闭句柄,释放资源
   finally
     CloseServiceHandle(SCManager);
   end;
end;


end.
