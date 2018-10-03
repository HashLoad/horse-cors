unit Horse.CORS;

interface

uses
  System.SysUtils, Horse;

type
  HorseCORS = record
  public
    function AllowedOrigin(AAllowedOrigin: string): HorseCORS;
    function AllowedCredentials(AAllowedCredentials: Boolean): HorseCORS;
    function AllowedHeaders(AAllowedHeaders: string): HorseCORS;
    function AllowedMethods(AAllowedMethods: string): HorseCORS;
    function ExposedHeaders(AExposedHeaders: string): HorseCORS;
    function Build: THorseCallback;
  end;

function HorseCORSBuilder(): HorseCORS;

implementation

uses
  System.StrUtils, Web.HTTPApp;

var
  LAllowedOrigin: string;
  LAllowedCredentials: string;
  LAllowedHeaders: string;
  LAllowedMethods: string;
  LExposedHeaders: string;

procedure CORS(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LWebResponse: TWebResponse;
begin
  LWebResponse := THorseHackResponse(Res).GetWebResponse;
  LWebResponse.SetCustomHeader('Access-Control-Allow-Origin', LAllowedOrigin);
  LWebResponse.SetCustomHeader('Access-Control-Allow-Credentials', LAllowedCredentials);
  LWebResponse.SetCustomHeader('Access-Control-Allow-Headers', LAllowedHeaders);
  LWebResponse.SetCustomHeader('Access-Control-Allow-Methods', LAllowedMethods);
  LWebResponse.SetCustomHeader('Access-Control-Expose-Headers', LExposedHeaders);
  if THorseHackRequest(Req).GetWebRequest.MethodType = mtHead then
  begin
    raise EHorseCallbackInterrupted.Create();
  end;

end;

{ HorseCORS }

function HorseCORS.AllowedCredentials(AAllowedCredentials: Boolean): HorseCORS;
begin
  LAllowedCredentials := ifthen(AAllowedCredentials, 'true', 'false');
end;

function HorseCORS.AllowedHeaders(AAllowedHeaders: string): HorseCORS;
begin
  LAllowedHeaders := AAllowedHeaders;
end;

function HorseCORS.AllowedMethods(AAllowedMethods: string): HorseCORS;
begin
  LAllowedMethods := AAllowedMethods;
end;

function HorseCORS.AllowedOrigin(AAllowedOrigin: string): HorseCORS;
begin
  LAllowedOrigin := AAllowedOrigin;
end;

function HorseCORS.Build: THorseCallback;
begin
  Result := CORS;
end;

function HorseCORS.ExposedHeaders(AExposedHeaders: string): HorseCORS;
begin
  LExposedHeaders := AExposedHeaders;
end;

function HorseCORSBuilder(): HorseCORS;
begin
  //
end;

initialization

LAllowedOrigin := '*';
LAllowedCredentials := 'true';
LAllowedHeaders := 'Access-Control-Allow-Headers, Content-Type, Accept, authentication';
LAllowedMethods := 'POST, GET, HEAD, PUT, DELETE';
LExposedHeaders := 'authorization, authentication';

end.
