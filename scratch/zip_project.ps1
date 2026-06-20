$srcDir = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"
$zipPath = "c:\Users\sujal\OneDrive\Desktop\Desktop\chess-portfolio.zip"

Write-Host "Creating updated chess-portfolio.zip..." -ForegroundColor Cyan

# Remove old zip if it exists
if (Test-Path $zipPath) {
    Remove-Item $zipPath -Force
    Write-Host "Removed old zip file."
}

# Create a temporary directory to copy only target website files
$tempDir = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), [System.IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Copy website files (HTML, Images, images directory)
Get-ChildItem -Path $srcDir | Where-Object {
    $_.Name -notmatch "^0\d-" -and # Exclude backup step files like 01-royal...
    $_.Name -ne "scratch" -and     # Exclude scratch directory
    $_.Name -ne "server.ps1"       # Exclude local dev server script
} | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $tempDir -Recurse -Force
}

# Compress the temporary folder into the zip file
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $zipPath)

# Clean up temporary directory
Remove-Item -Path $tempDir -Recurse -Force

Write-Host "Website successfully zipped into: $zipPath" -ForegroundColor Green
