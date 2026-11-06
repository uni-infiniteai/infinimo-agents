---
name: infinimo-ozon-category-trend-snapshots
description: Query Ozon Category Trend Snapshots via the Infinimo API. Use when the user needs Ozon category trend, category snapshot analysis.
---

# OzonCategory Trend Snapshots

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to bylevel-1 category ID queryCategory Trend Snapshots.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/category/trend-snapshots`

| Parameter | Location | Required | Description |
|------|------|------|------|
| categoryId | body | yes | Level-1 category ID. Map: 17027494=Home & Garden, 17027491=Sports & Leisure, 17027489=Beauty & Hygiene, 15621032=Shoes, 15621031=Apparel, 17027486=Home Appliances, 17027482=Construction & Renovation, 15… |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/category/trend-snapshots" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"categoryId": "15621042"}'
```

Or run the script:

```bash
bash scripts/query.sh 15621042
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

1. Confirm categoryId (level-1 category ID)
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: category ID
- category trend summary
- Add 1-2 category observations
