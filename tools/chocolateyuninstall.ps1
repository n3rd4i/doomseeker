$ErrorActionPreference = 'Stop'; # stop on all errors
$installLocation = "$ENV:LocalAppData\Programs\Doomseeker"
$startMenuLocation = "$ENV:AppData\Microsoft\Windows\Start Menu\Programs\Doomseeker"
$shortcutPath = "$ENV:UserProfile\Desktop\Doomseeker.lnk"
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'ZIP'
  softwareName  = 'doomseeker*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique
  zipFileName   = 'doomseeker-1.2_windows.zip'
}
Remove-Item $installLocation -recurse -force
Remove-Item $startMenuLocation -force
Remove-Item $shortcutPath -force

$uninstalled = $false
[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % { 
    $packageArgs['file'] = "$($_.UninstallString)" #NOTE: You may need to split this if it contains spaces, see below
    
    if ($packageArgs['fileType'] -eq 'MSI') {
      $packageArgs['silentArgs'] = "$($_.PSChildName) $($packageArgs['silentArgs'])"
      $packageArgs['file'] = ''
    } else {
    }
    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}
