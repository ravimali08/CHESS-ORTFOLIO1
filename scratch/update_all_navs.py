import os
import re

dir_path = r"c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1"
files = [f for f in os.listdir(dir_path) if f.endswith(".html")]

old_nav_pattern = re.compile(
    r'<nav class="absolute left-1/2 -translate-x-1/2 hidden xl:flex flex-row flex-nowrap items-center gap-5 min-[1400px]:gap-8">.*?</nav>',
    re.DOTALL
)

new_nav = (
    '<nav class="absolute left-1/2 -translate-x-1/2 hidden xl:grid grid-cols-8 gap-0 justify-items-center w-[760px] min-[1400px]:w-[880px] items-center">'
    '<a :href="homeHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'home\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Home</a>'
    '<a :href="aboutHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'about\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">About</a>'
    '<a :href="eventsHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'events\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Events</a>'
    '<a :href="tournamentsHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'tournaments\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Tournaments</a>'
    '<a :href="membershipHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'membership\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Membership</a>'
    '<a :href="coachesHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'coaches\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Coaches</a>'
    '<a :href="blogHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'blog\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Blog</a>'
    '<a :href="contactHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'contact\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Contact</a>'
    '</nav>'
)

for file_name in files:
    file_path = os.path.join(dir_path, file_name)
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()
    
    if old_nav_pattern.search(content):
        updated_content = old_nav_pattern.sub(new_nav, content)
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(updated_content)
        print(f"Updated: {file_name}")
    else:
        if "grid-cols-8" in content:
            print(f"Already updated: {file_name}")
        else:
            print(f"No match: {file_name}")
