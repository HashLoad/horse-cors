unit Horse.CORS;
{$IF DEFINED(FPC)}
{$MODE DELPHI}{$H+}
{$ENDIF}
interface

uses
  {$IF DEFINED(FPC)}
    SysUtils,
  {$ELSE}
    System.SysUtils,
  {$ENDIF}
  Horse;

type
  HorseCORSConfig = record
  public
    function AllowedOrigin(AAllowedOrigin: string): HorseCORSConfig;
    function AllowedCredentials(AAllowedCredentials: Boolean): HorseCORSConfig;
    function AllowedHeaders(AAllowedHeaders: string): HorseCORSConfig;
    function AllowedMethods(AAllowedMethods: string): HorseCORSConfig;
    function ExposedHeaders(AExposedHeaders: string): HorseCORSConfig;
  end;

function HorseCORS(): HorseCORSConfig; overload;
procedure CORS(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}  TProc {$ENDIF}); overload;

implementation

uses
  {$IF DEFINED(FPC)}
    httpdefs, StrUtils,
  {$ELSE}
    Web.HTTPApp, System.StrUtils,
  {$ENDIF}
  Horse.Commons;

var
  LAllowedOrigin: string;
  LAllowedCredentials: string;
  LAllowedHeaders: string;
  LAllowedMethods: string;
  LExposedHeaders: string;

procedure CORS(Req: THorseRequest; Res: THorseResponse; Next: {$IF DEFINED(FPC)}TNextProc{$ELSE}  TProc {$ENDIF});
var
  LWebResponse: {$IF DEFINED(FPC)}TResponse{$ELSE}  TWebResponse {$ENDIF};
begin
  LWebResponse := THorseHackResponse(Res).GetWebResponse;
  LWebResponse.SetCustomHeader('Access-Control-Allow-Origin', LAllowedOrigin);
  LWebResponse.SetCustomHeader('Access-Control-Allow-Credentials', LAllowedCredentials);
  LWebResponse.SetCustomHeader('Access-Control-Allow-Headers', LAllowedHeaders);
  LWebResponse.SetCustomHeader('Access-Control-Allow-Methods', LAllowedMethods);
  LWebResponse.SetCustomHeader('Access-Control-Expose-Headers', LExposedHeaders);
  if THorseHackRequest(Req).GetWebRequest.Method = 'OPTIONS' then
  begin
    Res.Send('').Status(THTTPStatus.NoContent);
    raise EHorseCallbackInterrupted.Create();
  end
  else
    Next();
end;

{ HorseCORS }

function HorseCORSConfig.AllowedCredentials(AAllowedCredentials: Boolean): HorseCORSConfig;
begin
  LAllowedCredentials := ifthen(AAllowedCredentials, 'true', 'false');
end;

function HorseCORSConfig.AllowedHeaders(AAllowedHeaders: string): HorseCORSConfig;
begin
  LAllowedHeaders := AAllowedHeaders;
end;

function HorseCORSConfig.AllowedMethods(AAllowedMethods: string): HorseCORSConfig;
begin
  LAllowedMethods := AAllowedMethods;
end;

function HorseCORSConfig.AllowedOrigin(AAllowedOrigin: string): HorseCORSConfig;
begin
  LAllowedOrigin := AAllowedOrigin;
end;

function HorseCORSConfig.ExposedHeaders(AExposedHeaders: string): HorseCORSConfig;
begin
  LExposedHeaders := AExposedHeaders;
end;

function HorseCORS(): HorseCORSConfig;
begin
  //
end;

initialization
  LAllowedOrigin := '*';
  LAllowedCredentials := 'true';
  LAllowedHeaders := '*';
  LAllowedMethods := '*';
  LExposedHeaders := '*';

end.
