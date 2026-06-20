$srcDir = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"

Write-Host "Applying White Flash Prevention Fix to all HTML files..." -ForegroundColor Cyan

# Find all HTML files
$htmlFiles = Get-ChildItem -Path $srcDir -Filter "*.html" -Recurse

foreach ($file in $htmlFiles) {
    # Skip backup step files
    if ($file.Name -match "^0\d-") { continue }
    if ($file.FullName -like "*\scratch\*") { continue }

    Write-Host "Processing $($file.Name)..." -ForegroundColor Yellow

    $content = Get-Content -Path $file.FullName -Raw

    # We want to insert the style block immediately after <head>
    # Check if the block is already inserted
    if ($content -like "*/* White Flash Fix */*") {
        Write-Host "Already has White Flash Fix. Skipping." -ForegroundColor Green
        continue
    }

    # Inject the style block immediately after <head>
    # We use a comment to easily identify and prevent double insertion
    $styleBlock = @"
<head>
  <!-- White Flash Fix -->
  <style>
    html, body {
      background-color: #050508 !important;
      background: #050508 !important;
    }
  </style>
"@

    # Replace <head> with <head> + style block
    # We do case-insensitive replacement
    if ($content -match "<head>") {
        $content = $content -replace "<head>", $styleBlock
        Set-Content -Path $file.FullName -Value $content -NoNewline
        Write-Host "Successfully injected White Flash Fix." -ForegroundColor Green
    } else {
        Write-Host "Warning: <head> tag not found in $($file.Name)" -ForegroundColor Red
    }
}

Write-Host "White Flash Fix propagation complete!" -ForegroundColor Green
