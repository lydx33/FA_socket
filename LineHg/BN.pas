unit BN;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
Vcl.ComCtrls,IniFiles, Vcl.ExtCtrls, Vcl.Buttons,math;

type
SENDFLAGT=(NONU,UP,DOWN,DOWNUN,DDDDFS,DDDD,NameList,open2,open6,zhuce,RETY,send,ddddty,ddddEX,ddddhg,ddddhgfg,ddddEND,
TTTTTTTTTTTT,TTTTTTTTTTTF,TTTTTTTTTTFF,RRRRRRRRRRRR,FFFFFFFFFFFF,FFFFFFFFFFFD,FLLIST,user,FAHG,ddddtp,ddddhgtp);
   fhdf=record
   datasd:SENDFLAGT;
   ID:int64;
 end;
 TMYSENDdf=record
  ID:int64;
  flag:SENDFLAGT;
  name:string[20];
  sendTI:string[32];
  zi:array[0..1228] of ansichar;
  end;
   TMYDATAdf=record
  ID:int64;
  flag:SENDFLAGT;
  //name:string[20];
  //sendTI:string[32];
  zi:array[0..115970] of ansichar;
  end;
  My_Tl=class(tthread)
    private
    BUUFT6:pbyte;
    send1:TMYSENDdf;
    data:TMYDATAdf;
    FLAGIDHG,sizeDATA:integer;
    tr:boolean;
    Filename2:Tstrings;
    name1:string;
    name2:string;
    BU,bupo:integer;
    BUUF,BUUF2,BUFFBU,BUFFBU2:Pbyte;
    CltSocket: TClientSocket;
    procedure FW(const ST:string;var sendhg:TMYDATAdf;var si:integer);
    procedure setfilename(const value:string);
    protected
    procedure SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYDATAdf;CSIZE:integer);overload;
    procedure SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYSENDdf);overload;
    procedure Execute; override;
    public
    Filename7:Tstrings;
    property Filename6:string write setfilename;
    constructor Create(CreateSuspended: Boolean;valr:Tstrings;name,nameb:string;const FLAGID:integer); overload;
  end;
    My_Ml=class(tthread)
    private
    BUUFT6:pbyte;
    send1:TMYSENDdf;
    data:TMYDATAdf;
    FLAGIDHG,sizeDATA:integer;
    tr:boolean;
    MHG:TStream;
    name1:string;
    name2:string;

    BUUF,BUUF2:Pbyte;
    CltSocket: TClientSocket;
    procedure FW(const ST:string;var sendhg:TMYDATAdf;var si:integer);

    protected
    procedure SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYDATAdf;CSIZE:integer);overload;
    procedure SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYSENDdf);overload;
    procedure Execute; override;
    public


    constructor Create(CreateSuspended: Boolean;valr:TStream;name,nameb:string;const FLAGID:integer); overload;
  end;
 My_Cl=class(tthread)
 //bg:boolean;
 send1:TMYSENDdf;
 TNFHG:integer;
 LOADHGTR:string;
 sizeDATA:integer;
 bh,sd:int64;
 data:TMYDATAdf;
 bq:double;
 boor:boolean;
 name1:string;
 name2:string;
 BU,bupo:integer;
 BUUF,BUUF2,BUUFt,BUFFBU,BUFFBU2:PByte;
 Time16,HGID:int64;
 time1,time2:cardinal;
 CltSocket: TClientSocket;
 HGJK:int64;
 tr:boolean;
 function FR(const sendhg:TMYDATAdf;var si:integer):string;
 function ExtractFileDir(const FileName: string): string;
 protected
 procedure Execute; override;
 public
 constructor Create(CreateSuspended: Boolean;name:string;nameb:string;LoadHG:string;const FLAGID:integer); overload;
 end;



var
  visiosma,visios:int64;
implementation


Uses
IdHashMessageDigest,
ActiveX,unit2;
constructor My_Cl.Create(CreateSuspended: Boolean;name:string;nameb:string;LoadHG:string;const FLAGID:integer);
begin
   //bg:=false;
   BU:=120;
   getmem(BUFFBU,BU*sizeof(data.zi));
   CoInitialize(nil);
   CltSocket:=TClientSocket.Create(nil);
   CltSocket.ClientType:=ctBlocking;
   CltSocket.Host:=ip_hg;
   CltSocket.Port:=port_hg;
   CltSocket.Open;
   name1:=name;
   name2:=nameb;
   LOADHGTR:=LoadHG;
   tr:=false;
   TNFHG:=FLAGID;

   inherited Create(CreateSuspended);
end;

function My_Cl.FR(const sendhg:TMYDATAdf;var si:integer):string;
var
i:integer;
FnSt:ansistring;
begin
move(sendhg.zi[0],i,4);
setlength(FnSt,i);

move(sendhg.zi[4],FnSt[1],i);
si:=sizeof(sendhg.zi)-(i+4);
result:=FnSt;
end;


procedure My_Cl.Execute;
var
isize,si,hgsize,hgsize2,i:integer;
pStream: TWinSocketStream;
cvdf:TfileStream;
fghj:fhdf;
HGMD5,ds:string;
mymd5:TIdHashMessageDigest5;
HGJKhg:int64;
HGMD56:ansistring;
HGMD52:string;
asname:string;
f,bool:boolean;
//hjkg:Extended;
begin
FreeOnTerminate:=true;
   sizeDATA:=sizeof(data.zi);
   getdir(0,ds);
   if AEST=2 then getmem(BUUF,sizeof(send1));
   getmem(BUUF2,sizeof(data));
   pStream := TWinSocketStream.Create(CltSocket.Socket, 60000);
   send1.flag:=DDDD;
   send1.name:=name1;
   send1.sendti:=name2;
   send1.ID:=TNFHG;
   if TNFHG=10 then
   begin
     move(FHGD[0],send1.zi[0],sizeof(send1.zi));
   end;
   HGJK:=0;
if AEST=1 then
begin
pStream.Write(send1,sizeof(send1));
end else
begin
 move(send1,BUUF^,sizeof(send1));
 ENAES(BUUF,KEYUEN,sizeof(send1));
 pStream.Write(BUUF^,sizeof(send1));
end;
   bupo:=0;
   BUFFBU2:=BUFFBU;
   //BUFFBU:=Tmemorystream.Create;
   //BUFFBU.Position:=0;
  try
  bh:=0;

  if (MDYT=2) and (ft=7) then mymd5:=TIdHashMessageDigest5.Create;
    while (not Terminated) and (CltSocket.Active) do
    begin
    bool:=pStream.WaitForData(60000);
//      while (not bool) and tr  do
//      begin
//        sleep(1);
//        inc(bh);
//        if bh>2 then
//         begin
//           fghj.datasd:=ddddEX;
//           fghj.ID:=HGID;
//           CltSocket.Socket.SendBuf(fghj,sizeof(fghj));
//           HGJK:=HGID*sizeDATA;
//           cvdf.Position:=HGJK;
//           break;
//         end;
//      end;


      if bool then
      begin



hgsize:=0;
      BUUFt:=BUUF2;
      hgsize:=pStream.Read(isize,4);
      hgsize:=pStream.Read(BUUF2^, isize);
       if hgsize=0 then
        begin
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
        end else
        begin
          if hgsize<isize then
          begin
            inc(BUUF2,hgsize);
            while hgsize<isize do
            begin

             hgsize2:=pStream.Read(BUUF2^, (isize-hgsize));
             inc(BUUF2,hgsize2);
             inc(hgsize,hgsize2);
            end;
           BUUF2:=BUUFt;
          end;
        end;

    if AEST=2 then
     begin
       DNAES(BUUF2,KEYUDE,isize);
       move(BUUF2^,data,isize);
    end else
    begin
       move(BUUF2^,data,isize);
    end;



        if data.flag=ddddhg then
        begin
        time2:=gettickcount;
        move(data.zi,BUFFBU^,sizeof(data.zi));
        inc(bupo);
        inc(BUFFBU,sizeof(data.zi));
        fghj.datasd:=ddddhg;
         CltSocket.Socket.SendBuf(fghj,sizeof(fghj));
           if bupo>=bu then
            begin
            BUFFBU:=BUFFBU2;
            cvdf.WriteBuffer(BUFFBU^,bupo*sizeof(data.zi));
            bupo:=0;
          end;
          //cvdf.WriteBuffer(data.zi,sizeDATA);

          HGJK:=HGJK+sizeDATA;

          if time2-time1>500 then
          begin
           time1:=time2;
           bq:=RoundTo(((HGJK-HGJKhg)/(1024*1024))*2,-5);
           Time16:=Round((sd-HGJK)/(HGJK-HGJKhg));
           HGJKhg:=HGJK;
          end;
          //HGID:=data.ID;


        end;

             if data.flag=ddddhgtp then
        begin
        time2:=gettickcount;
        move(data.zi,BUFFBU^,sizeof(data.zi));
        inc(bupo);
        inc(BUFFBU,sizeof(data.zi));
           if bupo>=bu then
            begin
            BUFFBU:=BUFFBU2;
            cvdf.WriteBuffer(BUFFBU^,bupo*sizeof(data.zi));
            bupo:=0;
          end;
          //cvdf.WriteBuffer(data.zi,sizeDATA);
          fghj.datasd:=ddddhg;
          HGJK:=HGJK+sizeDATA;

          if time2-time1>500 then
          begin
           time1:=time2;
           bq:=RoundTo(((HGJK-HGJKhg)/(1024*1024))*2,-5);
           Time16:=Round((sd-HGJK)/(HGJK-HGJKhg));
           HGJKhg:=HGJK;
          end;
          //HGID:=data.ID;

          CltSocket.Socket.SendBuf(fghj,sizeof(fghj));
        end;


        if data.flag=ddddhgfg then
        begin
          tr:=false;
          BUFFBU:=BUFFBU2;
          cvdf.WriteBuffer(BUFFBU^,bupo*sizeof(data.zi));
          bupo:=0;
          cvdf.WriteBuffer(data.zi,data.ID);
          fghj.datasd:=ddddhgfg;
          CltSocket.Socket.SendBuf(fghj,sizeof(fghj));
          if cvdf<>nil then
        begin
          cvdf.Free;
          cvdf:=nil;
        end;
        end;

        if data.flag=ddddty then
        begin
        if cvdf<>nil then
        begin
          cvdf.Free;
          cvdf:=nil;
        end;
        asname:=FR(data,si);
        if Pos('\',asname)>0 then
         begin
                if not FileExists(ExtractFileDir(LOADHGTR+'\'+asname)) then

                begin
                  //CreateDir(ExtractFileDir(myforde+'\'+My_Filename));
                  ForceDirectories(ExtractFileDir(LOADHGTR+'\'+asname));   //创建目录
                end;
         end;
        cvdf:=TfileStream.Create(LOADHGTR+'\'+asname,fmCreate);
        cvdf.Position:=0;
        sd:=data.ID;
        if si<sd then
        begin
         time1:=gettickcount;

         if data.ID>i.MaxValue then boor:=false else  boor:=true;
         tr:=true;

         HGID:=0;
         HGJK:=si;


         {bu:=(sd div sizeof(data.zi));
         if bu>260000 then bu:=260000;}

         CVDF.Write(data.zi[sizeof(data.zi)-si],si);
         fghj.datasd:=ddddhg;
         pStream.Write(fghj,sizeof(fghj));
        end else
        begin

        cvdf.Position:=0;
        CVDF.Write(data.zi[sizeof(data.zi)-si],sd);
        fghj.datasd:=ddddhgfg;
        pStream.Write(fghj,sizeof(fghj));
        if cvdf<>nil then
        begin
          cvdf.Free;
          cvdf:=nil;
        end;
        end;
        end;
        if data.flag=ddddEND then
        begin
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
        end;
      end;
    end;
  finally

    BUFFBU:=BUFFBU2;
    freemem(BUFFBU);
    freemem(BUUF2);
    if AEST=2 then freemem(BUUF);
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
   Terminate;
  end;
end;
function My_Cl.ExtractFileDir(const FileName: string): string;
var
  I: Integer;
begin
  I := FileName.LastDelimiter(PathDelim + DriveDelim);
  if (I > 0) and (FileName.Chars[I] = PathDelim) and
    (not FileName.IsDelimiter(PathDelim + DriveDelim, I-1)) then Dec(I);
  Result := FileName.SubString(0, I + 1);
end;
/////////////////Tl//////////////////////
constructor My_Tl.Create(CreateSuspended: Boolean;valr:Tstrings;name,nameb:string;const FLAGID:integer);
var
i:integer;
begin
   //bg:=false;
   Filename7:=TstringlisT.Create;
   Filename7.AddStrings(valr);
   CoInitialize(nil);
   CltSocket:=TClientSocket.Create(nil);
   CltSocket.ClientType:=ctBlocking;
   CltSocket.Host:=ip_hg;
   CltSocket.Port:=port_hg;
   CltSocket.Open;
   FLAGIDHG:=FLAGID;

   name1:=name;
   name2:=nameb;
   tr:=false;
   inherited Create(CreateSuspended);
end;

procedure My_Tl.FW(const ST:string;var sendhg:TMYDATAdf;var si:integer);
var
i:integer;
FnSt:ansistring;
begin
FnSt:=ST;
i:=length(FnSt);
fillchar(sendhg.zi, sizeof(sendhg.zi), '0');

move(i,sendhg.zi[0],4);
move(FnSt[1],sendhg.zi[4],length(FnSt));
si:=length(FnSt)+4;
end;
procedure My_Tl.SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYDATAdf;CSIZE:integer);
var
i:integer;
TEMP6:pbyte;
begin
i:=9+CSIZE;
TEMP6:=BUUFT6;
move(i,BUUFT6^,4);
inc(BUUFT6,4);
if AEST=1 then
begin
move(datahg,BUUFT6^,i);
BUUFT6:=TEMP6;
pStreamhg.Write(BUUFT6^,(i+4));
end else
begin
 move(datahg,BUUF2^,i);
 ENAES(BUUF2,KEYUEN,i);
 move(BUUF2^,BUUFT6^,i);
 BUUFT6:=TEMP6;
 pStreamhg.Write(BUUFT6^,(i+4));
end;
end;
procedure My_Tl.SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYSENDdf);
begin
if AEST=1 then
begin
pStreamhg.Write(datahg,sizeof(datahg));
end else
begin
 move(datahg,BUUF^,sizeof(datahg));
 ENAES(BUUF,KEYUEN,sizeof(datahg));
 pStreamhg.Write(BUUF^,sizeof(datahg));
end;
end;
procedure My_Tl.Execute;
var
si,i:integer;
pStream: TWinSocketStream;
cvdf:TfileStream;
fghj:fhdf;
ds:string;
filecount,filecount2,filecount6,bh:integer;
getr,filesize2:int64;
HGID:integer;
{bool2,}f,bool:boolean;
filename2:Tstrings;
mymd5:TIdHashMessageDigest5;
HGMD56:ansistring;
HGMD52:string;
//hjkg:Extended;
begin
FreeOnTerminate:=true;
   sizeDATA:=sizeof(data.zi);
   getdir(0,ds);
   pStream := TWinSocketStream.Create(CltSocket.Socket, 60000);
   send1.flag:=DDDDFS;
   send1.ID:=FLAGIDHG;
   if FLAGIDHG=5 then
   begin
   HGMD56:=name2;
    i:=length(HGMD56);
    FillChar(send1.zi, SizeOf(send1.zi), 0);
    move(i,send1.zi[0],4);
    if i>0 then
     begin
     move(HGMD56[1],send1.zi[4],i);
     end;
   end;
   bu:=100;
   getmem(BUFFBU,BU*sizeof(data.zi));
   if AEST=2 then getmem(BUUF,sizeof(data));
   getmem(BUUF2,sizeof(data));
   getmem(BUUFT6,sizeof(data)+4);
   send1.name:=name1;
   send1.sendTi:=name2;
   Filename2:=TstringList.Create;
   Filename2:=Filename7;
   filecount:=Filename2.Count;//文件总数
   //showmessage(inttostr(filecount));
   filecount2:=0;
   tr:=true;
SENDDATA(pStream,send1);

   //BUFFBU:=Tmemorystream.Create;
   BUFFBU2:=BUFFBU;
   bupo:=0;
   //Synchronize(setST);
  try
  bh:=0;

  //if MDYT=2 then mymd5:=TIdHashMessageDigest5.Create;

    while (not Terminated) and (CltSocket.Active) do
    begin

     if pStream.WaitForData(60000) then
      begin
      if pStream.Read(fghj, sizeof(fghj))=0 then
        begin
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
        end;
       if fghj.datasd=ddddhgfg then
       begin
       filecount2:=filecount2+1;
       if cvdf<>nil then
        begin
          cvdf.Free;
          cvdf:=nil;
        end;
         if filename2.Count>0 then
           begin
           f:=true;
           while f do
           begin
            try
            if filename2.Count>0 then
            begin
            cvdf:=TfileStream.Create(filename2[0],fmOpenRead or fmShareDenyNone);
            cvdf.Position:=0;
            //form1.Memo1.Lines.Add('开始发送文件'+filename2[0]);
            f:=false;
            end else
            begin
             f:=false;

             data.flag:=ddddEND;
             SENDDATA(pStream,data,0);
             if pStream<>nil then
             begin
               pStream.Free;
               pStream:=nil;
             end;
             if CltSocket<>nil then
             begin
               CltSocket.Close;
               CltSocket:=nil;
             end;
            end;
            except

            f:=true;



            filename2.Delete(0);
            end;

           end;

           filecount6:=0;
           if B then
           FW(copy(filename2[0], BinT+1, Length(filename2[0])),data,si)
           else
           FW(ExtractFileName(filename2[0]),data,si);
           filename2.Delete(0);
           filesize2:=cvdf.Size;
           getr:=filesize2;//文件大小
           {bu:=(getr div sizeof(data.zi));
           if bu>260000 then bu:=260000;}

           data.ID:=filesize2;
           data.flag:=ddddty;
           HGID:=0;
           //fileflag:=1;

           if getr>(sizeof(data.zi)-si) then
           begin
             cvdf.Read(data.zi[si],(sizeof(data.zi)-si));
             getr:=getr-(sizeof(data.zi)-si);
             SENDDATA(pStream,data,sizeof(data.zi));
             if (getr>(bu*sizeof(data.zi))) then
              begin
                bupo:=0;
                BUFFBU:=BUFFBU2;
                cvdf.Read(BUFFBU^,BU*sizeof(data.zi));
                {BUFFBU.CopyFrom(cvdf,BU*sizeof(data.zi));
                BUFFBU.Position:=0;}
                {bool2:=true}
              end else
              begin
              bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,getr);
              end;
           end else
           begin
           cvdf.Read(data.zi[si],getr);
           SENDDATA(pStream,data,getr+si);
           end;
           end else
           begin
           data.flag:=ddddEND;
SENDDATA(pStream,data,0);
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
           end;
       end;
                  if fghj.datasd=ddddtp then
        begin
          cvdf.Position:=fghj.ID;
          getr:=cvdf.Size;
          getr:=getr-fghj.ID;
          HGID:=0;
          if ((getr-(HGID*sizeDATA))>sizeDATA) then
           begin
            if (bupo>=BU) then
             begin

             if ((getr-(HGID*sizeDATA))>(bu*sizeof(data.zi))) then
              begin
              bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,BU*sizeof(data.zi));
              end else
              begin
              bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,(getr-(HGID*sizeDATA)));
              end;
           end;
           move(BUFFBU^,data.zi,sizeof(data.zi));
           inc(bupo);
           inc(BUFFBU,sizeof(data.zi));

           inc(HGID);

           data.ID:=HGID;
           data.flag:=ddddhgtp;
SENDDATA(pStream,data,sizeof(data.zi));
          //form1.Memo1.Lines.Add(inttostr(sizeof(data)));
           end
          else
           begin
             data.ID:=(getr-(HGID*sizeDATA));
             cvdf.ReadBuffer(data.zi,(getr-(HGID*sizeDATA)));
             data.flag:=ddddhgfg;
SENDDATA(pStream,data,(getr-(HGID*sizeDATA)));
           end;
        end;
        if fghj.datasd=ddddhg then
        begin

        if Terminated then exit;
          if ((getr-(HGID*sizeDATA))>sizeDATA) then
           begin
            if (bupo>=BU) then
             begin

             if ((getr-(HGID*sizeDATA))>(bu*sizeof(data.zi))) then
              begin
              bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,BU*sizeof(data.zi));
              end else
              begin
              bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,(getr-(HGID*sizeDATA)));
              end;
           end;
           move(BUFFBU^,data.zi,sizeof(data.zi));
           inc(bupo);
           inc(BUFFBU,sizeof(data.zi));

           inc(HGID);

           data.ID:=HGID;
           data.flag:=ddddhg;
SENDDATA(pStream,data,sizeof(data.zi));
          //form1.Memo1.Lines.Add(inttostr(sizeof(data)));
           end
          else
           begin
             data.ID:=(getr-(HGID*sizeDATA));
             move(BUFFBU^,data.zi,data.ID);
             data.flag:=ddddhgfg;
SENDDATA(pStream,data,(getr-(HGID*sizeDATA)));

           end;

        end;
        if fghj.datasd=ddddEX then
        begin
         HGID:=fghj.ID;
         cvdf.Position:=HGID*sizeDATA;
         cvdf.ReadBuffer(data.zi,sizeDATA);
         inc(HGID);
         data.ID:=HGID;
         if((getr-(HGID*sizeDATA))>(bu*sizeof(data.zi))) then
           begin
           bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,BU*sizeof(data.zi));
             end else
              begin
              bupo:=0;
              BUFFBU:=BUFFBU2;
              cvdf.ReadBuffer(BUFFBU^,(getr-(HGID*sizeDATA)));
              end;
         data.flag:=ddddhg;
SENDDATA(pStream,data,sizeof(data.zi));
        end;


      end;


    end;
  finally
  B:=False;
   BUFFBU:=BUFFBU2;
   freemem(BUFFBU);
   freemem(BUUFT6);
    if AEST=2 then freemem(BUUF);
    freemem(BUUF2);
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
   Terminate;
  end;
end;
procedure My_Tl.setfilename(const value:string);
begin
Filename2.add(value);
end;
/////////////////Ml//////////////////////
constructor My_Ml.Create(CreateSuspended: Boolean;valr:TStream;name,nameb:string;const FLAGID:integer);
var
i:integer;
begin
   //bg:=false;

   CoInitialize(nil);
   CltSocket:=TClientSocket.Create(nil);
   CltSocket.ClientType:=ctBlocking;
   CltSocket.Host:=ip_hg;
   CltSocket.Port:=port_hg;
   CltSocket.Open;
   FLAGIDHG:=FLAGID;

   MHG:=valr;

   name1:=name;
   name2:=nameb;
   tr:=false;
   inherited Create(CreateSuspended);
end;

procedure My_Ml.FW(const ST:string;var sendhg:TMYDATAdf;var si:integer);
var
i:integer;
FnSt:ansistring;
begin
FnSt:=ST;
i:=length(FnSt);
fillchar(sendhg.zi, sizeof(sendhg.zi), '0');

move(i,sendhg.zi[0],4);
move(FnSt[1],sendhg.zi[4],length(FnSt));
si:=length(FnSt)+4;
end;
procedure My_Ml.SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYDATAdf;CSIZE:integer);
var
i:integer;
TEMP6:pbyte;
begin
i:=9+CSIZE;
TEMP6:=BUUFT6;
move(i,BUUFT6^,4);
inc(BUUFT6,4);
if AEST=1 then
begin
move(datahg,BUUFT6^,i);
BUUFT6:=TEMP6;
pStreamhg.Write(BUUFT6^,(i+4));
end else
begin
 move(datahg,BUUF2^,i);
 ENAES(BUUF2,KEYUEN,i);
 move(BUUF2^,BUUFT6^,i);
 BUUFT6:=TEMP6;
 pStreamhg.Write(BUUFT6^,(i+4));
end;
end;
procedure My_Ml.SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYSENDdf);
begin
if AEST=1 then
begin
pStreamhg.Write(datahg,sizeof(datahg));
end else
begin
 move(datahg,BUUF^,sizeof(datahg));
 ENAES(BUUF,KEYUEN,sizeof(datahg));
 pStreamhg.Write(BUUF^,sizeof(datahg));
end;
end;
procedure My_Ml.Execute;
var
si,i:integer;
pStream: TWinSocketStream;

fghj:fhdf;
ds:string;
filecount,filecount2,filecount6,bh:integer;
getr,filesize2:int64;
HGID:integer;
{bool2,}f,bool:boolean;
mymd5:TIdHashMessageDigest5;
HGMD56:ansistring;
HGMD52:string;
//hjkg:Extended;
begin
FreeOnTerminate:=true;
   sizeDATA:=sizeof(data.zi);
   getdir(0,ds);
   pStream := TWinSocketStream.Create(CltSocket.Socket, 60000);
   send1.flag:=DDDDFS;
   send1.ID:=FLAGIDHG;
   if FLAGIDHG=5 then
   begin
   HGMD56:=name2;
    i:=length(HGMD56);
    FillChar(send1.zi, SizeOf(send1.zi), 0);
    move(i,send1.zi[0],4);
    if i>0 then
     begin
     move(HGMD56[1],send1.zi[4],i);
     end;
   end;

   if AEST=2 then getmem(BUUF,sizeof(data));
   getmem(BUUF2,sizeof(data));
   getmem(BUUFT6,sizeof(data)+4);
   send1.name:=name1;
   send1.sendTi:=name2;
   MHG.Position:=0;

   //showmessage(inttostr(filecount));
   filecount2:=0;
   tr:=true;
SENDDATA(pStream,send1);

   //BUFFBU:=Tmemorystream.Create;

   //Synchronize(setST);
  try
  bh:=0;

  //if MDYT=2 then mymd5:=TIdHashMessageDigest5.Create;

    while (not Terminated) and (CltSocket.Active) do
    begin

     if pStream.WaitForData(60000) then
      begin
      if pStream.Read(fghj, sizeof(fghj))=0 then
        begin
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
        end;
             if fghj.datasd=ddddhgfg then
             begin

                                   if MHG.Position=MHG.Size then
                                   begin
                                                f:=false;

                                     data.flag:=ddddEND;
                                     SENDDATA(pStream,data,0);
                                     if pStream<>nil then
                                     begin
                                       pStream.Free;
                                       pStream:=nil;
                                     end;
                                     if CltSocket<>nil then
                                     begin
                                       CltSocket.Close;
                                       CltSocket:=nil;
                                     end;
                                   end;




                                  //form1.Memo1.Lines.Add('开始发送文件'+filename2[0]);






                           filecount6:=0;
//                           if B then
//                           FW(copy(filename2[0], BinT+1, Length(filename2[0])),data,si)
//                           else
//                           FW(ExtractFileName(filename2[0]),data,si);
                           FW('a.jpg',data,si);

                           filesize2:=MHG.Size;
                           getr:=filesize2;//文件大小
                           {bu:=(getr div sizeof(data.zi));
                           if bu>260000 then bu:=260000;}

                           data.ID:=filesize2;
                           data.flag:=ddddty;
                           HGID:=0;
                           //fileflag:=1;

                           if getr>(sizeof(data.zi)-si) then
                           begin
                             MHG.Read(data.zi[si],(sizeof(data.zi)-si));
                             getr:=getr-(sizeof(data.zi)-si);
                             SENDDATA(pStream,data,sizeof(data.zi));
//                             if (getr>(bu*sizeof(data.zi))) then
//                              begin
//                                bupo:=0;
//                                BUFFBU:=BUFFBU2;
//                                MHG.Read(BUFFBU^,BU*sizeof(data.zi));
//                                {BUFFBU.CopyFrom(cvdf,BU*sizeof(data.zi));
//                                BUFFBU.Position:=0;}
//                                {bool2:=true}
//                              end else
//                              begin
//                              bupo:=0;
//                              BUFFBU:=BUFFBU2;
//                              MHG.ReadBuffer(BUFFBU^,getr);
//                              end;
                           end else
                           begin
                           MHG.Read(data.zi[si],getr);
                           SENDDATA(pStream,data,getr+si);
                           end;


                   end;

        if fghj.datasd=ddddhg then
        begin
          if ((getr-(HGID*sizeDATA))>sizeDATA) then
           begin
//            if (bupo>=BU) then
//             begin

//             if ((getr-(HGID*sizeDATA))>(bu*sizeof(data.zi))) then
//              begin
//              bupo:=0;
//              BUFFBU:=BUFFBU2;
//              MHG.ReadBuffer(BUFFBU^,BU*sizeof(data.zi));
//              end else
//              begin
//              bupo:=0;
//              BUFFBU:=BUFFBU2;
//              MHG.ReadBuffer(BUFFBU^,(getr-(HGID*sizeDATA)));
//              end;
//           end;
//           move(BUFFBU^,data.zi,sizeof(data.zi));
//           inc(bupo);
//           inc(BUFFBU,sizeof(data.zi));
           MHG.ReadBuffer(data.zi,sizeof(data.zi));
           inc(HGID);

           data.ID:=HGID;
           data.flag:=ddddhg;
SENDDATA(pStream,data,sizeof(data.zi));
          //form1.Memo1.Lines.Add(inttostr(sizeof(data)));
           end
          else
           begin
             data.ID:=(getr-(HGID*sizeDATA));
             MHG.ReadBuffer(data.zi,data.ID);
             data.flag:=ddddhgfg;
SENDDATA(pStream,data,(getr-(HGID*sizeDATA)));
           end;
        end;
        if fghj.datasd=ddddEX then
        begin
         HGID:=fghj.ID;
         MHG.Position:=HGID*sizeDATA;
         MHG.ReadBuffer(data.zi,sizeDATA);
         inc(HGID);
         data.ID:=HGID;
//         if((getr-(HGID*sizeDATA))>(bu*sizeof(data.zi))) then
//           begin
//           bupo:=0;
//              BUFFBU:=BUFFBU2;
//              MHG.ReadBuffer(BUFFBU^,BU*sizeof(data.zi));
//             end else
//              begin
//              bupo:=0;
//              BUFFBU:=BUFFBU2;
//              MHG.ReadBuffer(BUFFBU^,(getr-(HGID*sizeDATA)));
//              end;
         data.flag:=ddddhg;
SENDDATA(pStream,data,sizeof(data.zi));
        end;


      end;


    end;
  finally
  MHG.Free;
  B:=False;

   freemem(BUUFT6);
    if AEST=2 then freemem(BUUF);
    freemem(BUUF2);
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
   Terminate;
  end;
end;

{procedure TForm1.BitBtn1Click(Sender: TObject);
var
bool:boolean;
i:integer;
begin
 OpenDialog1.Execute();
 ch:=My_Tl.Create(false,OpenDialog1.files);
end;}

{procedure TForm1.Button1Click(Sender: TObject);
begin
 cf:=My_Cl.Create(False);

end;}

{procedure TForm1.FormShow(Sender: TObject);
begin

end;}

end.