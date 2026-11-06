---
name: infinimo-amazon-market-seller-concentration
description: Query Amazoncategory seller concentration via the Infinimo API. Use when the user needs seller concentration, category competition analysis.
---

# Amazon Category Seller Concentration

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for amazon market seller concentration.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/amazon/data/market/seller_concentration`

| Parameter | Location | Required | Description |
|------|------|------|------|
| marketplace | body | yes | Marketplace code. US=United States, UK=United Kingdom, ES=Spain, FR=France, DE=Germany, IT=Italy, CA=Canada, JP=Japan; default `US` |
| nodeIdPath | body | yes | Category node id path, formatted as parentId:childId。 Appliances - Appliance Protection Plans: 2619525011:2242350011 Appliances - Dishwashers: 2619525011:3741271 Appliances - Garbage Disposals: 2619525011:18116205011 ...; default `1055398:1063252` |
| month | body | no | Filter month, yyyyMM, for example 202507; default `202507` |


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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/market/seller_concentration" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace": "US", "nodeIdPath": "1055398:1063252", "month": "202507"}'
```

Or run the script:

```bash
bash scripts/query.sh US 1055398:1063252 202507
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

1. Confirm marketplace, nodeIdPath; optional month
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: marketplace, category path, month
- Leading seller share and concentration
- Add 1-2 competitive-landscape observations
