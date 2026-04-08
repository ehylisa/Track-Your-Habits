# HabitTracker Design System

Based on the **Paper** design style — minimal, clean, print-inspired with tactile surface qualities.

---

## Design Intent

A calm, distraction-free habit tracker with a paper-like aesthetic. Typography and whitespace do the heavy lifting; color is reserved for meaning (streaks, completion, warnings).

---

## Design Tokens

### Colors
| Token       | Value     | Usage                        |
|-------------|-----------|------------------------------|
| `primary`   | `#111111` | Titles, primary text         |
| `secondary` | `#8B5CF6` | Accent, streak highlights    |
| `success`   | `#16A34A` | Completed habits              |
| `warning`   | `#D97706` | Streak at risk               |
| `danger`    | `#DC2626` | Missed / broken streak       |
| `surface`   | `#FFFFFF` | Card and screen backgrounds  |
| `text`      | `#111827` | Body text                    |
| `neutral`   | System gray scale | Borders, secondary labels |

### Typography
| Role      | Font        | Size | Weight |
|-----------|-------------|------|--------|
| Title     | Montserrat  | 32   | 700    |
| Heading   | Montserrat  | 24   | 600    |
| Body      | Roboto      | 16   | 400    |
| Caption   | Roboto      | 14   | 400    |
| Mono      | PT Mono     | 14   | 400    |

> In SwiftUI: use `.font(.custom("Montserrat-Bold", size: 32))` or map to system fonts as a fallback (`.largeTitle`, `.title2`, `.body`).

### Spacing
Scale: `4 / 8 / 12 / 16 / 24 / 32` pt

Use `.padding(16)` as the standard content margin. Card internal padding: `12`. Section gaps: `24`.

---

## Components

### Habit Row
- Anatomy: checkbox | habit name | streak badge
- States: incomplete (default), complete (`success`), streak at risk (`warning`)
- Checkbox: 24×24pt, 6pt corner radius, `primary` border, filled `success` when complete
- Streak badge: pill shape, `secondary` background, white label, `caption` size
- Tap target: full row, minimum 44pt height

### Add Habit Button
- Style: `.borderedProminent`, full-width at bottom with 16pt horizontal padding
- Color: `primary` (#111111) background, white label
- States: default, pressed (0.9 opacity), disabled (40% opacity)

### Empty State
- Center-aligned, `caption` size, `neutral` color
- No icons — text only, consistent with minimal paper aesthetic

### Cards (future)
- Background: `surface`
- Corner radius: 8pt
- Shadow: none (flat, paper-like) or `shadowRadius: 1` at most
- Border: 0.5pt `neutral` stroke

---

## Accessibility

- All interactive elements must have a minimum tap target of 44×44pt
- Text contrast must meet WCAG 2.2 AA (4.5:1 for body, 3:1 for large text)
- Every control must have an `.accessibilityLabel`
- Use `.accessibilityAddTraits(.isButton)` on custom tappable views
- Support Dynamic Type: use relative font sizes where possible

---

## Content & Tone

- Labels: sentence case, no punctuation ("Add habit" not "Add Habit!")
- Empty states: plain and neutral ("No habits yet")
- Streak copy: short and factual ("3-day streak")

---

## Anti-Patterns

- No gradients — flat surfaces only
- No decorative icons on empty states or buttons
- Don't use raw hex values in SwiftUI — define a `Color` extension with token names
- Don't use spacing values outside the 4pt scale

---

## QA Checklist

- [ ] All text meets contrast ratio requirements
- [ ] Tap targets are ≥ 44pt
- [ ] Spacing uses only values from the 4pt scale
- [ ] Interactive states (hover/pressed/disabled) are implemented
- [ ] All controls have accessibility labels
- [ ] Fonts fall back gracefully if custom fonts are unavailable
