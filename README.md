<a href="https://gamepascal.org" target="_blank">![GamePascal Logo](media/logo.png)</a>

[![Chat on Discord](https://img.shields.io/discord/754884471324672040.svg?logo=discord)](https://discord.gg/tPWjMwK) [![GitHub stars](https://img.shields.io/github/stars/tinyBigGAMES/GamePascal?style=social)](https://github.com/tinyBigGAMES/GamePascal/stargazers) [![GitHub Watchers](https://img.shields.io/github/watchers/tinyBigGAMES/GamePascal?style=social)](https://github.com/tinyBigGAMES/GamePascal/network/members) [![GitHub forks](https://img.shields.io/github/forks/tinyBigGAMES/GamePascal?style=social)](https://github.com/tinyBigGAMES/GamePascal/network/members)
[![Twitter Follow](https://img.shields.io/twitter/follow/tinyBigGAMES?style=social)](https://twitter.com/tinyBigGAMES)

## Overview
GamePascal&trade; is a professional indie game toolkit that allows you to do 2D game development in using the <a href="https://en.wikipedia.org/wiki/Object_Pascal" target="_blank">Object Pascal</a> language. Officially supporting <a href="https://www.embarcadero.com/products/delphi" target="_blank"> Embarcadero Delphi®</a> and <a href="https://www.freepascal.org/" target="_blank">FreePascal</a> compilers on desktop PC's running Microsoft Windows® and uses Direct3D® for hardware accelerated rendering.

It's robust, designed for easy use and suitable for making all types of 2D games and other graphic simulations. You access the features from a simple and intuitive API, to allow you to develop your projects rapidly and efficiently. There is support for textures, audio samples, streaming music, video playback, loading resources directly from a compressed and encrypted archive, a thin object-oriented actor/scene system, collision detection and much more. GamePascal, make 2D games in Pascal. Easy, fast & fun!

Please star this repo by clicking the Star box in the top right corner if you find it useful!

## Downloads
<a href="https://github.com/tinyBigGAMES/GamePascal/archive/refs/heads/main.zip" target="_blank">**Development**</a> - This build represents the most recent development state an as such may or may not be as stable as the official release versions. If you like living on the bleeding edge, it's updated frequently (often daily) and will contain bug fixes and new features.

<a href="https://github.com/tinyBigGAMES/GamePascal/releases" target="_blank">**Releases**</a> - These are the official release versions and deemed to be the most stable.

## Features
- Written in **Object Pascal**
- Support Windows 64 bit platform
- Hardware accelerated with **Direct3D**
- You interact with GamePascal from routines in the `GaamePascal` unit.
- **Archive** (custom archive format, password protected)
- **Window** (Direct3D, primitives, blending)
- **Input** (keyboard, mouse and game controller)
- **Texture** (color key transparency, scaling, rotation, flipped, tiled, JPEG, PNG)
- **Video** (play, pause, rewind, MPEG-1 format)
- **Audio** (samples, streams, OGG/Vorbis formats)
- **Font** (true type, scale, can render using vertex buffer)
- **Math** (point, vector, rect and other useful routines for 2D graphics)
- **Timing** (time-based, frame elapsed, frame speed)
- **Speech** (text-to-speech, change speed, pitch, select different voices)
- **Screenshake** (you can set duration and magnitude, they are accumulative)
- **Async** (push a task to run in the background, and optionally run a forground task after background task completes)
- **Sprite** (animated texture images organized into pages and groups)
- **Entity** (sprite objects, that has position, color, can be scaled and rotated)
- **Misc** (collision, easing, screenshot, colors, logging and other useful utility routines)
- And more. See `GamePascal.pas` in `installdir\sources` and the docs in `installdir\docs` for more information about features.

## Minimum System Requirements
- Should work with any recent Delphi/FreePascal version that can target win64 and supports Unicode
- Should work on Windows 7+, 64 bits
- Direct3D 9

**NOTE: Made/tested on latest Windows/Delphi/FreePascal.** 

## Sponsor Benefits 
- The Software may be used by an unlimited number of developers to develop an unlimited number of commercial Products, which may be distributed to an unlimited number of clients, with no distribution or usage restrictions. 
- You will have priority support with access to our private DelphiGamekit development forum and discord channel.
- You will have access to private betas, documents, etc. and be able to help shape the direction of the product.
- You will be helping us continue developing this product, thank you in advance.

## Other ways to help
- I will make some examples and demos using this project.
- I will spread the word about this project.
- I wish to do X for this project.

Thank you very much for any support you can provide, I will be most grateful. :clap: 

## How to use
- Unzip the archive to a desired location.
- Add `installdir\sources`, folder to compiler's library path so the library source files can be found for any project or for a specific project add to its search path.
- Use `GVArc` utility for making archive files (standard zip, compressed, encrypted). Running `_makearc.bat` in `installdir\bin` will build `Data.arc` that is used by the examples. 
You can use `GPVideo.bat` and `GVAudio.bat` for video/audio conversion to formats compatiable with GPT. They use **FFmpeg** to do the actual conversion. Download and place `FFmpeg.exe` in the same location as `installdir\bin`. See `installdir\bin\ffmpeg.txt`.
- In Delphi, load `GamePascal.groupproj` to load and compile the examples which will showcase the toolkit features and how to use them.
- See examples in the `installdir\examples` folder for more information about usage.
- See `installdir\docs` folder for documentation.
- You must include the `GPL.dll` DLL in your project distribution.

## Known Issues
- This project is in active development so changes will be frequent 
- Documentation is WIP. They will continue to evolve
- More examples will continually be added over time

## A Tour of GamePascal
### Game Events
You just have to create a game event handler and respond to the various events that are issued by the library:
```pascal
uses
  GamePascal;

procedure GameEvents(aSender: Pointer; aType: TGameEventType; aParam: PGameEventParam);
begin
  case aType of
    geStartup:
    begin
      // game startup
    end;

    geShutdown:
    begin
      // game shutdown
    end;

    geUpdate:
    begin
      // game updates
    end;

    geRender:
    begin
      // game rendering
    end;

    geRenderHud:
    begin
      // game HUD rendering
    end;
  end;
end;

```
### How to use
A minimal implementation example:
```pascal
begin
  GameSetEventHandler(nil, GameEvents);
  GameRun;
end.
```

See the examples for more information on usage.

## Media
GamePascal Intro  

https://user-images.githubusercontent.com/69952438/211323153-a0480afd-70fb-43ab-ae96-52d1a4edebf2.mp4

## Support
Our development motto: 
- We will not release products that are buggy, incomplete, adding new features over not fixing underlying issues.
- We will strive to fix issues found with our products in a timely manner.
- We will maintain an attitude of quality over quantity for our products.
- We will establish a great rapport with users/customers, with communication, transparency and respect, always encouraging feedback to help shape the direction of our products.
- We will be decent, fair, remain humble and committed to the craft.

## Links:
- <a href="https://gamepascal.org" target="_blank">Website</a>
- <a href="mailto:support@tinybiggames.com" target="_blank">Email</a>
- <a href="https://github.com/tinyBigGAMES/GamePascal/issues" target="_blank">Issue Tracking</a>
- <a href="https://twitter.com/tinyBigGAMES" target="_blank">Twitter </a>
- <a href="https://discord.gg/JQqs8J9t9j" target="_blank">Discord</a> (#gamepascal)
- <a href="https://youtube.com/tinyBigGAMES" target="_blank">YouTube</a>

<p align="center">
 <a href="https://www.embarcadero.com/products/delphi" target="_blank"><img src="media/delphi.png"></a>
 <a href="https://www.freepascal.org" target="_blank"><img src="media/FreePascal.gif"></a><br/> 
 ♥ <b>Made for Pascal</b>
</p>

