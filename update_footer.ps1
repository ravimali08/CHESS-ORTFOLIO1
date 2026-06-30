$files = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\*.html"
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $newFooter = @"
          <!-- Column 2: Navigation Links (Col-span-2) -->
          <div class="lg:col-span-2 space-y-4">
            <h4 class="text-[10px] font-bold tracking-[0.2em] uppercase text-white/40">Platform</h4>
            <ul class="space-y-2.5 text-[12px] font-light">
              <li><a href="index.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Home</a></li>
              <li><a href="about.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">About</a></li>
              <li><a href="events.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Events</a></li>
              <li><a href="tournaments.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Tournaments</a></li>
            </ul>
          </div>
          
          <!-- Column 3: Arena & Resources (Col-span-2) -->
          <div class="lg:col-span-2 space-y-4">
            <h4 class="text-[10px] font-bold tracking-[0.2em] uppercase text-white/40">More Pages</h4>
            <ul class="space-y-2.5 text-[12px] font-light">
              <li><a href="membership.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Membership</a></li>
              <li><a href="coaches.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Coaches</a></li>
              <li><a href="blog.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Blog</a></li>
              <li><a href="contact.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Contact</a></li>
            </ul>
          </div>
"@

    # regex replacement
    # We will match from "<!-- Column 2:" to the end of Column 3 (just before Column 4).
    $pattern = '(?s)<!-- Column 2: Navigation Links \(Col-span-2\) -->.*?</ul>\s*</div>\s*<!-- Column 4'
    $replacement = $newFooter + "`n`n          <!-- Column 4"
    $newContent = $content -replace $pattern, $replacement
    Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
}
