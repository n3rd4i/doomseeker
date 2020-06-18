$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = 'http://doomseeker.drdteam.org/files/doomseeker-1.3.1_windows.zip'
  checksum      = '833496437c06b5ff6a8c8f423e5e48754fed70c1742ed7b042ff6305f6237699'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut "$(Join-Path $startMenuLocation 'Doomseeker.lnk')" `
  -TargetPath "$(Join-Path $installLocation 'Doomseeker.exe')" `
  -WorkingDirectory "$installLocation"
