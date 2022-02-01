$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = 'http://doomseeker.drdteam.org/files/doomseeker-1.3.2_windows.zip'
  checksum      = 'b4f2feb451424129d5fe38d10a8509948dcb91f00be7861da83e413496cdb2ed'
  checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

Install-ChocolateyShortcut "$(Join-Path $startMenuLocation $appName).lnk" `
  -TargetPath "$(Join-Path $installLocation $appName).exe" `
  -WorkingDirectory "$installLocation"
