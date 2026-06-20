# check_navs.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"
$results = @()
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match '(<nav[^>]*hidden xl:(flex|grid)[^>]*>.*?<\/nav>)') {
        $nav = $Matches[1]
        $results += [PSCustomObject]@{
            File = $file.Name
            Nav  = $nav
        }
    } else {
        $results += [PSCustomObject]@{
            File = $file.Name
            Nav  = "NO NAV MATCH"
        }
    }
}

$grouped = $results | Group-Object -Property Nav
foreach ($g in $grouped) {
    Write-Output "=== Group (Count: $($g.Count)) ==="
    Write-Output "Nav HTML: $($g.Name)"
    Write-Output "Files: $( ($g.Group | Select-Object -ExpandProperty File) -join ', ' )"
    Write-Output ""
}
