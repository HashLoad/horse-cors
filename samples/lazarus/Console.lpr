program Console;

{$MODE DELPHI}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Horse,
  Horse.CORS, // It's necessary to use the unit
  SysUtils;

procedure GetPing(Req: THorseRequest; Res: THorseResponse);
begin
  Res.Send('Pong');
end;

procedure OnListen;
begin
  Writeln(Format('Server is runing on %s:%d', [THorse.Host, THorse.Port]));
end;

begin
  // You can configure CORS as in the example below:

  // HorseCORS
  //   .AllowedOrigin('*')
  //   .AllowedCredentials('true')
  //   .AllowedHeaders('*')
  //   .AllowedMethods('*')
  //   .ExposedHeaders('*');

  // It's necessary to add the middleware in the Horse:
  THorse.Use(CORS);

  THorse.Get('/ping', GetPing);

  THorse.Listen(9000, OnListen);
end.
