---
name: infinimo-ozon-keyword-hot-ranking
description: Query Ozon Hot Keyword Ranking via the Infinimo API. Use when the user needs hot keywords, keyword ranking filters.
---

# OzonHot Keyword Ranking

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for ozon keyword hot ranking.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/keyword/hot-ranking`

| Parameter | Location | Required | Description |
|------|------|------|------|
| pageNo | body | no | Page number, starting at 1, max 10000; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 15; defaults to 15 if omitted; default `15` |
| level1CategoryId | body | no | Level-1 category ID. Map: 17027494=Home & Garden, 17027491=Sports & Leisure, 17027489=Beauty & Hygiene, 15621032=Shoes, 15621031=Apparel, 17027915=Furniture, 17027486=Home Appliances, 17027... |
| keyword | body | no | Keyword in Chinese, Russian, or English |
| searchType | body | no | Keyword search type: fuzzy (FUZZY) or exact (EXACT); default fuzzy search; default `FUZZY` |
| minSearchIndex | body | no | Minimum search index |
| maxSearchIndex | body | no | Maximum search index |
| minSearchVolumeGrowthRate | body | no | Minimum search-volume growth |
| maxSearchVolumeGrowthRate | body | no | Maximum search-volume growth |
| minOrderConversionRate | body | no | Minimum order conversion rate |
| maxOrderConversionRate | body | no | Maximum order conversion rate |
| minOrderedAmount | body | no | Minimum ordered amount |
| maxOrderedAmount | body | no | Maximum ordered amount |
| minOrderedProductCount | body | no | Minimum ordered products |
| maxOrderedProductCount | body | no | Maximum ordered products |
| minCartCount | body | no | Minimum add-to-cart count |
| maxCartCount | body | no | Maximum add-to-cart count |
| minCartAveragePrice | body | no | Minimum average cart price |
| maxCartAveragePrice | body | no | Maximum average cart price |
| minSupplyDemandRatio | body | no | Minimum supply-demand ratio |
| maxSupplyDemandRatio | body | no | Maximum supply-demand ratio |
| period | body | yes | Period: week (WEEK), calendar month (MONTH), quarter (QUARTER), year (YEAR) |
| updatePeriod | body | no | Snapshot period. If omitted, uses the latest snapshot for the selected period。Week: yyyy-MM-dd; calendar month: yyyy-MM; quarter: yyyy-Qn; year: yyyy |
| sortField | body | no | Sort field: search index (SEARCH_INDEX), ordered amount (ORDERED_AMOUNT), ordered product count (ORDERED_PRODUCT_COUNT); default SEARCH_INDEX; default `SEARCH_INDEX` |
| sortDirection | body | no | Sort direction, default DESC; default `DESC` |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/keyword/hot-ranking" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"period": "MONTH", "pageNo": "1", "pageSize": "15", "level1CategoryId": "15621042", "sortField": "SEARCH_INDEX", "sortDirection": "DESC"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"period": "MONTH", "pageNo": "1", "pageSize": "15", "level1CategoryId": "15621042", "sortField": "SEARCH_INDEX", "sortDirection": "DESC"}'

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

1. Confirm period (required: WEEK/MONTH/QUARTER/YEAR)and the other filters; pass JSON when there are many parameters
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: period, category, and main filters
- hot-keyword list metrics
- Add 2-3 keyword observations
