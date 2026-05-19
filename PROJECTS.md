# PROJECTS.md — Bảng Theo Dõi Dự Án

> Cập nhật: 2026-05-18
> Mở file này mỗi phiên mới để biết ngay mình đang làm gì.

---

## 🟢 Đang chạy / Hoàn thành

### 1. trungtienlearn — Web cá nhân / Blog Phật giáo
| Mục | Chi tiết |
|-----|----------|
| **Mô tả** | Website cá nhân, blog Phật giáo, admin panel |
| **Stack** | Next.js 16, Supabase (DB + Auth), Tailwind CSS |
| **Deploy** | Vercel — `trungtienlearn.vercel.app` |
| **GitHub** | `github.com:trungtiendev/trungtienlearn.git` |
| **Trạng thái** | ✅ Live, build sạch |
| **Việc tiếp theo** | Thêm nội dung, tính năng mới |

### 2. Agent Code Army — Đội quân AI Agent
| Mục | Chi tiết |
|-----|----------|
| **Mô tả** | Pipeline 8 AI agent tự động tạo full-stack app |
| **Stack** | OpenClaw sub-agents, DeepSeek models |
| **GitHub** | `github.com:trungtiendev/agent-code-army.git` |
| **Skill** | `~/.openclaw/skills/agent-code-army/` |
| **Trạng thái** | ✅ Sẵn sàng dùng |
| **Cách dùng** | Nói "Làm app [tên]" — skill tự trigger |

---

## 🟡 Đang phát triển

### 3. memora — Ghi chú thông minh
| Mục | Chi tiết |
|-----|----------|
| **Mô tả** | Ứng dụng ghi chú / knowledge base thông minh |
| **GitHub** | `github.com:trungtiendev/memora.git` |
| **Trạng thái** | 🟡 WIP |
| **Việc tiếp theo** | Cần xác định rõ scope |

### 4. Claw3D — Dự án 3D
| Mục | Chi tiết |
|-----|----------|
| **Mô tả** | Dự án 3D (cần xác định rõ) |
| **Trạng thái** | 🟡 WIP |
| **Ghi chú** | Có 2 repo: `Claw3D/` và `claw3d/` — nên gộp |

### 5. rag-brain — RAG AI Pipeline
| Mục | Chi tiết |
|-----|----------|
| **Mô tả** | Retrieval-Augmented Generation pipeline |
| **Trạng thái** | 🟡 WIP |

### 6. hermes-agent — Hermes Agent Framework
| Mục | Chi tiết |
|-----|----------|
| **Mô tả** | Hermes agent framework |
| **Trạng thái** | 🟡 WIP |

---

## 🗂️ Tổng quan Git Repos

```
/home/hgahct/trungtienlearn/     ← Next.js web (active)
/home/hgahct/memora/              ← Ghi chú thông minh
/home/hgahct/Claw3D/              ← 3D (cần gộp với claw3d/)
/home/hgahct/claw3d/              ← 3D (cần gộp với Claw3D/)
/home/hgahct/rag-brain/           ← RAG pipeline
/home/hgahct/.hermes/hermes-agent/ ← Hermes agent
/home/hgahct/.openclaw/workspace/ ← OpenClaw workspace (đã push GitHub)
```

---

## 📋 Việc cần làm (Backlog)

- [ ] Gộp Claw3D + claw3d thành 1 repo
- [ ] Xác định scope rõ ràng cho memora
- [ ] Đẩy tất cả dự án lên GitHub để backup
- [ ] Tạo 1 repo tổng "dotfiles" để lưu config OpenClaw
