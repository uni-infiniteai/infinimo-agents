---
name: infinimo-amazon-traffic-keyword-stat
description: Query Amazon ASIN traffic-keyword counts (all traffic keywords, organic ranking keywords, ad keywords and type mix) via the Infinimo API. Use when the user needs Amazon Traffic Keyword Stats, organic/ad-keyword share, competitor keyword coverage.
---

# Amazon Traffic Keyword Stats

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for amazon traffic keyword stat.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/amazon/data/traffic/keyword_stat`

| Parameter | Location | Required | Description |
|------|------|------|------|
| marketplace | body | yes | Marketplace code; default `US` |
| asin | body | yes | Product ASIN |
| month | body | no | Month, format `yyyyMM`; omit to return the latest data |

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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/traffic/keyword_stat" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace":"US","asin":"B07Z82895W"}'
```

a given month: 

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/traffic/keyword_stat" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace":"UK","asin":"B07Z82895W","month":"202405"}'
```

Or run the script:

```bash
bash scripts/query.sh US B07Z82895W

bash scripts/query.sh UK B07Z82895W 202405
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

1. Confirm `marketplace` and `asin`. If the user gives a month, validate `yyyyMM`
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key, ASIN, and marketplace
5. Parse the response and write an English traffic-keyword summary

## Output

- Query: marketplace, ASIN, month
- Compare total, organic, and ad keyword counts and share
- Add 1-2 keyword-coverage or PPC observations
