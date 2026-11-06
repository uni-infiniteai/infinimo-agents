---
name: infinimo-ozon-brand-top-ranking
description: Query Ozon brand Top rankingsalessalesdata via the Infinimo API. Use when the user needs Brand Ranking, category brand ranking.
---

# OzonBrand Top-Ranking Sales

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to bybrand namequery Top rankingsalessalesdata，optionally limited to a level-1 category.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/brand/top-ranking`

| Parameter | Location | Required | Description |
|------|------|------|------|
| level1CategoryId | body | no | Level-1 category ID. Map: 17027494=Home & Garden, 17027491=Sports & Leisure, 17027489=Beauty & Hygiene, 15621032=Shoes, 15621031=Apparel, 17027915=Furniture, 17027486=Home Appliances, 17027... |
| brandName | body | yes | Brand name keyword |
| brandSearchType | body | no | Brand search type: fuzzy (FUZZY) or exact (EXACT); default fuzzy search; default `FUZZY` |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/brand/top-ranking" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"brandName": "Nike", "level1CategoryId": "15621031", "brandSearchType": "FUZZY"}'
```

Or run the script:

```bash
bash scripts/query.sh Nike 15621031 FUZZY
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

1. Confirm brandName; optional level1CategoryId, brandSearchType (FUZZY/EXACT)
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: brand, category, search type
- top-ranking sales summary
- Add 1-2 brand-competition observations
