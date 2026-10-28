program GnuplotIDE;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, main, fPM, fXpm, fcolors, fAbout;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  {$PUSH}{$WARN 5044 OFF}
  Application.Scaled:=True;
  Application.MainFormOnTaskbar:=True;
  {$POP}
  Application.Initialize;
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TfParams, fParams);
  Application.CreateForm(TfX11Params, fX11Params);
  Application.CreateForm(TfColor, fColor);
  Application.CreateForm(TfAboutIDE, fAboutIDE);
  Application.Run;
end.

