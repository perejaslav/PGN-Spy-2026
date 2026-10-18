# Windows 11 Build Notes

PGN Spy now targets `PlatformToolset=v143` and `WindowsTargetPlatformVersion=10.0.22621.0` by default.

## Required Visual Studio components

- MSVC v143 build tools
- Windows 11 SDK `10.0.22621.0`
- MFC libraries for the selected architecture

Without MFC, `PGN Spy.vcxproj` fails with `MSB8041`.

## Build commands

Use the Visual Studio 2022 developer environment or call `vcvars32.bat` first.

Build `uci-analyser`:

```powershell
msbuild 'uci-analyser\uci-analyser.vcxproj' /t:Build /p:Configuration=Release;Platform=Win32
```

Build the GUI:

```powershell
msbuild 'PGN Spy\PGN Spy.vcxproj' /t:Build /p:Configuration=Release;Platform=Win32
```

Build the full solution:

```powershell
msbuild 'PGN Spy.sln' /t:Build /p:Configuration=Release;Platform=Win32
```

## Runtime files

To run the GUI successfully, keep these files together in the application folder:

- `PGN Spy.exe`
- `uci-analyser.exe`
- `pgn-extract.exe`

`stockfish.exe` can live anywhere, because the GUI stores the absolute engine path in its settings.

## Packing a release zip locally

```powershell
.\scripts\package.ps1 -Version 1.2.3 -PgnExtract 'D:\path\to\pgn-extract.exe'
```

The zip is written to `dist\`.

## GitHub Actions

`.github/workflows/release.yml` builds the solution on `windows-2022` (the image that ships MFC) for every push to `master` and every pull request. The zip is attached to the run as an artifact.

To publish a release, run the workflow manually (Actions → Build and release → Run workflow) and enter a version such as `1.2.3`. It needs `docs/releases/vX.Y.Z.ru.md` and `.en.md`. Running it again for an existing version replaces that release, its tag and zip with the current commit. `pgn-extract.exe` is taken from the v1.2.1 release.

## Linux

`uci-analyser` also builds on Linux:

```sh
cd uci-analyser && make
```

## Verified in this repository

- Both projects build with VS 2022 locally and on GitHub Actions (0 errors, 0 warnings).
- `uci-analyser` runs correctly against Stockfish 18 on Windows and against Stockfish on Linux.
- `Setup/Setup.vdproj` is a legacy installer project; it is not built and references old Stockfish versions.
