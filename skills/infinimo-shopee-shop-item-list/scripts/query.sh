#!/usr/bin/env bash
set -euo pipefail

SITE="${1:?Usage: query.sh <site> <shopId> [sortField] [pageNo] [pageSize]}"
SHOPID="${2:?Usage: query.sh <site> <shopId> [sortField] [pageNo] [pageSize]}"
SORTFIELD="${3:-}"
PAGENO="${4:-}"
PAGESIZE="${5:-}"
API_KEY="${INFINIMO_API_KEY:?Set the INFINIMO_API_KEY environment variable}"

_KEYS='["site", "shopId", "sortField", "pageNo", "pageSize"]'
_REQUIRED='["site", "shopId"]'
PAYLOAD=$(KEYS="$_KEYS" REQUIRED="$_REQUIRED" python3 - "${SITE}" "${SHOPID}" "${SORTFIELD}" "${PAGENO}" "${PAGESIZE}" <<'PY'
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

curl -s -X POST "https://infinimo.ai/api/aigc/ec/shopee/data/shop/item/list" \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $API_KEY" \
  -d "$PAYLOAD"
