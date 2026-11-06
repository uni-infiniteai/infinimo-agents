---
name: infinimo-amazon-asin-review
description: Query Amazon ASIN buyerreviews via the Infinimo API. Use when the user needs ASIN reviews, star filter, review insights.
---

# Amazon ASIN Reviews

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for amazon asin review.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/amazon/data/asin/review`

| Parameter | Location | Required | Description |
|------|------|------|------|
| marketplace | body | yes | Marketplace code. US=United States, UK=United Kingdom, ES=Spain, FR=France, DE=Germany, IT=Italy, CA=Canada, JP=Japan; default `US` |
| asin | body | yes | ASIN; default `B07Z82895W` |
| starList | body | no | Star filter, for example [5,4,3]; default `[5,4,3]` |
| typeList | body | no | Review-type filter |
| page | body | no | Page number, default 1; default `1` |
| size | body | no | Page size, default 20; default `20` |


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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/asin/review" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace": "US", "asin": "B07Z82895W", "starList": "[5,4,3]", "page": "1", "size": "20"}'
```

Or run the script:

```bash
bash scripts/query.sh US B07Z82895W [5,4,3] "" 1 20
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

1. Confirm marketplace, asin; optional starList, typeList, page, size
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: marketplace, ASIN, star/type filters, pagination
- Review highlights: star distribution and frequent themes
- Add 1-2 product-improvement or competitor observations
