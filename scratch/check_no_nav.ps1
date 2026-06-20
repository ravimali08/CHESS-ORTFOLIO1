# check_no_nav.ps1
$files = @("account-setup.html", "free-trial.html", "join.html", "register-event.html", "register-tournament.html")
foreach ($file in $files) {
    $path = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\$file"
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        if ($content -match '(<header[^>]*>.*?<\/header>)') {
            Write-Output "--- $file ---"
            Write-Output $Matches[1]
        } else {
            Write-Output "--- $file (NO HEADER) ---"
        }
    }
}
