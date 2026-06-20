Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipPath = "c:\Users\sujal\OneDrive\Desktop\Desktop\chess-portfolio.zip"
$destPath = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\index.html"

$zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
$entry = $zip.Entries | Where-Object { $_.FullName -match "index\.html$" }

if ($entry) {
    [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $destPath, $true)
    Write-Host "Successfully restored index.html from zip!" -ForegroundColor Green
} else {
    Write-Host "Error: Could not find index.html in zip!" -ForegroundColor Red
}

$zip.Dispose()
