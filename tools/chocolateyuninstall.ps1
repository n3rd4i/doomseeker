$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. "$toolsDir\commonEnv.ps1"

Remove-Item $installLocation -recurse -force
Remove-Item $startMenuLocation -recurse -force
