$indexFile = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\index.html"
$setupFile = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\account-setup.html"

# 1. Update index.html Testimonials header
if (Test-Path $indexFile) {
    $content = [System.IO.File]::ReadAllText($indexFile)
    
    $targetIndex = @"
<div class="container mx-auto max-w-[1440px] px-5 md:px-12 mb-16">
<div class="flex items-center gap-3 mb-6">
<span class="w-8 h-[1px] bg-white/30">
</span>
<span class="text-[10px] font-bold tracking-[0.4em] text-white/40 uppercase">Social Proof</span>
</div>
<h2 class="text-4xl md:text-6xl font-light serif-title text-white tracking-tight"> Hear from our members. </h2>
</div>
"@

    $replacementIndex = @"
<div class="container mx-auto max-w-[1440px] px-5 md:px-12 mb-16 flex flex-col md:flex-row md:items-end md:justify-between gap-6">
<div>
<div class="flex items-center gap-3 mb-6">
<span class="w-8 h-[1px] bg-white/30">
</span>
<span class="text-[10px] font-bold tracking-[0.4em] text-white/40 uppercase">Social Proof</span>
</div>
<h2 class="text-4xl md:text-6xl font-light serif-title text-white tracking-tight"> Hear from our members. </h2>
</div>
<a href="testimonials.html" class="text-xs uppercase tracking-[0.2em] font-bold text-white/50 hover:text-white transition-colors flex items-center gap-2 mt-4 md:mt-0 flex-shrink-0 min-h-[44px]">
View All Reviews 
<iconify-icon icon="lucide:arrow-right" class="text-sm"></iconify-icon>
</a>
</div>
"@

    # Remove any Windows vs Unix line ending discrepancy by normalizing to CRLF before replacement
    $content = $content -replace "`r`n", "`n" -replace "`n", "`r`n"
    $targetIndex = $targetIndex -replace "`r`n", "`n" -replace "`n", "`r`n"
    $replacementIndex = $replacementIndex -replace "`r`n", "`n" -replace "`n", "`r`n"
    
    if ($content.Contains($targetIndex)) {
        $content = $content.Replace($targetIndex, $replacementIndex)
        [System.IO.File]::WriteAllText($indexFile, $content)
        Write-Host "Successfully updated testimonials header in index.html!" -ForegroundColor Green
    } else {
        Write-Host "Warning: Could not find target testimonials header in index.html!" -ForegroundColor Yellow
    }
}

# 2. Update account-setup.html form and buttons
if (Test-Path $setupFile) {
    $content = [System.IO.File]::ReadAllText($setupFile)
    
    # Normalize line endings
    $content = $content -replace "`r`n", "`n" -replace "`n", "`r`n"
    
    # Form tag replacement
    $targetForm = '<form class="space-y-12">'
    $replacementForm = '<form onsubmit="alert(' + "'Profile setup complete! Welcome to the Royal Knights Chess Club.'" + '); window.location.href=' + "'index.html'" + '; return false;" class="space-y-12">'
    
    if ($content.Contains($targetForm)) {
        $content = $content.Replace($targetForm, $replacementForm)
        Write-Host "Updated form submit handler in account-setup.html!" -ForegroundColor Green
    } else {
        Write-Host "Warning: Could not find <form class=""space-y-12""> in account-setup.html!" -ForegroundColor Yellow
    }
    
    # Buttons replacement
    $targetButtons = @"
<div class="flex flex-col sm:flex-row gap-6 justify-between items-center">
<button type="button" class="order-2 sm:order-1 text-[11px] uppercase tracking-[0.3em] text-white/40 hover:text-white transition-colors py-4 px-8">Save as Draft</button>
<button type="submit" class="order-1 sm:order-2 w-full sm:w-auto px-12 py-5 bg-white text-black text-[12px] font-bold uppercase tracking-[0.3em] rounded-sm transition-all hover:scale-105 active:scale-95">Proceed to Payment</button>
</div>
"@

    $replacementButtons = @"
<div class="flex flex-col sm:flex-row gap-6 justify-between items-center">
<button type="button" onclick="alert('Draft progress saved successfully.')" class="order-2 sm:order-1 text-[11px] uppercase tracking-[0.3em] text-white/40 hover:text-white transition-colors py-4 px-8">Save as Draft</button>
<button type="submit" class="order-1 sm:order-2 w-full sm:w-auto px-12 py-5 bg-white text-black text-[12px] font-bold uppercase tracking-[0.3em] rounded-sm transition-all hover:scale-105 active:scale-95">Complete Setup</button>
</div>
"@

    $targetButtons = $targetButtons -replace "`r`n", "`n" -replace "`n", "`r`n"
    $replacementButtons = $replacementButtons -replace "`r`n", "`n" -replace "`n", "`r`n"
    
    if ($content.Contains($targetButtons)) {
        $content = $content.Replace($targetButtons, $replacementButtons)
        Write-Host "Updated draft & submit buttons in account-setup.html!" -ForegroundColor Green
    } else {
        Write-Host "Warning: Could not find target buttons in account-setup.html!" -ForegroundColor Yellow
    }
    
    [System.IO.File]::WriteAllText($setupFile, $content)
}

Write-Host "Replacements completed!" -ForegroundColor Cyan
