# check_spaces.ps1
$path = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\tournaments.html"
$content = Get-Content $path -Raw
if ($content -match '<nav[^>]*>(.*?)<\/nav>') {
    $navContent = $Matches[1]
    Write-Output "Nav Content: $navContent"
    # Find all <a> tags
    $matches_a = [regex]::Matches($navContent, '<a[^>]*>(.*?)<\/a>')
    foreach ($m in $matches_a) {
        $text = $m.Groups[1].Value
        Write-Output "Link text: '$text' (length: $($text.Length))"
        # Print byte array to check for hidden characters
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($text)
        Write-Output "Bytes: $($bytes -join ' ')"
    }
} else {
    Write-Output "Nav not found"
}
