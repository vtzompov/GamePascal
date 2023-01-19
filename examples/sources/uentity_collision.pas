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

unit uentity_collision;

interface

procedure RunGame;

implementation

uses
  GamePascal,
  uCommon;

const
  cWindowTitle  = 'Entity: Collision';

var
  Sprite: TSprite = nil;
  Boss: TEntity = nil;
  Figure: TEntity = nil;
  HitPos: TPoint;
  Collide: Boolean;
  MousePos: TPoint;

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

      // init sprite
      Sprite := SpriteNew;

      // init boss sprite
      SpriteLoadPage(Sprite, Archive, 'arc/images/boss.png', nil);
      SpriteAddGroup(Sprite);
      SpriteAddImageFromGrid(Sprite, 0, 0, 0, 0, 128, 128);
      SpriteAddImageFromGrid(Sprite, 0, 0, 1, 0, 128, 128);
      SpriteAddImageFromGrid(Sprite, 0, 0, 0, 1, 128, 128);

      // init boss figure
      SpriteLoadPage(Sprite, Archive, 'arc/images/figure.png', nil);
      SpriteAddGroup(Sprite);
      SpriteAddImageFromGrid(Sprite, 1, 1, 0, 0, 128, 128);

      // init boss entity
      Boss := EntityNew(Sprite, 0);
      EntitySetFrameFPS(Boss, 14);
      EntitySetPosAbs(Boss, WINDOW_WIDTH/2, (WINDOW_HEIGHT/2)-128);
      EntityTracePolyPoint(Boss, 6, 12, 70, nil);
      EntitySetRenderPolyPoint(Boss, True);

      // init figure entity
      Figure := EntityNew(Sprite, 1);
      EntitySetFrameFPS(Figure, 14);
      EntitySetPosAbs(Figure, WINDOW_WIDTH/2, WINDOW_HEIGHT/2);
      EntityTracePolyPoint(Figure, 6, 12, 70, nil);
      EntitySetRenderPolyPoint(Figure, True);

      Collide := False;
    end;

    // shutdown event
    geShutdown:
    begin
      // free entity
      EntityFree(Figure);
      EntityFree(Boss);

      // free sprite
      SpriteFree(Sprite);

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

      // get mouse pos
      InputGetMouseInfo(@MousePos, nil);

      // update boss
      EntityNextFrame(Boss);
      EntityThrustToPos(Boss, 30*50, 14*50, MousePos.X, MousePos.Y, 128, 32, 5*50, EPSILON, aParam.geUpdate_DeltaTime);
      if EntityCollidePolyPoint(Boss, Figure, HitPos) then
        Collide := True
      else
        Collide := False;

      // update figure
      EntityNextFrame(Figure);
      HitPos.Z := HitPos.Z + (30.0 * aParam.geUpdate_DeltaTime);
      ClipValuef(HitPos.Z, 0, 360, True);
      EntityRotateAbs(Figure, HitPos.Z);
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
      // render entities
      EntityRender(Figure, 0, 0);
      EntityRender(Boss, 0, 0);

      // show hit position
      if Collide then
        WindowDrawFilledRect(HitPos.X, HitPos.Y, 10, 10, RED, bmBlend);
    end;

    // render HUD event
    geRenderHud:
    begin
      HudPos.X := 3;
      HudPos.Y := 3;
      HudPos.Z := 0;

      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, WHITE, haLeft, 'fps %d', [TimerFrameRate]);
      FontDrawTextYva(DefaultFont, HudPos.X, HudPos.Y, HudPos.Z, DARKGREEN, haLeft, 'ESC - Quit', []);

      FontDrawText(DefaultFont, 0, 150, ORANGE, haCenter, 'Use mouse to move ship along edge of rotating figure to see collision');

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
