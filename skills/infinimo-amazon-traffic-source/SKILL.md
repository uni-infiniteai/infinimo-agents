---
name: infinimo-amazon-traffic-source
description: Amazon Traffic Source via the Infinimo API. Use when the user needs amazon traffic source.
---

# Amazon Traffic Source Analysis

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for amazon traffic source.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/amazon/data/traffic/source`

| Parameter | Location | Required | Description |
|------|------|------|------|
| marketplace | body | yes | Marketplace code. US=United States, UK=United Kingdom, ES=Spain, FR=France, DE=Germany, IT=Italy, CA=Canada, JP=Japan; default `US` |
| q | body | yes | ASIN or keyword |
| month | body | no | Month, yyyyMM |
| page | body | no | Page number, default 1; default `1` |
| size | body | no | Page size, default 50; default `50` |


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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/traffic/source" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace": "US", "q": "B07Z82895W", "month": "202507", "page": "1", "size": "50"}'
```

Or run the script:

```bash
bash scripts/query.sh US B07Z82895W 202507 1 50
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

1. Confirm marketplace, q; optional month, page, size
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: marketplace, query (q), month, pagination
- Organic vs ad traffic-source mix
- Add 1-2 traffic-mix observations
