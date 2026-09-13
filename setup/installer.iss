; M6.3 Inno Setup 安装器（Inno Setup 6+）
; 构建：先 setup\build.ps1（产 wheel+wheels），再 ISCC setup\installer.iss
; 定位：免管理员、装到用户目录、断网可装（离线 wheels）、后置模型下载
#define AppName "PAI-Station"
#define AppVersion "1.0.0"
#define AppPublisher "PAI-Station"

[Setup]
AppId={{8F3B9C2A-PAI1-4AIO-STAT1-ON0000000001}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
; 应用装 {localappdata}\PAI-Station\app；数据在 {localappdata}\PAI-Station
; （数据目录=config 默认值，卸载 app 不碰数据——用户记忆神圣）
DefaultDirName={localappdata}\{#AppName}\app
PrivilegesRequired=lowest
OutputBaseFilename=PAI-Station-Setup-{#AppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64compatible
WizardStyle=modern

[Files]
; 装后脚本自身
Source: "postinstall.ps1"; DestDir: "{app}\setup"; Flags: ignoreversion
; 应用 wheel 与离线依赖（build.ps1 产物）
Source: "..\dist\paistation-*.whl"; DestDir: "{app}\dist"; Flags: ignoreversion
Source: "..\setup\wheels\*"; DestDir: "{app}\wheels"; Flags: ignoreversion recursesubdirs
; 源码兜底（venv 直装模式）与配置样例
Source: "..\src\*"; DestDir: "{app}\src"; Flags: ignoreversion recursesubdirs
Source: "..\config\pai.ini"; DestDir: "{app}\config"; Flags: ignoreversion onlyifdoesnotexist
Source: "..\scripts\fetch_bge_m3.py"; DestDir: "{app}\scripts"; Flags: ignoreversion
Source: "..\scripts\install_service.ps1"; DestDir: "{app}\scripts"; Flags: ignoreversion
Source: "..\scripts\uninstall_service.ps1"; DestDir: "{app}\scripts"; Flags: ignoreversion

[Run]
; 装后：离线 venv + doctor 自检（postinstall.ps1）
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\setup\postinstall.ps1"" -AppDir ""{app}"""; \
  WorkingDir: "{app}"; Flags: runhidden postinstall; Description: "完成安装自检"
; 首启向导（3 步：档位/大脑/授权）+ 托盘
Filename: "{app}\.venv\Scripts\pythonw.exe"; Parameters: "-X utf8 -m paistation --gui"; \
  Flags: nowait postinstall skipifsilent unchecked; Description: "启动 PAI-Station 托盘"

[UninstallRun]
; 卸载前停服务（WinSW 卸载脚本存在才执行）
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -File ""{app}\scripts\uninstall_service.ps1"""; \
  WorkingDir: "{app}"; Flags: runhidden; RunOnceId: "UninstService"

[UninstallDelete]
; 数据目录（%LOCALAPPDATA%\PAI-Station 数据）不删——用户记忆神圣，卸载不碰
Type: filesandordirs; Name: "{app}\.venv"
