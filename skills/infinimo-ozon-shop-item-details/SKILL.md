---
name: infinimo-ozon-shop-item-details
description: Query Ozon Shop Product List via the Infinimo API. Use when the user needs shop assortment, shop product list.
---

# OzonShop Product List

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to byshop name or ID queryShop Product List.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/shop/item-details`

| Parameter | Location | Required | Description |
|------|------|------|------|
| pageNo | body | no | Page number, starting at 1, max 10000; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 15; defaults to 15 if omitted; default `15` |
| shopKeyword | body | yes | Shop name or ID |
| categoryId | body | no | level-1 categoryID。0 or omit for all categories。map: 17027494=Home & Garden, 17027491=Sports & Leisure, 17027489=Beauty & Hygiene, 15621032=Shoes, 15621031=Apparel, 17027915=Furniture, 17027486…; default `0` |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/shop/item-details" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"shopKeyword": "123456", "pageNo": "1", "pageSize": "15", "categoryId": "0"}'
```

Or run the script:

```bash
bash scripts/query.sh 123456 1 15 0
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

1. Confirm shopKeyword; optional pageNo, pageSize, categoryId
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: shop, category, pagination
- product-list summary
- Add 1-2 assortment observations
