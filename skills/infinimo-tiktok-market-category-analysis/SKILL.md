---
name: infinimo-tiktok-market-category-analysis
description: TikTok Market Category Analysis via the Infinimo API. Use when the user needs tiktok market category analysis.
---

# TikTok Market Category Analysis

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for tiktok market category analysis.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/tiktok/data/market/category_analysis`

| Parameter | Location | Required | Description |
|------|------|------|------|
| analysisType | body | yes | Analysis type: basic_metrics, sales_trends, or price_distribution |
| region | body | yes | Target market code, for example US, UK, ID, VN, TH, MY, PH, SG |
| categoryId | body | no | Level-1 category ID. Map: 10=Home Supplies, 11=Kitchenware, 12=Textiles & Soft Furnishings, 13=Home Appliances, 3=Men's Clothing & Underwear, 2=Women's Clothing & Underwear, 6=Shoes, 7=Bags & Luggage, 14=Beauty & Personal Care, 15=Computers & Office, 16=Phones & Electronics, 18=... |
| categoryPath | body | no | Category path from level 1 to 3, for example [100,200,300] |

### Common region values

| Code | Marketplace |
|------|------|
| US | United States |
| UK | United Kingdom |
| ID | Indonesia |
| VN | Vietnam |
| TH | Thailand |
| MY | Malaysia |
| PH | Philippines |
| SG | Singapore |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/tiktok/data/market/category_analysis" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"analysisType": "basic_metrics", "region": "US"}'
```

Or run the script:

```bash
bash scripts/query.sh basic_metrics US
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

1. Confirm analysisType, region
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- TikTokcategory market analysiscore metrics summary (use the returned fields)
- Add 1-2 actionable observations
