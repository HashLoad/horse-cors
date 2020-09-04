# horse-cors
Middleware for inject CORS headers in HORSE

### For install in your project using [boss](https://github.com/HashLoad/boss):
``` sh
$ boss install github.com/HashLoad/horse-cors
```

### Sample Horse Server with CORS middleware
```delphi
uses Horse, Horse.CORS;

begin  
  THorse.Use(CORS);
  
  THorse.Post('/ping',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000);
end;
```
