$dir = "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"
Write-Host "Starting global footer update..." -ForegroundColor Cyan

# Define the new premium footer HTML with the Testimonials link and Blog label
$newFooter = @'
  <!-- Global Footer (New Redesigned Premium Footer) -->
  <div v-scope="{ email: '' }">
    <footer class="py-20 px-5 md:px-12 border-t border-white/10 bg-[#050508] relative overflow-hidden">
      <!-- Glow effect inside footer -->
      <div class="absolute bottom-0 right-0 w-[500px] h-[300px] bg-white/[0.01] rounded-full blur-[120px] pointer-events-none"></div>
      
      <div class="container mx-auto max-w-[1440px]">
        <!-- Top Section: 4-Column Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-12 gap-12 lg:gap-16 pb-16 border-b border-white/5 text-left">
          
          <!-- Column 1: Brand Info & Newsletter (Col-span-5) -->
          <div class="lg:col-span-5 space-y-6">
            <div class="flex items-center gap-3">
              <div class="w-9 h-9 border border-white/10 rounded flex items-center justify-center">
                <iconify-icon icon="fa6-solid:chess-knight" class="text-white text-lg"></iconify-icon>
              </div>
              <div class="flex flex-col">
                <span class="font-bold text-[11px] sm:text-xs tracking-[0.3em] uppercase text-white">Royal Knights</span>
                <span class="text-[8px] sm:text-[9px] text-white/40 tracking-[0.1em] uppercase">Est. 1924</span>
              </div>
            </div>
            <p class="text-sm font-light text-white/50 leading-relaxed max-w-sm">
              The world's most prestigious digital arena for strategic mastery and competition. Join our community to master the board.
            </p>
            <!-- Sleek Newsletter Signup -->
            <form @submit.prevent="alert('Thank you for subscribing!')" class="flex items-center gap-2 max-w-sm pt-2">
              <input type="email" placeholder="Enter your email" required v-model="email" class="flex-1 bg-white/5 border border-white/10 rounded-full px-5 py-2.5 text-xs text-white placeholder-white/30 focus:outline-none focus:border-white/40 transition-colors">
              <button type="submit" class="px-5 py-2.5 bg-white text-black hover:bg-neutral-200 text-xs font-bold uppercase tracking-wider rounded-full transition-all duration-200 active:scale-95">Subscribe</button>
            </form>
          </div>
          
          <!-- Column 2: Navigation Links (Col-span-2) -->
          <div class="lg:col-span-2 space-y-4">
            <h4 class="text-[10px] font-bold tracking-[0.2em] uppercase text-white/40">Platform</h4>
            <ul class="space-y-2.5 text-[12px] font-light">
              <li><a href="index.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Home</a></li>
              <li><a href="about.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">About</a></li>
              <li><a href="coaches.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Coaches</a></li>
              <li><a href="programs.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Programs</a></li>
              <li><a href="membership.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Membership</a></li>
              <li><a href="testimonials.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Testimonials</a></li>
            </ul>
          </div>
          
          <!-- Column 3: Arena & Resources (Col-span-2) -->
          <div class="lg:col-span-2 space-y-4">
            <h4 class="text-[10px] font-bold tracking-[0.2em] uppercase text-white/40">Arena</h4>
            <ul class="space-y-2.5 text-[12px] font-light">
              <li><a href="tournaments.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Tournaments</a></li>
              <li><a href="events.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Events</a></li>
              <li><a href="puzzles.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Daily Puzzles</a></li>
              <li><a href="gallery.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Gallery</a></li>
              <li><a href="blog.html" class="text-white/50 hover:text-white transition-colors hover:underline decoration-white/20 underline-offset-4">Blog</a></li>
            </ul>
          </div>
          
          <!-- Column 4: Contact & Details (Col-span-3) -->
          <div class="lg:col-span-3 space-y-4">
            <h4 class="text-[10px] font-bold tracking-[0.2em] uppercase text-white/40">Contact Info</h4>
            <ul class="space-y-3 text-[12px] font-light text-white/50">
              <li class="flex items-start gap-2.5">
                <iconify-icon icon="lucide:map-pin" class="text-white/30 text-sm mt-0.5"></iconify-icon>
                <span>120 Chess Master Drive, Suite 100, New York, NY 10001</span>
              </li>
              <li class="flex items-center gap-2.5">
                <iconify-icon icon="lucide:mail" class="text-white/30 text-sm"></iconify-icon>
                <a href="mailto:contact@royalknights.com" class="hover:text-white transition-colors">contact@royalknights.com</a>
              </li>
              <li class="flex items-center gap-2.5">
                <iconify-icon icon="lucide:phone" class="text-white/30 text-sm"></iconify-icon>
                <a href="tel:+15551241924" class="hover:text-white transition-colors">+1 (555) 124-1924</a>
              </li>
            </ul>
          </div>
          
        </div>
        
        <!-- Bottom Section: Copyright and Socials -->
        <div class="flex flex-col md:flex-row justify-between items-center gap-6 pt-12 text-[11px] text-white/30 font-light">
          <div class="flex flex-col md:flex-row items-center gap-2 md:gap-6">
            <p>&copy; 2026 Royal Knights Chess Club. All rights reserved.</p>
            <span class="hidden md:inline text-white/10">|</span>
            <div class="flex gap-4">
              <a href="faq.html" class="hover:text-white transition-colors">FAQ</a>
              <a href="contact.html" class="hover:text-white transition-colors">Support</a>
              <a href="free-trial.html" class="hover:text-white transition-colors">Free Trial</a>
            </div>
          </div>
          
          <!-- Social Icons -->
          <div class="flex gap-4 items-center">
            <a href="#facebook" aria-label="Facebook" class="w-8 h-8 rounded-full border border-white/5 bg-white/5 hover:bg-white hover:text-black flex items-center justify-center text-white transition-all duration-300">
              <iconify-icon icon="brandico:facebook-rect" class="text-sm"></iconify-icon>
            </a>
            <a href="#twitter" aria-label="Twitter" class="w-8 h-8 rounded-full border border-white/5 bg-white/5 hover:bg-white hover:text-black flex items-center justify-center text-white transition-all duration-300">
              <iconify-icon icon="brandico:twitter-bird" class="text-sm"></iconify-icon>
            </a>
            <a href="#instagram" aria-label="Instagram" class="w-8 h-8 rounded-full border border-white/5 bg-white/5 hover:bg-white hover:text-black flex items-center justify-center text-white transition-all duration-300">
              <iconify-icon icon="brandico:instagram" class="text-sm"></iconify-icon>
            </a>
          </div>
          
          <p class="text-[10px] font-bold uppercase tracking-[0.3em] text-white/10 hidden lg:block">
            Strategy &bull; Discipline &bull; Mastery
          </p>
        </div>
        
      </div>
    </footer>
  </div>
'@

$coreFiles = @(
    "index.html", "about.html", "programs.html", "events.html", "membership.html",
    "coaches.html", "tournaments.html", "gallery.html", "testimonials.html", "puzzles.html",
    "faq.html", "blog.html", "blog-post-1.html", "blog-post-2.html", "blog-post-3.html",
    "blog-post-4.html", "blog-post-5.html", "blog-post-6.html", "contact.html", "account-setup.html"
)

# Regex patterns to search for footers
$pattern1 = '(?ms)<!-- Global Footer \(New Redesigned Premium Footer\) -->.*?<\/footer>\s*<\/div>'
$pattern2 = '(?ms)<!-- component: Footer \(14fe1a52-2ef6-44cb-9a11-c9c89675d742\) -->.*?<\/footer>\s*<\/div>'

foreach ($fileName in $coreFiles) {
    $filePath = Join-Path $dir $fileName
    if (Test-Path $filePath) {
        $content = [System.IO.File]::ReadAllText($filePath)
        $updated = $false
        
        if ($content -match $pattern1) {
            $content = [regex]::Replace($content, $pattern1, $newFooter)
            $updated = $true
        } elseif ($content -match $pattern2) {
            $content = [regex]::Replace($content, $pattern2, $newFooter)
            $updated = $true
        }
        
        if ($updated) {
            [System.IO.File]::WriteAllText($filePath, $content)
            Write-Host "Updated footer in: $fileName" -ForegroundColor Green
        } else {
            Write-Host "Warning: Could not find footer block in $fileName" -ForegroundColor Yellow
        }
    } else {
        Write-Host "Error: File not found - $fileName" -ForegroundColor Red
    }
}
Write-Host "Global footer update completed!" -ForegroundColor Cyan
