// http://bbs.2ccc.com/topic.asp?topicid=305495
(* ************************************************ *)
(* *)
(* Advanced Encryption Standard (AES) *)
(* Interface Unit v1.3.20031003 *)
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
unit AES.Common;

interface

uses
  System.SysUtils, System.Classes;

type
  TKeyBit = (kb128, kb192, kb256);
  TCRLFMode = (rlCRLF, rlLF, rlCR, rlNONE);

const
{$IFDEF MSWINDOWS}
  DefaultCRLFMode: TCRLFMode = rlCRLF;
{$ELSE}
{$IFDEF MACOS}
  DefaultCRLFMode: TCRLFMode = rlCR;
{$ELSE}
{$IFDEF IOS}
  DefaultCRLFMode: TCRLFMode = rlCR;
{$ELSE}
  DefaultCRLFMode: TCRLFMode = rlLF;
{$ENDIF IOS}
{$ENDIF MACOS}
{$ENDIF MSWINDOWS}

  {
    TStringStream = class(TStream)
    private
    FDataString: string;
    FPosition: Integer;
    protected
    procedure SetSize(NewSize: Longint); override;
    public
    constructor Create(const AString: string);
    function Read(var Buffer; Count: Longint): Longint; override;
    function ReadString(Count: Longint): string;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    procedure WriteString(const AString: string);
    property DataString: string read FDataString;
    end;
  }

{$IFDEF MSWINDOWS}

function StrToHex(Value: RawByteString): RawByteString;
function HexToStr(Value: string): RawByteString;

{$ELSE}

function StrToHex(Value: TBytes): string;
function HexToStr(Value: string): TBytes;

{$ENDIF}

function ChangCRLFType(Value: string; CRLFMode: TCRLFMode): string;

implementation


{
  constructor TStringStream.Create(const AString: string);
  begin
  inherited Create;
  FDataString := AString;
  end;

  function TStringStream.Read(var Buffer; Count: Longint): Longint;
  begin
  Result := Length(FDataString) - FPosition;
  if Result > Count then Result := Count;
  Move(PAnsiChar(@FDataString[FPosition + SizeOf(Char)])^, Buffer, Result * SizeOf(Char));
  Inc(FPosition, Result);
  end;

  function TStringStream.Write(const Buffer; Count: Longint): Longint;
  begin
  Result := Count;
  SetLength(FDataString, (FPosition + Result));
  Move(Buffer, PAnsiChar(@FDataString[FPosition + SizeOf(Char)])^, Result * SizeOf(Char));
  Inc(FPosition, Result);
  end;

  function TStringStream.Seek(Offset: Longint; Origin: Word): Longint;
  begin
  case Origin of
  soFromBeginning: FPosition := Offset;
  soFromCurrent: FPosition := FPosition + Offset;
  soFromEnd: FPosition := Length(FDataString) - Offset;
  end;
  if FPosition > Length(FDataString) then
  FPosition := Length(FDataString)
  else if FPosition < 0 then FPosition := 0;
  Result := FPosition;
  end;

  function TStringStream.ReadString(Count: Longint): string;
  var
  Len: Integer;
  begin
  Len := Length(FDataString) - FPosition;
  if Len > Count then Len := Count;
  SetString(Result, PAnsiChar(@FDataString[FPosition + SizeOf(Char)]), Len);
  Inc(FPosition, Len);
  end;

  procedure TStringStream.WriteString(const AString: string);
  begin
  Write(PAnsiChar(AString)^, Length(AString));
  end;

  procedure TStringStream.SetSize(NewSize: Longint);
  begin
  SetLength(FDataString, NewSize);
  if FPosition > NewSize then FPosition := NewSize;
  end;
}

function ChangCRLFType(Value: string; CRLFMode: TCRLFMode): string;
var
  HasCRLF: Boolean;
begin
  Result := Value;
  HasCRLF := Pos(#10, Result) > 0;
  if not HasCRLF then
  begin
    HasCRLF := Pos(#13, Result) > 0;
  end;
  if HasCRLF then
  begin
    Result := StringReplace(Result, #13#10, #10, [rfReplaceAll]);
    Result := StringReplace(Result, #10#13, #10, [rfReplaceAll]);
    Result := StringReplace(Result, #13, #10, [rfReplaceAll]);
    if CRLFMode = rlCRLF then
    begin
      Result := StringReplace(Result, #10, #13#10, [rfReplaceAll]);
    end
    else if CRLFMode = rlCR then
    begin
      Result := StringReplace(Result, #10, #13, [rfReplaceAll]);
    end
    else if CRLFMode = rlNONE then
    begin
      Result := StringReplace(Result, #10, '', [rfReplaceAll]);
    end;
  end;
end;

{$IFDEF MSWINDOWS}
function StrToHex(Value: RawByteString): RawByteString;
var
  I: Integer;
begin
  Result := '';
  for I := Low(Value) to High(Value) do
    Result := Result + RawByteString(IntToHex(Ord(Value[I]), 2));
end;

function HexToStr(Value: string): RawByteString;
var
  I: Integer;
begin
  Result := '';
  for I := 1 to Length(Value) do
  begin
    if ((I mod 2) = 1) then
    begin
      //Copy based 1
      Result :=Result + AnsiChar(StrToInt('0x' + Copy(Value, I, 2)));
    end;
  end;
end;
{$ELSE}
function StrToHex(Value: TBytes): string;
var
  I: Integer;
begin
  Result := '';
  for I := Low(Value) to High(Value) do
    Result := Result + IntToHex(Value[I], 2);
end;

function HexToStr(Value: string): TBytes;
var
  I: Integer;
begin
  SetLength(Result, Length(Value) div 2);
  for I := Low(Result) to High(Result) do
    Result[I] := 0;
  for I := 1 to Length(Value) do
  begin
    if ((I mod 2) = 1) then
    begin
      //Copy based 1
      Result[I div 2] := StrToInt('0x' + Copy(Value, I, 2));
    end;
  end;
end;
{$ENDIF}

end.
