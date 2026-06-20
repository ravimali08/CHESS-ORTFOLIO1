# update_all_navs.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"

$oldNavPattern = '(?s)<nav class="absolute left-1/2 -translate-x-1/2 hidden xl:flex flex-row flex-nowrap items-center gap-5 min-\[1400px\]:gap-8">.*?</nav>'

$newNav = '<nav class="absolute left-1/2 -translate-x-1/2 hidden xl:grid grid-cols-8 gap-0 justify-items-center w-[760px] min-[1400px]:w-[880px] items-center"><a :href="homeHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''home'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Home</a><a :href="aboutHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''about'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">About</a><a :href="eventsHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''events'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Events</a><a :href="tournamentsHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''tournaments'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Tournaments</a><a :href="membershipHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''membership'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Membership</a><a :href="coachesHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''coaches'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Coaches</a><a :href="blogHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''blog'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Blog</a><a :href="contactHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === ''contact'' ? ''text-white underline underline-offset-8 decoration-white/20'' : ''text-white/50 hover:text-white''">Contact</a></nav>'

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "scratch" -or $file.Name -eq "images") { continue }
    
    $content = Get-Content $file.FullName -Raw
    if ($content -match $oldNavPattern) {
        $content = $content -replace $oldNavPattern, $newNav
        Set-Content $file.FullName -Value $content -NoNewline
        Write-Output "Updated: $($file.Name)"
    } else {
        if ($content -like '*grid-cols-8*') {
            Write-Output "Already updated: $($file.Name)"
        } else {
            Write-Output "No match: $($file.Name)"
        }
    }
}
