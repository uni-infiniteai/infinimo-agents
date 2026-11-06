---
name: infinimo-ozon-shop-trend-snapshots
description: Ozon Shop Trend Snapshots via the Infinimo API. Use when the user needs ozon shop trend snapshots.
---

# OzonShop Trend Snapshot

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to byshop name or ID queryShop Trend Snapshot (one shop only).


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/shop/trend-snapshots`

| Parameter | Location | Required | Description |
|------|------|------|------|
| shopKeyword | body | yes | Shop name or ID. One shop only |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/shop/trend-snapshots" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"shopKeyword": "123456"}'
```

Or run the script:

```bash
bash scripts/query.sh 123456
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

1. Confirm shopKeyword (shop name or ID)
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: shop keyword
- shop trend summary
- Add 1-2 shop observations
