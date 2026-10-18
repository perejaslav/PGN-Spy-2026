# Builds PGN Spy and packs a release zip locally.
# Run from a "Developer PowerShell for VS 2022":
#   .\scripts\package.ps1 -Version 1.2.3 -PgnExtract 'D:\path\to\pgn-extract.exe'
param(
    [Parameter(Mandatory = $true)][string]$Version,
    [Parameter(Mandatory = $true)][string]$PgnExtract
)
$ErrorActionPreference = 'Stop'
Set-Location (Split-Path $PSScriptRoot -Parent)

msbuild 'PGN Spy.sln' /t:Build /m /p:Configuration=Release /p:Platform=Win32
if ($LASTEXITCODE -ne 0) { throw 'Build failed' }

$name = "PGN-Spy-v$Version-win32"
$dir = "dist\$name"
Remove-Item $dir -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force $dir | Out-Null
Copy-Item 'Release\PGN Spy.exe', 'Release\uci-analyser.exe', $PgnExtract $dir
Copy-Item README.md, README.ru.md, ReadMe.txt, LICENSE $dir
Compress-Archive -Path "$dir\*" -DestinationPath "dist\$name.zip" -Force
Write-Host "Created dist\$name.zip"
