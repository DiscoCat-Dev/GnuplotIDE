unit fXpm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  StdCtrls, synhighlightergnuplot, SynEdit;

type

  { TfX11Params }

  TfX11Params = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    pmXPanel: TPanel;
    edXParams: TSynEdit;
    SynGnuplotSyn1: TSynGnuplotSyn;
    procedure FormCreate(Sender: TObject);
    procedure GetFontName;
  private

  public
    Params: string;

  end;

var
  fX11Params: TfX11Params;


implementation

{$R *.lfm}

{ TfX11Params }

procedure TfX11Params.FormCreate(Sender: TObject);
begin
  edXParams.Font.Quality:= fqAntialiased;
  Font.Name := DefFontData.Name;
end;

procedure TfX11Params.GetFontName;
var
    FontName: string;

begin
  begin
    FontName := GetFontData(fX11Params.Font.Handle).Name;
    ShowMessage('The default font name is: ' + FontName);
  end;
end;



end.

