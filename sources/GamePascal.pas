{ ===========================================================================
   ___                       ___                    _ ™
  / _ \__ _ _ __ ___   ___  / _ \__ _ ___  ___ __ _| |
 / /_\/ _` | '_ ` _ \ / _ \/ /_)/ _` / __|/ __/ _` | |
/ /_\\ (_| | | | | | |  __/ ___/ (_| \__ \ (_| (_| | |
\____/\__,_|_| |_| |_|\___\/    \__,_|___/\___\__,_|_|
                     Toolkit

Copyright © 2022-present tinyBigGAMES™ LLC
All Rights Reserved.

Website: https://tinybiggames.com
Email  : support@tinybiggames.com

See LICENSE for license agreement
See README for latest news
============================================================================ }

{$IFDEF FPC}
  {$MODE DELPHIUNICODE}
{$ENDIF}

{$Z4}
{$A8}

{$IFNDEF WIN64}
  {$MESSAGE Error 'Unsupported platform'}
{$ENDIF}

unit GamePascal;

interface

//=== COMMON ================================================================
const
  GPL_DLL = 'GPL.dll';

  PASEXT  = 'pas';
  LOGEXT  = 'log';
  PNGEXT  = 'png';
  OGGEXT  = 'ogg';
  INIEXT  = 'ini';
  ARCEXT  = 'arc';
  MPGEXT  = 'mpg';

  CR = #10;
  LF = #13;
  CRLF = CR+LF;

type
  TBuffer      = type Pointer;
  TCompiler    = type Pointer;
  TArchiveFile = type Pointer;
  TArchive     = type Pointer;
  TFont        = type Pointer;
  TTexture     = type Pointer;
  TStarfield   = type Pointer;
  TPolygon     = type Pointer;
  TSprite      = type Pointer;
  TEntity      = type Pointer;

  TBlendMode = (bmNone=0, bmBlend=1, bmAdd=2, bmMod=4, bmMul=8, bmInvalid=2147483647);

  THAlign = (haLeft, haCenter, haRight);

  TVAlign = (vaTop, vaCenter, vaBottom);


//=== COMPILER ==============================================================
type
  TCompilerErrorType = (etError, etWarning);

  TCompilerMessageEvent = procedure(aSender: Pointer; aMsg: WideString);

/// Create a new compiler instance
function  CompilerNew: TCompiler; external GPL_DLL;
procedure CompilerFree(var aCompiler: TCompiler); external GPL_DLL;
procedure CompilerReset(aCompiler: TCompiler); external GPL_DLL;
procedure CompilerSetOnMessage(aCompiler: TCompiler; aSender: Pointer; aHandler: TCompilerMessageEvent); external GPL_DLL;
function  CompilerGetOnMessage(aCompiler: TCompiler): TCompilerMessageEvent; external GPL_DLL;
procedure CompilerAddToSearchPath(aCompiler: TCompiler; aPath: WideString); external GPL_DLL;
procedure CompilerAddSearchPaths(aCompiler: TCompiler; aPaths: WideString); external GPL_DLL;
procedure CompilerClearSearchPaths(aCompiler: TCompiler); external GPL_DLL;
function  CompilerGetSearchPathCount(aCompiler: TCompiler): Integer; external GPL_DLL;
function  CompilerGetSearchPath(aCompiler: TCompiler; aIndex: Integer): WideString; external GPL_DLL;
function  CompilerLocateFileInSearchPath(aCompiler: TCompiler; aFilename: WideString): WideString; external GPL_DLL;
procedure CompilerSetInputFile(aCompiler: TCompiler; aFilename: WideString); external GPL_DLL;
procedure CompilerSetOutputPath(aCompiler: TCompiler; aPath: WideString); external GPL_DLL;
procedure CompilerSetConsoleApp(aCompiler: TCompiler; aConsoleApp: Boolean); external GPL_DLL;
procedure CompilerSetDebugMode(aCompiler: TCompiler; aDebugMode: Boolean); external GPL_DLL;
procedure CompilerSetExeIcon(aCompiler: TCompiler; aFilename: WideString); external GPL_DLL;
procedure CompilerSetAddVersionInfo(aCompiler: TCompiler; aAddVersionInfo: Boolean); external GPL_DLL;
procedure CompilerSetVersionInfo(aCompiler: TCompiler; aCompanyName, aFileVersion, aFileDescription, aInternalName, aLegalCopyright, aLegalTrademarks, aOriginalFilename, aProductName, aProductVersion, aComments: WideString); external GPL_DLL;
function  CompilerLoadVersionInfo(aCompiler: TCompiler; aFilename: WideString): Boolean; external GPL_DLL;
function  CompilerSaveVersionInfo(aCompiler: TCompiler; aFilename: WideString): Boolean; external GPL_DLL;
function  CompilerCompile(aCompiler: TCompiler): Boolean; external GPL_DLL;
function  CompilerGetOutputModule(aCompiler: TCompiler): WideString; external GPL_DLL;
function  CompilerGetErrorCount(aCompiler: TCompiler; aType: TCompilerErrorType): Integer; external GPL_DLL;
function  CompilerGetErrorMessage(aCompiler: TCompiler; aIndex: Integer; var aFilename: WideString; var aLine: Integer; var aPos: Integer; var aMsg: WideString; aType: TCompilerErrorType): Boolean; external GPL_DLL;
function  CompilerCodeCompletion(aCompiler: TCompiler; aCode: WideString; aX, aY: Integer): Boolean; external GPL_DLL;
function  CompilerGetCodeCompletionTypeName(aCompiler: TCompiler): WideString; external GPL_DLL;
function  CompilerGetCodeCompletionCount(aCompiler: TCompiler): Integer; external GPL_DLL;
function  CompilerGetCodeCompletionItem(aCompiler: TCompiler; aIndex: Integer): WideString; external GPL_DLL;
function  CompilerFindDeclaration(aCompiler: TCompiler; aCode: WideString; aX, aY: Integer): WideString; external GPL_DLL;

//=== CMDLINE ===============================================================
procedure CmdLineReset; external GPL_DLL;
procedure CmdLineClear; external GPL_DLL;
procedure CmdLineAddParam(aParam: WideString); external GPL_DLL;
function  CmdLineStr: WideString; external GPL_DLL;
function  CmdLineCount: Integer; external GPL_DLL;
function  CmdLineParamCount(aName: WideString): Integer; external GPL_DLL;
function  CmdLineParam(aIndex: Integer): WideString; external GPL_DLL;
function  CmdLineParamParam(aName: WideString; aIndex: Integer): WideString; external GPL_DLL;
function  CmdLineParamIndex(aName: WideString): Integer; external GPL_DLL;
function  CmdLineParamExist(aName: WideString): Boolean; external GPL_DLL;
function  CmdLineParamValue(aName: WideString; var aValue: WideString): Boolean; external GPL_DLL;

//=== CONSOLE ===============================================================
procedure ConsolePrint(aText: WideString); external GPL_DLL;
procedure ConsolePrintLn(aText: WideString); external GPL_DLL;
procedure ConsolePrintva(aMsg: string; aArgs: array of const);
procedure ConsolePrintLnva(aMsg: string; aArgs: array of const);
function  ConsoleExist: Boolean; external GPL_DLL;
function  ConsoleAtStartup: Boolean; external GPL_DLL;
procedure ConsoleWaitForAnyKey; external GPL_DLL;
procedure ConsolePause(aPrompt: WideString=''); external GPL_DLL;

//=== VIRTUAL ===============================================================
function  VirtualCreateDir(aPath: WideString): Boolean; external GPL_DLL;
function  VirtualForceDirs(aPath: WideString): Boolean; external GPL_DLL;
function  VirtualCreateFile(aFilename: WideString): Boolean; external GPL_DLL;
function  VirtualDeleteFile(aFilename: WideString): Boolean; external GPL_DLL;
function  VirtualAllocMem(aSize: Cardinal): Pointer; external GPL_DLL;
function  VirtualFreeMem(aData: Pointer): Boolean; external GPL_DLL;

//=== BUFFER ================================================================
function  BufferFromFile(aFilename: WideString): TBuffer; external GPL_DLL;
function  BufferNew(aSize: Cardinal): TBuffer; external GPL_DLL;
procedure BufferFree(var aBuffer: TBuffer); external GPL_DLL;
function  BufferMemory(aBuffer: TBuffer): Pointer; external GPL_DLL;
function  BufferSize(aBuffer: TBuffer): Int64; external GPL_DLL;
function  BufferGetPosition(aBuffer: TBuffer): Int64; external GPL_DLL;
procedure BufferSetPosition(aBuffer: TBuffer; aPosition: Int64); external GPL_DLL;
function  BufferEOF(aBuffer: TBuffer): Boolean; external GPL_DLL;
function  BufferWrite(aBuffer: TBuffer; aData: Pointer; aCount: Cardinal): Cardinal; external GPL_DLL;
function  BufferRead(aBuffer: TBuffer; aData: Pointer; aCount: Cardinal): Cardinal; external GPL_DLL;
function  BufferSaveToFile(aBuffer: TBuffer; aFilename: WideString): Boolean; external GPL_DLL;

//=== ARCHIVEFILE ===========================================================
procedure ArchiveFileFree(var aArchiveFile: TArchiveFile); external GPL_DLL;
function  ArchiveFileIsOpen(aArchiveFile: TArchiveFile): Boolean; external GPL_DLL;
function  ArchiveFileSize(aArchiveFile: TArchiveFile): Int64; external GPL_DLL;
function  ArchiveFileGetPosition(aArchiveFile: TArchiveFile): Int64; external GPL_DLL;
function  ArchiveFileSetPosition(aArchiveFile: TArchiveFile; aPos: Int64): Int64; external GPL_DLL;
function  ArchiveFileRead(aArchiveFile: TArchiveFile; aBuffer: Pointer; aCount: NativeInt): NativeInt; external GPL_DLL;
function  ArchiveFileSaveToFile(aArchiveFile: TArchiveFile; aFilename: WideString): Boolean; external GPL_DLL;
function  ArchiveFileSaveToBuffer(aArchiveFile: TArchiveFile): TBuffer; external GPL_DLL;

//=== ARCHIVE ===============================================================
type
  TArchiveBuildProgressEvent = procedure(aSender: Pointer; aFilename: WideString; aProgress: Integer);

function  ArchiveNew: TArchive; external GPL_DLL;
procedure ArchiveFree(var aArchive: TArchive); external GPL_DLL;
function  ArchiveOpen(aArchive: TArchive; aPassword, aFilename: WideString): Boolean; external GPL_DLL;
function  ArchiveOpenRes(aArchive: TArchive; aPassword, aResName: WideString; aInstance: THandle): Boolean; external GPL_DLL;
function  ArchiveIsOpen(aArchive: TArchive): Boolean; external GPL_DLL;
procedure ArchiveClose(aArchive: TArchive); external GPL_DLL;
function  ArchiveFileExist(aArchive: TArchive; aFilename: WideString): Boolean; external GPL_DLL;
function  ArchiveBuild(aPassword, aFilename, aFolder: WideString; aSender: Pointer; aHandler: TArchiveBuildProgressEvent): Boolean; external GPL_DLL;

//=== MATH ==================================================================
const
  RADTODEG = 180.0 / PI;
  DEGTORAD = PI / 180.0;
  EPSILON  = 0.00001;
  NAN      =  0.0 / 0.0;

type
  TLineIntersection = (liNone, liTrue, liParallel);

  TEaseType = (etLinearTween, etInQuad, etOutQuad, etInOutQuad, etInCubic,
    etOutCubic, etInOutCubic, etInQuart, etOutQuart, etInOutQuart, etInQuint,
    etOutQuint, etInOutQuint, etInSine, etOutSine, etInOutSine, etInExpo,
    etOutExpo, etInOutExpo, etInCircle, etOutCircle, etInOutCircle);

  PRange = ^TRange;
  TRange = record
    MinX, MinY, MaxX, MaxY: Single;
  end;

  PVector = ^TVector;
  TVector = record
    X,Y,Z,W: Single;
  end;

  PPoint = ^TPoint;
  TPoint = record
    X,Y,Z: Single;
  end;

  PRect = ^TRect;
  TRect = record
    X, Y, Width,Height: Single;
  end;

procedure VectorClear(var aVector: TVector); external GPL_DLL;
procedure VectorAdd(var aVector: TVector; aTo: TVector); external GPL_DLL;
procedure VectorSubtract(var aVector: TVector; aFrom: TVector); external GPL_DLL;
procedure VectorMultiply(var aVector: TVector; aBy: TVector); external GPL_DLL;
procedure VectorDivide(var aVector: TVector; aBy: TVector); external GPL_DLL;
function  VectorMagnitude(aVector: TVector): Single; external GPL_DLL;
function  VectorMagnitudeTruncate(aVector: TVector; aMaxMagitude: Single): TVector; external GPL_DLL;
function  VectorDistance(aSrc, aDest: TVector): Single; external GPL_DLL;
procedure VectorNormalize(var aVector: TVector); external GPL_DLL;
function  VectorAngle(aSrc, aDest: TVector): Single; external GPL_DLL;
procedure VectorThrust(var aVector: TVector; aAngle, aSpeed: Single); external GPL_DLL;
function  VectorMagnitudeSquared(aVector: TVector): Single; external GPL_DLL;
function  VectorDotProduct(aSrc, aDest: TVector): Single; external GPL_DLL;
procedure VectorScale(var aVector: TVector; aValue: Single); external GPL_DLL;
procedure VectorDivideBy(var aVector: TVector; aValue: Single); external GPL_DLL;
function  VectorProject(aVector, aBy: TVector): TVector; external GPL_DLL;
procedure VectorNegate(var aVector: TVector); external GPL_DLL;

function  AngleCos(aAngle: Cardinal): Single; external GPL_DLL;
function  AngleSin(aAngle: Cardinal): Single; external GPL_DLL;

function  RandomRange(aMin, aMax: Integer): Integer; external GPL_DLL;
function  RandomRangef(aMin, aMax: Single): Single; external GPL_DLL;
function  RandomBool: Boolean; external GPL_DLL;

function  GetRandomSeed: Integer; external GPL_DLL;
procedure SetRandomSeed(aVaLue: Integer); external GPL_DLL;

function  ClipVaLuef(var aVaLue: Single; aMin, aMax: Single; aWrap: Boolean): Single; external GPL_DLL;
function  ClipVaLue(var aVaLue: Integer; aMin, aMax: Integer; aWrap: Boolean): Integer; external GPL_DLL;

function  SameSign(aVaLue1, aVaLue2: Integer): Boolean; external GPL_DLL;
function  SameSignf(aVaLue1, aVaLue2: Single): Boolean; external GPL_DLL;
function  SameVaLue(aA, aB: Double; aEpsilon: Double = 0): Boolean; external GPL_DLL;
function  SameVaLuef(aA, aB: Single; aEpsilon: Single = 0): Boolean; external GPL_DLL;

function  AngleDiff(aSrcAngle, aDestAngle: Single): Single; external GPL_DLL;
procedure AngleRotatePos(aAngle: Single; var aX, aY: Single); external GPL_DLL;

procedure SmoothMove(var aVaLue: Single; aAmount, aMax, aDrag: Single); external GPL_DLL;

function  Lerp(aFrom, aTo, aTime: Double): Double; external GPL_DLL;

function  PointInRectangle(aPoint: TVector; aRect: TRect): Boolean; external GPL_DLL;
function  PointInCircle(aPoint, aCenter: TVector; aRadius: Single): Boolean; external GPL_DLL;
function  PointInTriangle(aPoint, aP1, aP2, aP3: TVector): Boolean; external GPL_DLL;

function  CirclesOverlap(aCenter1: TVector; aRadius1: Single; aCenter2: TVector; aRadius2: Single): Boolean; external GPL_DLL;
function  CircleInRectangle(aCenter: TVector; aRadius: Single; aRect: TRect): Boolean; external GPL_DLL;

function  RectanglesOverlap(aRect1: TRect; aRect2: TRect): Boolean; external GPL_DLL;
function  RectangleIntersection(aRect1, aRect2: TRect): TRect; external GPL_DLL;

function  LineIntersection(aX1, aY1, aX2, aY2, aX3, aY3, aX4, aY4: Integer; var aX: Integer; var aY: Integer): TLineIntersection; external GPL_DLL;

function  RadiusOverlap(aRadius1, aX1, aY1, aRadius2, aX2, aY2, aShrinkFactor: Single): Boolean; external GPL_DLL;

function  EaseValue(aCurrentTime: Double; aStartValue: Double; aChangeInValue: Double; aDuration: Double; aEaseType: TEaseType): Double; external GPL_DLL;
function  EasePosition(aStartPos: Double; aEndPos: Double; aCurrentPos: Double; aEaseType: TEaseType): Double; external GPL_DLL;

//=== AUDIO =================================================================
const
  AUDIO_ERROR           = -1;
  AUDIO_MUSIC_COUNT     = 256;
  AUDIO_SOUND_COUNT     = 256;
  AUDIO_CHANNEL_COUNT   = 16;
  AUDIO_CHANNEL_DYNAMIC = -2;

function  AudioLoadMusic(aArchive: TArchive; aFilename: WideString): Integer; external GPL_DLL;
procedure AudioUnloadMusic(var aMusic: Integer); external GPL_DLL;
function  AudioPlayMusic(aMusic: Integer; aVolume: Single; aLoop: Boolean): Boolean; external GPL_DLL;
function  AudioMusicPlaying(aMusic: Integer): Boolean; external GPL_DLL;
procedure AudioStopMusic(aMusic: Integer); external GPL_DLL;
procedure AudioSetMusicVolume(aMusic: Integer; aVolume: Single); external GPL_DLL;
function  AudioGetMusicVolume(aMusic: Integer): Single; external GPL_DLL;
procedure AudioSetMusicLoop(aMusic: Integer; aLoop: Boolean); external GPL_DLL;
function  AudioGetMusicLoop(aMusic: Integer): Boolean; external GPL_DLL;
function  AudioGetMusicLength(aMusic: Integer; var aSeconds: Single): Boolean; external GPL_DLL;
function  AudioGetMusicPosition(aMusic: Integer; var aSeconds: Single): Boolean; external GPL_DLL;
procedure AudioRewindMusic(aMusic: Integer); external GPL_DLL;

function  AudioLoadSound(aArchive: TArchive; aFilename: WideString): Integer; external GPL_DLL;
procedure AudioUnloadSound(var aSound: Integer); external GPL_DLL;
function  AudioPlaySound(aSound, aChannel: Integer; aVolume: Single; aLoop: Boolean): Integer; external GPL_DLL;

procedure AudioReserveChannel(aChannel: Integer; aReserve: Boolean); external GPL_DLL;
procedure AudioStopChannel(aChannel: Integer); external GPL_DLL;
procedure AudioSetChannelVolume(aChannel: Integer; aVolume: Single); external GPL_DLL;
function  AudioGetChannelVolume(aChannel: Integer): Single; external GPL_DLL;
procedure AudioSetChannelPosition(aChannel: Integer; aX, aY: Single); external GPL_DLL;
procedure AudioSetchannelLoop(aChannel: Integer; aLoop: Boolean); external GPL_DLL;
function  AudioGetchannelLoop(aChannel: Integer): Boolean; external GPL_DLL;

//=== UTILS =================================================================
function  Format(aMsg: string; aArgs: array of const): string;
function  DebuggerDetected: Boolean; external GPL_DLL;
function  GetVersionInfo(aInstance: THandle; aIdent: WideString): WideString; external GPL_DLL;
function  GetVersionInfoFromFile(aFilename, aIdent: WideString): WideString; external GPL_DLL;
function  GetSemVersion(aInstance: THandle): WideString; external GPL_DLL;
function  GetSemVersionFromFile(aFilename: WideString): WideString; external GPL_DLL;
function  GetFileExt(aFilename: WideString): WideString; external GPL_DLL;
function  ChangeFileExt(aFilename, aExt: WideString): WideString; external GPL_DLL;
function  GetFileName(aPath: WideString): WideString; external GPL_DLL;
function  DirExist(aPath: WideString): Boolean; external GPL_DLL;
function  FileExist(aFilename: WideString): Boolean; external GPL_DLL;
function  StrRemoveQuotes(aText: WideString): WideString; external GPL_DLL;
function  IsKeyDown(aVirtualKeyCode: Integer): Boolean; external GPL_DLL;
function  WasKeyPressed(aVirtualKeyCode: Integer): Boolean; external GPL_DLL;
function  AnyKeyPressed: Boolean; external GPL_DLL;
procedure ShellOpen(aFilename, aParams, aDir: PUTF8Char); external GPL_DLL;

//=== COLOR =================================================================
type
  PColor = ^TColor;
  TColor = record
    Red, Green, Blue,Alpha: Byte;
  end;

function  ColorMake(aRed, aGreen, aBlue, aAlpha: Byte): TColor; external GPL_DLL;
function  ColorMakef(aRed, aGreen, aBlue, aAlpha: Single): TColor; external GPL_DLL;
function  ColorFade(aFrom, aTo: TColor; aPos: Single): TColor; external GPL_DLL;
function  ColorEqual(aColor1, aColor2: TColor): Boolean; external GPL_DLL;
procedure ColorClear(var aColor: TColor); external GPL_DLL;

{$REGION ' Common Colors '}
const
  ALICEBLUE           : TColor = (Red:$F0; Green:$F8; BLue:$FF; Alpha:$FF);
  ANTIQUEWHITE        : TColor = (Red:$FA; Green:$EB; BLue:$D7; Alpha:$FF);
  AQUA                : TColor = (Red:$00; Green:$FF; BLue:$FF; Alpha:$FF);
  AQUAMARINE          : TColor = (Red:$7F; Green:$FF; BLue:$D4; Alpha:$FF);
  AZURE               : TColor = (Red:$F0; Green:$FF; BLue:$FF; Alpha:$FF);
  BEIGE               : TColor = (Red:$F5; Green:$F5; BLue:$DC; Alpha:$FF);
  BISQUE              : TColor = (Red:$FF; Green:$E4; BLue:$C4; Alpha:$FF);
  BLACK               : TColor = (Red:$00; Green:$00; BLue:$00; Alpha:$FF);
  BLANCHEDALMOND      : TColor = (Red:$FF; Green:$EB; BLue:$CD; Alpha:$FF);
  BLUE                : TColor = (Red:$00; Green:$00; BLue:$FF; Alpha:$FF);
  BLUEVIOLET          : TColor = (Red:$8A; Green:$2B; BLue:$E2; Alpha:$FF);
  BROWN               : TColor = (Red:$A5; Green:$2A; BLue:$2A; Alpha:$FF);
  BURLYWOOD           : TColor = (Red:$DE; Green:$B8; BLue:$87; Alpha:$FF);
  CADETBLUE           : TColor = (Red:$5F; Green:$9E; BLue:$A0; Alpha:$FF);
  CHARTREUSE          : TColor = (Red:$7F; Green:$FF; BLue:$00; Alpha:$FF);
  CHOCOLATE           : TColor = (Red:$D2; Green:$69; BLue:$1E; Alpha:$FF);
  CORAL               : TColor = (Red:$FF; Green:$7F; BLue:$50; Alpha:$FF);
  CORNFLOWERBLUE      : TColor = (Red:$64; Green:$95; BLue:$ED; Alpha:$FF);
  CORNSILK            : TColor = (Red:$FF; Green:$F8; BLue:$DC; Alpha:$FF);
  CRIMSON             : TColor = (Red:$DC; Green:$14; BLue:$3C; Alpha:$FF);
  CYAN                : TColor = (Red:$00; Green:$FF; BLue:$FF; Alpha:$FF);
  DARKBLUE            : TColor = (Red:$00; Green:$00; BLue:$8B; Alpha:$FF);
  DARKCYAN            : TColor = (Red:$00; Green:$8B; BLue:$8B; Alpha:$FF);
  DARKGOLDENROD       : TColor = (Red:$B8; Green:$86; BLue:$0B; Alpha:$FF);
  DARKGRAY            : TColor = (Red:$A9; Green:$A9; BLue:$A9; Alpha:$FF);
  DARKGREEN           : TColor = (Red:$00; Green:$64; BLue:$00; Alpha:$FF);
  DARKGREY            : TColor = (Red:$A9; Green:$A9; BLue:$A9; Alpha:$FF);
  DARKKHAKI           : TColor = (Red:$BD; Green:$B7; BLue:$6B; Alpha:$FF);
  DARKMAGENTA         : TColor = (Red:$8B; Green:$00; BLue:$8B; Alpha:$FF);
  DARKOLIVEGREEN      : TColor = (Red:$55; Green:$6B; BLue:$2F; Alpha:$FF);
  DARKORANGE          : TColor = (Red:$FF; Green:$8C; BLue:$00; Alpha:$FF);
  DARKORCHID          : TColor = (Red:$99; Green:$32; BLue:$CC; Alpha:$FF);
  DARKRED             : TColor = (Red:$8B; Green:$00; BLue:$00; Alpha:$FF);
  DARKSALMON          : TColor = (Red:$E9; Green:$96; BLue:$7A; Alpha:$FF);
  DARKSEAGREEN        : TColor = (Red:$8F; Green:$BC; BLue:$8F; Alpha:$FF);
  DARKSLATEBLUE       : TColor = (Red:$48; Green:$3D; BLue:$8B; Alpha:$FF);
  DARKSLATEGRAY       : TColor = (Red:$2F; Green:$4F; BLue:$4F; Alpha:$FF);
  DARKTURQUOISE       : TColor = (Red:$00; Green:$CE; BLue:$D1; Alpha:$FF);
  DARKVIOLET          : TColor = (Red:$94; Green:$00; BLue:$D3; Alpha:$FF);
  DEEPPINK            : TColor = (Red:$FF; Green:$14; BLue:$93; Alpha:$FF);
  DEEPSKYBLUE         : TColor = (Red:$00; Green:$BF; BLue:$FF; Alpha:$FF);
  DIMGRAY             : TColor = (Red:$69; Green:$69; BLue:$69; Alpha:$FF);
  DODGERBLUE          : TColor = (Red:$1E; Green:$90; BLue:$FF; Alpha:$FF);
  FIREBRICK           : TColor = (Red:$B2; Green:$22; BLue:$22; Alpha:$FF);
  FLORALWHITE         : TColor = (Red:$FF; Green:$FA; BLue:$F0; Alpha:$FF);
  FORESTGREEN         : TColor = (Red:$22; Green:$8B; BLue:$22; Alpha:$FF);
  FUCHSIA             : TColor = (Red:$FF; Green:$00; BLue:$FF; Alpha:$FF);
  GAINSBORO           : TColor = (Red:$DC; Green:$DC; BLue:$DC; Alpha:$FF);
  GHOSTWHITE          : TColor = (Red:$F8; Green:$F8; BLue:$FF; Alpha:$FF);
  GOLD                : TColor = (Red:$FF; Green:$D7; BLue:$00; Alpha:$FF);
  GOLDENROD           : TColor = (Red:$DA; Green:$A5; BLue:$20; Alpha:$FF);
  GRAY                : TColor = (Red:$80; Green:$80; BLue:$80; Alpha:$FF);
  GREEN               : TColor = (Red:$00; Green:$80; BLue:$00; Alpha:$FF);
  GREENYELLOW         : TColor = (Red:$AD; Green:$FF; BLue:$2F; Alpha:$FF);
  GREY                : TColor = (Red:$80; Green:$80; BLue:$80; Alpha:$FF);
  HONEYDEW            : TColor = (Red:$F0; Green:$FF; BLue:$F0; Alpha:$FF);
  HOTPINK             : TColor = (Red:$FF; Green:$69; BLue:$B4; Alpha:$FF);
  INDIANRED           : TColor = (Red:$CD; Green:$5C; BLue:$5C; Alpha:$FF);
  INDIGO              : TColor = (Red:$4B; Green:$00; BLue:$82; Alpha:$FF);
  IVORY               : TColor = (Red:$FF; Green:$FF; BLue:$F0; Alpha:$FF);
  KHAKI               : TColor = (Red:$F0; Green:$E6; BLue:$8C; Alpha:$FF);
  LAVENDER            : TColor = (Red:$E6; Green:$E6; BLue:$FA; Alpha:$FF);
  LAVENDERBLUSH       : TColor = (Red:$FF; Green:$F0; BLue:$F5; Alpha:$FF);
  LAWNGREEN           : TColor = (Red:$7C; Green:$FC; BLue:$00; Alpha:$FF);
  LEMONCHIFFON        : TColor = (Red:$FF; Green:$FA; BLue:$CD; Alpha:$FF);
  LIGHTBLUE           : TColor = (Red:$AD; Green:$D8; BLue:$E6; Alpha:$FF);
  LIGHTCORAL          : TColor = (Red:$F0; Green:$80; BLue:$80; Alpha:$FF);
  LIGHTCYAN           : TColor = (Red:$E0; Green:$FF; BLue:$FF; Alpha:$FF);
  LIGHTGOLDENRODYELLOW: TColor = (Red:$FA; Green:$FA; BLue:$D2; Alpha:$FF);
  LIGHTGRAY           : TColor = (Red:$D3; Green:$D3; BLue:$D3; Alpha:$FF);
  LIGHTGREEN          : TColor = (Red:$90; Green:$EE; BLue:$90; Alpha:$FF);
  LIGHTGREY           : TColor = (Red:$D3; Green:$D3; BLue:$D3; Alpha:$FF);
  LIGHTPINK           : TColor = (Red:$FF; Green:$B6; BLue:$C1; Alpha:$FF);
  LIGHTSALMON         : TColor = (Red:$FF; Green:$A0; BLue:$7A; Alpha:$FF);
  LIGHTSEAGREEN       : TColor = (Red:$20; Green:$B2; BLue:$AA; Alpha:$FF);
  LIGHTSKYBLUE        : TColor = (Red:$87; Green:$CE; BLue:$FA; Alpha:$FF);
  LIGHTSLATEGRAY      : TColor = (Red:$77; Green:$88; BLue:$99; Alpha:$FF);
  LIGHTSLATEGREY      : TColor = (Red:$77; Green:$88; BLue:$99; Alpha:$FF);
  LIGHTSTEELBLUE      : TColor = (Red:$B0; Green:$C4; BLue:$DE; Alpha:$FF);
  LIGHTYELLOW         : TColor = (Red:$FF; Green:$FF; BLue:$E0; Alpha:$FF);
  LIME                : TColor = (Red:$00; Green:$FF; BLue:$00; Alpha:$FF);
  LIMEGREEN           : TColor = (Red:$32; Green:$CD; BLue:$32; Alpha:$FF);
  LINEN               : TColor = (Red:$FA; Green:$F0; BLue:$E6; Alpha:$FF);
  MAGENTA             : TColor = (Red:$FF; Green:$00; BLue:$FF; Alpha:$FF);
  MAROON              : TColor = (Red:$80; Green:$00; BLue:$00; Alpha:$FF);
  MEDIUMAQUAMARINE    : TColor = (Red:$66; Green:$CD; BLue:$AA; Alpha:$FF);
  MEDIUMBLUE          : TColor = (Red:$00; Green:$00; BLue:$CD; Alpha:$FF);
  MEDIUMORCHID        : TColor = (Red:$BA; Green:$55; BLue:$D3; Alpha:$FF);
  MEDIUMPURPLE        : TColor = (Red:$93; Green:$70; BLue:$DB; Alpha:$FF);
  MEDIUMSEAGREEN      : TColor = (Red:$3C; Green:$B3; BLue:$71; Alpha:$FF);
  MEDIUMSLATEBLUE     : TColor = (Red:$7B; Green:$68; BLue:$EE; Alpha:$FF);
  MEDIUMSPRINGGREEN   : TColor = (Red:$00; Green:$FA; BLue:$9A; Alpha:$FF);
  MEDIUMTURQUOISE     : TColor = (Red:$48; Green:$D1; BLue:$CC; Alpha:$FF);
  MEDIUMVIOLETRED     : TColor = (Red:$C7; Green:$15; BLue:$85; Alpha:$FF);
  MIDNIGHTBLUE        : TColor = (Red:$19; Green:$19; BLue:$70; Alpha:$FF);
  MINTCREAM           : TColor = (Red:$F5; Green:$FF; BLue:$FA; Alpha:$FF);
  MISTYROSE           : TColor = (Red:$FF; Green:$E4; BLue:$E1; Alpha:$FF);
  MOCCASIN            : TColor = (Red:$FF; Green:$E4; BLue:$B5; Alpha:$FF);
  NAVAJOWHITE         : TColor = (Red:$FF; Green:$DE; BLue:$AD; Alpha:$FF);
  NAVY                : TColor = (Red:$00; Green:$00; BLue:$80; Alpha:$FF);
  OLDLACE             : TColor = (Red:$FD; Green:$F5; BLue:$E6; Alpha:$FF);
  OLIVE               : TColor = (Red:$80; Green:$80; BLue:$00; Alpha:$FF);
  OLIVEDRAB           : TColor = (Red:$6B; Green:$8E; BLue:$23; Alpha:$FF);
  ORANGE              : TColor = (Red:$FF; Green:$A5; BLue:$00; Alpha:$FF);
  ORANGERED           : TColor = (Red:$FF; Green:$45; BLue:$00; Alpha:$FF);
  ORCHID              : TColor = (Red:$DA; Green:$70; BLue:$D6; Alpha:$FF);
  PALEGOLDENROD       : TColor = (Red:$EE; Green:$E8; BLue:$AA; Alpha:$FF);
  PALEGREEN           : TColor = (Red:$98; Green:$FB; BLue:$98; Alpha:$FF);
  PALETURQUOISE       : TColor = (Red:$AF; Green:$EE; BLue:$EE; Alpha:$FF);
  PALEVIOLETRED       : TColor = (Red:$DB; Green:$70; BLue:$93; Alpha:$FF);
  PAPAYAWHIP          : TColor = (Red:$FF; Green:$EF; BLue:$D5; Alpha:$FF);
  PEACHPUFF           : TColor = (Red:$FF; Green:$DA; BLue:$B9; Alpha:$FF);
  PERU                : TColor = (Red:$CD; Green:$85; BLue:$3F; Alpha:$FF);
  PINK                : TColor = (Red:$FF; Green:$C0; BLue:$CB; Alpha:$FF);
  PLUM                : TColor = (Red:$DD; Green:$A0; BLue:$DD; Alpha:$FF);
  POWDERBLUE          : TColor = (Red:$B0; Green:$E0; BLue:$E6; Alpha:$FF);
  PURPLE              : TColor = (Red:$80; Green:$00; BLue:$80; Alpha:$FF);
  REBECCAPURPLE       : TColor = (Red:$66; Green:$33; BLue:$99; Alpha:$FF);
  RED                 : TColor = (Red:$FF; Green:$00; BLue:$00; Alpha:$FF);
  ROSYBROWN           : TColor = (Red:$BC; Green:$8F; BLue:$8F; Alpha:$FF);
  ROYALBLUE           : TColor = (Red:$41; Green:$69; BLue:$E1; Alpha:$FF);
  SADDLEBROWN         : TColor = (Red:$8B; Green:$45; BLue:$13; Alpha:$FF);
  SALMON              : TColor = (Red:$FA; Green:$80; BLue:$72; Alpha:$FF);
  SANDYBROWN          : TColor = (Red:$F4; Green:$A4; BLue:$60; Alpha:$FF);
  SEAGREEN            : TColor = (Red:$2E; Green:$8B; BLue:$57; Alpha:$FF);
  SEASHELL            : TColor = (Red:$FF; Green:$F5; BLue:$EE; Alpha:$FF);
  SIENNA              : TColor = (Red:$A0; Green:$52; BLue:$2D; Alpha:$FF);
  SILVER              : TColor = (Red:$C0; Green:$C0; BLue:$C0; Alpha:$FF);
  SKYBLUE             : TColor = (Red:$87; Green:$CE; BLue:$EB; Alpha:$FF);
  SLATEBLUE           : TColor = (Red:$6A; Green:$5A; BLue:$CD; Alpha:$FF);
  SLATEGRAY           : TColor = (Red:$70; Green:$80; BLue:$90; Alpha:$FF);
  SLATEGREY           : TColor = (Red:$70; Green:$80; BLue:$90; Alpha:$FF);
  SNOW                : TColor = (Red:$FF; Green:$FA; BLue:$FA; Alpha:$FF);
  SPRINGGREEN         : TColor = (Red:$00; Green:$FF; BLue:$7F; Alpha:$FF);
  STEELBLUE           : TColor = (Red:$46; Green:$82; BLue:$B4; Alpha:$FF);
  TAN                 : TColor = (Red:$D2; Green:$B4; BLue:$8C; Alpha:$FF);
  TEAL                : TColor = (Red:$00; Green:$80; BLue:$80; Alpha:$FF);
  THISTLE             : TColor = (Red:$D8; Green:$BF; BLue:$D8; Alpha:$FF);
  TOMATO              : TColor = (Red:$FF; Green:$63; BLue:$47; Alpha:$FF);
  TURQUOISE           : TColor = (Red:$40; Green:$E0; BLue:$D0; Alpha:$FF);
  VIOLET              : TColor = (Red:$EE; Green:$82; BLue:$EE; Alpha:$FF);
  WHEAT               : TColor = (Red:$F5; Green:$DE; BLue:$B3; Alpha:$FF);
  WHITE               : TColor = (Red:$FF; Green:$FF; BLue:$FF; Alpha:$FF);
  WHITESMOKE          : TColor = (Red:$F5; Green:$F5; BLue:$F5; Alpha:$FF);
  YELLOW              : TColor = (Red:$FF; Green:$FF; BLue:$00; Alpha:$FF);
  YELLOWGREEN         : TColor = (Red:$9A; Green:$CD; BLue:$32; Alpha:$FF);
  BLANK               : TColor = (Red:$00; Green:$00; BLue:$00; Alpha:$00);
  WHITE2              : TColor = (Red:$F5; Green:$F5; BLue:$F5; Alpha:$FF);
  RED2                : TColor = (Red:$7E; Green:$32; BLue:$3F; Alpha:255);
  COLORKEY            : TColor = (Red:$FF; Green:$00; BLue:$FF; Alpha:$FF);
  OVERLAY1            : TColor = (Red:$00; Green:$20; BLue:$29; Alpha:$B4);
  OVERLAY2            : TColor = (Red:$01; Green:$1B; BLue:$01; Alpha:255);
  DIMWHITE            : TColor = (Red:$10; Green:$10; BLue:$10; Alpha:$10);
  DARKSLATEBROWN      : TColor = (Red:30;  Green:31;  BLue:30;  Alpha:1);
{$ENDREGION}

//=== WINDOW ================================================================
const
  WINDOW_WIDTH = 1920 div 2;
  WINDOW_HEIGHT = 1080 div 2;

function  WindowOpen(aTitle: WideString; aX, aY: Integer; aWidth: Integer=WINDOW_WIDTH; aHeight: Integer=WINDOW_HEIGHT): Boolean; external GPL_DLL;
procedure WindowClose; external GPL_DLL;
function  WindowIsOpen: Boolean; external GPL_DLL;
procedure WindowClear(aColor: TColor); external GPL_DLL;
procedure WindowShow; external GPL_DLL;
procedure WindowSetTitle(aTitle: WideString); external GPL_DLL;
function  WindowGetTitle: WideString; external GPL_DLL;
function  WindowGetViewport: TRect; external GPL_DLL;
procedure WindowDrawPoint(aX, aY: Single; aColor: TColor; aBlendMode: TBlendMode); external GPL_DLL;
procedure WindowDrawLine(aX1, aY1, aX2, aY2: Single; aColor: TColor; aBlendMode: TBlendMode); external GPL_DLL;
procedure WindowDrawRect(aX, aY, aWidth, aHeight: Single; aColor: TColor; aBlendMode: TBlendMode); external GPL_DLL;
procedure WindowDrawFilledRect(aX, aY, aWidth, aHeight: Single; aColor: TColor; aBlendMode: TBlendMode); external GPL_DLL;
function  WindowSave(aFilename: WideString): Boolean; external GPL_DLL;

//=== TIMER =================================================================
procedure TimerReset(aSpeed: Single=0; aFixedSpeed: Single=0); external GPL_DLL;
function  TimerFrameSpeed(var aTimer: Single; aSpeed: Single): Boolean; external GPL_DLL;
function  TimerElapsedTime(var aTimer: Single; aSeconds: Single): Boolean; external GPL_DLL;
function  TimerFrameRate: Cardinal; external GPL_DLL;
function  TimerUpdateSpeed: Single; external GPL_DLL;
function  TimerFixedUpdateSpeed: Single; external GPL_DLL;

//=== INPUT =================================================================
const
  TEXTINPUT_MAXLEN = 255;

  BUTTON_LEFT   = 1;
  BUTTON_MIDDLE = 2;
  BUTTON_RIGHT  = 3;
  BUTTON_X1     = 4;
  BUTTON_X2     = 5;

  GAMEPAD_AXIS_LEFTX        = 0;
  GAMEPAD_AXIS_LEFTY        = 1;
  GAMEPAD_AXIS_RIGHTX       = 2;
  GAMEPAD_AXIS_RIGHTY       = 3;
  GAMEPAD_AXIS_TRIGGERLEFT  = 4;
  GAMEPAD_AXIS_TRIGGERRIGHT = 5;

  GAMEPAD_BUTTON_A             = 0;
  GAMEPAD_BUTTON_B             = 1;
  GAMEPAD_BUTTON_X             = 2;
  GAMEPAD_BUTTON_Y             = 3;
  GAMEPAD_BUTTON_BACK          = 4;
  GAMEPAD_BUTTON_GUIDE         = 5;
  GAMEPAD_BUTTON_START         = 6;
  GAMEPAD_BUTTON_LEFTSTICK     = 7;
  GAMEPAD_BUTTON_RIGHTSTICK    = 8;
  GAMEPAD_BUTTON_LEFTSHOULDER  = 9;
  GAMEPAD_BUTTON_RIGHTSHOULDER = 10;
  GAMEPAD_BUTTON_DPAD_UP       = 11;
  GAMEPAD_BUTTON_DPAD_DOWN     = 12;
  GAMEPAD_BUTTON_DPAD_LEFT     = 13;
  GAMEPAD_BUTTON_DPAD_RIGHT    = 14;
  GAMEPAD_BUTTON_MISC1         = 15;
  GAMEPAD_BUTTON_PADDLE1       = 16;
  GAMEPAD_BUTTON_PADDLE2       = 17;
  GAMEPAD_BUTTON_PADDLE3       = 18;
  GAMEPAD_BUTTON_PADDLE4       = 19;
  GAMEPAD_BUTTON_TOUCHPAD      = 20;

  {$REGION ' Scancodes '}
  KEY_A = 4;
  KEY_B = 5;
  KEY_C = 6;
  KEY_D = 7;
  KEY_E = 8;
  KEY_F = 9;
  KEY_G = 10;
  KEY_H = 11;
  KEY_I = 12;
  KEY_J = 13;
  KEY_K = 14;
  KEY_L = 15;
  KEY_M = 16;
  KEY_N = 17;
  KEY_O = 18;
  KEY_P = 19;
  KEY_Q = 20;
  KEY_R = 21;
  KEY_S = 22;
  KEY_T = 23;
  KEY_U = 24;
  KEY_V = 25;
  KEY_W = 26;
  KEY_X = 27;
  KEY_Y = 28;
  KEY_Z = 29;
  KEY_1 = 30;
  KEY_2 = 31;
  KEY_3 = 32;
  KEY_4 = 33;
  KEY_5 = 34;
  KEY_6 = 35;
  KEY_7 = 36;
  KEY_8 = 37;
  KEY_9 = 38;
  KEY_0 = 39;
  KEY_RETURN = 40;
  KEY_ESCAPE = 41;
  KEY_BACKSPACE = 42;
  KEY_TAB = 43;
  KEY_SPACE = 44;
  KEY_MINUS = 45;
  KEY_EQUALS = 46;
  KEY_LEFTBRACKET = 47;
  KEY_RIGHTBRACKET = 48;
  KEY_BACKSLASH = 49;
  KEY_NONUSHASH = 50;
  KEY_SEMICOLON = 51;
  KEY_APOSTROPHE = 52;
  KEY_GRAVE = 53;
  KEY_COMMA = 54;
  KEY_PERIOD = 55;
  KEY_SLASH = 56;
  KEY_CAPSLOCK = 57;
  KEY_F1 = 58;
  KEY_F2 = 59;
  KEY_F3 = 60;
  KEY_F4 = 61;
  KEY_F5 = 62;
  KEY_F6 = 63;
  KEY_F7 = 64;
  KEY_F8 = 65;
  KEY_F9 = 66;
  KEY_F10 = 67;
  KEY_F11 = 68;
  KEY_F12 = 69;
  KEY_PRINTSCREEN = 70;
  KEY_SCROLLLOCK = 71;
  KEY_PAUSE = 72;
  KEY_INSERT = 73;
  KEY_HOME = 74;
  KEY_PAGEUP = 75;
  KEY_DELETE = 76;
  KEY_END = 77;
  KEY_PAGEDOWN = 78;
  KEY_RIGHT = 79;
  KEY_LEFT = 80;
  KEY_DOWN = 81;
  KEY_UP = 82;
  KEY_NUMLOCKCLEAR = 83;
  KEY_KP_DIVIDE = 84;
  KEY_KP_MULTIPLY = 85;
  KEY_KP_MINUS = 86;
  KEY_KP_PLUS = 87;
  KEY_KP_ENTER = 88;
  KEY_KP_1 = 89;
  KEY_KP_2 = 90;
  KEY_KP_3 = 91;
  KEY_KP_4 = 92;
  KEY_KP_5 = 93;
  KEY_KP_6 = 94;
  KEY_KP_7 = 95;
  KEY_KP_8 = 96;
  KEY_KP_9 = 97;
  KEY_KP_0 = 98;
  KEY_KP_PERIOD = 99;
  KEY_NONUSBACKSLASH = 100;
  KEY_APPLICATION = 101;
  KEY_POWER = 102;
  KEY_KP_EQUALS = 103;
  KEY_F13 = 104;
  KEY_F14 = 105;
  KEY_F15 = 106;
  KEY_F16 = 107;
  KEY_F17 = 108;
  KEY_F18 = 109;
  KEY_F19 = 110;
  KEY_F20 = 111;
  KEY_F21 = 112;
  KEY_F22 = 113;
  KEY_F23 = 114;
  KEY_F24 = 115;
  KEY_EXECUTE = 116;
  KEY_HELP = 117;
  KEY_MENU = 118;
  KEY_SELECT = 119;
  KEY_STOP = 120;
  KEY_AGAIN = 121;
  KEY_UNDO = 122;
  KEY_CUT = 123;
  KEY_COPY = 124;
  KEY_PASTE = 125;
  KEY_FIND = 126;
  KEY_MUTE = 127;
  KEY_VOLUMEUP = 128;
  KEY_VOLUMEDOWN = 129;
  KEY_KP_COMMA = 133;
  KEY_KP_EQUALSAS400 = 134;
  KEY_INTERNATIONAL1 = 135;
  KEY_INTERNATIONAL2 = 136;
  KEY_INTERNATIONAL3 = 137;
  KEY_INTERNATIONAL4 = 138;
  KEY_INTERNATIONAL5 = 139;
  KEY_INTERNATIONAL6 = 140;
  KEY_INTERNATIONAL7 = 141;
  KEY_INTERNATIONAL8 = 142;
  KEY_INTERNATIONAL9 = 143;
  KEY_LANG1 = 144;
  KEY_LANG2 = 145;
  KEY_LANG3 = 146;
  KEY_LANG4 = 147;
  KEY_LANG5 = 148;
  KEY_LANG6 = 149;
  KEY_LANG7 = 150;
  KEY_LANG8 = 151;
  KEY_LANG9 = 152;
  KEY_ALTERASE = 153;
  KEY_SYSREQ = 154;
  KEY_CANCEL = 155;
  KEY_CLEAR = 156;
  KEY_PRIOR = 157;
  KEY_RETURN2 = 158;
  KEY_SEPARATOR = 159;
  KEY_OUT = 160;
  KEY_OPER = 161;
  KEY_CLEARAGAIN = 162;
  KEY_CRSEL = 163;
  LuSCANCODE_EXSEL = 164;
  KEY_KP_00 = 176;
  KEY_KP_000 = 177;
  KEY_THOUSANDSSEPARATOR = 178;
  KEY_DECIMALSEPARATOR = 179;
  KEY_CURRENCYUNIT = 180;
  KEY_CURRENCYSUBUNIT = 181;
  KEY_KP_LEFTPAREN = 182;
  KEY_KP_RIGHTPAREN = 183;
  KEY_KP_LEFTBRACE = 184;
  KEY_KP_RIGHTBRACE = 185;
  KEY_KP_TAB = 186;
  KEY_KP_BACKSPACE = 187;
  KEY_KP_A = 188;
  KEY_KP_B = 189;
  KEY_KP_C = 190;
  KEY_KP_D = 191;
  KEY_KP_E = 192;
  KEY_KP_F = 193;
  KEY_KP_XOR = 194;
  KEY_KP_POWER = 195;
  KEY_KP_PERCENT = 196;
  KEY_KP_LESS = 197;
  KEY_KP_GREATER = 198;
  KEY_KP_AMPERSAND = 199;
  KEY_KP_DBLAMPERSAND = 200;
  KEY_KP_VERTICALBAR = 201;
  KEY_KP_DBLVERTICALBAR = 202;
  KEY_KP_COLON = 203;
  KEY_KP_HASH = 204;
  KEY_KP_SPACE = 205;
  KEY_KP_AT = 206;
  KEY_KP_EXCLAM = 207;
  KEY_KP_MEMSTORE = 208;
  KEY_KP_MEMRECALL = 209;
  KEY_KP_MEMCLEAR = 210;
  KEY_KP_MEMADD = 211;
  KEY_KP_MEMSUBTRACT = 212;
  KEY_KP_MEMMULTIPLY = 213;
  KEY_KP_MEMDIVIDE = 214;
  KEY_KP_PLUSMINUS = 215;
  KEY_KP_CLEAR = 216;
  KEY_KP_CLEARENTRY = 217;
  KEY_KP_BINARY = 218;
  KEY_KP_OCTAL = 219;
  KEY_KP_DECIMAL = 220;
  KEY_KP_HEXADECIMAL = 221;
  KEY_LCTRL = 224;
  KEY_LSHIFT = 225;
  KEY_LALT = 226;
  KEY_LGUI = 227;
  KEY_RCTRL = 228;
  KEY_RSHIFT = 229;
  KEY_RALT = 230;
  KEY_RGUI = 231;
  KEY_MODE = 257;
  KEY_AUDIONEXT = 258;
  KEY_AUDIOPREV = 259;
  KEY_AUDIOSTOP = 260;
  KEY_AUDIOPLAY = 261;
  KEY_AUDIOMUTE = 262;
  KEY_MEDIASELECT = 263;
  KEY_WWW = 264;
  KEY_MAIL = 265;
  KEY_CALCULATOR = 266;
  KEY_COMPUTER = 267;
  KEY_AC_SEARCH = 268;
  KEY_AC_HOME = 269;
  KEY_AC_BACK = 270;
  KEY_AC_FORWARD = 271;
  KEY_AC_STOP = 272;
  KEY_AC_REFRESH = 273;
  KEY_AC_BOOKMARKS = 274;
  KEY_BRIGHTNESSDOWN = 275;
  KEY_BRIGHTNESSUP = 276;
  KEY_DISPLAYSWITCH = 277;
  KEY_KBDILLUMTOGGLE = 278;
  KEY_KBDILLUMDOWN = 279;
  KEY_KBDILLUMUP = 280;
  KEY_EJECT = 281;
  KEY_SLEEP = 282;
  KEY_APP1 = 283;
  KEY_APP2 = 284;
  KEY_AUDIOREWIND = 285;
  KEY_AUDIOFASTFORWARD = 286;
  KEY_SOFTLEFT = 287;
  KEY_SOFTRIGHT = 288;
  KEY_CALL = 289;
  KEY_ENDCALL = 290;
  {$ENDREGION}

procedure InputClear; external GPL_DLL;
procedure InputClearKey(aKey: Cardinal); external GPL_DLL;
procedure InputClearTextInput; external GPL_DLL;
procedure InputClearLastInputChar; external GPL_DLL;
function  InputGetTextInput: WideString; external GPL_DLL;
procedure InputSetTextInput(aText: WideString); external GPL_DLL;
procedure InputSetTextInputSize(aSize: Cardinal); external GPL_DLL;
function  InputGetTextInputSize: Cardinal; external GPL_DLL;
function  InputGetEnableTextInput: Boolean; external GPL_DLL;
procedure InputSetEnableTextInput(aEnable: Boolean); external GPL_DLL;
function  InputKeyDown(aKey: Cardinal): Boolean; external GPL_DLL;
function  InputKeyPressed(aKey: Cardinal): Boolean; external GPL_DLL;
function  InputKeyReleased(aKey: Cardinal): Boolean; external GPL_DLL;
function  InputMouseDown(aButton: Cardinal): Boolean; external GPL_DLL;
function  InputMousePressed(aButton: Cardinal): Boolean; external GPL_DLL;
function  InputMouseReleased(aButton: Cardinal): Boolean; external GPL_DLL;
procedure InputSetMousePos(aX, aY: Integer); external GPL_DLL;
procedure InputGetMouseInfo(aPosition: PPoint; aDelta: PVector); external GPL_DLL;
function  InputGamepadDown(aButton: Cardinal): Boolean; external GPL_DLL;
function  InputGamepadPressed(aButton: Cardinal): Boolean; external GPL_DLL;
function  InputGamepadReleased(aButton: Cardinal): Boolean; external GPL_DLL;
function  InputGamepadPosition(aAxis: Cardinal): Single; external GPL_DLL;

//=== FONT ==================================================================
function  FontNew: TFont; external GPL_DLL;
procedure FontFree(var aFont: TFont); external GPL_DLL;
procedure FontUnload(aFont: TFont); external GPL_DLL;
procedure FontSetVertexBufferSize(aFont: TFont; aSize: UInt64); external GPL_DLL;
function  FontGetVertexBufferSize(aFont: TFont): UInt64; external GPL_DLL;
procedure FontSetUseVertexBuffer(aFont: TFont; aEnable: Boolean); external GPL_DLL;
function  FontGetUseVertexBuffer(aFont: TFont): Boolean; external GPL_DLL;
function  FontLoad(aFont: TFont; aArchive: TArchive; aFilename: WideString; aSize: Cardinal; aGlyphs: WideString=''): Boolean; external GPL_DLL;
function  FontLoadDefault(aFont: TFont; aSize: Cardinal; aGlyphs: WideString=''): Boolean; external GPL_DLL;
procedure FontDrawText(aFont: TFont; aX, aY: Single; aColor: TColor; aHAlign: THAlign; aText: WideString); external GPL_DLL;
procedure FontDrawTextY(aFont: TFont; aX: Single; var aY: Single; aLineSpace: Single; aColor: TColor; aHAlign: THAlign; aText: WideString); external GPL_DLL;
function  FontTextLength(aFont: TFont; aText: WideString): Single; external GPL_DLL;
function  FontTextHeight(aFont: TFont): Single; external GPL_DLL;
procedure FontRenderVertices(aFont: TFont; aReset: Boolean=True); external GPL_DLL;
procedure FontDrawTextva(aFont: TFont; aX, aY: Single; aColor: TColor; aHAlign: THAlign; aMsg: string; aArgs: array of const);
procedure FontDrawTextYva(aFont: TFont; aX: Single; var aY: Single; aLineSpace: Single; aColor: TColor; aHAlign: THAlign; aMsg: string; aArgs: array of const);

//=== TEXTURE ===============================================================
type
  TFlipMode = (fmNone=0, fmHorizontal=1, fmVertical=2);
  TTextureAccess = (taStatic=0, taStreaming=1, taTarget=2);

function  TextureNew: TTexture; external GPL_DLL;
function  TextureNewLoad(aArchive: TArchive; aFilename: WideString; aColorKey: PColor): TTexture; external GPL_DLL;
function  TextureNewAlloc(aWidth, aHeight: Cardinal; aAccess: TTextureAccess): TTexture; external GPL_DLL;
procedure TextureFree(var aTexture: TTexture); external GPL_DLL;
procedure TextureAlloc(aTexture: TTexture; aWidth, aHeight: Cardinal; aAccess: TTextureAccess); external GPL_DLL;
function  TextureLoad(aTexture: TTexture; aArchive: TArchive; aFilename: WideString; aColorKey: PColor): Boolean; external GPL_DLL;
procedure TextureUnload(aTexture: TTexture); external GPL_DLL;
procedure TextureRender(aTexture: TTexture; aSrcRect: PRect; aX, aY: Single; aScale, aAngle: Single; aFlipMode: TFlipMode; aOriginX, aOriginY: Single; aColor: TColor; aBlendMode: TBlendMode); external GPL_DLL;
procedure TextureRenderTiled(aTexture: TTexture; aDeltaX, aDeltaY: Single; aColor: TColor; aBlendMode: TBlendMode); external GPL_DLL;
procedure TextureLock(aTexture: TTexture; aRect: PRect); external GPL_DLL;
procedure TextureUnlock(aTexture: TTexture); external GPL_DLL;
procedure TextureSetPixel(aTexture: TTexture; aX, aY: Integer; aColor: TColor); external GPL_DLL;
function  TextureGetPixel(aTexture: TTexture; aX, aY: Integer): TColor; external GPL_DLL;
procedure TextureGetSize(aTexture: TTexture; aWidth: PInteger; aHeight: PInteger); external GPL_DLL;
procedure TextureSetColor(aTexture: TTexture; aColor: TColor); external GPL_DLL;
function  TextureGetColor(aTexture: TTexture): TColor; external GPL_DLL;
function  TextureSave(aTexture: TTexture; aFilename: WideString): Boolean; external GPL_DLL;

//=== VIDEO =================================================================
type
  TVideoStatus = (vsStopped=0, vsPlaying=1, vsPaused=2);

function  VideoLoad(aArchive: TArchive; aFilename: WideString): Boolean; external GPL_DLL;
procedure VideoUnload; external GPL_DLL;
procedure VideoPlay(aVolume: Single; aLoop: Integer); external GPL_DLL;
procedure VideoLoadPlay(aArchive: TArchive; aFilename: WideString; aVolume: Single; aLoop: Integer); external GPL_DLL;
procedure VideoPause(aPause: Boolean); external GPL_DLL;
procedure VideoStop; external GPL_DLL;
procedure VideoRewind; external GPL_DLL;
function  VideoGetStatus: TVideoStatus; external GPL_DLL;
function  VideoGetWidth: Cardinal; external GPL_DLL;
function  VideoGetHeight: Cardinal; external GPL_DLL;
function  VideoGetFrameRate: Single; external GPL_DLL;
function  VideoGetVolume: Single; external GPL_DLL;
procedure VideoSetVolume(aVolume: Single); external GPL_DLL;
procedure VideoDraw(aX, aY, aScale: Single); external GPL_DLL;

//=== SPEECH ================================================================
type
  TSpeechVoiceAttribute = (svaDescription, svaName, svaVendor, svaAge, svaGender, svaLanguage, svaId);

function  SpeechGetVoiceCount: Integer; external GPL_DLL;
function  SpeechGetVoiceAttribute(aIndex: Integer; aAttribute: TSpeechVoiceAttribute): WideString; external GPL_DLL;
procedure SpeechChangeVoice(aIndex: Integer); external GPL_DLL;
function  SpeechGetVoice: Integer; external GPL_DLL;
procedure SpeechSetVolume(aVolume: Single); external GPL_DLL;
function  SpeechGetVolume: Single; external GPL_DLL;
procedure SpeechSetRate(aRate: Single); external GPL_DLL;
function  SpeechGetRate: Single; external GPL_DLL;
procedure SpeechClear; external GPL_DLL;
procedure SpeechSay(aText: WideString; aPurge: Boolean); external GPL_DLL;
function  SpeechActive: Boolean; external GPL_DLL;
procedure SpeechPause; external GPL_DLL;
procedure SpeechResume; external GPL_DLL;
procedure SpeechReset; external GPL_DLL;
procedure SpeechSubstituteWord(aWord: WideString; aSubstituteWord: WideString); external GPL_DLL;

//=== SCREENSHAKE ===========================================================
procedure ScreenshakeStart(aDuration: Single; aMagnitude: Single); external GPL_DLL;
procedure ScreenshakeClear; external GPL_DLL;
function  ScreenshakeActive: Boolean; external GPL_DLL;

//=== STARFIELD =============================================================
function  StarfieldNew: TStarfield; external GPL_DLL;
procedure StarfieldFree(var aStarfield: TStarfield); external GPL_DLL;
procedure StarfieldInit(aStarfield: TStarfield; aStarCount: Cardinal; aMinX, aMinY, aMinZ, aMaxX, aMaxY, aMaxZ, aViewScale: Single); external GPL_DLL;
procedure StarfieldSetVirtualPos(aStarfield: TStarfield; aX, aY: Single); external GPL_DLL;
procedure StarfieldGetVirtualPos(aStarfield: TStarfield; var aX: Single; var aY: Single); external GPL_DLL;
procedure StarfieldSetXSpeed(aStarfield: TStarfield; aSpeed: Single); external GPL_DLL;
procedure StarfieldSetYSpeed(aStarfield: TStarfield; aSpeed: Single); external GPL_DLL;
procedure StarfieldSetZSpeed(aStarfield: TStarfield; aSpeed: Single); external GPL_DLL;
procedure StarfieldUpdate(aStarfield: TStarfield; aDeltaTime: Single); external GPL_DLL;
procedure StarfieldRender(aStarfield: TStarfield); external GPL_DLL;

//=== ASYNC =================================================================
type
  TAsyncProc = procedure(aSender: Pointer);

procedure AsyncRun(aName: WideString; aSender: Pointer; aBackgroundTask: TAsyncProc; aWaitForgroundTask: TAsyncProc); external GPL_DLL;
function  AsyncBusy(aName: WideString): Boolean; external GPL_DLL;
procedure AsyncEnter; external GPL_DLL;
procedure AsyncLeave; external GPL_DLL;

//=== POLYGON ===============================================================
function  PolygonNew: TPolygon; external GPL_DLL;
procedure PolygonFree(var aPolygon: TPolygon); external GPL_DLL;
procedure PolygonSave(aPolygon: TPolygon; aFilename: WideString); external GPL_DLL;
procedure PolygonLoad(aPolygon: TPolygon; aArchive: TArchive; aFilename: WideString); external GPL_DLL;
procedure PolygonCopyFrom(aTo: TPolygon; aFrom: TPolygon); external GPL_DLL;
procedure PolygonAddLocalPoint(aPolygon: TPolygon; aX, aY: Single; aVisible: Boolean); external GPL_DLL;
function  PolygonTransform(aPolygon: TPolygon; aX, aY, aScale, aAngle: Single; aFlipMode: TFlipMode; aOriginX, aOriginY: Single): Boolean; external GPL_DLL;
procedure PolygonRender(aPolygon: TPolygon; aX, aY, aScale, aAngle, aWidth: Single; aColor: TColor; aFlipMode: TFlipMode; aOriginX, aOriginY: Single; aBlendMode: TBlendMode); external GPL_DLL;
procedure PolygonSetSegmentVisible(aPolygon: TPolygon; aIndex: Integer; aVisible: Boolean); external GPL_DLL;
function  PolygonSegmentVisible(aPolygon: TPolygon; aIndex: Integer): Boolean; external GPL_DLL;
function  PolygonPointCount(aPolygon: TPolygon): Integer; external GPL_DLL;
function  PolygonWorldPoint(aPolygon: TPolygon; aIndex: Integer): PPoint; external GPL_DLL;
function  PolygonLocalPoint(aPolygon: TPolygon; aIndex: Integer): PPoint; external GPL_DLL;

//=== SPRITE ================================================================
function  SpriteNew: TSprite; external GPL_DLL;
procedure SpriteFree(var aSprite: TSprite); external GPL_DLL;
procedure SpriteClear(aSprite: TSprite); external GPL_DLL;
function  SpriteLoadPage(aSprite: TSprite; aArchive: TArchive; aFilename: WideString; const aColorKey: PColor): Integer; external GPL_DLL;
function  SpriteAddGroup(aSprite: TSprite) : Integer; external GPL_DLL;
function  SpriteAddImageFromRect(aSprite: TSprite; aPage, aGroup: Integer; aRect: TRect): Integer; external GPL_DLL;
function  SpriteAddImageFromGrid(aSprite: TSprite; aPage, aGroup, aGridX, aGridY, aGridWidth: Integer; aGridHeight: Integer): Integer; external GPL_DLL;
function  SpriteImageCount(aSprite: TSprite; aGroup: Integer): Integer; external GPL_DLL;
function  SpriteImageWidth(aSprite: TSprite; aNum, aGroup: Integer): Single; external GPL_DLL;
function  SpriteImageHeight(aSprite: TSprite; aNum, aGroup: Integer): Single; external GPL_DLL;
function  SpriteImageTexture(aSprite: TSprite; aNum, aGroup: Integer): TTexture; external GPL_DLL;

//=== ENTITY ================================================================
function  EntityNew(const aSprite: TSprite; const aGroup: Integer): TEntity; external GPL_DLL;
procedure EntityFree(var aEntity: TEntity); external GPL_DLL;
procedure EntitySetFrameRange(aEntity: TEntity; aFirst, aLast: Integer); external GPL_DLL;
function  EntityNextFrame(aEntity: TEntity): Boolean; external GPL_DLL;
function  EntityPrevFrame(aEntity: TEntity): Boolean; external GPL_DLL;
function  EntityFrame(aEntity: TEntity): Integer; external GPL_DLL;
procedure EntitySetFrame(aEntity: TEntity; aFrame: Integer); external GPL_DLL;
function  EntityFrameFPS(aEntity: TEntity): Single; external GPL_DLL;
procedure EntitySetFrameFPS(aEntity: TEntity; aFrameFPS: Single); external GPL_DLL;
function  EntityFirstFrame(aEntity: TEntity): Integer; external GPL_DLL;
function  EntityLastFrame(aEntity: TEntity): Integer; external GPL_DLL;
procedure EntitySetPosAbs(aEntity: TEntity; aX, aY: Single); external GPL_DLL;
procedure EntitySetPosRel(aEntity: TEntity; aX, aY: Single); external GPL_DLL;
function  EntityPos(aEntity: TEntity): TVector; external GPL_DLL;
function  EntityDir(aEntity: TEntity): TVector; external GPL_DLL;
procedure EntityScaleAbs(aEntity: TEntity; aScale: Single); external GPL_DLL;
procedure EntityScaleRel(aEntity: TEntity; aScale: Single); external GPL_DLL;
function  EntityAngle(aEntity: TEntity): Single; external GPL_DLL;
function  EntityAngleOffset(aEntity: TEntity): Single; external GPL_DLL;
procedure EntitySetAngleOffset(aEntity: TEntity; aAngle: Single); external GPL_DLL;
procedure EntityRotateAbs(aEntity: TEntity; aAngle: Single); external GPL_DLL;
procedure EntityRotateRel(aEntity: TEntity; aAngle: Single); external GPL_DLL;
function  EntityRotateToAngle(aEntity: TEntity; aAngle, aSpeed: Single): Boolean; external GPL_DLL;
function  EntityRotateToPos(aEntity: TEntity; aX, aY, aSpeed: Single): Boolean; external GPL_DLL;
function  EntityRotateToPosAt(aEntity: TEntity; aSrcX, aSrcY, aDestX, aDestY, aSpeed: Single): Boolean; external GPL_DLL;
procedure EntityThrust(aEntity: TEntity; aSpeed: Single); external GPL_DLL;
procedure EntityThrustAngle(aEntity: TEntity; aAngle, aSpeed: Single); external GPL_DLL;
function  EntityThrustToPos(aEntity: TEntity; aThrustSpeed, aRotSpeed, aDestX, aDestY, aSlowdownDist, aStopDist, aStopSpeed, aStopSpeedEpsilon: Single; aDeltaTime: Double): Boolean; external GPL_DLL;
function  EntityVisible(aEntity: TEntity; aVirtualX, aVirtualY: Single): Boolean; external GPL_DLL;
function  EntityFullyVisible(aEntity: TEntity; aVirtualX, aVirtualY: Single): Boolean; external GPL_DLL;
function  EntityOverlapPos(aEntity: TEntity; aX, aY, aRadius, aShrinkFactor: Single): Boolean; external GPL_DLL;
function  EntityOverlap(aEntity1, aEntity2: TEntity): Boolean; overload; external GPL_DLL;
procedure EntityRender(aEntity: TEntity; aVirtualX, aVirtualY: Single); external GPL_DLL;
procedure EntityRenderAt(aEntity: TEntity; aX, aY: Single); external GPL_DLL;
procedure EntityTracePolyPoint(aEntity: TEntity; aMju: Single=6; aMaxStepBack: Integer=12; aAlphaThreshold: Integer=70; aOrigin: PPoint=nil); external GPL_DLL;
function  EntityCollidePolyPoint(aEntity1, aEntity2: TEntity; var aHitPos: TPoint): Boolean; external GPL_DLL;
function  EntityCollidePolyPointPoint(aEntity: TEntity; var aPoint: TPoint): Boolean; external GPL_DLL;
function  EntitySprite(aEntity: TEntity): TSprite; external GPL_DLL;
function  EntityGroup(aEntity: TEntity): Integer; external GPL_DLL;
function  EntityScale(aEntity: TEntity): Single; external GPL_DLL;
function  EntityColor(aEntity: TEntity): TColor; external GPL_DLL;
procedure EntitySetColor(aEntity: TEntity; aColor: TColor); external GPL_DLL;
function  EntityFlipMode(aEntity: TEntity): TFlipMode; external GPL_DLL;
procedure EntitySetFlipMode(aEntity: TEntity; aFlipMode: TFlipMode); external GPL_DLL;
procedure EntitySetBlendMode(aEntity: TEntity; aBlendMode: TBlendMode); external GPL_DLL;
function  EntityBlendMode(aEntity: TEntity): TBlendMode; external GPL_DLL;
function  EntityLoopFrame(aEntity: TEntity): Boolean; external GPL_DLL;
procedure EntitySetLoopFrame(aEntity: TEntity; aLoop: Boolean); external GPL_DLL;
function  EntityWidth(aEntity: TEntity): Single; external GPL_DLL;
function  EntityHeight(aEntity: TEntity): Single; external GPL_DLL;
function  EntityEntityRadius(aEntity: TEntity): Single; external GPL_DLL;
function  EntityShrinkFactor(aEntity: TEntity): Single; external GPL_DLL;
procedure EntitySetShrinkFactor(aEntity: TEntity; aShrinkFactor: Single); external GPL_DLL;
procedure EntitySetRenderPolyPoint(aEntity: TEntity; aValue: Boolean); external GPL_DLL;

//=== CMDCONSOLE ============================================================
type
  TCmdConsoleActionEvent = procedure(aSender: Pointer; aParams: array of WideString);

procedure CmdConsoleAddTextLine(const aText: WideString); external GPL_DLL;
procedure CmdConsoleClearCommands; external GPL_DLL;
function  CmdConsoleAddCommand(const aName, aDiscription: WideString; const aSender: Pointer; const aHandler: TCmdConsoleActionEvent): Boolean; external GPL_DLL;
function  CmdConsoleGetActive: Boolean; external GPL_DLL;

//=== PREFS =================================================================
function  PrefsGetOrgName: WideString; external GPL_DLL;
procedure PrefsSetOrgName(aOrgName: WideString); external GPL_DLL;
function  PrefsGetAppName: WideString; external GPL_DLL;
procedure PrefsSetAppName(aAppName: WideString); external GPL_DLL;
function  PrefsGetPath: WideString; external GPL_DLL;
procedure PrefsGotoPath; external GPL_DLL;

//=== LOG ===================================================================
function  LogOpened: Boolean; external GPL_DLL;
procedure LogReset; external GPL_DLL;
function  LogGetFilename: WideString; external GPL_DLL;
function  LogAdd(aText: WideString): WideString; external GPL_DLL;
procedure LogSetConsoleOutput(aConsoleOutput: Boolean); external GPL_DLL;
function  LogGetConsoleOutput: Boolean; external GPL_DLL;
procedure LogView; external GPL_DLL;

//=== GAME ==================================================================
type

  TGameEventType = (geStartup, geShutdown, geReady, geUpdate, geFixedUpdate,
    geClearWindow, geShowWindow, geRender, geRenderHud, geVideoStatus,
    geSpeechWord);

  PGameEventParam = ^TGameEventParam;
  TGameEventParam = record
    geReady_Ready: Boolean;
    geUpdate_DeltaTime: Double;
    geFixedUpdate_Time: Single;
    geVideoStatus_Status: TVideoStatus;
    geVideoStatus_Filename: WideString;
    geSpeechWord_Word: WideString;
    geSpeechWord_Text: WideString;
  end;

  TGameEvent = procedure(aSender: Pointer; aType: TGameEventType; aParam: PGameEventParam);

procedure GameSetTerminated(aTermiante: Boolean); external GPL_DLL;
function  GameGetTerminated: Boolean; external GPL_DLL;
procedure GameSetEventHandler(aSender: Pointer; aHandler: TGameEvent); external GPL_DLL;
procedure GameGetEventHander(var aSender: Pointer; var aHandler: TGameEvent); external GPL_DLL;
procedure GameSetWindowUpdateOnLostFocus(aEnable: Boolean); external GPL_DLL;
function  GameGetWindowUpdateOnLostFocus: Boolean; external GPL_DLL;
procedure GameRun; external GPL_DLL;

implementation

uses
  SysUtils;

//=== CONSOLE ===============================================================
procedure ConsolePrintva(aMsg: string; aArgs: array of const);
begin
  if not ConsoleExist then Exit;
  ConsolePrint(WideString(GamePascal.Format(aMsg, aArgs)));
end;

procedure ConsolePrintLnva(aMsg: string; aArgs: array of const);
begin
  if not ConsoleExist then Exit;
  ConsolePrintLn(WideString(GamePascal.Format(aMsg, aArgs)));
end;

//=== UTILS =================================================================
function Format(aMsg: string; aArgs: array of const): string;
begin
  {$IFDEF FPC}
  Result := UnicodeFormat(aMsg, aArgs);
  {$ELSE}
  Result := SysUtils.Format(aMsg, aArgs);
  {$ENDIF}
end;

//=== FONT ==================================================================
procedure FontDrawTextVA(aFont: TFont; aX, aY: Single; aColor: TColor; aHAlign: THAlign; aMsg: string; aArgs: array of const);
begin
  FontDrawText(aFont, aX, aY, aColor, aHAlign, GamePascal.Format(aMsg, aArgs));
end;

procedure FontDrawTextYVA(aFont: TFont; aX: Single; var aY: Single; aLineSpace: Single; aColor: TColor; aHAlign: THAlign; aMsg: string; aArgs: array of const);
begin
  FontDrawTextY(aFont, aX, aY, aLineSpace, aColor, aHAlign, GamePascal.Format(aMsg, aArgs));
end;

//===========================================================================
procedure Startup; external GPL_DLL;
procedure Shutdown; external GPL_DLL;

initialization
  {$IFNDEF FPC}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}
  Startup;
finalization
  Shutdown;

end.
