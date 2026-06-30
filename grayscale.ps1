$files = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\*.html"
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $newContent = $content -replace '</head>', '<style> img, video, [style*="background-image"], .bg-cover, .bg-center, .hero-mesh { filter: grayscale(100%) !important; }</style></head>'
    Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
}
