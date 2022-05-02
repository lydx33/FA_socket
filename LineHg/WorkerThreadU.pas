unit WorkerThreadU;

interface

uses
  System.Classes;

type
  TWorkerThread = class(TThread)
  private
    FPaused: Boolean;

  protected
    procedure Execute; override;
  public
    procedure Pause;
    procedure Continue;
    function IsPaused: Boolean;
    constructor Create(CreateSuspended: Boolean); overload;
  end;

implementation

uses
  System.SysUtils, System.ioutils,unit2;

procedure TWorkerThread.Continue;
begin
  FPaused := False;
end;
constructor TWorkerThread.Create(CreateSuspended: Boolean);
begin
hg;
  inherited Create(CreateSuspended);
end;
procedure TWorkerThread.Execute;
var
  ExePath: string;
  //Log: TStreamWriter;
begin
  try
    FPaused := False;
    ExePath := TPath.GetDirectoryName(GetModuleName(HInstance));
    //LogFileName := TPath.Combine(ExePath,
      //ClassName + '_' + IntToStr(CurrentThread.ThreadID) + '.txt');
      //hg;
    //Log := TStreamWriter.Create(TFileStream.Create(LogFileName, fmCreate or fmShareDenyWrite));
    try
      while not Terminated do
      begin
        if not FPaused then
        begin
          TThread.Sleep(2000);
        end;

      end;
    finally
      //Log.Free;
    end;
  except
    on E: Exception do
    begin
      TFile.WriteAllText(TPath.Combine(ExePath, 'CRASH_LOG.TXT'), E.ClassName + ' ' + E.Message);
    end
  end;
end;

function TWorkerThread.IsPaused: Boolean;
begin
  Result := FPaused;
end;

procedure TWorkerThread.Pause;
begin
  FPaused := True;
end;

end.
