# books_scrape.py - scraper code for books.toscrape.com (website designed for scraping practice)
# Purpose - course practice - University of Essex Online
# Dean Carey - August 2025

import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin, urlparse
import urllib.robotparser
import time
import json
from pathlib import Path
from datetime import datetime

BASE = 'http://books.toscrape.com/'  # site designed for scraping
START_URL = BASE + 'catalogue/page-1.html'
HEADERS = {'User-Agent': 'UniversityOfEssexOnlineCourseBot/1.0 (+dc25199@essex.ac.uk)'}
OUT_DIR = Path('books_output')
OUT_DIR.mkdir(exist_ok=True)
JSON_OUT = OUT_DIR / 'books_list.json'
DELAY_SECONDS = 0.5     # small polite pause
MAX_PAGES = 2           # how many listing pages to scrape

# simple robots.txt check
def allowed_by_robots(url, user_agent=HEADERS['User-Agent']):
    parsed = urlparse(url)
    robots_url = f"{parsed.scheme}://{parsed.netloc}/robots.txt"
    rp = urllib.robotparser.RobotFileParser()
    rp.set_url(robots_url)
    rp.read()
    return rp.can_fetch(user_agent, url)

# fetch HTML
def fetch_html(url):
    resp = requests.get(url, headers=HEADERS, timeout=15)
    resp.raise_for_status()
    return resp.text

# parse a single listing page 
def parse_listing_page(html, base_url):
    soup = BeautifulSoup(html, 'html.parser')
    items = []
    # each book in grid
    for el in soup.select('article.product_pod'):
        a = el.select_one('h3 a')
        title = a['title'].strip() if a and a.has_attr('title') else a.get_text(strip=True) if a else ''
        # link to product page
        rel_link = a['href'] if a and a.has_attr('href') else ''
        product_link = urljoin(base_url, rel_link)
        # price
        price = el.select_one('.price_color')
        price = price.get_text(strip=True) if price else ''
        # availability text
        avail = el.select_one('.availability')
        availability = avail.get_text(strip=True) if avail else ''
        # rating - encoded in class "star-rating Three" etc
        rating_el = el.select_one('p.star-rating')
        rating = ''
        if rating_el:
            for cls in rating_el.get('class', []):
                if cls.lower() != 'star-rating':
                    rating = cls  # e.g. "Three"
        items.append({
            'title': title,
            'product_link': product_link,
            'price': price,
            'availability': availability,
            'rating': rating
        })
    return items

# main
def main():
    # check robots
    if not allowed_by_robots(BASE):
        print("Aborted - robots.txt disallows scraping this site from this agent")
        return

    results = []
    url = START_URL
    page = 1
    while page <= MAX_PAGES:
        print(f"Fetching page {page}: {url}")
        html = fetch_html(url)
        page_items = parse_listing_page(html, url)
        results.extend(page_items)
        # polite pause
        time.sleep(DELAY_SECONDS)
        # find next page link
        soup = BeautifulSoup(html, 'html.parser')
        next_a = soup.select_one('li.next a')
        if not next_a:
            break
        next_rel = next_a.get('href')
        url = urljoin(url, next_rel)
        page += 1

    # minimal validation - require at least one item
    if not results:
        print("No items parsed - aborting without saving")
        return

    out_obj = {
        'scrape_timestamp_utc': datetime.utcnow().isoformat() + 'Z',
        'source': START_URL,
        'pages_scraped': page,
        'total_items': len(results),
        'items': results
    }

    with open(JSON_OUT, 'w', encoding='utf-8') as f:
        json.dump(out_obj, f, ensure_ascii=False, indent=2)

    print(f"Saved {len(results)} items to {JSON_OUT}")

if __name__ == '__main__':
    main()


