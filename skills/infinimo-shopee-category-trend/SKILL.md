---
name: infinimo-shopee-category-trend
description: Shopee Category Trend via the Infinimo API. Use when the user needs shopee category trend.
---

# ShopeeCategory Trend Overview

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to queryShopeeCategory Trend Overview.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/shopee/data/category/trend`

| Parameter | Location | Required | Description |
|------|------|------|------|
| sites | body | yes | Site list (multi-select): tw=Taiwan, my=Malaysia, id=Indonesia, th=Thailand, ph=Philippines, sg=Singapore, vn=Vietnam, br=Brazil |
| catId | body | yes | categoryID。Level-1 category map: 100001=Health, 100009=Fashion Accessories, 100010=Home Appliances, 100011=Men's Clothing, 100012=Men's Shoes, 100013=Phones, Tablets & Accessories, 100015=Travel & Luggage, 100016=Women's Bags, … |
| granularity | body | yes | Grain: 1=calendar month, 2=calendar quarter, 3=year |
| startDate | body | yes | Range start, yyyy-MM-dd |
| endDate | body | yes | Range end, yyyy-MM-dd |
| productType | body | no | Product type: 0=all, 1=Shopee Preferred, 2=Shopee Mall, 3=other (default 0) |
| location | body | no | Item location: 0=all, 1=local, 2=cross-border (default 0) |

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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/category/trend" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"sites": "[\"tw\"]", "catId": "123456", "granularity": "1", "startDate": "2025-05-27", "endDate": "2026-05-27"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"sites": "[\"tw\"]", "catId": "123456", "granularity": "1", "startDate": "2025-05-27", "endDate": "2026-05-27"}'

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

1. Confirm sites, catId, granularity, startDate, endDate; pass JSON when there are many parameters
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- ShopeeCategory Trend Overviewcore metrics summary (use the returned fields)
- Add 1-2 actionable observations
