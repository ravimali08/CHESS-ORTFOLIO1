$htmlFiles = Get-ChildItem -Path . -Filter *.html
Write-Host "Found $($htmlFiles.Count) HTML files in the folder."
Write-Host "--------------------------------------------------"

$allFiles = @{}
foreach ($f in $htmlFiles) {
    $allFiles[$f.Name] = $true
}

$errors = 0
foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    
    # Regex to find href and :href values
    # Match href="value" or :href="value"
    $matches = [regex]::Matches($content, '(?i)(?:href|:href)\s*=\s*"([^"]+)"')
    
    Write-Host "File: $($file.Name)" -ForegroundColor Cyan
    $links = @()
    foreach ($m in $matches) {
        $link = $m.Groups[1].Value
        
        # Skip mailto, tel, javascript, anchors starting with #, or vue variable expressions
        if ($link -match '^mailto:' -or $link -match '^tel:' -or $link -match '^javascript:' -or $link -match '^#' -or $link -match 'Href$') {
            continue
        }
        
        # Skip dynamic function/object bindings like getFeaturedArticle().link, art.link
        if ($link -match '^getFeaturedArticle' -or $link -match '^art\.') {
            continue
        }
        
        # If it's an external link
        if ($link -match '^https?:') {
            continue
        }
        
        $links += $link
        
        # Check if the linked file exists locally (strip hash and query parameters)
        $cleanLink = $link.Split('?')[0].Split('#')[0]
        if (-not $allFiles.ContainsKey($cleanLink)) {
            Write-Host "  [BROKEN LINK] -> $link" -ForegroundColor Red
            $errors++
        }
    }
    
    $uniqueLinks = $links | Sort-Object -Unique
    Write-Host "  Links: $($uniqueLinks -join ', ')"
}

Write-Host "--------------------------------------------------"
if ($errors -gt 0) {
    Write-Host "Total Errors: $errors" -ForegroundColor Red
} else {
    Write-Host "Total Errors: $errors" -ForegroundColor Green
}
