; RXD - MODPACK AUTO-INSTALLER SCRIPT.

#define MyAppName "RXD - MODPACK - Steam"
#define MyAppVersion "2.5"
#define MyAppPublisher "RXD - MODS"
#define MyAppURL "https://rxd-mods.xyz/rxd-modpack"
#define MyAppExeName "wotblitz.exe"
#define BlitzExe "World of Tanks Blitz"
#define WinverInfo "2.5"

[Setup]
; NOTE: The value of AppId uniquely identifies this application. Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{76DF5EEC-FF6E-4D4F-8EEC-72F1C45BF355}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
VersionInfoVersion={#WinverInfo}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
AppendDefaultDirName=no
DefaultDirName=C:\Program Files (x86)\Steam\steamapps\common\World of Tanks Blitz
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
; Uncomment the following line to run in non administrative install mode (install for current user only.)
;PrivilegesRequired=lowest
OutputDir=D:\Github\RXD-MODPACK-PROJ
OutputBaseFilename=rxd-modpack-autoinstaller-steam
SetupIconFile=D:\Github\RXD-MODPACK-PROJ\docs\RxD.ico
Compression=lzma
SolidCompression=yes
WizardStyle=modern
WizardImageFile=D:\Github\RXD-MODPACK-PROJ\docs\RXD_Banner_V.bmp

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "armenian"; MessagesFile: "compiler:Languages\Armenian.isl"
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"
Name: "bulgarian"; MessagesFile: "compiler:Languages\Bulgarian.isl"
Name: "catalan"; MessagesFile: "compiler:Languages\Catalan.isl"
Name: "corsican"; MessagesFile: "compiler:Languages\Corsican.isl"
Name: "czech"; MessagesFile: "compiler:Languages\Czech.isl"
Name: "danish"; MessagesFile: "compiler:Languages\Danish.isl"
Name: "dutch"; MessagesFile: "compiler:Languages\Dutch.isl"
Name: "finnish"; MessagesFile: "compiler:Languages\Finnish.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "hebrew"; MessagesFile: "compiler:Languages\Hebrew.isl"
Name: "icelandic"; MessagesFile: "compiler:Languages\Icelandic.isl"
Name: "italian"; MessagesFile: "compiler:Languages\Italian.isl"
Name: "japanese"; MessagesFile: "compiler:Languages\Japanese.isl"
Name: "norwegian"; MessagesFile: "compiler:Languages\Norwegian.isl"
Name: "polish"; MessagesFile: "compiler:Languages\Polish.isl"
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"
Name: "slovak"; MessagesFile: "compiler:Languages\Slovak.isl"
Name: "slovenian"; MessagesFile: "compiler:Languages\Slovenian.isl"
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"
Name: "turkish"; MessagesFile: "compiler:Languages\Turkish.isl"
Name: "ukrainian"; MessagesFile: "compiler:Languages\Ukrainian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "{tmp}\*"; DestDir: "{app}"; Flags: external deleteafterinstall
Source: "D:\Github\RXD-MODPACK-PROJ\docs\7za.exe"; DestDir: "{app}"; Flags: deleteafterinstall
Source: "C:\Program Files (x86)\The Road To Delphi\VCL Styles Inno\VclStylesinno.dll"; DestDir: {app}; Flags: dontcopy
Source: "C:\Program Files (x86)\The Road To Delphi\VCL Styles Inno\Styles\AquaGraphite.vsf"; DestDir: {app}; Flags: dontcopy
Source: "D:\Github\RXD-MODPACK-PROJ\docs\RXD_Banner_H.bmp"; DestDir: {app}; Flags: dontcopy

// Code for Custom Themes
 
[Code]
// Import the LoadVCLStyle function from VclStylesInno.DLL
procedure LoadVCLStyle(VClStyleFile: String); external 'LoadVCLStyleW@files:VclStylesInno.dll stdcall';
// Import the UnLoadVCLStyles function from VclStylesInno.DLL
procedure UnLoadVCLStyles; external 'UnLoadVCLStyles@files:VclStylesInno.dll stdcall';
 
function InitializeSetup(): Boolean;
begin
  ExtractTemporaryFile('AquaGraphite.vsf');
  LoadVCLStyle(ExpandConstant('{tmp}\AquaGraphite.vsf'));
  Result := True;
end;
 
procedure DeinitializeSetup();
begin
  UnLoadVCLStyles;
end;


[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Code]
var
  DownloadPage: TDownloadWizardPage;

function OnDownloadProgress(const Url, FileName: String; const Progress, ProgressMax: Int64): Boolean;
begin
  if Progress = ProgressMax then
    Log(Format('Successfully downloaded file to {tmp}: %s', [FileName]));
  Result := True;
end;

procedure InitializeWizard;
  var
  BitmapImage: TBitmapImage;
begin
  ExtractTemporaryFile('RXD_Banner_H.bmp');
  BitmapImage := TBitmapImage.Create(WizardForm);
  BitmapImage.Parent := WizardForm.MainPanel;
  BitmapImage.Width := WizardForm.MainPanel.Width;
  BitmapImage.Height := WizardForm.MainPanel.Height;
  { Needed for WizardStyle=modern in Inno Setup 6. Must be removed in Inno Setup 5. }
  BitmapImage.Anchors := [akLeft, akTop, akRight, akBottom];
  BitmapImage.Stretch := True;
  BitmapImage.AutoSize := False;
  BitmapImage.Bitmap.LoadFromFile(ExpandConstant('{tmp}\RXD_Banner_H.bmp'));
  
  WizardForm.WizardSmallBitmapImage.Visible := False;
  WizardForm.PageDescriptionLabel.Visible := False;
  WizardForm.PageNameLabel.Visible := False;
  DownloadPage := CreateDownloadPage(SetupMessage(msgWizardPreparing), SetupMessage(msgPreparingDesc), @OnDownloadProgress);
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
    Result := True;
    if (CurPageId = wpSelectDir) and not FileExists(ExpandConstant('{app}\wotblitz.exe')) then begin
        MsgBox('World of Tanks Blitz does not seem to be installed in that folder.  Please select the correct folder.', mbError, MB_OK);
        Result := False;
        exit;
    end;
  if CurPageID = wpReady then begin
    DownloadPage.Clear;
    DownloadPage.Add('https://github.com/RifsxD/RXD-MODPACK-PROJ/releases/latest/download/rxd-modpack-steam.zip', 'rxd.zip', '');
    DownloadPage.Show;
    try
      try
        DownloadPage.Download; // This downloads the files to {tmp}
        Result := True;
      except
        if DownloadPage.AbortedByUser then
          Log('Aborted by user.')
        else
          SuppressibleMsgBox(AddPeriod(GetExceptionMessage), mbCriticalError, MB_OK, IDOK);
        Result := False;
      end;
    finally
      DownloadPage.Hide;
    end;
  end else
    Result := True;
end;

[Run]
Filename: "{app}\7za.exe"; Parameters: "x ""{app}\rxd.zip"" -o""{app}\"" * -r -aoa"; Flags: runhidden runascurrentuser;
Filename: "{app}\{#MyAppExeName}"; Description: "{cm:LaunchProgram,{#StringChange(BlitzExe, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

