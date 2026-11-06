---
name: infinimo-ozon-brand-detail
description: Ozon Brand Detail via the Infinimo API. Use when the user needs ozon brand detail.
---

# OzonBrand Details

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for ozon brand detail.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/brand/detail`

| Parameter | Location | Required | Description |
|------|------|------|------|
| brandNames | body | yes | Brand names, up to 10, comma-separated |

more than 10  brands, split into multiple requests。

## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/brand/detail" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"brandNames": "Nike,Adidas"}'
```

Or run the script:

```bash
bash scripts/query.sh "Nike,Adidas"
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

1. Confirm brandNames (up to 10, comma-separated)
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: brand names
- Compare core scale and operating metrics
- Add 1-2 brand observations
