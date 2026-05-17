# 🪷 Agent Code Army — OpenClaw Native

Đội quân AI Agent tự động tạo phần mềm, chạy hoàn toàn trên OpenClaw.

## 🏗️ Cấu trúc

```
agent-army/
├── README.md              ← Hướng dẫn (file này)
├── roles/                 ← Prompt templates cho từng agent
│   ├── commander-agent.md ← Cách tôi chỉ huy đội quân
│   ├── po-agent.md        ← Product Owner
│   ├── architect-agent.md ← Kiến trúc sư
│   ├── backend-agent.md   ← Backend dev
│   ├── frontend-agent.md  ← Frontend dev
│   ├── tester-agent.md    ← QA / Test
│   ├── reviewer-agent.md  ← Code reviewer
│   ├── devops-agent.md    ← Ops / Deploy
│   └── doc-agent.md       ← Tài liệu
├── projects/              ← Các dự án được tạo ra
│   └── <project-name>/
│       ├── idea.md        ← Ý tưởng gốc
│       ├── 01-prd.md      ← PRD (PO Agent)
│       ├── 02-spec.md     ← Spec kỹ thuật (Architect Agent)
│       ├── src/           ← Code (Backend + Frontend Agent)
│       ├── tests/         ← Test (Tester Agent)
│       ├── 05-review.md   ← Code review (Reviewer Agent)
│       ├── infra/         ← Docker, CI/CD (DevOps Agent)
│       ├── docs/          ← Tài liệu (Documenter Agent)
│       └── README.md      ← README tổng thể
```

## 🚀 Cách gọi đội quân

### Cách 1 — Nói với tôi (khuyên dùng)

Chỉ cần nói trong main session:

> "Làm app quản lý chi tiêu cá nhân"
> "Làm website bán hàng online"
> "Tạo app todo list"

Tôi sẽ đóng vai **Commander Agent**, tự động:
1. Spawn PO Agent → phân tích yêu cầu
2. Spawn Architect Agent → thiết kế
3. Spawn Backend + Frontend Agent → code song song
4. Spawn Tester Agent → test
5. Spawn Reviewer Agent → review
6. Spawn DevOps Agent → build + deploy
7. Spawn Documenter Agent → viết docs
8. Báo cáo lại cho Thầy

### Cách 2 — Gọi agent riêng lẻ

Nếu chỉ muốn 1 agent làm 1 việc cụ thể:

> "PO Agent, phân tích cái ý tưởng này..."  
> "Backend Agent, code API cho project ABC..."  
> "Reviewer Agent, review code ở thư mục XYZ..."

Tôi sẽ spawn đúng agent đó.

### Cách 3 — Cron (lập lịch tự động)

Đặt cron job để đội quân tự động kiểm tra và làm việc:

```json
{
  "name": "agent-army-daily",
  "schedule": { "kind": "cron", "expr": "0 8 * * *", "tz": "Asia/Ho_Chi_Minh" },
  "payload": {
    "kind": "systemEvent",
    "text": "Điểm danh đội quân Agent Code. Kiểm tra issues mới trong GitHub, nếu có task mới thì bắt đầu pipeline."
  },
  "sessionTarget": "main"
}
```

## 🧠 Luồng xử lý chi tiết

```
Thầy: "Làm app ABC"
  │
  ├─ [Tôi = Commander] Tạo thư mục dự án
  │
  ├─ sessions_spawn → PO Agent ────────────► viết 01-prd.md
  │
  ├─ sessions_spawn → Architect Agent ─────► viết 02-spec.md
  │
  ├─ sessions_spawn → Backend Agent ──────► src/backend/  ╮ (song song)
  │  sessions_spawn → Frontend Agent ─────► src/frontend/ ╯
  │
  ├─ sessions_spawn → Tester Agent ───────► tests/
  │
  ├─ sessions_spawn → Reviewer Agent ─────► 05-review.md
  │
  ├─ sessions_spawn → DevOps Agent ───────► infra/
  │
  ├─ sessions_spawn → Doc Agent ──────────► docs/ + README.md
  │
  └─ Báo cáo cho Thầy: "Xong! Đây là app..."
```

Mỗi agent là một **isolated sub-agent session** — không conflict context, không lo token tràn. Mỗi agent chỉ làm việc trong phạm vi file được giao.

## ⚙️ Yêu cầu

- OpenClaw (đã có)
- Model có khả năng code tốt (hiện tại: DeepSeek V4 Flash)
- Workspace: `~/.openclaw/workspace/`

## 📌 Lưu ý

- **Agent không biết nhau** — mỗi agent chỉ đọc file input và viết file output. Tôi (Commander) là người kết nối họ.
- **Human-in-the-loop** — Tôi sẽ hỏi Thầy trước khi deploy, trước khi dùng API key thật, trước khi chạy destructive commands.
- **Chi phí token** — Pipeline dài sẽ tốn nhiều token. Cân nhắc dùng model rẻ hơn (DeepSeek) cho các agent như PO, Doc.
- **Song song** — Backend + Frontend chạy đồng thời, tiết kiệm thời gian.

---

> 🪷 *Đội quân này có 8 agent, nhưng Thầy là tướng.*
