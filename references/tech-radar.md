# 🛰️ Tech Radar — Knowledge Injection Template

## Vai trò
Đảm bảo code được tạo ra dùng **API mới nhất, best practices hiện tại** của framework/library.

Commander dùng template này để fetch docs và inject vào prompt của Backend/Frontend agents.

## Khi nào dùng

| Tình huống | Bắt buộc? |
|------------|:---------:|
| Project dùng framework version cụ thể (Next.js 16, React 19, ...) | ✅ Luôn |
| Project dùng library phổ biến (shadcn/ui, Prisma, Supabase, PayOS, ...) | ✅ Luôn |
| Project dùng ngôn ngữ mới (Rust, Go, Python 3.14, ...) | ✅ Luôn |
| Project tech stack đơn giản (HTML/CSS thuần, no framework) | ❌ Bỏ qua |
| Project dùng stack mà AI cutoff đã bao phủ tốt (Express.js, React 18, ...) | 🟡 Có thể bỏ qua |

## Cách dùng (Commander flow)

### Bước 1 — Xác định tech stack cần fetch

Từ `02-spec.md` (Architect output), trích xuất tech stack:

```python
# Ví dụ từ spec:
tech_stack = {
    "backend": {"framework": "Next.js 16", "language": "TypeScript"},
    "frontend": {"framework": "React 19 + shadcn/ui", "css": "Tailwind CSS v4"},
    "database": "Supabase (PostgreSQL)",
    "auth": "Supabase Auth",
    "payment": "PayOS",
    "ai": "DeepSeek API"
}
```

### Bước 2 — Fetch docs mới nhất (Commander tự gọi)

Commander dùng `web_fetch` hoặc `tavily_search` để lấy docs:

```bash
# Mỗi framework/library = 1 web_fetch call
# Chỉ fetch những cái cần thiết (tránh quá tải context)

# Next.js 16 docs (getting started + key features)
web_fetch("https://nextjs.org/docs")

# shadcn/ui latest
web_fetch("https://ui.shadcn.com/docs")

# Supabase JS SDK v3
web_fetch("https://supabase.com/docs/reference/javascript/introduction")

# React 19
web_fetch("https://react.dev/blog/2025/04/17/react-19")
# OR
tavily_search("React 19 new features API changes 2025", search_depth="advanced")
```

### Bước 3 — Digest thành Tech Radar note

Commander tóm tắt docs thành file `docs/tech-radar.md`:

```markdown
# Tech Radar — {{PROJECT_NAME}}

> Cập nhật: {{DATE}}

## 1. Next.js 16

### Key API changes (vs 15)
- `app/` router is now default, `pages/` deprecated
- Server Actions: `"use server"` → `"use server action"` (nếu có thay đổi)
- RSC streaming improved: `loading.tsx` + `Suspense` boundary
- Middleware: `middleware.ts` ở root, exports `config.matcher`

### Import patterns
```ts
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs'
// HOẶC cách mới nếu API thay đổi
```

## 2. React 19

### Features cần dùng
- Server Components (mặc định trong Next.js 16)
- `use()` hook — đọc Promise trực tiếp
- Actions: form action với `useActionState`
- `useOptimistic` — optimistic updates
- ref as prop (không cần forwardRef)

### Deprecated
- `forwardRef` — không cần nữa, ref là prop
- `React.FC` — không khuyến khích

## 3. shadcn/ui

### Cài đặt
```bash
npx shadcn@latest init
npx shadcn@latest add button card dialog
```

### Component patterns
- `@/components/ui/button` — thay vì tự viết
- Dùng `asChild` prop cho polymorphic components

## 4. Supabase SDK

### Auth patterns
```ts
import { createClient } from '@supabase/supabase-js'
// Server component: supabase/server
// Client component: supabase/client
```

### Real-time
```ts
supabase.channel('custom').on('postgres_changes', ...)
```

---

## Nguyên tắc viết

1. **Chỉ lấy API/syntax mới** — không copy cả docs
2. **Ưu tiên breaking changes** — những gì khác so với AI knowledge cutoff
3. **Kèm code snippet** ngắn gọn, đúng syntax
4. **Không quá 50 dòng** cho mỗi framework — agent cần focused context
5. **Bỏ qua nếu docs không có gì mới** so với AI đã biết
