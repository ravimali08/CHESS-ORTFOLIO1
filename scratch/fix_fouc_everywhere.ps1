$dir = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"
Write-Host "Starting global FOUC fix across all files..." -ForegroundColor Cyan

# Core pages list (excluding old step backup files)
$coreFiles = @(
    "index.html", "about.html", "programs.html", "events.html", "membership.html",
    "coaches.html", "tournaments.html", "gallery.html", "testimonials.html",
    "faq.html", "blog.html", "blog-post-1.html", "blog-post-2.html", "blog-post-3.html",
    "blog-post-4.html", "blog-post-5.html", "blog-post-6.html", "contact.html", 
    "account-setup.html", "free-trial.html", "join.html", "register-event.html", "register-tournament.html"
)

foreach ($fileName in $coreFiles) {
    $filePath = Join-Path $dir $fileName
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllText($filePath)
        $changed = $false
        
        # 1. Add v-cloak CSS rule to the first style tag
        if ($content -notmatch '\[v-cloak\]') {
            $regexStyle = [regex]'(?i)</style>'
            $content = $regexStyle.Replace($content, "`n[v-cloak] { display: none !important; }`n</style>", 1)
            Write-Host "  Added [v-cloak] CSS rule to: $fileName" -ForegroundColor Green
            $changed = $true
        }
        
        # 2. Add v-cloak attribute to all v-scope tags using regex lookbehind
        # This replaces "v-scope=" with "v-cloak v-scope=" only if it is not preceded by "v-cloak"
        $newContent = [regex]::Replace($content, '(?ms)(?<!v-cloak\s+)v-scope\s*=\s*', 'v-cloak v-scope=')
        
        if ($newContent -ne $content) {
            $content = $newContent
            Write-Host "  Added v-cloak attribute to v-scope tag(s) in: $fileName" -ForegroundColor Green
            $changed = $true
        }
        
        if ($changed) {
            [System.IO.File]::WriteAllText($filePath, $content)
        } else {
            Write-Host "  No changes needed for: $fileName" -ForegroundColor DarkGreen
        }
        
    } else {
        Write-Host "  Warning: File not found - $fileName" -ForegroundColor Yellow
    }
}

Write-Host "Global FOUC fix completed across all pages!" -ForegroundColor Cyan
