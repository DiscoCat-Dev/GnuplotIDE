unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ComCtrls, PairSplitter, Menus, synhighlightergnuplot, RichMemo, SynEdit,
  SynEditHighlighter, Process, SyncObjs, UnTerminal, fpm, fXpm, fColors, fAbout,
  FileUtil, QtWidgets, Qt5, BaseUnix, SynEditTypes, LCLIntf;


{ TThread}
type

  { TGnuplotThread }

  TGnuplotThread = class(TThread)
  private
    FString: String;
    FCriticalSection: TCriticalSection;
    FProcess: TConsoleProc;
    FEditorText: string;
    FCommand: string;
    FPlotList: TStringList;
    FPlotDirectory: string;
    FGnuplotPID: TPid;
    FMemoQueue: TStringList;
    FQueueLock: TCriticalSection;
    procedure FProcLineCompleted(const Line: string);
    procedure FCleanPlotDirectory;
  protected
    procedure Execute; override;
  public
    constructor Create;
    destructor Destroy; override;
    property Command: String read FString;
    procedure SendCommand(const S: string);
    procedure Stop;
    function GetWinID: PtrUInt;
    procedure DrainMemoQueue(ADestination: TStrings);
  end;

  { TFileWatcher}
  TFileWatcherThread = class(TThread)
    private
      FProcess: TConsoleProc;
      FFileName: string;
      FLastFileName: string;

    protected
      procedure Execute; override;
    public
      constructor Create;
      destructor Destroy; override;
  end;

  { TDocumentState}
  type
  TDocumentState = record
    FileName : string;
    Modified : Boolean;
  end;


  { TfMain }
  TfMain = class(TForm)
    edPanel: TPanel;
    Editor: TSynEdit;
    FindDialog1: TFindDialog;
    eFD: TFontDialog;
    DelPop: TMenuItem;
    mFD: TFontDialog;
    ImageList1: TImageList;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    EditMenu: TMenuItem;
    GnuplotMenu: TMenuItem;
    HelpMenu: TMenuItem;
    ExitFile: TMenuItem;
    CutEdit: TMenuItem;
    CopyEdit: TMenuItem;
    mClearView: TMenuItem;
    xClearView: TMenuItem;
    pClearView: TMenuItem;
    sLastView: TMenuItem;
    pSaveView: TMenuItem;
    pListView: TMenuItem;
    ViewMenu: TMenuItem;
    xParamsGnuplot: TMenuItem;
    qPlotGnuplot: TMenuItem;
    eFontsOptions: TMenuItem;
    AppearanceOptions: TMenuItem;
    GitHelp: TMenuItem;
    AboutHelp: TMenuItem;
    InsertDataFile: TMenuItem;
    ExternalPop: TMenuItem;
    CutPop: TMenuItem;
    CopyPop: TMenuItem;
    FindEdit: TMenuItem;
    PastePop: TMenuItem;
    Separator10: TMenuItem;
    Separator11: TMenuItem;
    Separator8: TMenuItem;
    Separator9: TMenuItem;
    xClearToolButton: TToolButton;
    ToolButton9: TToolButton;
    X11Pop: TMenuItem;
    sAllPop: TMenuItem;
    Separator6: TMenuItem;
    Separator7: TMenuItem;
    sPlotPop: TMenuItem;
    PopupMenu1: TPopupMenu;
    Separator2: TMenuItem;
    Separator3: TMenuItem;
    Separator4: TMenuItem;
    Separator5: TMenuItem;
    mFontsOptions: TMenuItem;
    ParamsGnuplot: TMenuItem;
    StopGnuplot: TMenuItem;
    xPlotGnuplot: TMenuItem;
    sPlotGnuplot: TMenuItem;
    SelectEdit: TMenuItem;
    PasteEdit: TMenuItem;
    RedoEdit: TMenuItem;
    UndoEdit: TMenuItem;
    PageControl1: TPageControl;
    X11Panel: TPanel;
    SaveAsFile: TMenuItem;
    SD: TSaveDialog;
    SaveFile: TMenuItem;
    OpenFile: TMenuItem;
    OD: TOpenDialog;
    OptionsMenu: TMenuItem;
    NewFile: TMenuItem;
    Preview: TImage;
    MsgPanel: TPanel;
    Msg: TRichMemo;
    nedPanel: TPanel;
    bPanel: TPanel;
    PairSplitter1: TPairSplitter;
    LeftSide: TPairSplitterSide;
    RightSide: TPairSplitterSide;
    pltPreview: TPanel;
    Separator1: TMenuItem;
    Splitter2: TSplitter;
    StatusBar1: TStatusBar;
    SynGnuplotSyn1: TSynGnuplotSyn;
    ButtonBar: TToolBar;
    sPlotButton: TToolButton;
    tsX11: TTabSheet;
    tsPNG: TTabSheet;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    qPlotButton: TToolButton;
    PlotsButton: TToolButton;
    ToolButton3: TToolButton;
    ShowButton: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    StopButton: TToolButton;
    ToolButton6: TToolButton;
    imSaveButton: TToolButton;
    iClearButton: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ClearButton: TToolButton;
    xPlotButton: TToolButton;

    procedure AboutHelpClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure CopyEditClick(Sender: TObject);
    procedure CopyPopClick(Sender: TObject);
    procedure CutEditClick(Sender: TObject);
    procedure CutPopClick(Sender: TObject);
    procedure DelPopClick(Sender: TObject);
    procedure edPanelClick(Sender: TObject);
    procedure eFontsOptionsClick(Sender: TObject);
    procedure FindDialog1Find(Sender: TObject);
    procedure FindEditClick(Sender: TObject);
    procedure GitHelpClick(Sender: TObject);
    procedure InsertDataFileClick(Sender: TObject);
    procedure EditorChange(Sender: TObject);
    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
    procedure ExitFileClick(Sender: TObject);
    procedure ExternalPopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure iClearButtonClick(Sender: TObject);
    procedure imSaveButtonClick(Sender: TObject);
    procedure mClearViewClick(Sender: TObject);
    procedure AppearanceOptionsClick(Sender: TObject);
    procedure mFontsOptionsClick(Sender: TObject);
    procedure pClearViewClick(Sender: TObject);
    procedure pListViewClick(Sender: TObject);
    procedure pSaveViewClick(Sender: TObject);
    procedure qPlotButtonClick(Sender: TObject);
    procedure qPlotGnuplotClick(Sender: TObject);
    procedure MsgChange(Sender: TObject);
    procedure NewFileClick(Sender: TObject);
    procedure OpenFileClick(Sender: TObject);
    procedure PlotsButtonClick(Sender: TObject);
    procedure ParamsGnuplotClick(Sender: TObject);
    procedure PasteEditClick(Sender: TObject);
    procedure PastePopClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure RedoEditClick(Sender: TObject);
    procedure sAllPopClick(Sender: TObject);
    procedure SaveAsFileClick(Sender: TObject);
    procedure SaveFileClick(Sender: TObject);
    procedure SelectEditClick(Sender: TObject);
    procedure sLastViewClick(Sender: TObject);
    procedure sPlotButtonClick(Sender: TObject);
    procedure sPlotGnuplotClick(Sender: TObject);
    procedure sPlotPopClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
    procedure ShowPlot;
    procedure ShowButtonClick(Sender: TObject);
    procedure StopGnuplotClick(Sender: TObject);
    procedure UndoEditClick(Sender: TObject);
    procedure X11PopClick(Sender: TObject);
    procedure xClearToolButtonClick(Sender: TObject);
    procedure xClearViewClick(Sender: TObject);
    procedure xParamsGnuplotClick(Sender: TObject);
    procedure xPlotButtonClick(Sender: TObject);
    procedure xPlotGnuplotClick(Sender: TObject);

  private
    FDocument: TDocumentState;
    FMsgTimer: TTimer;
    FTrimmingMessages: Boolean;
    procedure MsgTimerTimer(Sender: TObject);

  public

  end;

var
  fMain: TfMain;
  GnuplotThread: TGnuplotThread;
  FileWatcherThread: TFileWatcherThread;




implementation

{$R *.lfm}
procedure TGnuplotThread.Execute;
begin
  FProcess := TConsoleProc.Create(nil);

  try
    FProcess.OnLineCompleted:=@FProcLineCompleted;
    FProcess.Open('gnuplot','');

    FGnuplotPID := FProcess.P.ProcessID;

    FProcess.Loop;

  finally
     FGnuplotPID := 0;

     FProcess.Close;
     FProcess.Free;
     FProcess := nil;
  end;

end;

constructor TGnuplotThread.Create;
begin
  inherited Create(True);

  FString := '';
  FPlotList := TStringList.Create;

  FMemoQueue := TStringList.Create;

  FCriticalSection := TCriticalSection.Create;
  FQueueLock := TCriticalSection.Create;

  Start;
end;

destructor TGnuplotThread.Destroy;
begin
  WaitFor;

  FMemoQueue.Free;
  FQueueLock.Free;

  FCriticalSection.Free;

  inherited Destroy;
end;



procedure TGnuplotThread.FProcLineCompleted(const Line: string);
var
  S: string;
  Lines: TStringList;
  I: Integer;
begin
  S := Trim(Line);

  if Pos('gnuplot>', S) = 1 then
  begin
    FCommand := Trim(Copy(S, Length('gnuplot>') + 1, MaxInt));

    Lines := TStringList.Create;
    try
      Lines.Text := FEditorText;

      for I := 0 to Lines.Count - 1 do
      begin
        if Trim(Lines[I]) = FCommand then
        begin
          FQueueLock.Enter;
          try
            FMemoQueue.Add(
              '[ line ' + IntToStr(I + 1) + ',  ' + FCommand + ' ]'
            );
          finally
            FQueueLock.Leave;
          end;
          Break;
        end;
      end;
    finally
      Lines.Free;
    end;
  end
  else if Pos('line 0:', S) = 1 then
  begin
    S := Trim(Copy(S, Length('line 0:') + 1, MaxInt));

    FQueueLock.Enter;
    try
      if Pos('warning', S) > 0 then
        FMemoQueue.Add(' ');

      FMemoQueue.Add(S);
    finally
      FQueueLock.Leave;
    end;
  end
  else
  begin
    FQueueLock.Enter;
    try
      FMemoQueue.Add(Line);
    finally
      FQueueLock.Leave;
    end;
  end;
end;

procedure TGnuplotThread.FCleanPlotDirectory;
var
  SR: TSearchRec;
begin

  if DirectoryExists(FPlotDirectory) then
     begin
       if FindFirst(FPlotDirectory + '*', faAnyFile, SR) = 0 then
          begin
            repeat
            if (SR.Attr and faDirectory) = 0 then
               DeleteFile(FPlotDirectory + SR.Name);
            until FindNext(SR) <> 0;

            FindClose(SR);
          end;
     end;

end;


procedure TGnuplotThread.SendCommand(const S: string);
begin
  FCriticalSection.Enter;
  try
    FEditorText := S;

    if Assigned(FProcess) then
       begin
       FProcess.SendLn(S);
       //Internal Gnuplot's variables (0 -> success, 1 -> error)
       FProcess.SendLn('print GPVAL_ERRNO');
       //Resets GP_VAL to discard previous values
       FProcess.SendLn('reset error');
       end;

  finally
     FCriticalSection.Leave;
  end;

end;

procedure TGnuplotThread.Stop;
var
  PID: TPid;

begin

  FCriticalSection.Enter;
  try
    PID := FGnuplotPID;
  finally
     FCriticalSection.Leave;
  end;

  if PID > 0 then
     fpKill(PID, SIGINT);

end;


//Retrieve x11 window ID for interactive plot preview
function TGnuplotThread.GetWinID: PtrUInt;
begin
  Result := QWidget_winID(TQtWidget(fMain.X11Panel.Handle).Widget);
end;


procedure TGnuplotThread.DrainMemoQueue(ADestination: TStrings);
begin
  FQueueLock.Enter;
  try
    ADestination.AddStrings(FMemoQueue);
    FMemoQueue.Clear;
  finally
    FQueueLock.Leave;
  end;
end;


{ TfMain }


procedure TfMain.FormCreate(Sender: TObject);
begin
  GnuplotThread := TGnuPlotThread.Create;

  Editor.Font.Quality := fqAntialiased;

  StatusBar1.Panels[1].Text:= 'Line: ' + IntToStr(Editor.CaretY) +
                              ' Col: ' + IntToStr(Editor.CaretX);

  FileWatcherThread := TFileWatcherThread.Create;
  FileWatcherThread.Start;

  FDocument.FileName := '';
  FDocument.Modified := False;

  //Temporary plot folder
  GnuplotThread.FPlotDirectory := IncludeTrailingPathDelimiter(
                    ExtractFilePath(Application.ExeName) + 'GIDEPlots');

  if not DirectoryExists(GnuplotThread.FPlotDirectory) then
     ForceDirectories(GnuplotThread.FPlotDirectory);

  //Auxiliary to the MsgTimerTimer
  FMsgTimer := TTimer.Create(Self);
  FMsgTimer.Interval := 100;
  FMsgTimer.OnTimer := @MsgTimerTimer;
  FMsgTimer.Enabled := True;

  FTrimmingMessages := False;

  //This code opens the .plt or .gp file inside the app if clicked.
  if ParamCount > 0 then
     begin

       if SameText(ExtractFileExt(ParamStr(1)), '.plt') or
          SameText(ExtractFileExt(ParamStr(1)), '.gp') then

          begin
          Editor.Lines.LoadFromFile(ParamStr(1));

          FDocument.FileName := ParamStr(1);
          FDocument.Modified := False;
          Msg.Lines.Add('File opened: ' + FDocument.FileName);
          StatusBar1.Panels[0].Text := ExtractFileName(FDocument.FileName);
          end;
     end;
end;

procedure TfMain.FormDestroy(Sender: TObject);
begin
  FMsgTimer.Enabled := False;

  GnuplotThread.FCleanPlotDirectory;
  GnuplotThread.FPlotList.Free;

  fColor.SaveAppearance;

  if FileExists('SizeCheckLog.txt') then
     DeleteFile('SizeCheckLog.txt');

  //Gnuplot loop must be exited - otherwise, it will leave app hanging.
  GnuplotThread.SendCommand('exit');
  GnuplotThread.Free;
  FileWatcherThread.Free;
end;


procedure TfMain.EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges
  );
begin
  StatusBar1.Panels[1].Text:= 'Line: ' + IntToStr(Editor.CaretY) +
                              ' Col: ' + IntToStr(Editor.CaretX);

end;


procedure TfMain.ExitFileClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.ExternalPopClick(Sender: TObject);
begin
  qPlotButtonClick(Sender);
end;



procedure TfMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  Result: TModalResult;
begin
  if FDocument.Modified then
     begin
       Result := MessageDlg('File Save',
                            'Current file changed. Save changes?',
                            mtConfirmation, [mbYes, mbNo, mbCancel], 0);

       if Result = mrYes then
             SaveFileClick(Sender)
       else if
            Result = mrCancel then
               CloseAction := caNone;
     end;
end;


procedure TfMain.ShowPlot;
Var
  Path: string;
begin
  Path := GnuplotThread.FPlotDirectory + FileWatcherThread.FFileName;

  try
    Preview.Picture.LoadFromFile(Path);

  except
    on E: Exception do
      ShowMessage('The plot could not be displayed.' + LineEnding +
                  'Please check Gnuplot output or try plotting again.');
  end;
end;


procedure TfMain.ShowButtonClick(Sender: TObject);
begin
  ShowPlot;
  PageControl1.ActivePage := tsPNG;
end;

procedure TfMain.StopGnuplotClick(Sender: TObject);
begin
  StopButtonClick(Sender);
end;

procedure TfMain.UndoEditClick(Sender: TObject);
begin
  Editor.Undo;
end;

procedure TfMain.X11PopClick(Sender: TObject);
begin
  xPlotButtonClick(Sender);
end;

procedure TfMain.xClearToolButtonClick(Sender: TObject);
begin
  GnuplotThread.SendCommand('set term x11 reset');
end;

procedure TfMain.xClearViewClick(Sender: TObject);
begin
  xClearToolButtonClick(Sender);
end;

procedure TfMain.xParamsGnuplotClick(Sender: TObject);
begin
  fX11Params.ShowModal;

end;


procedure TfMain.xPlotButtonClick(Sender: TObject);
var
  WinID: PtrUInt;
  IDStr: string;

begin
  if Editor.Text <> '' then
     fMain.Msg.Lines.Add('Interactive plot requested.');

  WinID := GnuplotThread.GetWinID;
  IDStr := Format('0x%x', [WinID]);

  if Editor.Text = '' then
     Exit;


  fX11Params.Params := fX11Params.edXParams.Text;

  GnuplotThread.SendCommand('unset output');
  GnuplotThread.SendCommand('reset');

  GnuplotThread.SendCommand('set terminal x11 reset');

  //Params line sends user set parameters if there are any
  GnuplotThread.SendCommand(FX11Params.Params);

  GnuplotThread.SendCommand('set terminal x11 enhanced background rgb "#aaa9a3" window '
                                 + '"' + IDStr + '"');

  GnuPlotThread.SendCommand(Editor.Text);

  PageControl1.ActivePage := tsX11;

  Editor.SetFocus;

end;

procedure TfMain.xPlotGnuplotClick(Sender: TObject);
begin
  xPlotButtonClick(Sender);
end;

procedure TfMain.MsgTimerTimer(Sender: TObject);
var
  Pending: TStringList;
begin
  Pending := TStringList.Create;
  try
    GnuplotThread.DrainMemoQueue(Pending);

    if Pending.Count = 0 then
      Exit;

    Msg.Lines.BeginUpdate;
    try
      Msg.Lines.AddStrings(Pending);
      //Following two lines keep Memo scrolling.
      Msg.SelStart := Length(Msg.Text);
      Msg.SelLength := 0;
    finally
      Msg.Lines.EndUpdate;
    end;
  finally
    Pending.Free;
  end;
end;



procedure TfMain.ClearButtonClick(Sender: TObject);
begin
  fMain.Msg.Clear;
end;

procedure TfMain.AboutHelpClick(Sender: TObject);
begin
  fAboutIDE.ShowModal;
end;

procedure TfMain.CopyEditClick(Sender: TObject);
begin
  Editor.CopyToClipboard;
end;

procedure TfMain.CopyPopClick(Sender: TObject);
begin
  CopyEditClick(Sender);
end;

procedure TfMain.CutEditClick(Sender: TObject);
begin
  Editor.CutToClipboard;
end;

procedure TfMain.CutPopClick(Sender: TObject);
begin
  CutEditClick(Sender);
end;

procedure TfMain.DelPopClick(Sender: TObject);
begin
  Editor.SelText:= '';
end;

procedure TfMain.edPanelClick(Sender: TObject);
begin

end;


procedure TfMain.eFontsOptionsClick(Sender: TObject);
begin
  eFD.Font := Editor.Font;

  if eFD.Execute then
     Editor.Font := eFD.Font;
end;

procedure TfMain.FindDialog1Find(Sender: TObject);
var
  FindItem: string;
  Encounter: Integer;
  Options: TSynSearchOptions;

begin

  FindItem := FindDialog1.FindText;

  Options := [];

  if not (frDown in FindDialog1.Options) then
     Options += [ssoBackwards];

  if frMatchCase in FindDialog1.Options then
     Options += [ssoMatchCase];

  if frWholeWord in FindDialog1.Options then
     Options += [ssoWholeWord];

  if frEntireScope in FindDialog1.Options then
     Options += [ssoEntireScope];

  Encounter := Editor.SearchReplace(FindItem, '', Options);


  if Encounter = 0 then
      ShowMessage(FindItem + ':  ' +'not found (anymore).')

end;

procedure TfMain.FindEditClick(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TfMain.GitHelpClick(Sender: TObject);
begin
  OpenURL('https://github.com/DiscoCat-Dev/ShinPlot');
end;

procedure TfMain.InsertDataFileClick(Sender: TObject);
begin
  Editor.InsertTextAtCaret('"' + TMenuItem(Sender).Caption + '"');
end;

procedure TfMain.EditorChange(Sender: TObject);
begin
  FDocument.Modified := True;
end;


procedure TfMain.FormShow(Sender: TObject);
begin
  //Colors and font settings (appearance)
  fColor.FEditor := Editor;
  fColor.FMemo := fMain.Msg;
  fColor.LoadAppearance;

  Editor.SetFocus;
end;

procedure TfMain.iClearButtonClick(Sender: TObject);
begin
  Preview.Picture.Clear;
end;

procedure TfMain.imSaveButtonClick(Sender: TObject);
var
  FileName: string;
begin
  FileName := 'saved_' + FileWatcherThread.FFileName;
  Preview.Picture.SaveToFile(FileName);
  fMain.Msg.Lines.Add('Plot saved.');
end;

procedure TfMain.mClearViewClick(Sender: TObject);
begin
  ClearButtonClick(Sender);
end;

procedure TfMain.AppearanceOptionsClick(Sender: TObject);
begin
  fColor.ShowModal;
end;

procedure TfMain.mFontsOptionsClick(Sender: TObject);
begin
  mFD.Font := fMain.Msg.Font;

  if mFD.Execute then
     fMain.Msg.Font := mFD.Font;
end;

procedure TfMain.pClearViewClick(Sender: TObject);
begin
  iClearButtonClick(Sender);
end;

procedure TfMain.pListViewClick(Sender: TObject);
begin
  PlotsButtonClick(Sender);
end;

procedure TfMain.pSaveViewClick(Sender: TObject);
begin
  imSaveButtonClick(Sender);
end;

procedure TfMain.qPlotButtonClick(Sender: TObject);
begin
  if Editor.Text <> '' then
     fMain.Msg.Lines.Add('External plot requested.');

  if Editor.Text = '' then
     Exit;

  GnuplotThread.SendCommand('unset output');
  GnuplotThread.SendCommand('reset');
  GnuplotThread.SendCommand('set terminal qt enhanced');


  GnuPlotThread.SendCommand(Editor.Text);

  Editor.SetFocus;


end;

procedure TfMain.qPlotGnuplotClick(Sender: TObject);
begin
  qPlotButtonClick(Sender);
end;


procedure TfMain.MsgChange(Sender: TObject);
begin
    Msg.Invalidate;

    //clear messages to reduce strain on memory
    if FTrimmingMessages then
       Exit;

    if Msg.Lines.Count < 100 then
       Exit;

       FTrimmingMessages := True;
    try
          Msg.Lines.BeginUpdate;
       try
          while Msg.Lines.Count > 80 do
                Msg.Lines.Delete(0);
       finally
          Msg.Lines.EndUpdate;
       end;
    finally
       FTrimmingMessages := False;
    end;
end;


procedure TfMain.NewFileClick(Sender: TObject);
var
  Result: TModalResult;
begin

  if FDocument.Modified then

     begin
       Result := MessageDlg('Save File',
                            'Current file changed. Save changes?',
                            mtConfirmation, [mbYes, mbNo, mbCancel], 0);

       if Result = mrYes then
          SaveFileClick(Sender)
       else if
          Result = mrCancel then
             Exit;

     end;

  if Editor.Text <> '' then
     Editor.Clear;

  FDocument.FileName := '';
  FDocument.Modified := False;

  fMain.Msg.Lines.Add('New file created.');
  StatusBar1.Panels[0].Text:='untitled file';
end;

procedure TfMain.OpenFileClick(Sender: TObject);
var
  Result : TModalResult;
begin

  if FDocument.Modified then
     begin
       Result := MessageDlg('Save File',
                            'Current file changed. Save changes?',
                            mtConfirmation, [mbYes, mbNo, mbCancel], 0);


       if Result = mrYes then
          SaveFileClick(Sender)
       else if
          Result = mrCancel then
             Exit;
     end;

  if not OD.Execute then
     Exit;

  Editor.Lines.LoadFromFile(OD.FileName);

  FDocument.FileName := OD.FileName;
  FDocument.Modified := False;
  fMain.Msg.Lines.Add('File opened: ' + FDocument.FileName);
  StatusBar1.Panels[0].Text := ExtractFileName(FDocument.FileName);

end;


procedure TfMain.PlotsButtonClick(Sender: TObject);
var
  DisplayList: TStringList;
  I, FirstIndex: Integer;

begin
  DisplayList := TStringList.Create;

  try
    FirstIndex := GnuplotThread.FPlotList.Count - 10;

    if FirstIndex < 0 then
       FirstIndex := 0;

    for I := FirstIndex to GnuplotThread.FPlotList.Count - 1 do

        DisplayList.Add(
           StringReplace(GnuplotThread.FPlotList[I],
                         GnuplotThread.FPlotDirectory, '',
                         [rfReplaceAll]));

    ShowMessage(DisplayList.Text);

  finally
     DisplayList.Free;
  end;

end;

procedure TfMain.ParamsGnuplotClick(Sender: TObject);
begin
  fParams.ShowModal;
end;

procedure TfMain.PasteEditClick(Sender: TObject);
begin
   Editor.PasteFromClipboard();
end;

procedure TfMain.PastePopClick(Sender: TObject);
begin
  PasteEditClick(Sender);
end;

procedure TfMain.PopupMenu1Popup(Sender: TObject);
var
  SR: TSearchRec;
  Item: TMenuItem;
  Dir: string;

begin
  InsertDataFile.Clear;
  InsertDataFile.OnClick:= nil;

  Dir := ExtractFilePath(SD.FileName);

  if FindFirst(Dir + '*.dat', faAnyFile, SR) = 0 then
     begin
       repeat
       if (SR.Attr and faDirectory) = 0 then
          begin
            Item := TMenuItem.Create(PopUpMenu1);
            Item.Caption := SR.Name;
            Item.OnClick := @InsertDataFileClick;
            InsertDataFile.Add(Item);
          end;
       until FindNext(SR) <> 0;
       FindClose(SR);
     end;
end;

procedure TfMain.RedoEditClick(Sender: TObject);
begin
  Editor.Redo;
end;

procedure TfMain.sAllPopClick(Sender: TObject);
begin
  SelectEditClick(Sender);
end;


procedure TfMain.SaveAsFileClick(Sender: TObject);
begin

  if not SD.Execute then
     Exit;

  Editor.Lines.SaveToFile(SD.FileName);

  FDocument.FileName := Sd.FileName;
  FDocument.Modified := False;

  fMain.Msg.Lines.Add('File saved as: ' + SD.FileName);
  StatusBar1.Panels[0].Text := ExtractFileName(FDocument.FileName);

end;

procedure TfMain.SaveFileClick(Sender: TObject);
begin

  if FDocument.FileName <> '' then
     begin
       Editor.Lines.SaveToFile(FDocument.FileName);
       FDocument.Modified := False;
       fMain.Msg.Lines.Add('File saved.');
       StatusBar1.Panels[0].Text := ExtractFileName(FDocument.FileName);
     end
  else
      SaveAsFileClick(Sender);

end;

procedure TfMain.SelectEditClick(Sender: TObject);
begin
  Editor.SelectAll;
end;

procedure TfMain.sLastViewClick(Sender: TObject);
begin
  ShowButtonClick(Sender);
end;



procedure TfMain.sPlotButtonClick(Sender: TObject);
var
  FileName: string;
  sPlotSize: string;
  PlotDirectory: string;

begin
  if Editor.Text <> '' then
     fMain.Msg.Lines.Add('Static plot requested.');

  fParams.PlotHeight := Preview.ClientHeight;
  fParams.PlotWidth := Preview.ClientWidth;
  //These two lines update plot size as client window size changes
  sPlotSize := Format('set terminal pngcairo enhanced size %d,%d',
           [fParams.PlotWidth, fParams.PlotHeight]);


  fParams.edPNGParams.Lines.Add(sPlotSize);


  if Editor.Text = '' then
     Exit;

  PlotDirectory := GnuplotThread.FPlotDirectory;

  FileWatcherThread.FFileName := 'plot_' + FormatDateTime('mm_dd_z', Now) + '.png';

  FileName := PlotDirectory + FileWatcherThread.FFileName;

  GnuplotThread.FPlotList.Add(FileName);


  fParams.edPNGParams.Lines.Add('set output "'+ FileName + '"');
  //pmEditor of fparams must be updated
  fParams.Params := fParams.edPNGParams.Text;

  GnuplotThread.SendCommand('reset');

    if fParams.edPNGParams.Lines.Count > 1 then
     begin
       fParams.edPNGParams.Lines.Delete(fParams.edPNGParams.Lines.Count - 1);
       fParams.edPNGParams.Lines.Delete(fParams.edPNGParams.Lines.Count - 1);
     end;


  GnuplotThread.SendCommand(fParams.Params);
  GnuplotThread.SendCommand(Editor.Text);

  PageControl1.ActivePage := tsPNG;
  Editor.SetFocus;

end;

procedure TfMain.sPlotGnuplotClick(Sender: TObject);
begin
  sPlotButtonClick(Sender);
end;

procedure TfMain.sPlotPopClick(Sender: TObject);
begin
  sPlotButtonClick(Sender);
end;


procedure TfMain.StopButtonClick(Sender: TObject);
begin
  GnuplotThread.Stop;
  fMain.Msg.Lines.Add('Stop signal requested.');
end;

{TFileWatcherThread}

procedure TFileWatcherThread.Execute;
var
  Size1, Size2: Int64;
  SR: TSearchRec;
  LogFile: TextFile;
  PlotDirectory: string;

begin

  PlotDirectory := GnuplotThread.FPlotDirectory;

  //Completion of plot generation is checked by tracing its size
  AssignFile(LogFile, 'SizeCheckLog.txt');
  Rewrite(LogFile);
  try
  while not Terminated do
        begin
          if (FFileName <> '') and (FLastFileName <> FFileName) then
             begin

               Repeat
                 if FindFirst(PlotDirectory + FFileName, faAnyFile, SR) = 0 then
                    begin
                    Size1 := SR.Size;
                    FindClose(SR);
                    end
                 else
                     Size1 := 0;

               Sleep(100);

               if FindFirst(PlotDirectory + FFileName, faAnyFile, SR) = 0 then
                  begin
                  Size2 := SR.Size;
                  FindClose(SR);
                  end
               else
                   Size2 := 0;

               Writeln(LogFile, 'Size1 = ', Size1, ' Size2 = ', Size2);
               Flush(LogFile);

               until Terminated or ((Size1 > 0) and (Size1 = Size2));

               if Terminated then
                  Break;

               FLastFileName := FFileName;

               Queue(@fMain.ShowPlot);


               end;
          Sleep(100);
        end;
  finally
     Close(LogFile);

  end;

end;


constructor TFileWatcherThread.Create;
begin
  inherited Create(True);
end;

destructor TFileWatcherThread.Destroy;
begin
  Terminate;

  if Assigned(FProcess) then
     FProcess.Close;

  WaitFor;
  inherited Destroy;
end;


end.

