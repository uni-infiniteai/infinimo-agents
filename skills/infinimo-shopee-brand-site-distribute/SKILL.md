---
name: infinimo-shopee-brand-site-distribute
description: Shopee Brand Site Distribute via the Infinimo API. Use when the user needs shopee brand site distribute.
---

# ShopeeBrand Site Distribution

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to shopee brandacross sites forsalesrevenuesharedistribution.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/shopee/data/brand/site/distribute`

| Parameter | Location | Required | Description |
|------|------|------|------|
| brandName | body | yes | Brand name (exact match) |

## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/brand/site/distribute" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"brandName": "Nike"}'
```

Or run the script:

```bash
bash scripts/query.sh Nike
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

1. Confirm brandName
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- ShopeeBrand Site Distributioncore metrics summary (use the returned fields)
- Add 1-2 actionable observations
