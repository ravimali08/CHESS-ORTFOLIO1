# check_registration_headers.ps1
$files = @("register-event.html", "register-tournament.html", "free-trial.html", "account-setup.html")
foreach ($file in $files) {
    $path = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\$file"
    if (Test-Path $path) {
        $content = Get-Content $path -Raw
        if ($content -match '(?s)(<header[^>]*>.*?<\/header>)') {
            Write-Output "=== $file ==="
            Write-Output $Matches[1]
            Write-Output ""
        } else {
            Write-Output "=== $file (NO HEADER MATCH) ==="
        }
    }
}
