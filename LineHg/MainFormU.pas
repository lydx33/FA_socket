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
   Service := CreateService(SCManager,  //���
                    PChar(ServiceName), //��������
                    PChar(DisplayName), //��ʾ������
                    SERVICE_ALL_ACCESS, //�����������
                    SERVICE_WIN32_OWN_PROCESS or SERVICE_INTERACTIVE_PROCESS, //��������  or SERVICE_WIN32_OWN_PROCESS,//
                    SERVICE_AUTO_START, //�Զ���������
                    SERVICE_ERROR_IGNORE, //���Դ���
                    PChar(FileName),  //�������ļ���
                    nil,  //name of load ordering group (��������) &#39;LocalSystem&#39;
                    nil,  //��ǩ��ʶ��
                    nil,  //�����������
                    nil,  //�ʻ�(��ǰ)
                    nil); //����(��ǰ)

   Args := nil;
   if Service = 0 then exit;
   if StartService(Service, 0, Args) then
     MainForm.memo1.Lines.Add(DisplayName+' �����Ѿ�����')
   else
     MainForm.memo1.Lines.Add(DisplayName+' ��������ʧ�ܣ�');
   CloseServiceHandle(Service);
   CloseServiceHandle(SCManager);
  except on E: Exception do
    begin
      CloseServiceHandle(SCManager);
      MainForm.Memo1.Lines.Add('ʧ��ԭ���ǣ�' + E.Message);
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
   SCManager := OpenSCManager(nil, nil, SC_MANAGER_ALL_ACCESS);//���SC���������
   if SCManager = 0 then Exit;
   try
     Service := OpenService(SCManager, PChar(ServiceName), SERVICE_ALL_ACCESS);

     //�����Ȩ�޴�ָ���������ķ���,�����ؾ��
     ss := ControlService(Service, SERVICE_CONTROL_STOP, ServiceStatus);
     MainForm.Memo1.Lines.Add('ֹͣ��������' + BoolToStr(ss));

     //����������Ϳ�������,ֹͣ����, ServiceStatus ��������״̬
     ss := DeleteService(Service);
     MainForm.Memo1.Lines.Add('ж�ط�������' + BoolToStr(ss));
     //��SC ManGer ��ɾ������
     CloseServiceHandle(Service);
     result:=true;
     //�رվ��,�ͷ���Դ
   finally
     CloseServiceHandle(SCManager);
   end;
end;


end.
