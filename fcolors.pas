unit fColors;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Buttons, SynEdit, RichMemo, synhighlightergnuplot, IniFiles;

type

  { TfColor }

  TfColor = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    CD: TColorDialog;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Shape1: TShape;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public
    FEditor: TSynEdit;
    FMemo: TRichMemo;
    procedure SetDefaultColors;
    procedure SaveAppearance;
    procedure LoadAppearance;
    function AppearanceIniFile: string;


  end;

var
  fColor: TfColor;

implementation

{$R *.lfm}

{ TfColor }
procedure TfColor.SetDefaultColors;
begin
  FEditor.Color := clMoneyGreen;
  FMemo.Color := clDefault;
  FMemo.Font.Color := clDefault;

  TSynGnuplotSyn(FEditor.Highlighter).KeyAttri.Foreground := clBlue;
  TSynGnuplotSyn(FEditor.Highlighter).StringAttri.Foreground := clRed;
  TSynGnuplotSyn(FEditor.Highlighter).SymbolAttri.Foreground := clRed;
  TSynGnuplotSyn(FEditor.Highlighter).NumberAttri.Foreground := clGreen;
  TSynGnuplotSyn(FEditor.Highlighter).VarAttri.Foreground := clPurple;

  ComboBox1Change(ComboBox1);

end;

procedure TfColor.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
  0: Shape1.Brush.Color := FEditor.Color;
  1: Shape1.Brush.Color := TSynGnuplotSyn(FEditor.Highlighter).KeyAttri.Foreground;
  2: Shape1.Brush.Color := TSynGnuplotSyn(FEditor.Highlighter).StringAttri.Foreground;
  3: Shape1.Brush.Color := TSynGnuplotSyn(FEditor.Highlighter).SymbolAttri.Foreground;
  4: Shape1.Brush.Color := TSynGnuplotSyn(FEditor.Highlighter).NumberAttri.Foreground;
  5: Shape1.Brush.Color := TSynGnuplotSyn(FEditor.Highlighter).VarAttri.Foreground;
  6: Shape1.Brush.Color := FMemo.Color;
  7:
    if FMemo.Font.Color = clDefault then
       Shape1.Brush.Color := clWhite
    else
       Shape1.Brush.Color := FMemo.Font.Color;
  end;
end;

procedure TfColor.FormCreate(Sender: TObject);
begin

end;

procedure TfColor.SaveAppearance;
var
  Ini: TIniFile;

begin
  ForceDirectories(GetAppConfigDir(False));
  Ini := TIniFile.Create(AppearanceIniFile);

  try
    Ini.WriteInteger('Colors', 'EditorFontColor', FEditor.Font.Color);
    Ini.WriteInteger('Colors', 'EditorBackground', FEditor.Color);

    Ini.WriteInteger('Colors', 'MemoFontColor', FMemo.Font.Color);
    Ini.WriteInteger('Colors', 'MemoBackground', FMemo.Color);

    Ini.WriteString('Fonts', 'EditorFontName', FEditor.Font.Name);
    Ini.WriteInteger('Fonts', 'EditorFontSize', FEditor.Font.Size);

    Ini.WriteString('Fonts', 'MemoFontName', FMemo.Font.Name);
    Ini.WriteInteger('Fonts', 'MemoFontSize', FMemo.Font.Size);
  finally
    Ini.Free;
  end;
end;


procedure TfColor.LoadAppearance;
var
  Ini: TIniFile;

begin
  if not FileExists(AppearanceIniFile) then
     Exit;

  Ini := TIniFile.Create(AppearanceIniFile);

  try
    FEditor.Font.Color :=
      Ini.ReadInteger('Colors', 'EditorFontColor', FEditor.Font.Color);

    FEditor.Color :=
      Ini.ReadInteger('Colors', 'EditorBackground', FEditor.Color);


    FMemo.Font.Color :=
      Ini.ReadInteger('Colors', 'MemoFontColor', FMemo.Font.Color);

    FMemo.Color :=
      Ini.ReadInteger('Colors', 'MemoBackground', FMemo.Color);

    FEditor.Font.Name :=
      Ini.ReadString('Fonts', 'EditorFontName', FEditor.Font.Name);

    FEditor.Font.Size :=
      Ini.ReadInteger('Fonts', 'EditorFontSize', FEditor.Font.Size);

    FMemo.Font.Name :=
      Ini.ReadString('Fonts', 'MemoFontName', FMemo.Font.Name);

    FMemo.Font.Size :=
      Ini.ReadInteger('Fonts', 'MemoFontSize', FMemo.Font.Size);
  finally
    Ini.Free;
  end;
end;

function TfColor.AppearanceIniFile: string;
begin
  Result := GetAppConfigDir(False) + 'ShinPlot.ini';
end;



procedure TfColor.Button1Click(Sender: TObject);
begin
  if not CD.Execute then Exit;

  case ComboBox1.ItemIndex of
  0: FEditor.Color := CD.Color;
  1: TSynGnuplotSyn(FEditor.Highlighter).KeyAttri.Foreground := CD.Color;
  2: TSynGnuplotSyn(FEditor.Highlighter).StringAttri.Foreground := CD.Color;
  3: TSynGnuplotSyn(FEditor.Highlighter).SymbolAttri.Foreground := CD.Color;
  4: TSynGnuplotSyn(FEditor.Highlighter).NumberAttri.Foreground := CD.Color;
  5: TSynGnuplotSyn(FEditor.Highlighter).VarAttri.Foreground := CD.Color;
  6: FMemo.Color := CD.Color;
  7: FMemo.Font.Color := CD.Color;
  end;

  Shape1.Brush.Color := CD.Color;
end;

procedure TfColor.Button2Click(Sender: TObject);
begin
  SetDefaultColors;
end;



end.

