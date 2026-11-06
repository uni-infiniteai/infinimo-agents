---
name: infinimo-shopee-item-hotword
description: Shopee Item Hotword via the Infinimo API. Use when the user needs shopee item hotword.
---

# ShopeeItem Hot Keywords

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API to item Hot Keywordsanalysis.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/shopee/data/item/hotword`

| Parameter | Location | Required | Description |
|------|------|------|------|
| site | body | yes | Site code: tw=Taiwan, my=Malaysia, id=Indonesia, th=Thailand, ph=Philippines, sg=Singapore, vn=Vietnam, br=Brazil; default `tw` |
| itemIds | body | yes | Product IDs, comma-separated, up to 10; default `1234567890,1234567891` |
| type | body | yes | Type: 1=traffic-driving keywords, 2=same-category hot keywords; default `1` |
| timest | body | no | Data date, yyyy-MM-dd, one day only; defaults to yesterday if omitted; default `2026-05-26` |

Note: `itemIds` Product IDs, comma-separated, up to 10

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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/item/hotword" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"site": "tw", "itemIds": "1234567890,1234567891", "type": "1", "timest": "2026-05-26"}'
```

Or run the script:

```bash
bash scripts/query.sh tw "1234567890,1234567891" 1 2026-05-26
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

1. Confirm site, itemIds, type
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query conditions and key parameters
- ShopeeItem Hot Keywordscore metrics summary (use the returned fields)
- Add 1-2 actionable observations
