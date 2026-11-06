---
name: infinimo-ozon-product-hot-ranking
description: Query Ozon Bestseller List via the Infinimo API. Use when the user needs bestseller ranking, category bestseller filters.
---

# OzonBestseller List

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to by level-1 categoryandmultipledimensionfilterselectitemsconditionsqueryBestseller List.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/product/hot-ranking`

| Parameter | Location | Required | Description |
|------|------|------|------|
| pageNo | body | no | Page number, starting at 1, max 10000; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 15; defaults to 15 if omitted; default `15` |
| level1CategoryId | body | yes | Level-1 category ID. Map: 17027494=Home & Garden, 17027491=Sports & Leisure, 17027489=Beauty & Hygiene, 15621032=Shoes, 15621031=Apparel, 17027915=Furniture, 17027486=Home Appliances, 17027... |
| period | body | no | Period: last 7 days (SEVEN_DAY), last 28 days (TWENTY_EIGHT_DAY), calendar month (MONTH), quarter (QUARTER), year (YEAR); default `SEVEN_DAY` |
| updatePeriod | body | no | Snapshot period. If omitted, uses the latest snapshot for the selected period。Last 7 days / last 28 days: yyyy-MM-dd; calendar month: yyyy-MM; quarter: yyyy-Qn; year: yyyy |
| minSales | body | no | Minimum sales |
| maxSales | body | no | Maximum sales |
| minGmv | body | no | Minimum GMV, in RUB |
| maxGmv | body | no | Maximum GMV, in RUB |
| minPrice | body | no | Minimum average price |
| maxPrice | body | no | Maximum average price |
| minCreateDate | body | no | Min product-card created date, yyyy-MM-dd |
| maxCreateDate | body | no | Max product-card created date, yyyy-MM-dd |
| deliveryModes | body | no | Fulfillment mode: FBS, FBO, rFBS, OZON; omit for all |
| crossBorderSalePermission | body | no | Cross-border permission: 1=blocked, 2=allowed; omit for no limit |
| productType | body | no | Product type: 1=local, 2=cross-border, 3=unknown; omit for all |
| salesLevel | body | no | Sales tier: 1=top sellers, 2=top 1%, 3=top 10%, 4=top 50%; omit for no limit |
| sortField | body | no | Sort field: sales (SALES), GMV (GMV), price (PRICE); default `SALES` |
| sortDirection | body | no | Sort direction; default `DESC` |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/product/hot-ranking" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"level1CategoryId": "15621042", "period": "SEVEN_DAY", "pageNo": "1", "pageSize": "15", "sortField": "SALES", "sortDirection": "DESC"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"level1CategoryId": "15621042", "period": "SEVEN_DAY", "pageNo": "1", "pageSize": "15", "sortField": "SALES", "sortDirection": "DESC"}'

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

1. Confirm level1CategoryId (required)and the other filters; pass JSON when there are many parameters
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: category, period, and main filters
- bestseller list metrics
- Add 2-3 product-research observations
