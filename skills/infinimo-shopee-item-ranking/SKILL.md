---
name: infinimo-shopee-item-ranking
description: Shopee Item Ranking via the Infinimo API. Use when the user needs shopee item ranking.
---

# ShopeeItem Ranking

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to queryShopeeItem Ranking.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/shopee/data/item/ranking`

| Parameter | Location | Required | Description |
|------|------|------|------|
| site | body | yes | Site code: tw=Taiwan, my=Malaysia, id=Indonesia, th=Thailand, ph=Philippines, sg=Singapore, vn=Vietnam, br=Brazil |
| categoryId | body | yes | categoryID。Level-1 category map: 100001=Health, 100009=Fashion Accessories, 100010=Home Appliances, 100011=Men's Clothing, 100012=Men's Shoes, 100013=Phones, Tablets & Accessories, 100015=Travel & Luggage, 100016=Women's Bags, … |
| date | body | no | Ranking date, yyyy-MM-dd; defaults to yesterday if omitted; default `yesterday` |
| borderType | body | no | Ranking type: 0=overall, 1=cross-border, 2=local (default 0); default `0` |
| sortField | body | yes | Sort: 1=bestsellers, 2=trending |
| productType | body | no | Product type: 1=Shopee Preferred, 2=Shopee Mall, 3=other, 0=all (default 0); default `0` |
| period | body | yes | Period: 1=daily, 2=weekly, 3=monthly |
| pageNo | body | no | Page number, starting at 1, max 100000; defaults to 1 if omitted; default `1` |
| pageSize | body | no | Page size, max 10; defaults to 10 if omitted; default `10` |

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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/item/ranking" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"site": "tw", "categoryId": "123456", "date": "yesterday", "borderType": "0", "sortField": "1", "productType": "0", "period": "1", "pageNo": "1", "pageSize": "10"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"site": "tw", "categoryId": "123456", "date": "yesterday", "borderType": "0", "sortField": "1", "productType": "0", "period": "1", "pageNo": "1", "pageSize": "10"}'

bash scripts/query.sh @payload.json
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

1. Confirm site, categoryId, sortField, period; pass JSON when there are many parameters
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- ShopeeItem Rankingcore metrics summary (use the returned fields)
- Add 1-2 actionable observations
