# check_all_spaces.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match '<nav[^>]*hidden xl:flex[^>]*>(.*?)<\/nav>') {
        $navContent = $Matches[1]
        # Find all <a> tags
        $matches_a = [regex]::Matches($navContent, '<a[^>]*>(.*?)<\/a>')
        foreach ($m in $matches_a) {
            $text = $m.Groups[1].Value
            # Check if text contains leading/trailing spaces or newlines
            if ($text -match '^\s|\s$|\r|\n') {
                Write-Output "$($file.Name): Found spacing in '$text'"
            }
        }
    }
}
