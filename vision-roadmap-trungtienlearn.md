# 🪷 Tầm Nhìn & Roadmap: trungtienlearn

> *Personal Website & Digital Platform cho Nhà Sư Phật Giáo Việt Nam*

---

## 🎯 Tầm Nhìn (Vision)

**trungtienlearn không chỉ là blog cá nhân — nó là nền tảng số để hoằng pháp, chia sẻ tri thức, và kết nối cộng đồng Phật tử trong thời đại AI.**

Một nơi mà:
- 🏠 **Trang chủ** kể câu chuyện về hành trình tu học và lập trình của Thầy
- ✍️ **Blog** chia sẻ Phật pháp, kinh nghiệm code, hành trình tâm linh
- 🔊 **Pháp âm** — kho tàng bài giảng, khóa tu, audio/video
- 🛠️ **Projects** — showcase các dự án công nghệ + Phật giáo Thầy đã xây dựng
- 🤖 **AI Agent Hub** — nơi mọi người tương tác với AI Phật học
- 📚 **E-Learning** — khóa học online về Phật pháp và công nghệ
- 🌐 **Đa ngôn ngữ** — Tiếng Việt, English, Chinese, Japanese...

---

## 🏗️ Hiện Trạng

| Lĩnh vực | Có gì | Thiếu gì |
|----------|-------|----------|
| **Trang chủ** | Hero, blog list, projects list | About section, stats, social proof |
| **Blog** | List + detail, 3 categories | Search, tags filter, related posts, RSS |
| **Projects** | List + detail, 4 status | Demo link, tech stack badges, gallery |
| **Pháp âm (Courses)** | List page (static) | Audio player, video embed, download |
| **Contact** | Form submit → Supabase | Auto-reply email, spam protection |
| **Newsletter** | Subscribe form | Email sending, template, scheduling |
| **Admin** | CRUD posts/projects/courses | Media library, analytics, SEO preview |
| **Auth** | Basic admin login | OAuth (Google, GitHub), MFA |
| **i18n** | Structure có sẵn | Nội dung tiếng Anh, Nhật, Trung |
| **SEO** | Sitemap, robots.txt | Meta tags, OG images, structured data |
| **Performance** | Cơ bản | Image optimization, ISR, caching |

---

## 🗺️ Roadmap

### 🟢 Giai Đoạn 1: Hoàn Thiện Nền Tảng (T5-T6/2026)

**Mục tiêu:** Website chuyên nghiệp, đầy đủ tính năng cốt lõi.

| # | Tính năng | Chi tiết |
|---|-----------|----------|
| 1.1 | **Blog nâng cao** | Search, filter by tag/category, related posts, table of contents |
| 1.2 | **RSS Feed** | Đã có scaffold → hoàn thiện `feed.xml` |
| 1.3 | **SEO tối ưu** | Meta tags động, OG images, JSON-LD structured data, breadcrumbs |
| 1.4 | **Trang About** | Timeline cuộc đời, học vấn, chứng chỉ, tông phái |
| 1.5 | **Pháp âm Audio Player** | Custom audio player + playlist + download |
| 1.6 | **Newsletter hoàn chỉnh** | Gửi email hàng tuần, template đẹp, unsubscribe |
| 1.7 | **Admin Dashboard nâng cao** | Analytics (views, clicks), media library upload, SEO preview |
| 1.8 | **Image optimization** | Next/Image + blur placeholder + WebP auto |
| 1.9 | **Comment system** | Giscus hoặc Supabase-based comments |
| 1.10 | **Newsletter popup** | Exit-intent + timed popup cho blog |

---

### 🟡 Giai Đoạn 2: Tương Tác & Cộng Đồng (T6-T7/2026)

**Mục tiêu:** Biến website thành nơi cộng đồng Phật tử tương tác.

| # | Tính năng | Chi tiết |
|---|-----------|----------|
| 2.1 | **AI Chatbot Phật học** | RAG-based, trả lời câu hỏi giáo lý, kinh điển |
| 2.2 | **Đa ngôn ngữ đầy đủ** | English, 中文, 日本語, 한국어 — cả UI lẫn content |
| 2.3 | **E-Learning Platform** | Khóa học online: video, quiz, certificate |
| 2.4 | **User accounts** | Đăng ký thành viên, profile, bookmark bài viết |
| 2.5 | **Forum / Diễn đàn** | Thảo luận Phật pháp, hỏi đáp |
| 2.6 | **Live stream integration** | Tích hợp YouTube Live / Zoom cho khóa tu |
| 2.7 | **Donation / Cúng dường** | Tích hợp MoMo, VNPay, PayPal |
| 2.8 | **Event Calendar** | Lịch khóa tu, lễ Phật, sự kiện |

---

### 🟠 Giai Đoạn 3: AI-Powered (T7-T9/2026)

**Mục tiêu:** Dùng AI để tăng trải nghiệm và tự động hóa.

| # | Tính năng | Chi tiết |
|---|-----------|----------|
| 3.1 | **AI Content Assistant** | Gợi ý bài viết, dịch tự động, tóm tắt kinh |
| 3.2 | **Personalized Feed** | AI recommend bài viết dựa trên sở thích |
| 3.3 | **Voice Narration** | TTS đọc bài viết (giọng Thầy) |
| 3.4 | **Auto-SEO Agent** | Tự động tối ưu SEO, tạo OG image bằng AI |
| 3.5 | **Analytics AI** | AI phân tích traffic, gợi ý nội dung |
| 3.6 | **Kinhe Search** | Full-text search kinh điển (Nikaya, A-hàm...) |
| 3.7 | **AI Meditation Guide** | Hướng dẫn thiền cá nhân hóa bằng AI |

---

### 🔴 Giai Đoạn 4: Hệ Sinh Thái (T9-T12/2026)

**Mục tiêu:** Mở rộng thành nền tảng Phật giáo số toàn diện.

| # | Tính năng | Chi tiết |
|---|-----------|----------|
| 4.1 | **Mobile App** | React Native app — đọc kinh, nghe pháp, thiền |
| 4.2 | **Multi-tenant Chùa** | Các chùa có thể tạo trang riêng trên nền tảng |
| 4.3 | **Monk Network** | Kết nối tăng ni, trao đổi Phật pháp |
| 4.4 | **Digital Library** | Thư viện số kinh sách, nghiên cứu |
| 4.5 | **API Platform** | Public API cho developers xây dựng app Phật giáo |
| 4.6 | **Offline PWA** | Đọc kinh offline, đồng bộ khi có mạng |

---

## 🎨 Design Vision

```
┌────────────────────────────────────────────────────┐
│                    TRANG CHỦ                        │
│  ┌──────────────────────────────────────────────┐  │
│  │         HERO — Câu chuyện của Thầy            │  │
│  │    "Từ nhà sư đến kỹ sư AI"                   │  │
│  └──────────────────────────────────────────────┘  │
│  ┌─────────────────┐ ┌─────────────────┐          │
│  │   BLOG MỚI NHẤT  │ │  PHÁP ÂM MỚI    │          │
│  │  • Bài viết 1    │ │  • Bài giảng 1  │          │
│  │  • Bài viết 2    │ │  • Khóa tu 1    │          │
│  │  • Bài viết 3    │ │  • Thuyết pháp  │          │
│  └─────────────────┘ └─────────────────┘          │
│  ┌──────────────────────────────────────────────┐  │
│  │         PROJECTS SHOWCASE                     │  │
│  │    agent-code-army | claw3d | memora ...      │  │
│  └──────────────────────────────────────────────┘  │
│  ┌──────────────────────────────────────────────┐  │
│  │    NEWSLETTER — "Nhận Pháp âm hàng tuần"     │  │
│  └──────────────────────────────────────────────┘  │
└────────────────────────────────────────────────────┘
```

**Phong cách thiết kế:**
- 🎨 **Zen Minimalism** — sạch, thoáng, tập trung vào nội dung
- 🌸 **Phật giáo Việt Nam** — hoa sen, màu vàng ấm, nâu trầm
- 🌙 **Dark/Light mode** — đã có ThemeProvider
- 📱 **Mobile-first** — tối ưu cho điện thoại (Phật tử hay dùng mobile)
- ♿ **Accessibility** — WCAG AA, font lớn cho người lớn tuổi

---

## 📊 KPI Mục Tiêu

| Chỉ số | Hiện tại | GĐ1 | GĐ2 | GĐ3 |
|--------|:--------:|:---:|:---:|:---:|
| Page speed (Lighthouse) | ? | >90 | >95 | >98 |
| SEO score | ? | >90 | >95 | 100 |
| Bài viết | ? | 20+ | 50+ | 100+ |
| Pháp âm | ? | 10+ | 30+ | 100+ |
| Ngôn ngữ | 1 (VI) | 2 (VI+EN) | 4 | 6 |
| Newsletter subs | ? | 100 | 500 | 2000 |
| Monthly visitors | ? | 500 | 2000 | 10000 |
| AI Chatbot queries | — | — | 100/day | 1000/day |

---

## 🔧 Tech Stack Mở Rộng

```
Hiện tại                    Tương lai
─────────                   ────────
Next.js 16          →       Next.js (latest)
Supabase            →       Supabase + Redis (cache)
Tailwind CSS        →       Tailwind + shadcn/ui
Vercel              →       Vercel Pro (analytics, ISR)
—                   →       OpenAI/Claude API (AI chatbot)
—                   →       Resend / SendGrid (newsletter)
—                   →       Cloudflare R2 (media storage)
—                   →       Umami / Plausible (analytics)
```

---

## 🪷 Thông Điệp Trang Web

> *"Giữa bùn nhơ vẫn tỏa hương thơm."*

Website không chỉ là nơi showcase kỹ năng — nó là **cánh cửa số** để:
1. **Hoằng pháp** trong thời đại AI
2. **Kết nối** Phật tử toàn cầu
3. **Chia sẻ** hành trình tu học và lập trình
4. **Truyền cảm hứng** cho thế hệ trẻ Phật tử yêu công nghệ
5. **Xây dựng cầu nối** giữa Phật giáo truyền thống và công nghệ hiện đại

---

> *Cập nhật: 2026-05-18 | Next review: 2026-06-18*
