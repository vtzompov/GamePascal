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

unit uvideo_chained_play;

interface

procedure RunGame;

implementation

uses
  GamePascal,
  uCommon;

const
  cWindowTitle  = 'Video: Chained Play';

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
      WindowClearColor := DARKSLATEBROWN;

      // open a render window
      WindowOpen(cBaseWindowTitle + cWindowTitle, -1, -1);

      // init default font
      DefaultFont := FontNew;
      FontLoadDefault(DefaultFont, 10);

      // load and play video
      VideoLoadPlay(Archive, 'arc/videos/GPT.mpg', 1.0, 0);
    end;

    // shutdown event
    geShutdown:
    begin
      // unload video
      VideoUnload;

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
      // draw video frame
      VideoDraw(0, 0, 0.5);
    end;

    // render HUD event
    geRenderHud:
    begin
      HudPos.X := 3;
      HudPos.Y := 3;
      HudPos.Z := 0;

      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, WHITE, haLeft, 'fps %d', [TimerFrameRate]);
      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'ESC - Quit', []);
    end;

    // video status event
    geVideoStatus:
    begin
      case aParam.geVideoStatus_Status of
        vsPlaying:
        begin
          if aParam.geVideoStatus_Filename = 'arc/videos/GPT.mpg' then
            SpeechSay('Welcome to GamePascal', True)
          else
          if aParam.geVideoStatus_Filename = 'arc/videos/TBG.mpg' then
            SpeechSay('Made by tiny big games', True);

        end;

        vsStopped:
        begin
          if aParam.geVideoStatus_Filename = 'arc/videos/GPT.mpg' then
            VideoLoadPlay(Archive, 'arc/videos/TBG.mpg', 1.0, 0)
          else
          if aParam.geVideoStatus_Filename = 'arc/videos/TBG.mpg' then
            VideoLoadPlay(Archive, 'arc/videos/GPT.mpg', 1.0, 0);
        end;
      end;
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
