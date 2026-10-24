unit fpm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Buttons, SynEdit, synhighlightergnuplot;

type

  { TfParams }

  TfParams = class(TForm)
    BitBtn1: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    pmPanel: TPanel;
    edPNGParams: TSynEdit;
    SynGnuplotSyn1: TSynGnuplotSyn;
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);

  private

  public
    Params: string;
    PlotWidth: Integer;
    PlotHeight: Integer;
  end;

var
  fParams: TfParams;


implementation

{$R *.lfm}

{ TfParams }

procedure TfParams.FormCreate(Sender: TObject);
begin
   edPNGParams.Font.Quality:= fqAntialiased;
end;

procedure TfParams.Label1Click(Sender: TObject);
begin

end;



end.

