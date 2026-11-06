---
name: infinimo-ozon-shop-hot-ranking
description: Query Ozon Shop Bestseller Ranking via the Infinimo API. Use when the user needs shop bestseller ranking, shop ranking filters.
---

# OzonShop Bestseller Ranking

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to by category, sales, rating and other filtersqueryShop Bestseller Ranking.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/shop/hot-ranking`

| Parameter | Location | Required | Description |
|------|------|------|------|
| pageNo | body | no | Page number, starting at 1, max 10000; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 15; defaults to 15 if omitted; default `15` |
| updatePeriod | body | no | Snapshot period. If omitted, uses the latest snapshot |
| categoryId | body | no | level-1 categoryID。omit to query all categories。map: 17027494=Home & Garden, 17027491=Sports & Leisure, 17027489=Beauty & Hygiene, 15621032=Shoes, 15621031=Apparel, 17027915=Furniture, 17027486=... |
| shopKeyword | body | no | Shop ID, name, or URL |
| minProductCount | body | no | Minimum product count in the shop |
| maxProductCount | body | no | Maximum product count in the shop |
| minSalableProductCount | body | no | Minimum products with sales |
| maxSalableProductCount | body | no | Maximum products with sales |
| minShopRating | body | no | Minimum shop rating |
| maxShopRating | body | no | Maximum shop rating |
| minSalesRate | body | no | Minimum sell-through rate |
| maxSalesRate | body | no | Maximum sell-through rate |
| minSales | body | no | Minimum monthly sales |
| maxSales | body | no | Maximum monthly sales |
| minGmv | body | no | Minimum monthly GMV |
| maxGmv | body | no | Maximum monthly GMV |
| shopLevel | body | no | Shop tier: 0 regular seller, 1 premium seller, 2 official store; -1 or omit for all |
| openTimeRange | body | no | Shop age: 1 under 1 month, 2 1-3 months, 3 3-6 months, 4 6-12 months, 5 1-3 years, 6 3-5 years, 7 over 5 years |
| shopArea | body | no | Shop type: 1 cross-border, 2 local, 3 unknown; omit for all |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/shop/hot-ranking" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"pageNo": "1", "pageSize": "15", "categoryId": "15621042"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"pageNo": "1", "pageSize": "15", "categoryId": "15621042"}'

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

1. Pass filters as needed (use JSON when there are many). Empty filters return the default ranking
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: category and main filters
- hot-shop list metrics
- Add 2-3 shop-opportunity observations
