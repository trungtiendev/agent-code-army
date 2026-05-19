---
name: agent-code-army
description: >
  Auto-generate full-stack software projects using a pipeline of 8 specialized AI agents (PO, Architect, Backend, Frontend, Tester, Reviewer, DevOps, Doc).
  Trigger when user says "Làm app [tên]", "Tạo [project]", "Làm [website/app/tool] [mô tả]",
  or calls individual agents like "Backend Agent, code API...", "Reviewer Agent, review code...".
  Also supports adding features, fixing bugs, auditing security, refactoring, writing tests, setting up Docker/CI-CD, and writing documentation
  for existing projects. User is Vietnamese Buddhist monk named Nguyễn Hoàng Anh (Sư Tiến), UTC+7.
---

# 🪷 Agent Code Army

Orchestrate a multi-agent pipeline to auto-generate production-ready software.

## Pipeline

```
User → Commander → PO → Architect → Backend+Frontend (parallel) → Tester → Reviewer → DevOps → Doc → Report
```

Each agent is an **isolated sub-agent** (`sessions_spawn` with default `isolated` context). Agents read input files and write output files — they don't talk to each other. Commander is the orchestrator.

## 🧠 Axon Knowledge Graph (Pre-Index)

**Trước khi spawn bất kỳ agent nào**, Commander index codebase bằng [Axon](https://github.com/harshkedia177/axon) — một graph-powered code intelligence engine dùng tree-sitter static analysis.

### Tại sao dùng Axon?

Thay vì mỗi agent phải `read` hàng chục file để hiểu codebase (burn 50-70% token cho exploration), Axon index 1 lần (~4-5s) rồi mọi agent dùng chung graph:

| Không có Axon | Có Axon |
|---|---|
| Agent `ls` + `read` từng file | Agent gọi `axon context <symbol>` → có ngay toàn cảnh |
| Mỗi agent lặp lại việc đọc codebase | Index 1 lần, dùng mãi mãi |
| Token burn cho exploration | Token dành cho execution |
| Agent bỏ sót indirect dependency | Graph trace toàn bộ call chain |

### Cài đặt (1 lần)

```bash
# Đã cài tại: ~/.local/venvs/axon/bin/axon
# Symlink: ~/.local/bin/axon
#
# Nếu chưa cài:
python3 -m venv ~/.local/venvs/axon
~/.local/venvs/axon/bin/pip install axoniq
ln -sf ~/.local/venvs/axon/bin/axon ~/.local/bin/axon
```

### Commander flow với Axon

```
Commander:
  1. Tạo project structure (mkdir...)
  2. Chạy axon analyze agent-army/projects/<name>/
     → Index tất cả file, tạo .axon/ (KuzuDB ~80MB)
  3. Spawn PO Agent (đọc idea.md, chưa có code → không cần Axon)
  4. Spawn Architect Agent (đọc 01-prd.md, chưa có code → không cần Axon)
  5. Spawn Backend + Frontend (song song) — code xong
  6. Chạy axon analyze agent-army/projects/<name>/ LẦN 2
     → Index code vừa được tạo bởi BE+FE agents
  7. Spawn Tester → dùng axon test-impact để biết cần test gì
  8. Spawn Reviewer → dùng axon impact, review-risk
  9. Spawn DevOps, Doc → dùng axon context, explain
```

### Axon CLI commands mỗi agent dùng

| Agent | Axon commands |
|-------|--------------|
| **Backend** | `axon context <symbol>`, `axon file-context <file>`, `axon query "..."` |
| **Frontend** | `axon context <component>`, `axon query "..."` |
| **Architect** | `axon communities`, `axon cycles`, `axon call-path A B` |
| **Reviewer** | `axon impact <symbol>`, `axon review-risk "$(git diff)"`, `axon coupling <file>`, `axon dead-code`, `axon cycles` |
| **Tester** | `axon test-impact --symbols "func1,func2"`, `axon impact <symbol>`, `axon context <symbol>` |
| **DevOps** | `axon communities`, `axon context <service>` |
| **Doc** | `axon explain <symbol>`, `axon communities` |

### Axon không cần cho:
- **PO Agent** — chỉ đọc idea.md (text), không có code để index
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
│   ├── backend/     ← Backend Agent
│   └── frontend/    ← Frontend Agent
├── tests/           ← Tester Agent
├── 05-review.md     ← Reviewer Agent
├── infra/           ← DevOps Agent
├── docs/            ← Doc Agent
├── .axon/           ← Axon knowledge graph (KuzuDB)
├── pipeline.log.md  ← Commander (audit trail)
└── README.md        ← Doc Agent
```

## Command triggers

| User says | I do |
|-----------|------|
| "Làm app quản lý chi tiêu" | Full pipeline: Setup → PO → Architect → BE+FE → **Axon index** → Tester → Reviewer → DevOps → Doc |
| "Làm website bán hàng dùng Next.js + PostgreSQL" | Full pipeline with tech stack constraint |
| "Làm app todo, chỉ MVP: CRUD cơ bản" | Full pipeline, scope-limited |
| "Làm app note, code luôn khỏi cần PO với Architect" | Skip PO + Architect, go straight to code |
| "Thêm tính năng login Google vào project abc" | Axon analyze → PO → Architect → Code → Test → Review |
| "Fix bug crash khi nhập số âm" | Axon context → Reviewer → Backend/Frontend → Tester |
| "Review code project abc" | Axon analyze → Reviewer Agent → report |
| "Setup Docker cho project abc" | Axon communities → DevOps Agent |
| "Viết docs cho todo-app" | Axon explain → Documenter Agent |
| "Thêm test cho module payment" | Axon test-impact → Tester Agent |
| "Đăng bài viết mới lên trungtienlearn" | Commander → Backend Agent gọi Admin API POST /api/admin/posts |
| "Cập nhật trạng thái dự án X" | Commander → Backend Agent gọi Admin API PUT |
| "Kiểm tra dashboard trungtienlearn" | Commander → GET /api/admin/dashboard → báo cáo |
| "Dùng Claude cho Reviewer Agent" | Override model per agent |

## Spawning agents

Use `sessions_spawn` with `context="isolated"` (default). Set `runTimeoutSeconds` per agent:

<!-- FIXED: S1 — Đổi code block sang plain text, không còn viết dạng JavaScript sai -->
```text
sessions_spawn({
  task: "Đọc file SKILL.md để biết vai trò. Dự án: agent-army/projects/<name>/ ...",
  runTimeoutSeconds: 300,
  mode: "run"
})
```

Timeouts by agent:
- PO, Architect: 120s
- Backend, Frontend: 300s
- Tester, Reviewer: 240s
- DevOps, Doc: 180s

## Error handling

Always validate before spawning the next agent:

```bash
if [ ! -f "agent-army/projects/<name>/01-prd.md" ]; then
  # Critical path → must stop, ask user
  "PO Agent failed. Retry? Skip? Cancel?"
fi
```

- **Critical path** (PO, Architect, Backend, Frontend): Fail → stop pipeline, ask user
- **Non-critical** (Tester, Reviewer, DevOps, Doc): Fail → warn user, continue

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
| `references/tester-agent.md` | Spawning Tester Agent (task: write tests to `tests/`) |
| `references/reviewer-agent.md` | Spawning Reviewer Agent (task: review to `05-review.md`) |
| `references/devops-agent.md` | Spawning DevOps Agent (task: infra to `infra/`) |
| `references/doc-agent.md` | Spawning Documenter Agent (task: docs to `docs/`) |
| `references/commander-agent.md` | When orchestrating the full pipeline as Commander |

## Audit trail

Record pipeline progress to `pipeline.log.md`:

```markdown
# Pipeline Log: {{PROJECT_NAME}}

| Step | Agent | Time | Status |
|------|-------|------|--------|
| 1 | Setup | 08:00 | ✅ |
| 2 | PO | 08:01 | ✅ |
| 3 | Architect | 08:03 | ✅ |
| 4 | Backend | 08:05 | ✅ |
| 5 | Frontend | 08:05 | ✅ |
| 6 | Axon Index | 08:10 | ✅ |
| 7 | Tester | 08:10 | ✅ |
| 8 | Reviewer | 08:14 | ✅ |
| 9 | DevOps | 08:17 | ✅ |
| 10 | Doc | 08:20 | ✅ |
```

## Token cost estimate

## Token cost estimate

<!-- Với Axon, token cost giảm ~40-60% vì agent không cần đọc file -->
~150K tokens / full pipeline (app cỡ vừa, với Axon; ước tính DeepSeek Flash) — giảm từ ~265K so với không dùng Axon. Pro x2-3x. Nếu không có Axon, fallback về đọc file (~265K).

<!-- FIXED: W2 — Thêm disclaimer về model dùng để estimate -->

## Model recommendations

<!-- FIXED: W3 — Gợi ý model cho từng agent -->
| Agent | Model gợi ý | Lý do |
|-------|-------------|-------|
| PO | DeepSeek Flash | Phân tích yêu cầu, viết PRD — không cần code |
| Architect | DeepSeek Pro | Thiết kế hệ thống cần suy luận sâu |
| Backend | DeepSeek Pro / Claude | Code nhiều, cần chính xác cao |
| Frontend | DeepSeek Pro / Claude | UI/UX + code, cần model mạnh |
| Tester | DeepSeek Flash | Viết test cases, độ phức tạp vừa phải |
| Reviewer | DeepSeek Pro | Review chất lượng cao, phát hiện bug tinh vi |
| DevOps | DeepSeek Flash / Pro | Docker, CI/CD — Pro nếu infra phức tạp |
| Doc | DeepSeek Flash | Viết tài liệu, README — nhẹ |

## Recovery / Resume

<!-- FIXED: S2 — Hướng dẫn resume pipeline khi gián đoạn -->
Nếu pipeline bị gián đoạn (mất kết nối, timeout, lỗi agent):
1. **Kiểm tra `pipeline.log.md`** — xem bước nào đã hoàn thành và bước nào thất bại.
2. **Resume từ bước thất bại:** chạy lại Agent bị lỗi với đầu vào từ output file của bước trước đó. Ví dụ: nếu Architect đã xong nhưng Backend bị timeout, spawn lại Backend Agent với `02-spec.md` có sẵn.
3. **File output đã tạo vẫn giữ nguyên** — các agent viết vào file, nên không mất dữ liệu trung gian.
4. Nếu thất bại ở bước critical (PO/Architect/BE/FE) và không thể resume, hỏi người dùng: "Retry? Skip? Cancel?"

## Setup / Installation

<!-- FIXED: W1 — Hướng dẫn tạo workspace structure cho dự án mới -->
### Cấu trúc workspace cho dự án mới

Trước khi chạy pipeline, Commander sẽ tự động tạo cấu trúc project. Nếu cần tạo thủ công:

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
