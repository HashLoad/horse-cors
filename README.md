# horse-cors
Middleware for inject CORS headers in HORSE

### For install in your project using [boss](https://github.com/HashLoad/boss):
``` sh
$ boss install github.com/HashLoad/horse-cors
```

### Sample Horse Server with CORS middleware
```delphi
uses
  Horse, Horse.CORS;

var
  App: THorse;

begin
  App := THorse.Create(9000);
  
  App.Use(CORS);
  
  App.Post('marco',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('polo');
    end);

  App.Start;
```
