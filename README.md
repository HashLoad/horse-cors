# horse-cors
<b>horse-cors</b> is a official middleware for handling CORS in APIs developed with the <a href="https://github.com/HashLoad/horse">Horse</a> framework.
<br>We created a channel on Telegram for questions and support:<br><br>
<a href="https://t.me/hashload">
  <img src="https://img.shields.io/badge/telegram-join%20channel-7289DA?style=flat-square">
</a>

## ❓ What's CORS?
Cross-Origin Resource Sharing (CORS) is an HTTP-header based mechanism that allows a server to indicate any origins (domain, scheme, or port) other than its own from which a browser should permit loading resources. CORS also relies on a mechanism by which browsers make a "preflight" request to the server hosting the cross-origin resource, in order to check that the server will permit the actual request. In that preflight, the browser sends headers that indicate the HTTP method and headers that will be used in the actual request.

An example of a cross-origin request: the front-end JavaScript code served from `https://domain-a.com` uses XMLHttpRequest to make a request for `https://domain-b.com/data.json`.

For security reasons, browsers restrict cross-origin HTTP requests initiated from scripts. For example, XMLHttpRequest and the Fetch API follow the same-origin policy. This means that a web application using those APIs can only request resources from the same origin the application was loaded from unless the response from other origins includes the right CORS headers.

The CORS mechanism supports secure cross-origin requests and data transfers between browsers and servers. Modern browsers use CORS in APIs such as XMLHttpRequest or Fetch to mitigate the risks of cross-origin HTTP requests.

Read more in [https://developer.mozilla.org](https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS)

## ⚙️ Installation
Installation is done using the [`boss install`](https://github.com/HashLoad/boss) command:
``` sh
boss install horse-cors
```
If you choose to install manually, simply add the following folders to your project, in *Project > Options > Resource Compiler > Directories and Conditionals > Include file search path*
```
../horse-cors/src
```

## ✔️ Compatibility
This middleware is compatible with projects developed in:
- [X] Delphi
- [X] Lazarus

## ⚡️ Quickstart Delphi
```delphi
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
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    begin
      Res.Send('pong');
    end);

  THorse.Listen(9000);
end.
```

## ⚡️ Quickstart Lazarus
```delphi
{$MODE DELPHI}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Horse,
  Horse.CORS, // It's necessary to use the unit
  SysUtils;

procedure GetPing(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send('Pong');
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

  THorse.Listen(9000);
end.
```

## ⚠️ License
`horse-cors` is free and open-source middleware licensed under the [MIT License](https://github.com/HashLoad/horse-cors/blob/master/LICENSE). 
