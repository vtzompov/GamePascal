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

unit ucommon;

interface

uses
  GamePascal;

const
  cArchivePassword = '32754f46fa1c43bb844bd5fe38773838';
  cArchiveFilename = 'Data.arc';

  cBaseWindowTitle     = 'GamePascal - ';

var
  Archive    : TArchive;
  DefaultFont: TFont;
  UnicodeFont: TFont;
  HudPos     : TPoint;
  WindowClearColor: TColor;
  MousePos   : TPoint;

implementation

end.
