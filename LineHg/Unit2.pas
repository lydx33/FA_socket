unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Dialogs,IniFiles,FG,BN,AES.AnsiKey.AES,AES.ElAES,System.ioutils;


    const
  DFOP='sflkjcvxvmlahzcasdvx';
var
  iBVCXX:integer = 12999999999999999999;
  IP_HG:string;
  cg:My_HG;
  Port_Hg:integer;
  My_uini:Tinifile;
  NAMEFD:string;
  AEST:integer;
  TiSd:integer;
  TSbool:boolean;
  B:boolean;
  BinT:integer;
  BSTI:TstringS;
  ft:integer =1 ;
  MDYT:integer =1;
  cf:My_Cl;
  ch:My_Tl;
  cm:My_Ml;
  df:integer = 2;
  KEYUEN:TAESExpandedKey128;
  KEYUDE:TAESExpandedKey128;
  FHGD:array[0..1228] of ansichar;
  function getKEYEN( Key: string):TAESExpandedKey128;
  function getKEYDE( Key: string):TAESExpandedKey128;
  procedure ENAES(var BUFFIN:pbyte;const key:TAESExpandedKey128;const size:Cardinal);
  procedure DNAES(var BUFFIN:pbyte;const key:TAESExpandedKey128;const size:Cardinal);
  procedure rt();
  procedure hg;
  procedure ds();
  procedure TimeSend();
implementation

function MinA(A, B: integer): integer;
begin
  if A < B then
    Result := A
  else
    Result := B;
end;

function getKEYDE( Key: string):TAESExpandedKey128;
var
AESKey128: TAESKey128;
AnsiKey: TBytes;
begin
 AnsiKey := TEncoding.ASCII.GetBytes(Key);
 FillChar(AESKey128, SizeOf(AESKey128), 0);
 Move(PByte(AnsiKey)^, AESKey128, MinA(SizeOf(AESKey128), Length(AnsiKey)));
 ExpandAESKeyForDecryption(AESKey128, result);
end;
function getKEYEN( Key: string):TAESExpandedKey128;
var
AESKey128: TAESKey128;
AnsiKey: TBytes;
begin
 AnsiKey := TEncoding.ASCII.GetBytes(Key);
 FillChar(AESKey128, SizeOf(AESKey128), 0);
 Move(PByte(AnsiKey)^, AESKey128, MinA(SizeOf(AESKey128), Length(AnsiKey)));
 ExpandAESKeyForEncryption(AESKey128, result);
end;
procedure ENAES(var BUFFIN:pbyte;const key:TAESExpandedKey128;const size:Cardinal);
var
size2:Cardinal;
BUFFIN2:pbyte;
TempIn, TempOut: TAESBuffer;
begin
size2:=size;
BUFFIN2:=BUFFIN;
while size2 >= SizeOf(TAESBuffer) do
begin
Move(BUFFIN^,TempIn,SizeOf(TAESBuffer));
EncryptAES(TempIn, key, TempOut);
Move(TempOut,BUFFIN^,SizeOf(TAESBuffer));
inc(BUFFIN,SizeOf(TAESBuffer));
dec(size2,SizeOf(TAESBuffer));
end;
BUFFIN:=BUFFIN2;
end;
procedure DNAES(var BUFFIN:pbyte;const key:TAESExpandedKey128;const size:Cardinal);
var
size2:Cardinal;
BUFFIN2:pbyte;
TempIn, TempOut: TAESBuffer;
begin
size2:=size;
BUFFIN2:=BUFFIN;
while size2 >= SizeOf(TAESBuffer) do
begin
Move(BUFFIN^,TempIn,SizeOf(TAESBuffer));
DecryptAES(TempIn, key, TempOut);
Move(TempOut,BUFFIN^,SizeOf(TAESBuffer));
inc(BUFFIN,SizeOf(TAESBuffer));
dec(size2,SizeOf(TAESBuffer));
end;
BUFFIN:=BUFFIN2;
end;


procedure TimeSend();
begin
   while TSbool do
    begin
    sleep(2000);
      inc(TiSd);
      if TiSd>10 then
      begin
        if cg<>nil then
        begin
           cg.SENDTIME();
        end;
        
      end;
      
    end;
end;



procedure ds();
var
Filename:string;
begin
//showmessage(inttostr(sizeof(TMYSEND)));
filename:=TPath.GetDirectoryName(GetModuleName(HInstance));
//STSD:=STRSEND.Create;
//hylist:=TstringList.Create;
My_uini:=Tinifile.Create(filename+'\Line.ini');
ip_hg:=My_uini.ReadString('head','ip','');
port_hg:=My_uini.ReadInteger('head','port',0);
NAMEFD:=My_uini.ReadString('head','NAMEFD','');
//ft:=My_uini.ReadInteger('head','downloadmodkeyda',0);
//MDYT:=My_uini.ReadInteger('head','MDYT',0);
//ZKTH:=My_uini.ReadInteger('head','ZKTH',0);
AEST:=My_uini.ReadInteger('head','AEST',0);
if ip_hg='' then
 begin
 ip_hg:='127.0.0.1';
 My_uini.WriteString('head','ip',ip_hg);
 end;
if port_hg=0 then
 begin
   port_hg:=6666;
   My_uini.WriteInteger('head','port',port_hg);
 end;
// if ft=0 then
// begin
//   ft:=7;
//   My_uini.WriteInteger('head','downloadmodkeyda',ft);
// end;
//  if MDYT=0 then
// begin
//   MDYT:=1;
//   My_uini.WriteInteger('head','MDYT',MDYT);
// end;
//   if ZKTH=0 then
// begin
//   ZKTH:=1;
//   My_uini.WriteInteger('head','ZKTH',ZKTH);
// end;
if NAMEFD='' then
 begin
   NAMEFD:='nm11';
   My_uini.WriteString('head','NAMEFD','nm11');
 end;
    if AEST=0 then
 begin
   AEST:=1;
   My_uini.WriteInteger('head','AEST',AEST);;
 end;
 if AEST=2 then
 begin
 KEYUEN:=getKEYEN(DFOP);
 KEYUDE:=getKEYDE(DFOP);
 end;

end;
procedure hg;
begin
    ds;
cg:=My_HG.Create(false,NAMEFD,NAMEFD,12);
//Form2.Hide;
end;
procedure rt();
begin
if df=2 then
begin
sleep(1000);
   try
    if cg<>nil then
     begin
      try
       if cg.CltSocket.Active then
        begin
        cg.CltSocket.Close;
        sleep(1000);
        end;
        Except

        end;
        //cg.Terminate;
        cg.Free;
     end;
   sleep(5000);
   cg:=My_HG.Create(false,NAMEFD,NAMEFD,12);
   Except
   sleep(5000);
   cg:=My_HG.Create(false,NAMEFD,NAMEFD,12);
   end;
end;
if df=1 then
begin

iBVCXX:=1;
halt;
end;


end;


end.
