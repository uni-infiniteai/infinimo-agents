---
name: infinimo-ozon-keyword-trend-snapshots
description: Query Ozon singleKeyword Trend Snapshot via the Infinimo API. Use when the user needs Ozon keyword trend, keyword trend snapshot.
---

# OzonKeyword Trend Snapshot

## About Infinimo

Infinimo is an AI workspace for cross-border e-commerce. Describe the task, run it, and get a finished deliverable. It connects Amazon, TikTok, Shopee, Ozon, and other major marketplaces, plans the work, and calls tools to produce product-research reports and creative assets.

This skill calls the Infinimo open API for ozon keyword trend snapshots.


## Auth and Base URL

- **Base URL**: `https://infinimo.ai/api`
- **API Key**: Sign up at https://infinimo.ai/?source=q-github-agent, then create or copy a key at https://infinimo.ai/api-key?source=q-github-agent
- **Headers**:
  - `Content-Type: application/json`
  - `Authorization: Bearer <API_KEY>`

Read the key from the `INFINIMO_API_KEY` environment variable. If it is unset, ask the user. Do not hardcode it.


## Endpoint

`POST /aigc/ec/ozon/data/keyword/trend-snapshots`

| Parameter | Location | Required | Description |
|------|------|------|------|
| keywordId | body | yes | Keyword ID. One keyword only |
| period | body | no | Period: week (WEEK), calendar month (MONTH), quarter (QUARTER), year (YEAR); default weekly ranking; default `WEEK` |


## Request

```bash
curl -s -X POST "https://infinimo.ai/api/aigc/ec/ozon/data/keyword/trend-snapshots" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $INFINIMO_API_KEY" \
  -d '{"keywordId": "12345", "period": "WEEK"}'
```

Or run the script:

```bash
bash scripts/query.sh 12345 WEEK
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

1. Confirm keywordId; optional period (WEEK/MONTH/QUARTER/YEAR)
2. Check that `INFINIMO_API_KEY` is set
3. Call the API
4. On failure, report the error and ask the user to check the key and required parameters
5. Parse the response and write an English summary

## Output

- Query: keyword ID, period
- trend summary
- Add 1-2 trend observations
