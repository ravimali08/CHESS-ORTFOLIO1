const fs = require('fs');
const path = require('path');

function checkLinks() {
    const files = fs.readdirSync('.').filter(f => f.endsWith('.html'));
    console.log(`Found ${files.length} HTML files.`);

    const fileLinks = {};
    const vueVars = {
        homeHref: 'index.html',
        aboutHref: 'about.html',
        eventsHref: 'events.html',
        tournamentsHref: 'tournaments.html',
        membershipHref: 'membership.html',
        coachesHref: 'coaches.html',
        blogHref: 'blog.html',
        contactHref: 'contact.html',
        ctaHref: 'free-trial.html'
    };

    files.forEach(filename => {
        const content = fs.readFileSync(filename, 'utf-8');
        const hrefRegex = /href="([^"]*)"|:href="([^"]*)"/g;
        let match;
        const links = new Set();

        while ((match = hrefRegex.exec(content)) !== null) {
            const rawHref = match[1];
            const vueHref = match[2];

            if (rawHref) {
                links.add(rawHref);
            } else if (vueHref) {
                const resolved = vueVars[vueHref] || `vue:${vueHref}`;
                links.add(resolved);
            }
        }
        fileLinks[filename] = Array.from(links);
    });

    console.log("\n--- Links in each page ---");
    Object.keys(fileLinks).sort().forEach(file => {
        console.log(`\n${file}:`);
        console.log("  " + fileLinks[file].sort().join(", "));
    });
}

checkLinks();
