# horse-cors
Middleware for inject CORS headers in HORSE

### For install in your project using [boss](https://github.com/HashLoad/boss):
`boss install github.com/HashLoad/horse-cors`

### Sample Horse Server with CORS middleware
```delphi
uses
  Horse, Horse.CORS;

var
  App: THorse;

begin
  App := THorse.Create(9000);

  App.Use(HorseCORSBuilder.AllowedOrigin('https://docs.mongodb.com').Build());
  
  App.Post('marco',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('polo');
    end);

  App.Start;
```
