#!/usr/bin/env bash
set -euo pipefail

SITE="${1:?Usage: query.sh <site> [categoryId] [brandName] [sortType] [pageNo] [pageSize]}"
CATEGORYID="${2:-}"
BRANDNAME="${3:-}"
SORTTYPE="${4:-}"
PAGENO="${5:-}"
PAGESIZE="${6:-}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

_KEYS='["site", "categoryId", "brandName", "sortType", "pageNo", "pageSize"]'
_REQUIRED='["site"]'
PAYLOAD=$(KEYS="$_KEYS" REQUIRED="$_REQUIRED" python3 - "${SITE}" "${CATEGORYID}" "${BRANDNAME}" "${SORTTYPE}" "${PAGENO}" "${PAGESIZE}" <<'PY'
import json, os, sys
keys = json.loads(os.environ["KEYS"])
required = set(json.loads(os.environ["REQUIRED"]))
vals = sys.argv[1:]
body = {}
for k, v in zip(keys, vals):
    v = (v or "").strip()
    if not v:
        if k in required:
            raise SystemExit(f"{k} must not be empty")
        continue
    body[k] = v
print(json.dumps(body, ensure_ascii=False))
PY
)

curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/brand/search" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
