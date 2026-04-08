# Project: Baker Hub — Personal Dashboard

## User Context
- **Owner**: Cathrine Baker (cathcoach4u)
- **Location**: Northern Beaches, Sydney, Australia (AEST)
- **Currency**: Australian Dollars (AUD, $)
- **Date format**: DD/MM/YYYY (Australian standard)
- **Locale**: en-AU for all formatting
- **Family members**: Cath, Andrew, Sarah, Russell

## Architecture
- **Hosting**: GitHub Pages at `cathcoach4u.github.io/personal-baker-hub/`
- **Database**: Supabase (project ID: `ziwycymhaqghdiznyhhw`)
- **AI Proxy**: Supabase Edge Function `claude-proxy` using `claude-haiku-4-5`
- **Entry point**: `index.html` (root of repo)
- **AI standalone**: `ai.html` (purple theme)
- **Config**: `config.js` (Supabase URL + anon key)
- **Stack**: Vanilla HTML/CSS/JS, Supabase JS CDN, no frameworks
- **PWA**: Web app manifest — teal icon with white B (standalone mode)
- **AI PWA**: Purple icon with white B (standalone mode)
- **CSS scope**: `#personalHub` for main app

## Navigation
Sidebar (desktop) + slide-out drawer (mobile, 768px breakpoint):
1. Dashboard (home)
2. To-Do
3. NDIS
4. Insurance
5. Contacts
6. House Projects
7. Dates
8. AisleMate (shopping)
9. Fiona Tasks
10. About

Baker AI accessible via purple B button (bottom-right popup) on all pages.

## Dashboard (Home)
- **Greeting**: Time-based (Good morning/afternoon/evening)
- **Week A/B pill**: Changes every Monday. Reference: Mon 30 Mar 2026 = Week A
  - Week A = Paula (Cleaners) + Yellow bin (Recycling)
  - Week B = Fiona + Green bin (Vegetation)
  - "Wrong week? Swap" toggle (persists in localStorage)
  - Phone numbers: Paula +61 450 042 221, Fiona +61 403 772 056
- **Important Reminders**: Bulky waste countdown, outstanding NDIS, upcoming premiums, Fiona tasks pending
- **NDIS Funding**: Compact fund cards with budget/spent/remaining

## To-Do
- Categories: General, Health, Home, Work, Shopping, Finance, Family, Admin, Personal
- Add/complete/edit/delete tasks
- Category filter pills with counts
- Clear completed button
- Due dates with today (amber) and overdue (red) highlighting

## NDIS
- Transaction table with provider, invoice, date, fund, amount, status, receipt
- **Providers dropdown**: Auto-fills NDIS number and fund
- **Add/Edit form**: Click row to edit, + Add Transaction to create
- **Receipt upload**: Files stored in Supabase Storage bucket `ndis-invoices`

## Insurance
- **Grouped by owner**: Cathrine Baker, Andrew Baker (collapsible, start collapsed)
- Monthly/annual premium totals per person
- Add/Edit form with all policy fields

## Contacts
- **Grouped by person** (default) or **by category** (toggle)
- Groups start collapsed
- **Categories**: Medical, Massage, Pharmacy, NDIS, Home & Services, Recreation, Food & Lifestyle, Government
- **For Person**: Multi-select checkboxes (Family, Cath, Andrew, Sarah, Russell)
- **Fields**: Name, contact person, phone, email, meeting/portal link, notes, category, for person
- Add/Edit/Delete from form
- Phone (tap to call), email (mailto), meeting link (opens in new tab)

## House Projects
- Status: Not Started, In Progress, Complete
- Priority: Low, Medium, High, Urgent
- Add/Edit/Delete from form
- Delete button in both card and edit form

## Dates (Important Dates)
- **Month timeline**: Apr 2026 to Mar 2027, collapsible months
- **Week grouping**: Within each month, grouped by week (collapsible)
- Current month/week highlighted green, past months collapsed
- **Categories**: Multi-select checkboxes — Council, Family, Cath, Andrew, Sarah, Russell, Public Holidays, Financial, Other
- **Filtered view**: When filtering by category or searching, shows flat date-ordered list (no weekly grouping)
- **Recurring**: yearly badge for birthdays, ANZAC Day etc.
- Add/Edit/Delete from form and card
- Delete button in both card and edit form

## AisleMate (Shopping)
- Uses existing Supabase tables: shopping_items, master_items, receipts, receipt_items
- Weekly shop, master list, shop info, family, receipts, spending, history, meal plan, QR code
- Receipt scanning via claude-proxy edge function
- Shared with Cath Hub (same Supabase project)

## Fiona Tasks
- For cleaner (Fiona) task lists
- Table: `fiona_tasks` (id: Date.now(), task, done, created_at)
- Add/toggle done/delete/clear all/clear completed
- **Print**: Opens clean printable page with checkboxes
- **Auto-refresh**: Every 30 seconds when on Fiona tab
- **URL quick-add**: `?add=Task+name`
- Dashboard shows pending count in Important Reminders

## Baker AI
- **Popup**: Purple B button bottom-right on all pages
- **Standalone**: ai.html with own PWA manifest (purple)
- **Model**: claude-haiku-4-5 via Supabase Edge Function
- **Quick action buttons**: Add to Dates, Add To-Do, Fiona Task, Add Contact (pre-fill input)
- **Auto-refresh**: After any action, reloads data and re-renders active screen
- **Calendar reference**: 14-day calendar in system prompt to prevent day-of-week calculation errors
- **Copy button**: On all AI responses
- **Tools**:
  - add_todo, complete_todo, delete_todo
  - add_date
  - add_project
  - update_ndis_status
  - add_contact (with email, meeting_link, notes)
  - add_fiona_task, complete_fiona_task, delete_fiona_task
- **AI Tool Rules**: Every DB operation checks for errors. Dedicated handlers per action. Never silent failures.

## About Page
- Built With: GitHub, Claude AI, Supabase
- Stack, features list, Supabase tables reference

## Apps Directory
- `apps-directory.html` — compact tile grid of all apps
- Black top bar, own PWA manifest (black A icon)
- Links: Baker Hub, Cath Hub, Baker AI, Cath AI, Morning, IAS, Coach4U Hub (new + old), Professional Dev, Resources, ThriveHQ

## Supabase Tables

| Table | Purpose | ID Type |
|-------|---------|---------|
| ndis_funds | Funding bucket budgets | auto bigint |
| ndis_transactions | Transaction history + receipt paths | auto bigint |
| ndis_providers | Provider defaults (name, NDIS#, fund) | auto bigint |
| insurance_policies | Insurance & super policies | auto bigint |
| contacts | Family contacts with categories | auto bigint |
| house_projects | House project tracking | auto bigint |
| important_dates | Important dates & events | auto bigint |
| todos | To-do list | auto bigint |
| fiona_tasks | Fiona cleaner task list | manual (Date.now()) |
| shopping_items | AisleMate shopping list | auto UUID |
| master_items | AisleMate master items | auto UUID |
| receipts | AisleMate receipts | auto UUID |
| receipt_items | AisleMate receipt line items | auto UUID |

All tables have RLS enabled with `allow_all` policy (FOR ALL USING true WITH CHECK true).

## Supabase Storage
- **Bucket**: `ndis-invoices` (public) — receipt/invoice uploads

## Weekly Schedule
- **Collection day**: Thursday
- **Week A**: Paula (Cleaners) + Yellow bin (Recycling)
- **Week B**: Fiona + Green bin (Vegetation/Organics)
- **Red bin**: Every week (General Waste)
- **Week changes**: Every Monday
- **Reference**: Monday 30 March 2026 = Week A
- **Bulky waste**: Booked 11 May 2026 (1 of 2 free per year)

## Design System
- **Top bar / sidebar / drawer**: Teal `#0d9488`
- **AI theme**: Purple `#7c3aed`
- **Background**: `#f8fafc`
- **Cards**: White, border `#e8edf2`, radius 16px, shadow `0 2px 8px rgba(0,0,0,0.04)`
- **Font**: Segoe UI / system font stack
- **Mobile**: Slide-out drawer from left, safe-area-inset-top padding
- **Forms**: 2-column grid desktop, single column mobile
- **Collapsible groups**: `.group-header` + `.group-body` toggle `.open` class

## Key Files
| File | Purpose |
|------|---------|
| index.html | Main dashboard (all HTML/CSS/JS) |
| ai.html | Standalone Baker AI page |
| config.js | Supabase credentials |
| manifest.json | Baker Hub PWA manifest |
| ai-manifest.json | Baker AI PWA manifest |
| apps-directory.html | Apps directory page |
| apps-manifest.json | Apps directory PWA manifest |
| shopping.html | AisleMate standalone shopping page |
| icon-192.svg / icon-512.svg / icon.svg | Baker Hub icons (teal B) |
| ai-icon-192.svg / ai-icon-512.svg | Baker AI icons (purple B) |
| apps-icon-192.svg / apps-icon-512.svg | Apps directory icons (black A) |
| Personal-hub/ | Legacy files (original WordPress version) |
| supabase-*.sql | Various SQL setup scripts |

## Important Notes for Future Sessions
- The main `index.html` has 3 separate `<script>` blocks. Each needs its own `sb` Supabase client
- `FIONA_TASKS` must be declared at the top with other data variables (before renderHome)
- AisleMate code is in the 3rd script block with its own `sb`
- AI popup is in the 2nd script block with its own `sb`
- When adding new features that use Supabase, always create `sb` in the correct script scope
- All delete operations need RLS DELETE policy (use `allow_all` policy)
- For `fiona_tasks` inserts, always include `id: Date.now()` — table doesn't auto-generate IDs
- Dates and contacts support comma-separated multi-values for categories/people
