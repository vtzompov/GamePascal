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

unit udemo_elastic;

interface

procedure RunGame;

implementation

uses
  GamePascal,
  uCommon;


const
  cWindowTitle = 'Demo: Elastic';
  cGravity     = 0.04;
  cXDecay      = 0.97;
  cYDecay      = 0.97;
  cBeadCount   = 10;
  cXElasticity = 0.02;
  cYElasticity = 0.02;
  cWallDecay   = 0.9;
  cSlackness   = 1;
  cBeadSize    = 12;
  cBedHalfSize = cBeadSize / 2;
  cBeadFilled  = True;

type
  TBead = record
    X    : Single;
    Y    : Single;
    XMove: Single;
    YMove: Single;
  end;

var
  LViewport: TRect;
  FBead : array[0..cBeadCount] of TBead;
  FTimer: Single;
  FMusic: Integer = AUDIO_ERROR;
  LDist, LDistX, LDistY: Single;

// Process game events
procedure GameEvents(aSender: Pointer; aType: TGameEventType; aParam: PGameEventParam);
var
  I: Integer;
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

      FillChar(FBead, SizeOf(FBead), 0);

      LViewport := WindowGetViewport;

      FMusic := AudioLoadMusic(Archive, 'arc/music/song04.ogg');
      AudioPlayMusic(FMusic, 1.0, True);

    end;

    // shutdown event
    geShutdown:
    begin
      // unload music
      AudioUnloadMusic(FMusic);

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

      if not TimerFrameSpeed(FTimer, TimerUpdateSpeed) then Exit;
      InputGetMouseInfo(@MousePos, nil);

      FBead[0].X := MousePos.X;
      FBead[0].Y := MousePos.Y;

      if FBead[0].X - (cBeadSize+10)/2 < 0 then
       FBead[0].X := (cBeadSize+10)/2;

      if FBead[0].X + ((cBeadSize+10)/2) > LViewport.Width then
       FBead[0].X := LViewport.Width - (cBeadSize+10)/2;

      if FBead[0].Y - ((cBeadSize+10)/2) < 0 then
       FBead[0].Y := (cBeadSize+10)/2;

      if FBead[0].Y + ((cBeadSize+10)/2) > LViewport.Height then
       FBead[0].Y := LViewport.Height - (cBeadSize+10)/2;

      // loop though other beads
      for i := 1 to cBeadCount do
      begin
        // calc X and Y distance between the bead and the one before it
        LDistX := FBead[i].X - FBead[i-1].X;
        LDistY := FBead[i].Y - FBead[i-1].Y;

        // calc total distance
        LDist := sqrt(LDistX*LDistX + LDistY * LDistY);

        // if the beads are far enough apart, decrease the movement to create elasticity
        if LDist > cSlackness then
        begin
           FBead[i].XMove := FBead[i].XMove - (cXElasticity * LDistX);
           FBead[i].YMove := FBead[i].YMove - (cYElasticity * LDistY);
        end;

        // if bead is not last bead
        if i <> cBeadCount then
        begin
           // calc distances between the bead and the one after it
           LDistX := FBead[i].X - FBead[i+1].X;
           LDistY := FBead[i].Y - FBead[i+1].Y;
           LDist  := sqrt(LDistX*LDistX + LDistY*LDistY);

           // if beads are far enough apart, decrease the movement to create elasticity
           if LDist > 1 then
           begin
              FBead[i].XMove := FBead[i].XMove - (cXElasticity * LDistX);
              FBead[i].YMove := FBead[i].YMove - (cYElasticity * LDistY);
           end;
        end;

        // decay the movement of the beads to simulate loss of energy
        FBead[i].XMove := FBead[i].XMove * cXDecay;
        FBead[i].YMove := FBead[i].YMove * cYDecay;

        // apply cGravity to bead movement
        FBead[i].YMove := FBead[i].YMove + cGravity;

        // move beads
        FBead[i].X := FBead[i].X + FBead[i].XMove;
        FBead[i].Y := FBead[i].Y + FBead[i].YMove;

        // ff the beads hit a wall, make them bounce off of it
        if FBead[i].X - ((cBeadSize + 10 ) / 2) < 0 then
        begin
           FBead[i].X     :=  FBead[i].X     + (cBeadSize+10)/2;
           FBead[i].XMove := -FBead[i].XMove * cWallDecay;
        end;

        if FBead[i].X + ((cBeadSize+10)/2) > LViewport.Width then
        begin
           FBead[i].X     := LViewport.Width - (cBeadSize+10)/2;
           FBead[i].xMove := -FBead[i].XMove * cWallDecay;
        end;

        if FBead[i].Y - ((cBeadSize+10)/2) < 0 then
        begin
           FBead[i].YMove := -FBead[i].YMove * cWallDecay;
           FBead[i].Y     :=(cBeadSize+10)/2;
        end;

        if FBead[i].Y + ((cBeadSize+10)/2) > LViewport.Height then
        begin
           FBead[i].YMove := -FBead[i].YMove * cWallDecay;
           FBead[i].Y     := LViewport.Height - (cBeadSize+10)/2;
        end;
      end;
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
      // draw last bead
      WindowDrawFilledRect(FBead[0].X, FBead[0].Y, cBeadSize, cBeadSize, GREEN, bmBlend);

      // loop though other beads
      for I := 1 to cBeadCount do
      begin
        // draw bead and string from it to the one before it
        WindowDrawLine(FBead[i].x+cBedHalfSize,
          FBead[i].y+cBedHalfSize, FBead[i-1].x+cBedHalfSize,
          FBead[i-1].y+cBedHalfSize, YELLOW, bmBlend);
        WindowDrawFilledRect(FBead[i].X, FBead[i].Y, cBeadSize,
         cBeadSize, GREEN, bmBlend);
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
