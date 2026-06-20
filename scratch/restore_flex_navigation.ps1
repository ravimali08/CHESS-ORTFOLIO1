# restore_flex_navigation.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"

$oldNavPattern = '(?s)<nav class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 hidden xl:grid grid-cols-8 gap-0 justify-items-center w-\[640px\] min-\[1400px\]:w-\[760px\] items-center">.*?</nav>'

$newNav = '<nav class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 hidden xl:flex flex-row flex-nowrap items-center gap-6 min-[1400px]:gap-8"><a :href="homeHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''home'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Home</a><a :href="aboutHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''about'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">About</a><a :href="eventsHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''events'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Events</a><a :href="tournamentsHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''tournaments'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Tournaments</a><a :href="membershipHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''membership'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Membership</a><a :href="coachesHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''coaches'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Coaches</a><a :href="blogHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''blog'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Blog</a><a :href="contactHref" class="text-[13px] font-medium tracking-wide transition-all flex-shrink-0" :class="activeItem === ''contact'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Contact</a></nav>'

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "scratch" -or $file.Name -eq "images") { continue }
    
    $content = Get-Content $file.FullName -Raw
    if ($content -match $oldNavPattern) {
        $content = $content -replace $oldNavPattern, $newNav
        Set-Content $file.FullName -Value $content -NoNewline
        Write-Output "Restored flex layout: $($file.Name)"
    } else {
        if ($content -like '*flex-shrink-0*') {
            Write-Output "Already restored or matches: $($file.Name)"
        } else {
            Write-Output "No old nav match: $($file.Name)"
        }
    }
}
