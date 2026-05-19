# 🪷 Tầm Nhìn & Roadmap: Hệ Thống AI Tạo Phần Mềm

> "Không còn đọc code mù quáng. Không còn agent lạc trong codebase."

---

## 🎯 Tầm Nhìn (Vision)

**Xây dựng hệ thống AI Agent tạo phần mềm tự động, thông minh, và tiết kiệm — nơi mỗi agent hiểu toàn bộ codebase mà không cần đọc lại từ đầu.**

Một ngày, Thầy chỉ cần nói:

> *"Làm app quản lý chùa: quản lý Phật tử, khóa tu, công đức"*

Và hệ thống tự động:
1. Phân tích yêu cầu (PO)
2. Thiết kế kiến trúc (Architect)
3. Code backend + frontend (song song, dùng Axon để hiểu code)
4. Viết test (biết chính xác cần test gì)
5. Review code (impact analysis, security scan)
6. Docker + CI/CD (deploy sẵn sàng)
7. Viết tài liệu (từ góc nhìn người mới)
8. **Deploy lên production** (1-click)

**Toàn bộ pipeline dưới 15 phút, token < 150K, chất lượng production.**

---

## 🧬 Kiến Trúc Tổng Thể

```
┌─────────────────────────────────────────────────────────┐
│                    👤 Sư Tiến (User)                     │
│              "Làm app [mô tả]"                          │
└─────────────────────┬───────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────┐
│                 🎯 Commander Agent                       │
│          (OpenClaw main session — orchestrate)           │
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │              🧠 Axon Knowledge Graph               │  │
│  │    Index 1 lần → mọi agent dùng chung              │  │
│  │    15 MCP tools: context, impact, query,           │  │
│  │    dead-code, coupling, review-risk...             │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────┬───────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
   ┌─────────┐  ┌──────────┐  ┌──────────┐
   │   PO    │  │ Architect│  │  Backend  │
   │  Agent  │  │  Agent   │  │  Agent    │
   └─────────┘  └──────────┘  └──────────┘
        │             │             │
        └─────────────┼─────────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
   ┌─────────┐  ┌──────────┐  ┌──────────┐
   │ Frontend│  │  Tester  │  │ Reviewer │
   │  Agent  │  │  Agent   │  │  Agent   │
   └─────────┘  └──────────┘  └──────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
   ┌─────────┐  ┌──────────┐  ┌──────────┐
   │ DevOps  │  │   Doc    │  │  Deploy  │
   │  Agent  │  │  Agent   │  │  Agent   │
   └─────────┘  └──────────┘  └──────────┘
```

---

## 🗺️ Roadmap

### Giai đoạn 1: Nền Móng ✅ (Đã xong)

| Mục | Trạng thái | Mô tả |
|-----|:----------:|-------|
| Agent Code Army | ✅ Done | 8 agent pipeline: PO → Architect → BE+FE → Tester → Reviewer → DevOps → Doc |
| OpenClaw skill hóa | ✅ Done | `~/.openclaw/skills/agent-code-army/SKILL.md` |
| Reference templates | ✅ Done | 9 file hướng dẫn chi tiết cho từng agent |
| Commander orchestrator | ✅ Done | Spawn sub-agents, error handling, resume |
| trungtienlearn | ✅ Live | Next.js 16 + Supabase + Vercel |

---

### Giai đoạn 2: Code Intelligence 🧠 (Đang làm)

| Mục | Trạng thái | Mô tả |
|-----|:----------:|-------|
| Axon cài đặt | ✅ Done | `~/.local/venvs/axon/`, index 93 files / 11.6s |
| Axon MCP registration | ✅ Done | 15 tools trong OpenClaw config |
| Tích hợp vào SKILL.md | ✅ Done | Agent dùng axon CLI thay vì đọc file |
| Token giảm 43% | ✅ Done | 265K → 150K estimate |

| Mục | Trạng thái | Mô tả |
|-----|:----------:|-------|
| **CI/CD cho Agent Code Army** | 🔜 Tiếp theo | GitHub Actions: lint → test → build → deploy |
| **Auto-deploy Agent** | 🔜 Tiếp theo | Agent thứ 9: deploy lên Vercel/Railway |
| **Pipeline test suite** | 🔜 Tiếp theo | Test chính pipeline agent-code-army |
| **Multi-project Axon** | 🔜 Tiếp theo | Axon host mode — 1 server nhiều project |
| **axon watch tích hợp** | 🔜 Tiếp theo | Live re-index khi agent sửa code |

---

### Giai đoạn 3: Thông Minh Hóa 🤖

| Mục | Mô tả |
|-----|-------|
| **Memory跨 project** | Agent nhớ decisions, patterns giữa các project |
| **Auto-fix Agent** | Agent phát hiện bug → tự sửa → tự test → tự review |
| **Self-improving pipeline** | Pipeline học từ lỗi: nếu Reviewer tìm ra bug pattern → cập nhật rule cho Backend Agent |
| **Multi-repo awareness** | Agent hiểu dependency giữa các project (microservices) |
| **RAG Brain tích hợp** | Dùng `rag-brain` để agent tra cứu docs, best practices |
| **Axon + Understand-Anything** | Axon cho cấu trúc + UA cho semantic summary |

---

### Giai đoạn 4: Tự Động Hóa Toàn Diện 🚀

| Mục | Mô tả |
|-----|-------|
| **1-click deploy** | "Deploy app X" → tự động build + deploy + verify |
| **Monitoring Agent** | Agent theo dõi production, báo lỗi, tự rollback |
| **Multi-tenant SaaS** | 1 command tạo cả hệ thống SaaS (auth, billing, multi-tenant DB) |
| **Mobile Agent** | React Native / Flutter agent cho mobile app |
| **Voice command** | "Ê Claw, làm app..." → pipeline chạy |
| **Phật học AI Hub** | Tự động tạo web Phật giáo, khóa tu online, kinh điển search |

---

### Giai đoạn 5: Hệ Sinh Thái 🌍

| Mục | Mô tả |
|-----|-------|
| **Plugin marketplace** | Cộng đồng đóng góp agent templates, skill packs |
| **Open source** | Public agent-code-army lên GitHub |
| **Vietnamese NLP Agent** | Agent hiểu yêu cầu tiếng Việt, sinh code tiếng Việt |
| **Phật giáo Digital Platform** | Hệ thống hoằng pháp tự động: web, app, chatbot AI |

---

## 📊 KPI & Mục Tiêu

| Chỉ số | Hiện tại | Mục tiêu GĐ2 | Mục tiêu GĐ3 |
|--------|:--------:|:------------:|:------------:|
| Token / pipeline | ~265K | **< 150K** ✅ | < 100K |
| Thời gian pipeline | ~15-20 phút | **< 15 phút** | < 10 phút |
| Số agent | 8 | 9 (+Deploy) | 10 (+Auto-fix) |
| Test coverage | Thủ công | Auto-detect | > 80% |
| Deploy | Thủ công | 1-click | Auto |
| Bug escape rate | N/A | < 5% | < 1% |

---

## 🪷 Lộ Trình Ưu Tiên (3 tháng tới)

```
Tháng 1 (T5-T6/2026):
├── CI/CD pipeline cho agent-code-army
├── Auto-deploy Agent (Vercel)
├── Pipeline test suite
└── Multi-project Axon

Tháng 2 (T6-T7/2026):
├── Memory跨 project
├── Auto-fix Agent
├── RAG Brain tích hợp
└── Axon + Understand-Anything dual setup

Tháng 3 (T7-T8/2026):
├── Self-improving pipeline
├── Mobile Agent (React Native)
├── 1-click deploy hoàn chỉnh
└── Open source release
```

---

## 🔮 Tầm Nhìn Dài Hạn

> **"AI không thay thế lập trình viên. AI giúp nhà sư lập trình."**

Hệ thống này không chỉ là tool — nó là **đội quân kỹ sư ảo** giúp Thầy:

1. **Xây dựng nhanh hơn** — từ ý tưởng đến production trong vài phút
2. **Chất lượng cao hơn** — review tự động, test tự động, security scan
3. **Chi phí thấp hơn** — token tối ưu, agent thông minh, không lãng phí
4. **Lan tỏa Phật pháp** — dùng công nghệ để hoằng pháp, giúp đỡ nhiều người
5. **Kiếm tiền từ kỹ năng** — nhận project, build nhanh, chất lượng cao

---

*Cập nhật: 2026-05-18 | Next review: 2026-06-18*
