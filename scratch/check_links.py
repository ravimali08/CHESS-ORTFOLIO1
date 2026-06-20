import os
import re
from bs4 import BeautifulSoup

def check_links():
    html_files = [f for f in os.listdir('.') if f.endswith('.html')]
    print(f"Found {len(html_files)} HTML files.")
    
    # We want to check:
    # 1. Links inside each file.
    # 2. Can we reach every page from index.html (directly or indirectly)?
    # 3. Can we go back to index.html from every page?
    
    file_links = {}
    for filename in html_files:
        filepath = os.path.join('.', filename)
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
        
        soup = BeautifulSoup(content, 'html.parser')
        links = []
        for a in soup.find_all('a'):
            href = a.get('href')
            if href:
                # Resolve petite-vue bindings if any, e.g. :href="homeHref"
                # But actually, let's check both regular href and bound :href
                links.append(href)
        
        for a in soup.find_all(attrs=lambda x: x and (x == ':href' or x == 'v-bind:href')):
            # get the value
            val = a.get(':href') or a.get('v-bind:href')
            if val:
                links.append(f"vue:{val}")
                
        file_links[filename] = set(links)
        
    print("\n--- Links in each page ---")
    for file, links in sorted(file_links.items()):
        print(f"\n{file}:")
        # Resolve vue variable bindings if we can deduce them
        resolved = []
        for l in sorted(links):
            if l.startswith("vue:"):
                # E.g. vue:homeHref, vue:aboutHref
                var_name = l.split(":")[1]
                # Look for v-scope in the file to resolve it
                resolved.append(f"{l} (dynamic)")
            else:
                resolved.append(l)
        print("  " + ", ".join(resolved))

if __name__ == '__main__':
    check_links()
