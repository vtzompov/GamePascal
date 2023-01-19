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

unit utexture_parallax;

interface

procedure RunGame;

implementation

uses
  GamePascal,
  uCommon;

const
  cWindowTitle  = 'Texture: Parallax';

var
  Texture: array[0..3] of TTexture = (nil, nil, nil, nil);
  Speed: array[0..3] of Single;
  Pos: array[0..3] of TVector;


// Process game events
procedure GameEvents(aSender: Pointer; aType: TGameEventType; aParam: PGameEventParam);
var
  I: Integer;
  LBlendMode: TBlendMode;
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

      // Create textures
      Texture[0] := TextureNewLoad(Archive, 'arc/images/space.png', nil);
      Texture[1] := TextureNewLoad(Archive, 'arc/images/nebula.png', @BLACK);
      Texture[2] := TextureNewLoad(Archive, 'arc/images/spacelayer1.png', @BLACK);
      Texture[3] := TextureNewLoad(Archive, 'arc/images/spacelayer2.png', @BLACK);

      // Set bitmap speeds
      Speed[0] := 0.3 * 30;
      Speed[1] := 0.5 * 30;
      Speed[2] := 1.0 * 30;
      Speed[3] := 2.0 * 30;

      // Clear pos
      VectorClear(Pos[0]);
      VectorClear(Pos[1]);
      VectorClear(Pos[2]);
      VectorClear(Pos[3]);
    end;

    // shutdown event
    geShutdown:
    begin
      // free textures
      TextureFree(Texture[3]);
      TextureFree(Texture[2]);
      TextureFree(Texture[1]);
      TextureFree(Texture[0]);

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

      // Update texture layers
      for I := Low(Texture) to High(Texture) do
        Pos[I].Y := Pos[I].Y + (Speed[I] * aParam.geUpdate_DeltaTime);
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

      // Render texture layers
      for I := Low(Texture) to High(Texture) do
      begin
        case I of
          0:   LBlendMode := bmNone;
          1:   LBlendMode := bmAdd;
          2,3: LBlendMode := bmBlend;
        else
          LBlendMode := bmBlend;
        end;

        TextureRenderTiled(Texture[I], Pos[I].X, Pos[I].Y, WHITE, LBlendMode);
      end;

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
