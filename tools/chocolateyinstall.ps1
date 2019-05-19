$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installLocation = "$ENV:LocalAppData\Programs\Doomseeker"
$startMenuLocation = "$ENV:AppData\Microsoft\Windows\Start Menu\Programs\Doomseeker"
New-Item -ItemType Directory -Force -Path $installLocation
New-Item -ItemType Directory -Force -Path $startMenuLocation
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $installLocation
  url           = 'https://doomseeker.drdteam.org/files/doomseeker-1.2_windows.zip'
  softwareName  = 'doomseeker*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  checksum      = '461066E4F3AB85A5B0CBED442201B877'
  checksumType  = 'md5' #default is md5, can also be sha1, sha256 or sha512
}
Install-ChocolateyZipPackage @packageArgs # https://chocolatey.org/docs/helpers-install-chocolatey-zip-package

Install-ChocolateyShortcut `
  -ShortcutFilePath "$startMenuLocation\Doomseeker.lnk" `
  -TargetPath "$installLocation\Doomseeker.exe" `
  -IconLocation "$installLocation\Doomseeker.exe" `
  -Description "Doomseeker version 1.2.0" `
  -WorkingDirectory "$installLocation"

Install-ChocolateyShortcut `
  -ShortcutFilePath "$ENV:UserProfile\Desktop\Doomseeker.lnk" `
  -TargetPath "$installLocation\Doomseeker.exe" `
  -IconLocation "$installLocation\Doomseeker.exe" `
  -Description "Doomseeker version 1.2.0" `
  -WorkingDirectory "$installLocation"
