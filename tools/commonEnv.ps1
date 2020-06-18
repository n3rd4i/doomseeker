$appName = 'Doomseeker'
$installLocation = [IO.Path]::Combine($ENV:LocalAppData, 'Programs', $appName.toLower())
$startMenuLocation = [IO.Path]::Combine($ENV:AppData, 'Microsoft\Windows\Start Menu\Programs', $appName)
