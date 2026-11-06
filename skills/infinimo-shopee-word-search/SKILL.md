---
name: infinimo-shopee-word-search
description: Shopee Word Search via the Infinimo API. Use when the user needs shopee word search.
---

# ShopeeHot Keyword Search

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for shopee word search.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/shopee/data/word/search`

| Parameter | Location | Required | Description |
|------|------|------|------|
| site | body | yes | Site code: tw=Taiwan, my=Malaysia, id=Indonesia, th=Thailand, ph=Philippines, sg=Singapore, vn=Vietnam, br=Brazil |
| categoryId | body | no | categoryID。Level-1 category map: 100001=Health, 100009=Fashion Accessories, 100010=Home Appliances, 100011=Men's Clothing, 100012=Men's Shoes, 100013=Phones, Tablets & Accessories, 100015=Travel & Luggage, 100016=Women's Bags, … |
| categoryLocation | body | no | Product origin: 1=local, 2=cross-border, 0=all (default 0); default `0` |
| itemCountMin | body | no | Min product count |
| itemCountMax | body | no | Max product count |
| sales30dayMin | body | no | Min 30-day sales |
| sales30dayMax | body | no | Max 30-day sales |
| recPriceMin | body | no | Min recommended bid |
| recPriceMax | body | no | Max recommended bid |
| sortType | body | no | Sort: 1=30-day sales, 2=recommended bid, 3=search index, 4=product count (default 1); default `1` |
| pageNo | body | no | Current page; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 100; defaults to 10 if omitted; default `10` |
| timest | body | no | Data date, yyyy-MM-dd, one day only; defaults to yesterday if omitted |

### site / sites values

| Code | Site |
|------|------|
| tw | Taiwan |
| my | Malaysia |
| id | Indonesia |
| th | Thailand |
| ph | Philippines |
| sg | Singapore |
| vn | Vietnam |
| br | Brazil |

When `sites` is a multi-select list, pass a JSON array string, for example `["tw","my"]`.


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/word/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"site": "tw", "categoryLocation": "0", "sortType": "1", "pageNo": "1", "pageSize": "10"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"site": "tw", "categoryLocation": "0", "sortType": "1", "pageNo": "1", "pageSize": "10"}'

bash scripts/query.sh @payload.json
```

## Response

```json
{
  "status": 1,
  "data": { ... }
}
```

- `status`: `1` = success, `0` = failure
- On success, turn `data` into an English summary for the request. No card component is needed.


## Workflow

1. Confirm site; pass JSON when there are many parameters
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- ShopeeHot Keyword Searchcore metrics summary (use the returned fields)
- Add 1-2 actionable observations
