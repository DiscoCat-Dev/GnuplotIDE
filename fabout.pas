unit fAbout;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, RichMemo, LCLIntf;

type

  { TfAboutIDE }

  TfAboutIDE = class(TForm)
    BitBtn1: TBitBtn;
    Logo: TImage;
    General: TLabel;
    Link: TLabel;
    Panel1: TPanel;
    RichMemo1: TRichMemo;
    procedure LinkClick(Sender: TObject);
  private

  public

  end;

var
  fAboutIDE: TfAboutIDE;

implementation

{$R *.lfm}

{ TfAboutIDE }



procedure TfAboutIDE.LinkClick(Sender: TObject);
begin
  OpenURL('https://github.com/DiscoCat-Dev/ShinPlot');
end;


end.

