# Frontend Design System — Nguyên Tắc Thiết Kế Chuyên Nghiệp

> Khi Frontend Agent code UI, tuân thủ các nguyên tắc dưới đây.
> Commander inject nội dung này vào prompt Frontend Agent.

---

## 🎨 Chiến Lược Màu Sắc

### Quy tắc chung
- **Dùng OKLCH**, không dùng hex hay HSL. `oklch(65% 0.15 250)` thay vì `#3b82f6`.
- **Giảm chroma khi lightness gần 0% hoặc 100%.** Màu quá bão hòa ở extreme lightness nhìn rẻ tiền.
- **Không dùng `#000` hay `#fff`.** Tint mọi neutral về brand hue (chroma 0.005-0.01 là đủ).

### 4 Cấp độ cam kết màu sắc

| Cấp độ | Mô tả | Dùng khi |
|--------|------|----------|
| **Restrained** | Tinted neutrals + 1 accent ≤10% diện tích | Dashboard, admin, tool, app nội bộ |
| **Committed** | 1 màu bão hòa chiếm 30-60% surface | Landing page, brand identity |
| **Full Palette** | 3-4 named roles, dùng có chủ đích | Campaign, data visualization |
| **Drenched** | Surface CHÍNH LÀ màu | Hero section, campaign splash |

**Mặc định Frontend Agent: Restrained cho app, Committed cho landing page.**

### Thang màu nhanh (OKLCH)

```
Primary:     oklch(60% 0.20 250)  — màu chính (xanh dương làm ví dụ)
Surface:      oklch(98% 0.005 250) — nền sáng, tint nhẹ brand hue
Surface-alt:  oklch(95% 0.005 250) — nền xen kẽ
Text:         oklch(20% 0.003 250) — chữ chính, gần đen nhưng không đen tuyền
Text-muted:   oklch(50% 0.003 250) — chữ phụ
Border:       oklch(88% 0.003 250) — viền nhẹ
Danger:       oklch(55% 0.22 20)   — đỏ
Success:      oklch(60% 0.18 145)  — xanh lá
```

### Triển khai Tailwind

```css
/* tailwind.config.ts */
colors: {
  surface: 'oklch(98% 0.005 250)',
  'surface-alt': 'oklch(95% 0.005 250)',
  primary: 'oklch(60% 0.20 250)',
  'text-primary': 'oklch(20% 0.003 250)',
  'text-muted': 'oklch(50% 0.003 250)',
}
```

---

## 🌓 Theme (Dark / Light)

**Không mặc định dark "vì tool nhìn cool". Không mặc định light "cho an toàn".**

Trước khi chọn theme, viết 1 câu mô tả cảnh vật lý:
- *Ai dùng? Ở đâu? Ánh sáng môi trường? Tâm trạng?*

Ví dụ:
- ❌ "Admin dashboard" → không đủ để quyết
- ✅ "Kế toán kiểm tra sổ sách lúc 2h chiều trong văn phòng sáng đèn huỳnh quang" → Light
- ✅ "SRE check incident severity lúc 2h sáng trong phòng tối" → Dark

**Nếu không có thông tin từ user, mặc định Light cho app thông thường.**

---

## 🔤 Typography

### Quy tắc
- **Line length: 65-75ch cho body text.** Dùng `max-w-prose` hoặc `max-w-[65ch]`.
- **Hierarchy qua scale + weight contrast.** Tỷ lệ giữa các bậc ≥1.25.
- **Không flat scale.** Nếu h1=2rem, h2=1.5rem, h3=1.2rem → tỷ lệ 1.33 và 1.25 là đủ.

### Font recommendations
- **Body + UI:** Inter, system-ui (đọc tốt, neutral)
- **Display/Heading:** Cùng font body (tránh mismatch) hoặc 1 serif contrast nếu brand cần
- **Monospace:** JetBrains Mono, Fira Code (cho code block, data)

```css
/* Ví dụ font stack */
--font-sans: 'Inter', system-ui, -apple-system, sans-serif;
--font-mono: 'JetBrains Mono', 'Fira Code', monospace;
```

### Đừng dùng
- ❌ Quá nhiều font weight (regular + medium + semibold là đủ)
- ❌ Letter-spacing âm trên body text (chỉ dùng cho display heading lớn)
- ❌ Line-height < 1.5 cho body text

---

## 📐 Layout

### Quy tắc
- **Vary spacing cho rhythm.** Cùng padding khắp nơi = đơn điệu. Section spacing > component spacing > element spacing.
- **Card là lười biếng.** Chỉ dùng khi thực sự cần affordance "có thể click/press". Nested card luôn sai.
- **Đừng bọc mọi thứ trong container.** Không phải thứ gì cũng cần `max-w-7xl mx-auto`.
- **Edge-to-edge cho visual impact.** Hero images, gradient bands, stats band — kéo full width.

### Spacing scale (gợi ý)
```
Section spacing:  py-16 md:py-24 lg:py-32
Component gap:    gap-8 md:gap-12
Element gap:      gap-4 md:gap-6
Inner padding:    p-4 md:p-6
```

---

## ✨ Motion

### Quy tắc
- **Không animate CSS layout properties** (width, height, top, left). Dùng transform.
- **Ease-out với exponential curves.** `cubic-bezier(0.16, 1, 0.3, 1)` (ease-out-expo).
- **Không bounce, không elastic.** Trừ khi làm game hoặc toy project.
- **Duration: 150-300ms cho micro-interaction, 300-500ms cho page transition.**

### Tailwind motion
```html
<!-- Hover scale -->
<button class="transition-transform duration-200 ease-out hover:scale-[1.02] active:scale-[0.98]">

<!-- Fade in -->
<div class="animate-in fade-in duration-300">

<!-- Slide in -->
<div class="animate-in slide-in-from-bottom-4 duration-500 ease-out">
```

### Đừng dùng
- ❌ `transition-all` — quá chậm, animate thứ không cần
- ❌ Animation vô nghĩa (spin vô hạn trên element không loading)
- ❌ Delay > 500ms (người dùng đã scroll qua rồi)

---

## 🚫 Cấm Tuyệt Đối (Match-and-Refuse)

Nếu chuẩn bị viết 1 trong những thứ dưới đây → dừng lại, viết lại với structure khác:

1. **Side-stripe borders.** `border-l-4 border-primary` trên card/list item. → Dùng full border, background tint, hoặc leading icon thay thế.
2. **Gradient text.** `bg-gradient-to-r bg-clip-text text-transparent`. → Dùng 1 solid color. Emphasis qua weight/size.
3. **Glassmorphism mặc định.** `backdrop-blur` + `bg-white/10` mặc định. → Chỉ dùng khi có lý do cụ thể và hiếm khi.
4. **Hero-metric template.** Số to + label nhỏ + stats phụ + gradient accent. SaaS cliché. → Làm khác đi.
5. **Identical card grids.** Icon + heading + text lặp lại vô tận. → Vary layout, dùng alternating patterns, hoặc không dùng card.
6. **Modal làm lựa chọn đầu tiên.** → Dùng inline expansion, slide-out panel, progressive disclosure trước.

---

## 📝 Copy (UX Writing)

- **Mỗi chữ phải kiếm được chỗ đứng.** Không restate heading, không intro lặp title.
- **Không em dash (—).** Dùng comma, colon, semicolon, period.
- **Label ngắn gọn, action rõ ràng.** "Lưu" thay "Lưu thay đổi", "Xóa" thay "Xóa mục này".
- **Error message nói cách khắc phục.** Không chỉ "Có lỗi xảy ra".

---

## 🧪 AI Slop Test

Sau khi thiết kế xong, tự hỏi 2 câu:

1. **First-order:** Nếu ai đó đoán được theme + palette chỉ từ category ("observability → dark blue", "healthcare → white + teal", "finance → navy + gold") → thất bại. Làm khác đi.
2. **Second-order:** Nếu ai đó đoán được aesthetic family từ category + anti-reference ("AI tool → dark purple gradient", "startup SaaS → white + single accent blue") → thất bại. Làm khác đi.

**Chiến lược để qua Slop Test:**
- Đổi hue: healthcare không nhất thiết phải teal/xanh lá, thử warm amber hoặc muted plum
- Đổi texture: thay shadow bằng border, thay gradient bằng solid color blocks
- Đổi density: thay sparse white-space bằng compact layout hoặc ngược lại
- Đổi typography scale: thay Inter 16px bằng system font 17px với line-height cao hơn

---

## 🧩 Component Checklist

Mỗi component phải có đủ 4 state:

| State | Mô tả | Ví dụ |
|-------|-------|-------|
| **Loading** | Đang fetch data | Skeleton, spinner có nhãn |
| **Empty** | Không có data | Illustration + CTA + mô tả |
| **Error** | Fetch fail | Message + retry button |
| **Loaded** | Có data | UI bình thường |

### Component Anti-patterns
- ❌ Skeleton không cùng shape với content (gây layout shift)
- ❌ Empty state chỉ có text "No data" (không helpful)
- ❌ Error state không có retry action
- ❌ Loading spinner không label (người dùng không biết đang chờ gì)

---

## 📱 Responsive

- **Mobile-first:** viết mobile layout trước, dùng `md:`, `lg:` để enhance lên.
- **Touch target ≥ 44x44px** cho interactive elements trên mobile.
- **Không ẩn nội dung quan trọng trên mobile.** Reflow, đừng remove.
- **Test ở 320px (iPhone SE), 375px (iPhone), 768px (iPad), 1024px+ (desktop).**

---

## ♿ Accessibility Cơ Bản

- **Focus visible:** `focus-visible:ring-2 focus-visible:ring-primary focus-visible:ring-offset-2`
- **Color contrast ≥ 4.5:1** cho body text, ≥ 3:1 cho large text
- **Không chỉ dùng màu để truyền tải thông tin** (thêm icon/text)
- **Alt text cho image có ý nghĩa**, `alt=""` cho decorative
- **Form labels luôn có `<label>`**, không chỉ placeholder
- **Keyboard navigation:** Tab order hợp lý, skip-link cho trang dài

---

## 🔧 Triển khai thực tế (Frontend Agent)

### Khi code component mới:
1. Chọn 1 cấp độ màu (thường là Restrained)
2. Chọn theme (mặc định Light nếu không rõ)
3. Áp dụng typography scale
4. Code đủ 4 state
5. Check accessibility cơ bản
6. Check các lệnh cấm (side-stripe, gradient text, glassmorphism...)
7. **Kiểm tra CSS layout regression** — nếu thay đổi layout (topbar → sidebar, grid → flex), kiểm tra TẤT CẢ `position: sticky`, `position: fixed`, `top`, `z-index` trong toàn bộ CSS cũ. Không để sót giá trị hardcoded từ layout cũ.
8. Chạy AI Slop Test (có cliché không?)
