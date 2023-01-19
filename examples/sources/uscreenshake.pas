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

unit uscreenshake;

interface

procedure RunGame;

implementation

uses
  GamePascal,
  uCommon;

const
  cWindowTitle  = 'Screenshake';

var
  Starfield: TStarfield = nil;

// Process game events
procedure GameEvents(aSender: Pointer; aType: TGameEventType; aParam: PGameEventParam);
begin

  case aType of
    // startup event
    geStartup:
    begin
      // init archive
      Archive := ArchiveNew;
      ArchiveOpen(Archive, cArchivePassword, cArchiveFilename);

      // set window clear color
      WindowClearColor := BLACK;

      // open a render window
      WindowOpen(cBaseWindowTitle + cWindowTitle, -1, -1);

      // init default font
      DefaultFont := FontNew;
      FontLoadDefault(DefaultFont, 10);

      // init starfield
      Starfield := StarfieldNew;

    end;

    // shutdown event
    geShutdown:
    begin
      // free starfield
      StarfieldFree(Starfield);

      // free fonts
      FontFree(DefaultFont);

      // close render window
      WindowClose;

      // free archive
      ArchiveFree(Archive);
    end;

    // ready event
    geReady:
    begin
      // check game ready state
      if aParam.geReady_Ready then
        ConsolePrintLnva('Ready...', [])
      else
        ConsolePrintLnva('Not ready...', [])
    end;

    // update event
    geUpdate:
    begin
      // terminate on ESCAPE key
      if InputKeyPressed(KEY_ESCAPE) then
        GameSetTerminated(True);

      // start screenshake
      if InputKeyPressed(KEY_S) then
        ScreenshakeStart(60, 7);

      // update starfield
      StarfieldUpdate(Starfield, aParam.geUpdate_DeltaTime);
    end;

    // fixed update event
    geFixedUpdate:
    begin
    end;

    // clear window event
    geClearWindow:
    begin
      // clear render window to specified color
      WindowClear(WindowClearColor);
    end;

    // show window event
    geShowWindow:
    begin
      // show render window
      WindowShow;
    end;

    // render event
    geRender:
    begin
      // render starfield
      StarfieldRender(Starfield);
    end;

    // render HUD event
    geRenderHud:
    begin
      HudPos.X := 3;
      HudPos.Y := 3;
      HudPos.Z := 0;

      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, WHITE, haLeft, 'fps %d', [TimerFrameRate]);
      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'ESC - Quit', []);
      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'S   - Screenshake', []);
    end;

    // video status event
    geVideoStatus:
    begin
    end;

    // speech word event
    geSpeechWord:
    begin
    end;

  end;
end;

// Run game
procedure RunGame;
begin
  // hook to game event handler
  GameSetEventHandler(nil, GameEvents);

  // start game loop
  GameRun;
end;

end.
