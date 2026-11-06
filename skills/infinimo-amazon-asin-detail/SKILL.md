---
name: infinimo-amazon-asin-detail
description: Query Amazon ASIN basic details via the Infinimo API. Use when the user needs ASIN details, single-product research, Listing basic info.
---

# Amazon ASIN Details

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for amazon asin detail.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/amazon/data/asin/detail`

| Parameter | Location | Required | Description |
|------|------|------|------|
| marketplace | body | yes | Marketplace code. US=United States, UK=United Kingdom, ES=Spain, FR=France, DE=Germany, IT=Italy, CA=Canada, JP=Japan |
| asin | body | yes | ASIN |


### Marketplace values

| Code | Marketplace |
|------|------|
| US | United States |
| UK | United Kingdom |
| ES | Spain |
| FR | France |
| DE | Germany |
| IT | Italy |
| CA | Canada |
| JP | Japan |

## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/asin/detail" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace": "US", "asin": "B07Z82895W"}'
```

Or run the script:

```bash
bash scripts/query.sh US B07Z82895W
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

1. Confirm marketplace, asin
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: marketplace, ASIN
- core fields: title, price, rating, BSR, category, brand and similar
- Add 1-2 product observations
