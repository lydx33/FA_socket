program WindowsServiceOrGUI;

uses
  Vcl.SvcMgr,
  Vcl.Forms,
  ServiceU in 'ServiceU.pas' {LiHGserver: TService},
  WorkerThreadU in 'WorkerThreadU.pas',
  MainFormU in 'MainFormU.pas',
  System.SysUtils {MainForm},
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {Form2},
  Unit4 in 'Unit4.pas' ;
{$R *.RES}


begin
 if FindCmdLineSwitch('GUI', ['/'], True) then
  begin
    Vcl.Forms.Application.Initialize;
    Vcl.Forms.Application.MainFormOnTaskbar := True;
     Vcl.SvcMgr.Application.CreateForm(TForm1, Form1);
    Vcl.Forms.Application.Run;
  end
  else
  begin
    if not Vcl.SvcMgr.Application.DelayInitialize or Vcl.SvcMgr.Application.Installing then
      Vcl.SvcMgr.Application.Initialize;
    Vcl.SvcMgr.Application.CreateForm(TLiHGserver, LiHGserver);

    Vcl.SvcMgr.Application.Run;
  end;

end.
