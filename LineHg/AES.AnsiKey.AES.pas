// http://bbs.2ccc.com/topic.asp?topicid=305495
(* ************************************************ *)
(* *)
(* Advanced Encryption Standard (AES) *)
(* Interface Unit v1.3.20131003 *)
(* *)
(* *)
(* Copyright (c) 2002 Jorlen Young *)
(* *)
(* *)
(* *)
(* 说明： *)
(* *)
(* 基于 ElASE.pas 单元封装 *)
(* *)
(* 这是一个 AES 加密算法的标准接口。 *)
(* *)
(* *)
(* 作者：杨泽晖      2004.12.04 *)
(* *)
(* 支持 128 / 192 / 256 位的密匙 *)
(* 默认情况下按照 128 位密匙操作 *)
(* *)
(* *)
(* Modify By 爱吃猪头肉 & Flying Wang 2013-10-01*)
(* *)
(* ************************************************ *)
{$H+}
unit AES.AnsiKey.AES;

interface

uses
  System.SysUtils, System.Classes, System.Math,
  AES.ElAES, AES.Common;


function UTF8Encryptstring(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepValueCRLF: Boolean = False;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
function UTF8DecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepResultCRLF: Boolean = False;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;

function WideEncryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepValueCRLF: Boolean = False;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
function WideDecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepResultCRLF: Boolean = False;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;

function AnsiEncryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepValueCRLF: Boolean = False;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
function AnsiDecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepResultCRLF: Boolean = False;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;

function EncryptStream(Stream: TStream; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): TStream;
function DecryptStream(Stream: TStream; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): TStream;


procedure EncryptFile(SourceFile, DestFile: string; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  );
procedure DecryptFile(SourceFile, DestFile: string; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  );


implementation

{ --  字符串加密函数 默认按照 128 位密匙加密 -- }
function UTF8Encryptstring(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepValueCRLF: Boolean = False;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
var
  SS, DS: TStringStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  I, MaxI: Integer;
  s: string;
  AnsiKey: TBytes;
{$IFDEF MSWINDOWS}
{$ELSE}
  UTF8Value: TBytes;
{$ENDIF}
begin
  Result := '';
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  if KeepValueCRLF then
  begin
    Value := ChangCRLFType(Value,ValueCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SS := TStringStream.Create(Value,TEncoding.UTF8, False);
  DS := TStringStream.Create('',TEncoding.ANSI, False);
  try
    MaxI := 16;
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey128, DS);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey192, DS);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey256, DS);
    end;
    s := '';
    MaxI := ((High(SS.Bytes)div MaxI) + 1) * MaxI;
    if High(DS.Bytes) > 0 then
    begin
      for I := Low(DS.Bytes) to MaxI + Low(DS.Bytes) - 1 do
      begin
        s := s + IntToHex(DS.Bytes[I], 2);
      end;
    end;
    Result := (s);
//     Result := StrToHex(DS.DataString);//+' '+inttostr(l));
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
end;

{ --  字符串解密函数 默认按照 128 位密匙解密 -- }
function UTF8DecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepResultCRLF: Boolean = False;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
var
  SS, DS: TStringStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  AnsiKey: TBytes;
begin
  Result := '';
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SS := TStringStream.Create(HexToStr(Value));
  DS := TStringStream.Create('', TEncoding.UTF8, False);
  try
    // SS.ReadBuffer(Size, SizeOf(Size));
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey128, DS);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey192, DS);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey256, DS);
    end;
    Result := DS.DataString;
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
  if KeepResultCRLF then
  begin
    Result := ChangCRLFType(Result,ResultCRLFMode);
  end;
end;


{ --  字符串加密函数 默认按照 128 位密匙加密 -- }
function WideEncryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepValueCRLF: Boolean = False;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
var
  SS, DS: TStringStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  I, MaxI: Integer;
  s: string;
  AnsiKey: TBytes;
{$IFDEF MSWINDOWS}
{$ELSE}
  WideValue: TBytes;
{$ENDIF}
begin
  Result := '';
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  if KeepValueCRLF then
  begin
    Value := ChangCRLFType(Value,ValueCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SS := TStringStream.Create(Value,TEncoding.Unicode, False);
  DS := TStringStream.Create('',TEncoding.ANSI, False);
  try
    MaxI := 16;
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey128, DS);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey192, DS);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey256, DS);
    end;
    s := '';
    MaxI := ((High(SS.Bytes)div MaxI) + 1) * MaxI;
    if High(DS.Bytes) > 0 then
    begin
      for I := Low(DS.Bytes) to MaxI + Low(DS.Bytes) - 1 do
      begin
        s := s + IntToHex(DS.Bytes[I], 2);
      end;
    end;
    Result := (s);
//     Result := StrToHex(DS.DataString);//+' '+inttostr(l));
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
end;

{ --  字符串解密函数 默认按照 128 位密匙解密 -- }
function WideDecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepResultCRLF: Boolean = False;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
var
  SS, DS: TStringStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  AnsiKey: TBytes;
begin
  Result := '';
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SS := TStringStream.Create(HexToStr(Value));
  DS := TStringStream.Create('', TEncoding.Unicode, False);
  try
    // SS.ReadBuffer(Size, SizeOf(Size));
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey128, DS);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey192, DS);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey256, DS);
    end;
    Result := DS.DataString;
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
  if KeepResultCRLF then
  begin
    Result := ChangCRLFType(Result,ResultCRLFMode);
  end;
end;


{ --  字符串加密函数 默认按照 128 位密匙加密 -- }
function AnsiEncryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepValueCRLF: Boolean = False;
  ValueCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
var
  SS, DS: TStringStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  I, MaxI: Integer;
  s: string;
  AnsiKey: TBytes;
  AnsiValue: TBytes;
  AEncoding: TEncoding;
begin
  Result := '';
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  if KeepValueCRLF then
  begin
    Value := ChangCRLFType(Value,ValueCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SS := TStringStream.Create(Value, TEncoding.ANSI);
  DS := TStringStream.Create('',TEncoding.ASCII, False);
  try
    MaxI := 16;
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey128, DS);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey192, DS);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      EncryptAESStreamECB(SS, 0, AESKey256, DS);
    end;
    s := '';
    MaxI := ((High(SS.Bytes)div MaxI) + 1) * MaxI;
    if High(DS.Bytes) > 0 then
    begin
      for I := Low(DS.Bytes) to MaxI + Low(DS.Bytes) - 1 do
      begin
        s := s + IntToHex(DS.Bytes[I], 2);
      end;
    end;
    Result := (s);
//     Result := StrToHex(DS.DataString);//+' '+inttostr(l));
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
end;

{ --  字符串解密函数 默认按照 128 位密匙解密 -- }
function AnsiDecryptString(Value: string; Key: string;
  KeyBit: TKeyBit = kb128;
  KeepResultCRLF: Boolean = False;
  ResultCRLFMode: TCRLFMode = rlCRLF;
  KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): string;
var
  SS, DS: TStringStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  AnsiKey: TBytes;
begin
  Result := '';
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SS := TStringStream.Create(HexToStr(Value));
  DS := TStringStream.Create('', TEncoding.ANSI, False);
  try
    // SS.ReadBuffer(Size, SizeOf(Size));
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey128, DS);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey192, DS);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      DecryptAESStreamECB(SS, SS.Size - SS.Position, AESKey256, DS);
    end;
    Result := DS.DataString;
  finally
    FreeAndNil(SS);
    FreeAndNil(DS);
  end;
  if KeepResultCRLF then
  begin
    Result := ChangCRLFType(Result,ResultCRLFMode);
  end;
end;


{ --  流加密函数 默认按照 128 位密匙解密 -- }
function EncryptStream(Stream: TStream; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): TStream;
var
  Count: Int64;
  OutStrm: TStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  SS: TStringStream;
  AnsiKey: TBytes;
begin
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  OutStrm := TStream.Create;
  Stream.Position := 0;
  Count := Stream.Size;
  OutStrm.Write(Count, SizeOf(Count));
  try
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      EncryptAESStreamECB(Stream, 0, AESKey128, OutStrm);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      EncryptAESStreamECB(Stream, 0, AESKey192, OutStrm);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      EncryptAESStreamECB(Stream, 0, AESKey256, OutStrm);
    end;
    Result := OutStrm;
  finally
    FreeAndNil(OutStrm);
  end;
end;

{ --  流解密函数 默认按照 128 位密匙解密 -- }
function DecryptStream(Stream: TStream; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  ): TStream;
var
  Count, OutPos: Int64;
  OutStrm: TStream;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  SS: TStringStream;
  AnsiKey: TBytes;
begin
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  OutStrm := TStream.Create;
  Stream.Position := 0;
  OutPos := OutStrm.Position;
  Stream.ReadBuffer(Count, SizeOf(Count));
  try
    { --  128 位密匙最大长度为 16 个字符 -- }
    if KeyBit = kb128 then
    begin
      FillChar(AESKey128, SizeOf(AESKey128), 0);
      Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
      DecryptAESStreamECB(Stream, Stream.Size - Stream.Position, AESKey128,
        OutStrm);
    end;
    { --  192 位密匙最大长度为 24 个字符 -- }
    if KeyBit = kb192 then
    begin
      FillChar(AESKey192, SizeOf(AESKey192), 0);
      Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
      DecryptAESStreamECB(Stream, Stream.Size - Stream.Position, AESKey192,
        OutStrm);
    end;
    { --  256 位密匙最大长度为 32 个字符 -- }
    if KeyBit = kb256 then
    begin
      FillChar(AESKey256, SizeOf(AESKey256), 0);
      Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
      DecryptAESStreamECB(Stream, Stream.Size - Stream.Position, AESKey256,
        OutStrm);
    end;
    OutStrm.Size := OutPos + Count;
    OutStrm.Position := OutPos;
    Result := OutStrm;
  finally
    FreeAndNil(OutStrm);
  end;
end;

{ --  文件加密函数 默认按照 128 位密匙解密 -- }
procedure EncryptFile(SourceFile, DestFile: string; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  );
var
  SFS, DFS: TFileStream;
  Size: Int64;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  SS: TStringStream;
  AnsiKey: TBytes;
begin
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SFS := TFileStream.Create(SourceFile, fmOpenRead);
  try
    DFS := TFileStream.Create(DestFile, fmCreate);
    try
      Size := SFS.Size;
      DFS.WriteBuffer(Size, SizeOf(Size));
      { --  128 位密匙最大长度为 16 个字符 -- }
      if KeyBit = kb128 then
      begin
        FillChar(AESKey128, SizeOf(AESKey128), 0);
        Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
        EncryptAESStreamECB(SFS, 0, AESKey128, DFS);
      end;
      { --  192 位密匙最大长度为 24 个字符 -- }
      if KeyBit = kb192 then
      begin
        FillChar(AESKey192, SizeOf(AESKey192), 0);
        Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
        EncryptAESStreamECB(SFS, 0, AESKey192, DFS);
      end;
      { --  256 位密匙最大长度为 32 个字符 -- }
      if KeyBit = kb256 then
      begin
        FillChar(AESKey256, SizeOf(AESKey256), 0);
        Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
        EncryptAESStreamECB(SFS, 0, AESKey256, DFS);
      end;
    finally
      FreeAndNil(DFS);
    end;
  finally
    FreeAndNil(SFS);
  end;
end;

{ --  文件解密函数 默认按照 128 位密匙解密 -- }
procedure DecryptFile(SourceFile, DestFile: string; Key: string;
  KeyBit: TKeyBit = kb128; KeepKeyCRLF: Boolean = False;
  KeyCRLFMode: TCRLFMode = rlCRLF
  );
var
  SFS, DFS: TFileStream;
  Size: Int64;
  AESKey128: TAESKey128;
  AESKey192: TAESKey192;
  AESKey256: TAESKey256;
  SS: TStringStream;
  AnsiKey: TBytes;
begin
  if KeepKeyCRLF then
  begin
    Key := ChangCRLFType(Key,KeyCRLFMode);
  end;
  AnsiKey := TEncoding.ASCII.GetBytes(Key);
  SFS := TFileStream.Create(SourceFile, fmOpenRead);
  try
    SFS.ReadBuffer(Size, SizeOf(Size));
    DFS := TFileStream.Create(DestFile, fmCreate);
    try
      { --  128 位密匙最大长度为 16 个字符 -- }
      if KeyBit = kb128 then
      begin
        FillChar(AESKey128, SizeOf(AESKey128), 0);
        Move(PByte(AnsiKey)^, AESKey128, Min(SizeOf(AESKey128), Length(AnsiKey)));
        DecryptAESStreamECB(SFS, SFS.Size - SFS.Position, AESKey128, DFS);
      end;
      { --  192 位密匙最大长度为 24 个字符 -- }
      if KeyBit = kb192 then
      begin
        FillChar(AESKey192, SizeOf(AESKey192), 0);
        Move(PByte(AnsiKey)^, AESKey192, Min(SizeOf(AESKey192), Length(AnsiKey)));
        DecryptAESStreamECB(SFS, SFS.Size - SFS.Position, AESKey192, DFS);
      end;
      { --  256 位密匙最大长度为 32 个字符 -- }
      if KeyBit = kb256 then
      begin
        FillChar(AESKey256, SizeOf(AESKey256), 0);
        Move(PByte(AnsiKey)^, AESKey256, Min(SizeOf(AESKey256), Length(AnsiKey)));
        DecryptAESStreamECB(SFS, SFS.Size - SFS.Position, AESKey256, DFS);
      end;
      DFS.Size := Size;
    finally
      FreeAndNil(DFS);
    end;
  finally
    FreeAndNil(SFS);
  end;
end;

end.
