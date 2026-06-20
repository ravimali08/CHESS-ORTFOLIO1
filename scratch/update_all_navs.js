const fs = require('fs');
const path = require('path');

const dirPath = 'c:\\Users\\sujal\\OneDrive\\Desktop\\Desktop\\CHESS PORTFOLIO 1';
const files = fs.readdirSync(dirPath).filter(f => f.endsWith('.html'));

const oldNavRegex = /<nav class="absolute left-1\/2 -translate-x-1\/2 hidden xl:flex flex-row flex-nowrap items-center gap-5 min-\[1400px\]:gap-8">.*?<\/nav>/s;

const newNav = '<nav class="absolute left-1/2 -translate-x-1/2 hidden xl:grid grid-cols-8 gap-0 justify-items-center w-[760px] min-[1400px]:w-[880px] items-center"><a :href="homeHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'home\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Home</a><a :href="aboutHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'about\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">About</a><a :href="eventsHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'events\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Events</a><a :href="tournamentsHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'tournaments\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Tournaments</a><a :href="membershipHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'membership\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Membership</a><a :href="coachesHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'coaches\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Coaches</a><a :href="blogHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'blog\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Blog</a><a :href="contactHref" class="text-[13px] font-medium tracking-wide transition-all block w-full text-center" :class="activeItem === \'contact\' ? \'text-white underline underline-offset-8 decoration-white/20\' : \'text-white/50 hover:text-white\'">Contact</a></nav>';

files.forEach(file => {
    const filePath = path.join(dirPath, file);
    const content = fs.readFileSync(filePath, 'utf8');
    
    if (oldNavRegex.test(content)) {
        const updatedContent = content.replace(oldNavRegex, newNav);
        fs.writeFileSync(filePath, updatedContent, 'utf8');
        console.log(`Updated: ${file}`);
    } else {
        if (content.includes('grid-cols-8')) {
            console.log(`Already updated: ${file}`);
        } else {
            console.log(`No match: ${file}`);
        }
    }
});
