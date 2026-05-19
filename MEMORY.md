# MEMORY.md — Bộ Nhớ Dài Hạn

> Cập nhật: 2026-05-18

---

## 🪷 Danh tính

- **Tôi:** OpenClaw — trợ lý cá nhân thông minh, chuyên nghiệp
- **Emoji:** 🪷 (hoa sen Phật giáo Việt Nam)
- **Vibe:** thân thiện, chuyên nghiệp, sâu sắc, giỏi

## 👤 Con người của tôi

- **Pháp danh:** Thích Trung Tiến (thế danh: Nguyễn Hoàng Anh)
- **Cách gọi:** Sư Tiến / Thầy / anh Tiến
- **Timezone:** Asia/Ho_Chi_Minh (UTC+7)
- **Là:** Nhà Sư Phật Giáo Bắc Tông Việt Nam
- **Học vấn:** Cao đẳng QTKD, Trung cấp Phật học, đang học ĐH CNTT
- **Định hướng:** Kỹ sư phần mềm + AI, kết hợp AI & Phật học, giúp đỡ nhiều người
- **Sở thích:** lập trình, hệ thống, Phật học, kiếm tiền
- **Lĩnh vực:** IT, coding, AI, kinh doanh, Phật học

---

## 📦 Dự án đang có

| Dự án | Mô tả | Trạng thái |
|-------|-------|:----------:|
| **trungtienlearn** | Next.js 16 + Supabase + Vercel, web cá nhân/blog Phật giáo | ✅ Live |
| **agent-code-army** | Đội quân 9 AI Agent tự động tạo phần mềm (đã skill hóa) | ✅ Sẵn sàng |
| **memora** | Dự án ghi chú/thông minh (đang phát triển) | 🟡 WIP |
| **Claw3D / claw3d** | Dự án 3D | 🟡 WIP |
| **rag-brain** | RAG AI pipeline | 🟡 WIP |
| **hermes-agent** | Hermes agent framework | 🟡 WIP |

---

## 🛠️ Công cụ & Skill đã cài

### Skills trong `~/.openclaw/skills/`
- **agent-code-army** — pipeline 8 agent tạo phần mềm (tự viết)
- **supabase** — Supabase DB/Auth/Storage
- **supabase-postgres-best-practices** — tối ưu Postgres
- **deploy-to-vercel** — deploy lên Vercel
- **skill-creator** — tạo skill mới
- **tdd** — test-driven development
- **systematic-debugging** — debug hệ thống
- **writing-plans** — lập kế hoạch trước khi code
- **web-design-guidelines** — review UI/UX
- **vercel-react-best-practices** — React/Next.js perf
- **vercel-composition-patterns** — React patterns
- **improve-codebase-architecture** — cải thiện kiến trúc
- **healthcheck** — audit server
- **weather** — thời tiết
- **node-connect** — debug node pairing
- **video-frames** — extract frames video



### Công cụ đặc biệt
- **CloakBrowser** (`/home/hgahct/.cloakbrowser/`) — stealth Chromium, pass 30/30 bot detection
  - Dùng thay Playwright khi crawl trang chống bot mạnh
  - WSL: phải dùng `headless=True`

---

## ⚙️ Cấu hình OpenClaw

- **Provider:** Chỉ dùng DeepSeek chính hãng
- **Default model:** DeepSeek V4 Flash
- **Pro model:** DeepSeek V4 Pro (dùng cho task nặng: review, architect, logic)

---

## 🔑 Thông tin quan trọng

### trungtienlearn
- **GitHub:** `github.com:trungtiendev/trungtienlearn.git`
- **Deploy:** Vercel — `trungtienlearn.com`
- **Admin:** `trungtiendev@gmail.com` / pass lưu trong `.admin-password.txt` (reset 2026-05-18)
- **Stack:** Next.js 16 + Supabase + Tailwind

### Agent Code Army
- **GitHub:** `github.com:trungtiendev/agent-code-army.git`
- **Skill:** `~/.openclaw/skills/agent-code-army/`
- **Cách gọi:** "Làm app [tên]" → trigger skill → spawn 8 agent
- **Pipeline:** Setup → PO → Architect → BE+FE (song song) → Axon Index → Tester → Reviewer → DevOps → Doc
- **Axon integration:** Đã tích hợp Axon knowledge graph vào pipeline. Agent dùng axon CLI thay vì đọc file, giảm ~43% token (265K → 150K). Cài tại `~/.local/venvs/axon/`. MCP: đăng ký trong OpenClaw config.

### Workspace
- **Path:** `~/.openclaw/workspace/`
- **Git:** đã init, remote GitHub
- **BACKPACK.md:** phao cứu sinh khi reset

---

## 📝 Nhật ký quan trọng

- **2026-05-16:** Setup OpenClaw lần đầu, tạo IDENTITY/USER/SOUL
- **2026-05-17:** Cleanup config (chỉ DeepSeek), tạo Agent Code Army, nghiên cứu skills.sh, phát hiện CloakBrowser, fix trungtienlearn (Next.js 16 build + CI/CD)
- **2026-05-18:** Skill hóa agent-code-army, review + fix skill, fix trungtienlearn (Turbopack root, audit), dọn dẹp session rác. **Nghiên cứu + cài Axon** (code intelligence engine) — index trungtienlearn (93 files, 4.2s, 247 symbols). **Tích hợp Axon vào agent-code-army SKILL.md** — tất cả agent dùng axon CLI thay vì đọc file, giảm token ~43%. Đăng ký Axon MCP server vào OpenClaw (15 tools).
