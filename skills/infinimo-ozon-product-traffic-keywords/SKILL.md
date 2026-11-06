---
name: infinimo-ozon-product-traffic-keywords
description: Query Ozon producttraffic keywords via the Infinimo API. Use when the user needs producttraffic keywords, organic/ad-keyword analysis.
---

# OzonProduct Traffic Keywords

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for ozon product traffic keywords.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/product/traffic-keywords`

| Parameter | Location | Required | Description |
|------|------|------|------|
| pageNo | body | no | Page number, starting at 1, max 10000; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 15; defaults to 15 if omitted; default `15` |
| itemIds | body | yes | Product IDs, up to 10, comma-separated |
| keywordType | body | no | Keyword type: all (ALL), theme tag (THEME_TAG), organic (NATURAL), ads (AD_CPC), order ads (AD_ORDER), special ads (AD_SPECIAL); default `ALL` |
| keyword | body | no | Keyword in Russian or Chinese, fuzzy match |
| sortField | body | no | Sort field, default SEARCH_INDEX. SEARCH_INDEX=search index, SEARCH_INDEX_GROWTH_RATE=search-index growth, CONVERSION_INDEX=conversion index, CART_CONVERSION_RATE…; default `SEARCH_INDEX` |
| sortDirection | body | no | Sort direction, default DESC; default `DESC` |

more than 10 product ID , split into multiple requests。

## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/product/traffic-keywords" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"itemIds": "123456789", "pageNo": "1", "pageSize": "15", "keywordType": "ALL", "sortField": "SEARCH_INDEX", "sortDirection": "DESC"}'
```

Or run the script:

```bash
bash scripts/query.sh 123456789 1 15 ALL "" SEARCH_INDEX DESC
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

1. Confirm itemIds (up to 10); pagination, keywordType, keyword, and sort are optional
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: product IDs, keyword type, pagination
- traffic keywords and core indexes
- Add 1-2 keyword-set observations
