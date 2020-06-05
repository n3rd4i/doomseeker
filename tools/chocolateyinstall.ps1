﻿$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$url = 'http://doomseeker.drdteam.org/files/doomseeker-1.3_windows.zip'
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = $url
  checksum      = '9A4134CE843DDBB05BD69D1B9DA7EDEB49935275DDAB5DC38B35C80C3DEFE327'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut "$(Join-Path $startMenuLocation 'Doomseeker.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'Doomseeker.exe')" `
  -WorkingDirectory "$installLocation"
