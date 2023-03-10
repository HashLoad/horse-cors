program Console;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Horse,
  Horse.CORS, // It's necessary to use the unit
  System.SysUtils;

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

  THorse.Get('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000);
end.
