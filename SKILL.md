---
name: agent-code-army
description: >
  Auto-generate full-stack software projects using a pipeline of 8 specialized AI agents (PO, Architect, Backend, Frontend, Tester, Reviewer, DevOps, Doc).
  Trigger when user says "Làm app [tên]", "Tạo [project]", "Làm [website/app/tool] [mô tả]",
  or calls individual agents like "Backend Agent, code API...", "Reviewer Agent, review code...".
  Also triggers for UI/design tasks: "sửa giao diện", "cải tiến UI", "làm đẹp", "thiết kế lại", "chỉnh theme/màu".
  Also supports adding features, fixing bugs, auditing security, refactoring, writing tests, setting up Docker/CI-CD, and writing documentation
  for existing projects. User is Vietnamese Buddhist monk named Nguyễn Hoàng Anh (Sư Tiến), UTC+7.
---

# 🪷 Agent Code Army

Orchestrate a multi-agent pipeline to auto-generate production-ready software.

## Pipeline

```
User → Commander → PO → Architect → 🛰️ Tech Radar → Backend+Frontend (parallel) → Tester → Reviewer → DevOps → Doc → Report
```

> 🛰️ **Tech Radar** (Bước 3.5 mới): Commander tự fetch docs mới nhất của framework/library trong tech stack, viết vào `docs/tech-radar.md`, inject context vào Backend + Frontend agents. Không cần agent riêng.

Each agent is an **isolated sub-agent** (`sessions_spawn` with default `isolated` context). Agents read input files and write output files — they don't talk to each other. Commander is the orchestrator.

## 🧠 CodeGraph Knowledge Graph + Semble Code Search (Pre-Index)

Pipeline dùng **cả hai** — chúng bổ sung cho nhau:

| Công cụ | Chức năng chính | Dùng khi nào |
|---------|----------------|-------------|
| **CodeGraph** | Knowledge graph (callers, callees, impact, context) | Reviewer, Tester, Architect — cần hiểu cấu trúc & dependency |
| **Semble** | Semantic code search (search bằng NL, ~98% token savings) | Backend, Frontend, Doc — cần tìm code theo mô tả |

### Tại sao dùng cả hai?

- **CodeGraph** = bản đồ code (ai gọi ai, dependency, impact analysis) — trả lời "cái này ảnh hưởng gì?"
- **Semble** = Google Search cho code — trả lời "tìm code authentication nằm ở đâu?"

Thay vì mỗi agent phải `read` hàng chục file (burn 70-90% token cho exploration), cả 2 tool đều pre-index, agent dùng MCP tools:

| Không có tool | Có CodeGraph + Semble |
|---|---|
| Agent `ls` + `read` từng file | Agent dùng Semble search (98% savings) + CodeGraph context (59% savings) |
| Mỗi agent lặp lại việc đọc codebase | Index 1 lần, dùng mãi mãi |
| Token burn cho exploration | Token dành cho execution |
| Agent bỏ sót indirect dependency | Graph trace toàn bộ call chain |

**Benchmark:**
- CodeGraph: **35% rẻ hơn, 59% ít token, 70% ít tool calls** (structural analysis)
- Semble: **~98% ít token hơn grep+read**, NDCG@10 0.854, index 250ms, query 1.5ms

### Cài đặt (đã cài sẵn)

```bash
# CodeGraph (đã cài): npm install -g @colbymchenry/codegraph (v0.8.0)
# Semble (đã cài): uv tool install semble (v0.2.0)
# Cả 2 MCP server đều config trong OpenClaw → agent dùng được qua MCP tools
```

### Commander flow với CodeGraph + Semble + Tech Radar

```
Commander:
  1. Tạo project structure (mkdir...)
  2. Chạy codegraph init -i agent-army/projects/<name>/
     → Index codebase, tạo .codegraph/ (SQLite, structural graph)
  3. Chạy semble index agent-army/projects/<name>/ -o agent-army/projects/<name>/.semble/
     → Index semantic search (BM25 + Model2Vec embeddings)
  4. Spawn PO Agent (đọc idea.md, chưa có code → không cần index)
  5. Spawn Architect Agent (đọc PRD, chưa có code)
  6. 🛰️ **Tech Radar** — fetch docs mới nhất:
     - web_fetch/tavily_search cho từng framework/library
     - Viết docs/tech-radar.md (tóm tắt API mới, breaking changes)
  7. Spawn Backend + Frontend (song song) — inject tech-radar.md + 🎨 frontend-design-system.md context
  8. Re-index: cả codegraph + semble
     codegraph index .
     semble index . -o .semble/
  9. Spawn Tester → codegraph affected + semble search test targets
  10. Spawn Reviewer → codegraph_impact + codegraph_callers + semble search
  11. Spawn DevOps, Doc → codegraph_context + semble search
```

### MCP tools agents dùng (có sẵn qua OpenClaw MCP)

| Agent | CodeGraph tools | Semble tools |
|-------|----------------|-------------|
| **Backend** | `codegraph_context`, `codegraph_search`, `codegraph_node` | `semble_search` — tìm code theo mô tả |
| **Frontend** | `codegraph_context`, `codegraph_search`, `codegraph_node` | `semble_search` — tìm component, API |
| **Architect** | `codegraph_context`, `codegraph_callers`, `codegraph_callees` | `semble_search` — tìm pattern |
| **Reviewer** | `codegraph_impact`, `codegraph_callers`, `codegraph_callees` | `semble_search` + `find_related` |
| **Tester** | `codegraph_impact`, `codegraph_context` — CLI: `codegraph affected` | `semble_search` — tìm code cần test |
| **DevOps** | `codegraph_context`, `codegraph_files` | `semble_search` — tìm config |
| **Doc** | `codegraph_context`, `codegraph_node` | `semble_search` + `find_related` |

### Không cần cho:
- **PO Agent** — chỉ đọc idea.md (text), không có code
- **Architect Agent** — đọc PRD, thiết kế từ đầu, chưa có code

## 🌐 trungtienlearn Admin API (Quản trị web bằng Agent)

Agent có thể quản trị website trungtienlearn qua REST API:

```bash
# Base URL
PROD="https://trungtienlearn.com"
KEY="<ADMIN_API_KEY>"

# Đọc API docs đầy đủ
cat trungtienlearn/docs/admin-api.md

# Ví dụ: tạo bài viết
curl -X POST $PROD/api/admin/posts \
  -H "Authorization: Bearer $KEY" \
  -H "Content-Type: application/json" \
  -d '{"title":"...","slug":"...","content":"...","published":false}'

# Ví dụ: lấy dashboard
curl $PROD/api/admin/dashboard -H "Authorization: Bearer $KEY"
```

**Các lệnh Thầy có thể dùng:**
- "Đăng bài viết mới lên trungtienlearn"
- "Cập nhật trạng thái dự án X"
- "Kiểm tra dashboard trungtienlearn"
- "Xem có tin nhắn mới không"

Agent sẽ tự động gọi API với ADMIN_API_KEY từ `.env.local`.

## Project structure

Every project lives at `agent-army/projects/<name>/`:
```
project/
├── idea.md          ← Raw idea (user input)
├── 01-prd.md        ← PO Agent
├── 02-spec.md       ← Architect Agent
├── src/
│   ├── backend/     ← Backend Agent(s)
│   └── frontend/    ← Frontend Agent(s)
├── tests/           ← Tester Agent
├── 05-review.md     ← Reviewer Agent
├── infra/           ← DevOps Agent
├── docs/
│   ├── tech-radar.md ← 🛰️ Tech Radar (Commander) — latest API docs
│   └── ...          ← Doc Agent
├── .codegraph/      ← CodeGraph knowledge graph (SQLite) — callers, callees, impact
├── .semble/         ← Semble semantic search index (BM25 + Model2Vec)
├── pipeline.log.md  ← Commander (audit trail)
└── README.md        ← Doc Agent
```

## Command triggers

| User says | I do |
|-----------|------|
| "Làm app quản lý chi tiêu" | Full pipeline: Setup → PO → Architect → BE+FE → **CodeGraph index** → Tester → Reviewer → DevOps → Doc |
| "Làm website bán hàng dùng Next.js + PostgreSQL" | Full pipeline with tech stack constraint |
| "Làm app todo, chỉ MVP: CRUD cơ bản" | Full pipeline, scope-limited |
| "Làm app note, code luôn khỏi cần PO với Architect" | Skip PO + Architect, go straight to code |
| "Thêm tính năng login Google vào project abc" | CodeGraph init → PO → Architect → Code → Test → Review |
| "Fix bug crash khi nhập số âm" | CodeGraph context → Reviewer → Backend/Frontend → Tester |
| "Review code project abc" | CodeGraph init → Reviewer Agent → report |
| "Setup Docker cho project abc" | CodeGraph context → DevOps Agent |
| "Viết docs cho todo-app" | CodeGraph context → Documenter Agent |
| "Thêm test cho module payment" | CodeGraph affected → Tester Agent |
| "Đăng bài viết mới lên trungtienlearn" | Commander → Backend Agent gọi Admin API POST /api/admin/posts |
| "Cập nhật trạng thái dự án X" | Commander → Backend Agent gọi Admin API PUT |
| "Kiểm tra dashboard trungtienlearn" | Commander → GET /api/admin/dashboard → báo cáo |
| "Dùng Claude cho Reviewer Agent" | Override model per agent |

### 🎨 UI / Design Triggers

| User says | I do |
|-----------|------|
| "Sửa giao diện trang X" | Commander → Frontend Agent với [[frontend-design-system]] |
| "Cải tiến UI/UX" | Commander → Frontend Agent + Reviewer audit UI |
| "Làm đẹp trang web" | Commander → Frontend Agent (polish existing UI) |
| "Thiết kế lại trang chủ" | Commander → Frontend Agent redesign với design system |
| "Chỉnh màu / theme" | Commander → Frontend Agent (color + theme điều chỉnh) |
| "Thêm animation / hiệu ứng" | Commander → Frontend Agent (motion rules) |
| "Sửa layout / responsive" | Commander → Frontend Agent (layout + responsive rules) |

---

## ⏱️ Timeout Prevention Protocol (BUỘC PHẢI LÀM)

> **Root cause:** Agent dùng `read(file)` chunk-by-chunk — 7-8 lượt cho file 33KB = 2-3 phút chỉ để đọc. Commander không truyền context. Timeout cố định bất kể project size. Agent viết file cuối mới commit → mất hết nếu timeout.
>
> **Fix triệt để: 5 bước bên dưới.**

### Bước 0 — Project Sizing (trước pipeline)

Commander đo input size để quyết định chiến lược:

| Size | idea.md size | Timeout PO | Timeout Arch | Timeout BE | Timeout FE | Phase Split? |
|:----:|:------------:|:----------:|:------------:|:----------:|:----------:|:------------:|
| **S** | <2KB | 90s | 90s | 180s | 180s | ❌ |
| **M** | 2-10KB | 120s | 120s | 300s | 300s | ❌ |
| **L** | 10-30KB | 180s | 180s | 600s | 600s | 🔄 nếu >15 files |
| **XL** | >30KB | ❌ Commander | ❌ Commander | ❌ Phase split | ❌ Phase split | ✅ BẮT BUỘC |

### Bước 1 — Context Digestion (quan trọng nhất)

**Commander đọc input files, digest vào prompt. Agent KHÔNG tự đọc file.**

```diff
- ❌ CÁCH CŨ (chết timeout):
  task: "Đọc 02-spec.md ... Code backend vào src/backend/"

+ ✅ CÁCH MỚI:
  task: "Schema SQLite gồm 5 bảng: suttas(id,pali_title,basket...), verses(id,sutta_id,pali_text...), ...
          Struct Rust: pub struct Sutta { id: String, basket: Basket, pali_title: String, ... }
          Endpoints: GET /api/v1/suttas, GET /api/v1/suttas/:id/verses, POST /api/v1/search
          Code tất cả vào src/backend/tipitaka-core/src/"
```

**Cách digest cho từng agent:**

| Agent | Commander cung cấp | Thay vì agent tự đọc |
|-------|-------------------|---------------------|
| **PO** | Tóm tắt idea.md + format PRD | `read(idea.md)` chunk-by-chunk |
| **Architect** | Tóm tắt PRD + key decisions | `read(01-prd.md)` |
| **Backend** | Schema SQL + struct types + endpoints (trích từ spec) | `read(02-spec.md)` 15-33KB |
| **Frontend** | Component tree + pages + API endpoints | `read(02-spec.md)` |
| **Tester** | File structure + test targets + CodeGraph results | `find src/` + `read` từng file |
| **Reviewer** | File list + CodeGraph impact data | `read` toàn bộ src/ |

### Bước 2 — Phase Splitting (cho project L/XL)

Thay vì 1 agent, chia thành nhiều phase, mỗi phase spawn riêng:

```
Size L (10-30KB idea, 15-30 files output):
  Backend: Phase1 (core lib) → Phase2 (import + API)
  Frontend: Phase1 (pages + components) → Phase2 (PWA + polish)

Size XL (>30KB idea, >30 files output):
  Backend: Phase1 (types + schema) → Phase2 (db + search) → Phase3 (import) → Phase4 (API)
  Frontend: Phase1 (setup + api client) → Phase2 (components) → Phase3 (pages) → Phase4 (styling + PWA)
  Mỗi phase tạo 3-8 files, timeout 600s.
```

### Bước 3 — Checkpoint Writing

Agent viết file NGAY KHI XONG, mỗi file là 1 checkpoint:

```diff
- ❌ CŨ: Đọc hết → suy nghĩ → suy nghĩ tiếp → write tất cả → TIMEOUT mất hết
+ ✅ MỚI: Đọc types spec → write types.rs NGAY → đọc schema → write db.rs NGAY → ...
```

**Nếu timeout, các file đã viết vẫn còn.** Commander resume từ checkpoint.

### Bước 4 — Dynamic Timeout

```python
TIMEOUT = 120 + (ESTIMATED_FILES * 30)  # seconds
# +60s buffer luôn
# Nếu kết quả > 600s → split phase
```

Ví dụ:
- BE Agent, size M, 8 files → 120 + (8×30) + 60 = 420s
- FE Agent, size L, 25 files → 120 + (25×30) + 60 = 930s → split 4 phases
- Tester Agent, 5 test files → 120 + (5×30) + 60 = 330s

### Bước 5 — Recovery Protocol (khi timeout)

```
1. Kiểm tra files đã tạo: find src/ -type f | wc -l
2. Nếu có file: spawn agent mới với context + danh sách file còn thiếu
3. Nếu không file: retry với timeout × 2
4. Retry 2 lần fail → Commander viết thay
5. Luôn báo user: "Agent X timeout sau Ys, đã viết Z files. Resuming..."
```

### SỬA ĐỔI Critical Path Rule

```diff
- CŨ: Critical fail → stop pipeline, ask user
+ MỚI: Critical fail → auto-retry × 2 → Commander viết thay → continue pipeline
+ Chỉ hỏi user khi Commander cũng không viết được
```

---

## Spawning agents

Use `sessions_spawn` with `context="isolated"` (default). **Dynamic timeout dựa trên size class:**

```text
sessions_spawn({
  task: "[Digested context from Commander - KHÔNG bắt agent đọc file]",
  runTimeoutSeconds: <dynamic: 120 + (files * 30) + 60>,
  mode: "run"
})
```

### Dynamic timeouts quick reference

| Agent | Size S | Size M | Size L (phased) | Size XL (phased) |
|-------|:------:|:------:|:---------------:|:----------------:|
| PO | 90s | 120s | ❌ Commander | ❌ Commander |
| Architect | 90s | 120s | ❌ Commander | ❌ Commander |
| Backend (per phase) | 180s | 300s | 600s | 600s |
| Frontend (per phase) | 180s | 300s | 600s | 600s |
| Tester | 180s | 240s | 300s | 300s |
| Reviewer | 180s | 240s | 300s | 300s |
| DevOps | 120s | 180s | 180s | 180s |
| Doc | 120s | 180s | 180s | 180s |

## Error handling

Validate bằng số lượng FILE, không chỉ kiểm tra thư mục:

```bash
# Kiểm tra backend: cần ít nhất N files
COUNT=$(find agent-army/projects/<name>/src/backend -type f 2>/dev/null | wc -l)
MIN_FILES=5  # types, db, search, error, lib
if [ "$COUNT" -lt "$MIN_FILES" ]; then
  echo "❌ Backend: only $COUNT/$MIN_FILES files. Retrying..."
  # Auto-retry logic
fi
```

- **Critical path:** Fail → auto-retry 1 lần với timeout × 2 → fail tiếp → Commander viết thay
- **Non-critical:** Fail → Commander viết thay hoặc warn user, continue

## Template variables

Replace before spawning: `{{PROJECT_DIR}}` → `agent-army/projects/<name>`, `{{PROJECT_NAME}}` → project name.

## Reference files

Load these when orchestrating the corresponding agent:

| File | When to load |
|------|-------------|
| `references/po-agent.md` | Spawning PO Agent (task: write PRD to `01-prd.md`) |
| `references/architect-agent.md` | Spawning Architect Agent (task: write spec to `02-spec.md`) |
| `references/backend-agent.md` | Spawning Backend Agent (task: code to `src/backend/`) |
| `references/frontend-agent.md` | Spawning Frontend Agent (task: code to `src/frontend/`) |
| `references/frontend-design-system.md` | 🎨 Injected vào Frontend Agent — nguyên tắc thiết kế chuyên nghiệp |
| `references/tester-agent.md` | Spawning Tester Agent (task: write tests to `tests/`) |
| `references/reviewer-agent.md` | Spawning Reviewer Agent (task: review to `05-review.md`) |
| `references/devops-agent.md` | Spawning DevOps Agent (task: infra to `infra/`) |
| `references/doc-agent.md` | Spawning Documenter Agent (task: docs to `docs/`) |
| `references/tech-radar.md` | 🛰️ Before spawning Backend/Frontend — fetch latest docs for tech stack |
| `references/commander-agent.md` | When orchestrating the full pipeline as Commander |

## Audit trail

Record pipeline progress to `pipeline.log.md`:

```markdown
# Pipeline Log: {{PROJECT_NAME}}
| Step | Agent | Time | Status | Files |
|------|-------|------|--------|-------|
| 1 | Setup | 08:00 | ✅ | — |
| 2 | PO | 08:01 | ✅ | 01-prd.md |
```

**Ghi chi tiết: số files tạo được, số lần retry, thời gian thực tế.**

## Token cost estimate

~150K tokens / full pipeline (app cỡ vừa, với CodeGraph + Semble; DeepSeek V4 Pro cho tất cả agent) — giảm từ ~400K so với không dùng:
- CodeGraph: ~59% savings (structural analysis)
- Semble: ~98% savings so với grep+read (semantic search)
- Kết hợp: agent dùng Semble để tìm code, CodeGraph để hiểu cấu trúc → **~70% tổng thể**
- Pro x2.5x.
- Fallback (không tool): agent đọc file (~400K).

**Với Timeout Prevention Protocol, token cost giảm thêm ~30%** vì agent không đọc file chunk-by-chunk.

## Model recommendations — BẮT BUỘC DeepSeek V4 Pro

> ⚠️ **TẤT CẢ AGENT DÙNG DeepSeek V4 Pro.** Không dùng Flash, không dùng Claude.

| Agent | Model | Lý do |
|-------|:-----:|-------|
| PO | Pro | Phân tích PRD chất lượng cao, context lớn |
| Architect | Pro | Thiết kế hệ thống cần suy luận sâu |
| Backend | Pro | Code nhiều, cần chính xác tuyệt đối |
| Frontend | Pro | UI/UX + design system, cần model mạnh |
| Tester | Pro | Viết test toàn diện, edge cases |
| Reviewer | Pro | Review chất lượng cao, phát hiện bug tinh vi |
| DevOps | Pro | Docker, CI/CD — Pro cho infra chính xác |
| Doc | Pro | Viết tài liệu chất lượng, README chuyên nghiệp |

**Spawn luôn kèm `model: "deepseek/deepseek-v4-pro"`.**

## Recovery / Resume

Nếu pipeline bị gián đoạn (mất kết nối, timeout, lỗi agent):

1. **Kiểm tra `pipeline.log.md`** — xem bước nào đã hoàn thành và bước nào thất bại.
2. **Kiểm tra files** — đếm files đã tạo được trong thư mục của agent bị lỗi.
3. **Resume từ checkpoint:** spawn lại agent với context đã biết + danh sách file còn thiếu.
4. **File output đã tạo vẫn giữ nguyên** — các agent viết vào file, nên không mất dữ liệu trung gian.
5. **Nếu Commander không thể resume** — hỏi người dùng: "Retry? Skip? Cancel?"

## Setup / Installation

### Cấu trúc workspace cho dự án mới

Trước khi chạy pipeline, Commander tự động tạo cấu trúc project:

```bash
mkdir -p agent-army/projects/<project-name>/{src/{backend,frontend},tests,infra,docs}
touch agent-army/projects/<project-name>/idea.md
```

### Template `.gitignore` cho project

```gitignore
# agent-code-army project gitignore
node_modules/
venv/
.env
*.db
*.sqlite
__pycache__/
dist/
build/
.next/
```

## Related files

- `scripts/setup.sh`: Bootstrap health-check for the army
