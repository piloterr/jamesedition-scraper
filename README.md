<p align="center">
  <a href="https://www.piloterr.com"><img src="images/banner.png" alt="JamesEdition Scraper API by Piloterr – scrape JamesEdition data as JSON" width="100%"></a>
</p>

# JamesEdition Scraper API

[![Discord](https://img.shields.io/badge/Discord-Join%20the%20community-5865F2?logo=discord&logoColor=white)](https://discord.gg/CFj3ph8aHU) [![Get API key](https://img.shields.io/badge/Piloterr-Get%20a%20free%20API%20key-111827)](https://app.piloterr.com) [![API docs](https://img.shields.io/badge/Docs-OpenAPI-0EA5E9)](https://app.piloterr.com/openapi) [![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

The **Piloterr JamesEdition Scraper API** lets you extract public data from JamesEdition as **clean, structured JSON** — no proxies, headless browsers or HTML parsing to maintain. Endpoints available in production:

- **JamesEdition Property API** — Read one JamesEdition listing from its URL.
- **JamesEdition Search API** — Search JamesEdition luxury homes by keyword or by a results URL.

Use it for price monitoring, assortment tracking, competitor analysis, product research or catalog enrichment.

| Endpoint | Path | Credits | What you get |
|---|---|---|---|
| [JamesEdition Property API](#jamesedition-property-api) | `/v2/jamesedition/property` | 1 | Read one JamesEdition listing from its URL. |
| [JamesEdition Search API](#jamesedition-search-api) | `/v2/jamesedition/search` | 1 | Search JamesEdition luxury homes by keyword or by a results URL. |

## Table of contents

- [How it works](#how-it-works)
- [JamesEdition Property API](#jamesedition-property-api)
- [JamesEdition Search API](#jamesedition-search-api)
- [Code examples in other languages](#code-examples-in-other-languages)
- [Practical use cases](#practical-use-cases)
- [Why Piloterr?](#why-piloterr)
- [FAQ](#faq)
- [Related scrapers](#related-scrapers)
- [Support](#support)

## How it works

1. **Create a free Piloterr account** and copy your API key from the [dashboard](https://app.piloterr.com).
2. **Send a `GET` (or `POST`) request** to `https://api.piloterr.com/v2/...` with the header `x-api-key: YOUR_API_KEY`.
3. **Receive structured JSON** — Piloterr handles rendering, proxies, retries and parsing.

```bash
export PILOTERR_API_KEY="your-api-key"
pip install requests        # Python
# TypeScript: Node.js 18+ (native fetch), run with `npx tsx file.ts`
```

> Every endpoint accepts both `GET` (query string) and `POST` (JSON body with the same fields).

## JamesEdition Property API

Read one JamesEdition listing from its URL.

`GET | POST https://api.piloterr.com/v2/jamesedition/property` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. JamesEdition listing URL, for example https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477. A keyword is rejected. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/jamesedition/property",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type JameseditionProperty = {
  id?: string;
  url?: string;
  image?: string;
  price?: number;
  specs?: string[];
  title?: string;
  lot_sqm?: unknown;
  bedrooms?: number;
  currency?: string;
  location?: string;
  bathrooms?: number;
  description?: string;
  lot_display?: unknown;
  interior_sqm?: number;
  price_display?: string;
  interior_display?: string;
};

const params = new URLSearchParams({
  "query": "https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477",
});

const response = await fetch(`https://api.piloterr.com/v2/jamesedition/property?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as JameseditionProperty;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/jamesedition/property
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "id": "17793477",
  "url": "https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477",
  "image": "https://img.jamesedition.com/listing_images/2026/05/07/09/16/45/419dac60-8b4b-4032-ac51-9765ab7d3418/je/1040x620xc.jpg",
  "price": 670000,
  "specs": [
    "1 Beds",
    "1 Baths"
  ],
  "title": "Alpine Panorama Above Lake Starnberg – New Build Project Near Munich",
  "lot_sqm": null,
  "bedrooms": 1,
  "currency": "EUR",
  "location": "Munich, Bavaria, Germany",
  "bathrooms": 1,
  "description": "Munich, Bavaria, Germany | 1 Bed, 1 Bath Apartment For Sale | €670,000 - FELDAFINGER HÖHE – LIVING WHERE OTHERS GO ON VACATION<br/><br/>I…",
  "lot_display": null,
  "interior_sqm": 44,
  "price_display": "€670,000",
  "interior_display": "44 Sqm"
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `id` | string |  |
| `url` | string |  |
| `image` | string |  |
| `price` | integer |  |
| `specs` | string[] |  |
| `title` | string |  |
| `lot_sqm` | object |  |
| `bedrooms` | integer |  |
| `currency` | string |  |
| `location` | string |  |
| `bathrooms` | integer |  |
| `description` | string |  |
| `lot_display` | object |  |
| `interior_sqm` | integer |  |
| `price_display` | string |  |
| `interior_display` | string |  |

## JamesEdition Search API

Search JamesEdition luxury homes by keyword or by a results URL.

`GET | POST https://api.piloterr.com/v2/jamesedition/search` · **1 credit per request** · [Full reference](https://app.piloterr.com/openapi)

### Request parameters

| Parameter | Type | Required | Description |
|---|---|---|---|
| `query` | string | ✅ | Required. Keyword, for example villa, or a JamesEdition results URL such as https://www.jamesedition.com/real_estate/france. A single listing URL is rejected. |
| `page` | number | — | Optional. Page number starting at 1. Example: 2. Omitted means page 1. A page already present in a results URL is kept when this is omitted or 1. |

### Python example

```python
import json
import os
import requests

response = requests.get(
    "https://api.piloterr.com/v2/jamesedition/search",
    headers={"x-api-key": os.environ["PILOTERR_API_KEY"]},
    params={
        "query": "villa",
    },
    timeout=60,
)
response.raise_for_status()
data = response.json()

print(json.dumps(data, indent=2, ensure_ascii=False)[:2000])
```

### TypeScript example

```typescript
type JameseditionSearch = {
  results?: {
    id?: string;
    url?: string;
    city?: string;
    image?: string;
    price?: number;
    title?: string;
    badges?: string[];
    region?: string;
    address?: string;
    country?: string;
    area_sqm?: number;
    bedrooms?: number;
    category?: string;
    currency?: string;
    latitude?: number;
    promoted?: boolean;
    bathrooms?: number;
    longitude?: number;
    price_eur?: number;
    price_usd?: number;
    office_url?: string;
    area_display?: string;
    country_code?: string;
    price_display?: string;
  }[];
  pagination?: {
    next?: string;
    page?: number;
    per_page?: number;
    total_pages?: unknown;
    total_results?: unknown;
  };
};

const params = new URLSearchParams({
  "query": "villa",
});

const response = await fetch(`https://api.piloterr.com/v2/jamesedition/search?${params}`, {
  headers: { "x-api-key": process.env.PILOTERR_API_KEY! },
});
if (!response.ok) throw new Error(`Piloterr error ${response.status}: ${await response.text()}`);

const data = (await response.json()) as JameseditionSearch;

console.log(JSON.stringify(data, null, 2).slice(0, 2000));
```

<details>
<summary><b>POST variant</b></summary>

```http
POST https://api.piloterr.com/v2/jamesedition/search
x-api-key: YOUR_API_KEY
Content-Type: application/json

{"query": "villa"}
```
</details>

### Output example

Example response from the API reference, abridged — real values depend on the page you scrape.

```json
{
  "results": [
    {
      "id": "17793477",
      "url": "https://www.jamesedition.com/real_estate/munich-germany/alpine-panorama-above-lake-starnberg-new-build-project-near-munich-17793477",
      "city": "Munich",
      "image": "https://img.jamesedition.com/listing_images/2026/05/07/09/16/45/419dac60-8b4b-4032-ac51-9765ab7d3418/je/507x312xc.jpg",
      "price": 670000,
      "title": "Alpine Panorama above Lake Starnberg – New-Build Project near Munich",
      "badges": [
        "Directly from developer",
        "Video"
      ],
      "region": "Bavaria",
      "address": "Munich, Bavaria, Germany",
      "country": "Germany",
      "area_sqm": 43,
      "bedrooms": 1,
      "category": "Apartment",
      "currency": "EUR",
      "latitude": 48.1351253,
      "promoted": true,
      "bathrooms": 1,
      "longitude": 11.5819806,
      "price_eur": 670000,
      "price_usd": 750540,
      "office_url": "https://www.jamesedition.com/offices/real_estate/c7-gruppe-505101",
      "area_display": "43 sqm",
      "country_code": "DE",
      "price_display": "€670,000"
    }
  ],
  "pagination": {
    "next": "https://www.jamesedition.com/real_estate?q=villa&page=2",
    "page": 1,
    "per_page": 31,
    "total_pages": null,
    "total_results": null
  }
}
```

### Response fields

| Field | Type | Description |
|---|---|---|
| `results[]` | object[] |  |
| `results[].id` | string |  |
| `results[].url` | string |  |
| `results[].city` | string |  |
| `results[].image` | string |  |
| `results[].price` | integer |  |
| `results[].title` | string |  |
| `results[].badges` | string[] |  |
| `results[].region` | string |  |
| `results[].address` | string |  |
| `results[].country` | string |  |
| `results[].area_sqm` | integer |  |
| `results[].bedrooms` | integer |  |
| `results[].category` | string |  |
| `results[].currency` | string |  |
| `results[].latitude` | number |  |
| `results[].promoted` | boolean |  |
| `results[].bathrooms` | integer |  |
| `results[].longitude` | number |  |
| `results[].price_eur` | integer |  |
| `results[].price_usd` | integer |  |
| `results[].office_url` | string |  |
| `results[].area_display` | string |  |
| `results[].country_code` | string |  |
| `results[].price_display` | string |  |

## Code examples in other languages

Ready-to-run examples live in the [`examples/`](examples) folder. Each one reads your key from the `PILOTERR_API_KEY` environment variable.

| Language | Property | Search |
|---|---|---|
| cURL (Bash) | [`property`](examples/curl/property.sh) | [`search`](examples/curl/search.sh) |
| PHP | [`property`](examples/php/property.php) | [`search`](examples/php/search.php) |
| C# | [`property`](examples/csharp/Property.cs) | [`search`](examples/csharp/Search.cs) |
| Go | [`property`](examples/go/property.go) | [`search`](examples/go/search.go) |
| Java | [`property`](examples/java/PropertyExample.java) | [`search`](examples/java/SearchExample.java) |
| Ruby | [`property`](examples/ruby/property.rb) | [`search`](examples/ruby/search.rb) |
| Node.js | [`property`](examples/nodejs/property.mjs) | [`search`](examples/nodejs/search.mjs) |

## Practical use cases

- **Price monitoring** — Track prices, promotions and availability over time to react to competitors.
- **Assortment & catalog tracking** — Follow new products, delisted items and category changes.
- **Competitor analysis** — Benchmark ranges, brands and positioning across retailers.
- **Product research** — Spot best-sellers and trends from search results.
- **Catalog enrichment** — Pull titles, images and attributes into your PIM or marketplace listings.

## Why Piloterr?

- **No infrastructure** — no proxies, headless browsers or CAPTCHA solving to run yourself.
- **Structured JSON** — stable, documented fields instead of brittle HTML selectors.
- **Pay per request** — transparent credit cost per endpoint, failed requests are retried for you.
- **One API key, hundreds of sources** — JamesEdition plus many other e-commerce, search and company data endpoints in the [Piloterr library](https://www.piloterr.com/library).
- **Any language** — plain HTTPS + JSON, with examples for Python, TypeScript, cURL, PHP, C#, Go, Java, Ruby and Node.js.

## FAQ

### Is it legal to scrape JamesEdition?

Collecting publicly available data is generally allowed in many jurisdictions, but rules depend on your country, the data you collect and how you use it. Avoid personal data unless you have a lawful basis, respect the website's terms where they apply, and get legal advice for your specific use case. This is not legal advice.

### Do I need proxies or a headless browser?

No. Piloterr handles rendering, proxy rotation and retries on its side. You only send an HTTPS request with your `x-api-key` header and receive JSON.

### How much does a request cost?

Credits per call: `/v2/jamesedition/property` **1**, `/v2/jamesedition/search` **1**. See the [Piloterr website](https://www.piloterr.com) for plans.

### What data does the JamesEdition API return?

Each endpoint returns structured JSON: **JamesEdition Property** — `id`, `url`, `image`, `price`, `specs`, `title`; **JamesEdition Search** — `results[]`, `results[].id`, `results[].url`, `results[].city`, `results[].image`, `results[].price`.

### How do I paginate JamesEdition results?

Use the `page` parameter and keep requesting while the response indicates more results.

### Which languages are supported?

Any language that can make an HTTP request. This README shows Python and TypeScript; the [`examples/`](examples) folder contains cURL, PHP, C#, Go, Java, Ruby and Node.js.

## Related scrapers

- [About You Scraper API](https://github.com/piloterr/aboutyou-scraper)
- [Action Scraper API](https://github.com/piloterr/action-scraper)
- [Aldi Scraper API](https://github.com/piloterr/aldi-scraper)
- [Alibaba Scraper API](https://github.com/piloterr/alibaba-scraper)
- [AliExpress Scraper API](https://github.com/piloterr/aliexpress-scraper)
- [Allegro Scraper API](https://github.com/piloterr/allegro-scraper)
- [All Piloterr scrapers on GitHub](https://github.com/piloterr)

## Support

- 💬 Join the [Piloterr Discord](https://discord.gg/CFj3ph8aHU) to ask questions and share what you build.
- 📚 Browse the [API reference (OpenAPI)](https://app.piloterr.com/openapi) and the [Piloterr library](https://www.piloterr.com/library).
- 🔑 [Get your API key](https://app.piloterr.com).

---

<p align="center">
  <a href="https://www.piloterr.com">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="images/logo-dark.svg">
      <img src="images/logo.svg" alt="Piloterr" height="32">
    </picture>
  </a>
  <br>
  <sub>Built by <a href="https://www.piloterr.com">Piloterr</a> — web scraping APIs for e-commerce, search, real estate and more, one API key.</sub>
</p>

<sub>JamesEdition is a trademark of its respective owner. This repository is not affiliated with or endorsed by JamesEdition. Examples are released under the MIT license.</sub>
