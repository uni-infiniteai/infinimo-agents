---
name: infinimo-shopee-shop-item-price-distribute
description: Shopee Shop Item Price Distribute via the Infinimo API. Use when the user needs shopee shop item price distribute.
---

# ShopeeShop Price Distribution

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to shopee hot-item price-band distribution.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/shopee/data/shop/item/price/distribute`

| Parameter | Location | Required | Description |
|------|------|------|------|
| site | body | yes | Site code: tw=Taiwan, my=Malaysia, id=Indonesia, th=Thailand, ph=Philippines, sg=Singapore, vn=Vietnam, br=Brazil |
| shopId | body | yes | Shop ID from a shop list or ranking API |
| sortType | body | no | Product filter: 1=sales descending, 2=GMV descending (default 1); default `1` |
| rankType | body | no | Ranking period: 1=daily, 2=weekly, 3=monthly (default 3); default `3` |

### site / sites values

| Code | Site |
|------|------|
| tw | Taiwan |
| my | Malaysia |
| id | Indonesia |
| th | Thailand |
| ph | Philippines |
| sg | Singapore |
| vn | Vietnam |
| br | Brazil |

When `sites` is a multi-select list, pass a JSON array string, for example `["tw","my"]`.


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/shop/item/price/distribute" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"site": "tw", "shopId": "123456", "sortType": "1", "rankType": "3"}'
```

Or run the script:

```bash
bash scripts/query.sh tw 123456 1 3
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

1. Confirm site, shopId
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- ShopeeShop Price Distributioncore metrics summary (use the returned fields)
- Add 1-2 actionable observations
