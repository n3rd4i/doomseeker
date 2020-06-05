import-module au

$domain   = 'http://doomseeker.drdteam.org'
$releases = "$domain/files"

function global:au_SearchReplace {
  @{ 
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   	= "`$1'$($Latest.Checksum32)'"
    }
  }
}

function global:au_GetLatest {
     $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing #1
     $regex   = 'doomseeker-\d+.\d+(.\d+)?_windows.zip'
     $url_raw     = $download_page.links | ? href -match $regex | Sort-Object | select -First 1 -expand href #2
     $url     = "$releases/$url_raw"
     $token = $url_raw -split 'doomseeker-' | select -First 1 -Skip 1 #3
     $version = $token -split '_windows.zip' | select -Last 1 -Skip 1 #3
     return @{ Version = $version; URL32 = $url }
}

update -ChecksumFor 32
