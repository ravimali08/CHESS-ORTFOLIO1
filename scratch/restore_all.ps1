Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipPath = "c:\Users\sujal\OneDrive\Desktop\Desktop\chess-portfolio.zip"

$zip = [System.IO.Compression.ZipFile]::OpenRead($zipPath)

$filesToRestore = @("index.html", "account-setup.html")

foreach ($fileName in $filesToRestore) {
    $destPath = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\$fileName"
    $entry = $zip.Entries | Where-Object { $_.FullName -match "$fileName$" }
    
    if ($entry) {
        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $destPath, $true)
        Write-Host "Successfully restored $fileName from zip!" -ForegroundColor Green
    } else {
        Write-Host "Error: Could not find $fileName in zip!" -ForegroundColor Red
    }
}

$zip.Dispose()
