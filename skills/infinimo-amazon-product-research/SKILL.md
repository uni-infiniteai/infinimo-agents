---
name: infinimo-amazon-product-research
description: Amazon Product Research via the Infinimo API. Use when the user needs amazon product research.
---

# Amazon Product Research

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for amazon product research.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/amazon/data/product/research`

| Parameter | Location | Required | Description |
|------|------|------|------|
| marketplace | body | yes | Marketplace code. US=United States, UK=United Kingdom, ES=Spain, FR=France, DE=Germany, IT=Italy, CA=Canada, JP=Japan |
| month | body | no | Month, yyyyMM, for example 202507 |
| keyword | body | no | keyword |
| includeSellers | body | no | Include sellers |
| excludeSellers | body | no | Exclude sellers |
| matchType | body | no | Match type: 1 phrase, 2 fuzzy, 3 exact. Default 2 |
| excludeKeywords | body | no | Excluded keywords |
| minPrice | body | no | Minimum price |
| maxPrice | body | no | Maximum price |
| minRating | body | no | Minimum rating |
| maxRating | body | no | Maximum rating |
| minRatings | body | no | Minimum review count |
| maxRatings | body | no | Maximum review count |
| minRatingsCv | body | no | Minimum new reviews in the month |
| maxRatingsCv | body | no | Maximum new reviews in the month |
| minSellers | body | no | Minimum seller count |
| maxSellers | body | no | Maximum seller count |
| minProfit | body | no | Minimum margin |
| maxProfit | body | no | Maximum margin |
| minBsr | body | no | Best (lowest) root BSR |
| maxBsr | body | no | Worst (highest) root BSR |
| minBsrCv | body | no | Minimum BSR change |
| maxBsrCv | body | no | Maximum BSR change |
| minBsrCr | body | no | Minimum BSR growth rate |
| maxBsrCr | body | no | Maximum BSR growth rate |
| minUnits | body | no | Minimum monthly sales |
| maxUnits | body | no | Maximum monthly sales |
| minAmzUnit | body | no | Minimum monthly child-ASIN sales |
| maxAmzUnit | body | no | Maximum monthly child-ASIN sales |
| minRevenue | body | no | Minimum monthly revenue |
| maxRevenue | body | no | Maximum monthly revenue |
| minRevenueCr | body | no | Minimum monthly revenue growth |
| maxRevenueCr | body | no | Maximum monthly revenue growth |
| minUnitsCr | body | no | Minimum monthly sales growth |
| maxUnitsCr | body | no | Maximum monthly sales growth |
| weightUnit | body | no | Weight unit, default g |
| minWeights | body | no | Minimum weight |
| maxWeights | body | no | Maximum weight |
| minVariations | body | no | Minimum variation count |
| maxVariations | body | no | Maximum variation count |
| filterSub | body | no | Filter to a child category. Y = yes. Applies only when a category is set |
| minSubBsrRank | body | no | Min child-category rank. Applies only when filterSub=Y |
| maxSubBsrRank | body | no | Max child-category rank. Applies only when filterSub=Y |
| includeBrands | body | no | Include brands |
| excludeBrands | body | no | Exclude brands |
| nodeIdPaths | body | no | Category nodeIdPath list. Each path is parentId:childId。   Appliances - Appliance Protection Plans: 2619525011:2242350011 Appliances - Dishwashers: 2619525011:3741271 Appliances - Garbage Disposals: 261… |
| nodeIdPathEqual | body | no | true matches the category exactly; false includes child categories. Default false |
| availableMonth | body | no | Listing month |
| dimensionType | body | no | Dimension types, comma-separated |
| minFba | body | no | Minimum FBA fee |
| maxFba | body | no | Maximum FBA fee |
| minLqs | body | no | Minimum listing quality score |
| maxLqs | body | no | Maximum listing quality score |
| sellerNation | body | no | Seller country, comma-separated |
| badgeBS | body | no | Best Seller badge. Y = yes |
| badgeAC | body | no | Amazon's Choice badge. Y = yes |
| badgeNR | body | no | New Release badge. Y = yes |
| fulfillment | body | no | Fulfillment, comma-separated: AMZ/FBA/FBM |
| variation | body | no | Variation filter. N = include variations, Y = exclude variations |
| page | body | no | Page number, starting at 1, default 1 |
| size | body | no | Page size, default 50, max 100 |
| order | body | no | sort |


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
curl -s -X POST "https://infinimo.ai/api/aigc/ec/amazon/data/product/research" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"marketplace": "US", "month": "202507", "keyword": "wireless earbuds", "page": "1", "size": "50"}'
```

When there are many filters, pass a JSON body directly (or `@payload.json`).
Or run the script:

```bash
bash scripts/query.sh '{"marketplace":"US","month":"202507","keyword":"wireless earbuds","page":"1","size":"50"}'

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

1. Confirm marketplace (required)and the other filters; pass JSON when there are many parameters
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: marketplace and main filters
- Listing fields: price, rating, sales, revenue, BSR, brand, and similar
- Add 2-3 product-opportunity observations
