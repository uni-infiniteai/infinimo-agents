---
name: infinimo-ozon-product-detail
description: Ozon Product Detail via the Infinimo API. Use when the user needs ozon product detail.
---

# Ozonproduct details

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for ozon product detail.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/product/detail`

| Parameter | Location | Required | Description |
|------|------|------|------|
| itemIds | body | yes | Product IDs, up to 10, comma-separated |
| period | body | no | Period: last 7 days (SEVEN_DAY), last 28 days (TWENTY_EIGHT_DAY), calendar month (MONTH), quarter (QUARTER), year (YEAR); defaults to the last 28 days if omitted; default `TWENTY_EIGHT_DAY` |
| updatePeriod | body | no | Snapshot period. If omitted, uses the latest snapshot for the selected period。Last 7 days / last 28 days: yyyy-MM-dd; calendar month: yyyy-MM; quarter: yyyy-Qn; year: yyyy |
| sortField | body | no | Sort field: sales (SALES), GMV (GMV), price (PRICE) |
| sortDirection | body | no | Sort direction |

more than 10 product ID , split into multiple requests。

## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/product/detail" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"itemIds": "123456789,987654321", "period": "TWENTY_EIGHT_DAY"}'
```

Or run the script:

```bash
bash scripts/query.sh "123456789,987654321" TWENTY_EIGHT_DAY
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

1. Confirm itemIds (up to 10); optional period, updatePeriod, sort
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: product ID, period, snapshot
- Basic info, price, sales, conversion, and traffic fields
- Add 2-3 actionable observations
