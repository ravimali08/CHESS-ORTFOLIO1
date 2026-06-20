$dir = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"
Write-Host "Starting global FOUC fix..." -ForegroundColor Cyan

# Files to update
$files = @(
    "join.html",
    "register-event.html",
    "register-tournament.html",
    "free-trial.html",
    "contact.html",
    "blog.html",
    "blog-post-1.html",
    "blog-post-2.html",
    "blog-post-3.html",
    "blog-post-4.html",
    "blog-post-5.html",
    "blog-post-6.html"
)

foreach ($fileName in $files) {
    $filePath = Join-Path $dir $fileName
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllText($filePath)
        
        # 1. Add v-cloak CSS rule to the first style tag
        if ($content -notmatch '\[v-cloak\]') {
            $regex = [regex]'(?i)</style>'
            $content = $regex.Replace($content, "`n[v-cloak] { display: none !important; }`n</style>", 1)
            Write-Host "  Added [v-cloak] style rule to: $fileName" -ForegroundColor Green
        } else {
            Write-Host "  [v-cloak] style rule already exists in: $fileName" -ForegroundColor DarkGreen
        }
        
        # 2. Add v-cloak attribute to the target v-scope container
        $updatedScope = $false
        
        if ($fileName -eq "join.html" -or $fileName -eq "register-event.html" -or $fileName -eq "register-tournament.html" -or $fileName -eq "free-trial.html") {
            # Target: <div v-scope="{
            # Make sure it doesn't already have v-cloak
            if ($content -match '<div v-scope="\{' -and $content -notmatch '<div v-cloak v-scope="\{') {
                $content = $content.Replace('<div v-scope="{', '<div v-cloak v-scope="{')
                $updatedScope = $true
            }
        } elseif ($fileName -eq "contact.html") {
            # Target: <div v-scope="{ name: '', email: '', subject: '', message: '', submitted: false }"
            $target = '<div v-scope="{ name: ' + "''" + ', email: ' + "''" + ', subject: ' + "''" + ', message: ' + "''" + ', submitted: false }"'
            $replacement = '<div v-cloak v-scope="{ name: ' + "''" + ', email: ' + "''" + ', subject: ' + "''" + ', message: ' + "''" + ', submitted: false }"'
            if ($content.Contains($target) -and -not $content.Contains($replacement)) {
                $content = $content.Replace($target, $replacement)
                $updatedScope = $true
            }
        } elseif ($fileName -eq "blog.html" -or $fileName -match "blog-post-\d\.html") {
            # Target: <main class="flex-1" v-scope="{
            if ($content -match '<main class="flex-1" v-scope="\{' -and $content -notmatch '<main class="flex-1" v-cloak v-scope="\{') {
                $content = $content.Replace('<main class="flex-1" v-scope="{', '<main class="flex-1" v-cloak v-scope="{')
                $updatedScope = $true
            }
        }
        
        if ($updatedScope) {
            Write-Host "  Added v-cloak attribute to v-scope container in: $fileName" -ForegroundColor Green
            [System.IO.File]::WriteAllText($filePath, $content)
        } else {
            Write-Host "  v-cloak attribute already present or not applicable in: $fileName" -ForegroundColor DarkGreen
        }
        
    } else {
        Write-Host "  Warning: File not found - $fileName" -ForegroundColor Yellow
    }
}

Write-Host "FOUC fix completed!" -ForegroundColor Cyan
