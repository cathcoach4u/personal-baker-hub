# Project: Baker Hub — Personal Dashboard

## Working Style & Preferences
- **Don't apologise** — just action the request
- **Push to main** — commit and push directly to main branch, don't create PRs unless asked
- **Be the full coder** — Claude's role is to code, push, and complete tasks end-to-end
- **Australian English** — all text, dates (DD/MM/YYYY), currency (AUD $), locale en-AU
- **No uppercase headings** — use normal case for section labels
- **Use filter pills** — not dropdowns, for mobile-friendly category filtering
- **Collapsible sections** — group content into collapsible cards where possible
- **Don't add emojis** unless the user asks

## User Context
- **Owner**: Cathrine Baker (cathcoach4u)
- **Location**: Northern Beaches, Sydney, Australia (AEST)
- **Currency**: Australian Dollars (AUD, $)
- **Date format**: DD/MM/YYYY (Australian standard)
- **Family members**: Cath, Andrew, Sarah, Russell
- **Address**: 11 Castle Crescent, Belrose NSW 2085

## Architecture
- **Hosting**: GitHub Pages at `cathcoach4u.github.io/personal-baker-hub/`
- **Database**: Supabase (project ID: `ziwycymhaqghdiznyhhw`)
- **AI Proxy**: Supabase Edge Function `claude-proxy`
- **Entry point**: `index.html` (root of repo)
- **Config**: `config.js` (Supabase URL + anon key)
- **Stack**: Vanilla HTML/CSS/JS, Supabase JS CDN, no frameworks
- **PWA**: Web app manifest for home screen install
- **Service Workers**: `sw.js` (Baker Hub), `shopping-sw.js` (AisleMate), `apps-sw.js` (Apps Hub)
- **CSS scope**: `#personalHub` for main app
- **Script blocks**: index.html has 3 separate `<script>` blocks, each with its own `sb` Supabase client:
  1. Main app (dashboard, NDIS, insurance, contacts, dates, todos, habits, animals, kids, house projects)
  2. Baker AI popup
  3. AisleMate shopping

## Navigation
Sidebar (desktop) + slide-out drawer (mobile, 768px breakpoint):
1. Dashboard (home)
2. To-Do
3. Fiona Tasks
4. NDIS
5. Finance & Insurance
6. Contacts
7. House Projects
8. Dates
9. Habits & Rhythms
10. Animals
11. Kids
12. AisleMate
13. About

Baker AI accessible via purple B button (bottom-right popup) on all pages.

## Dashboard (Home)
- **Greeting**: Time-based (Good morning/afternoon/evening)
- **Week A/B badge**: Shows week type with date range (e.g. "Week A — 7 Apr - 13 Apr 2026")
  - Week A = Fiona + Red + Blue bins
  - Week B = Paula (Cleaners) + Red + Yellow + Green bins
  - Reference: Monday 7 April 2026 = Week A
  - Collection day: Wednesday (NOT Thursday)
  - Bin calendar PDF: https://files.northernbeaches.nsw.gov.au/nbc-prod-files/documents/2024-01/ThursdayA.pdf
  - Phone numbers: Fiona +61 403 772 056, Paula +61 450 042 221
  - "Wrong week? Swap" toggle (persists in localStorage)
- **Weekly Checklist**: Tappable items stored in Supabase `checklist_items` table (editable from Habits section). State saved to `weekly_checklist` table. Auto-resets each Monday.
- **Important Reminders**: Bulky waste countdown, outstanding NDIS, Fiona tasks pending
- **NDIS Funding**: Compact fund cards with budget/spent/remaining
- **Links**: "Edit checklist" (goes to Habits), "Bin calendar" (PDF), "Wrong week? Swap"

## To-Do
- Categories: General, Health, Home, Work, Shopping, Finance, Family, Admin, Personal
- Category filter pills with counts
- Add/complete/edit/delete tasks
- Due dates with today (amber) and overdue (red) highlighting

## Fiona Tasks
- Sits directly below To-Do in the sidebar navigation
- Table: `fiona_tasks` (id: Date.now(), task, done, created_at)
- Add/toggle done/delete/clear all/clear completed
- **Print**: Opens clean printable page with checkboxes
- **Auto-refresh**: Every 30 seconds when on Fiona tab
- **URL quick-add**: `?add=Task+name`

## NDIS
- **Desktop**: Table view with provider, invoice, date, fund, amount, status, receipt
- **Mobile** (<768px): Card-based layout (hidden table, shown cards)
- **Receipt indicator**: Green checkmark + View when uploaded, Red X + Missing when not
- **Providers dropdown**: Auto-fills NDIS number and fund
- **Copy List**: Copies filtered transactions to clipboard
- **Export CSV**: Downloads filtered transactions as CSV
- **Receipt upload**: Files stored in Supabase Storage bucket `ndis-invoices`

## Finance & Insurance
- **Two tabs**: "Insurance & Super" and "Bills" (tab switch at top)
- **Finance Files**: OneDrive link at top
- **Category pills**: All, Personal Insurance, Household, Car, Investments, Superannuation
- **Grouped by person**: Cathrine Baker, Andrew Baker, Russell Baker etc.
- **Sub-grouped by payment source**: "Paid Personally" (credit card) vs "Paid via Super" (Macquarie Super, MLC Masterkey) — collapsible
- **Form includes**: Person, Category, Insurer/Provider, Policy No, Cover Type, Premium, Frequency, Payment Method
- **Key insurance facts**:
  - Acenda = provider for several policies, Customer Number: 7150590, portal: https://my.acenda.com.au/documents
  - AIA = underlying insurer for Acenda policies, Adviser: Joanne Brassett 0282682900
  - ClearView = formerly MLC (Andrew's Income Protection 51825896)
  - Policies paid via Macquarie Super get 15% super rebate
- **Bills tab**: Recurring bills tracker (Utilities, Internet & Phone, Streaming, Council, Car, Other) with category pills, totals, add/edit/delete

## Contacts
- **Grouped by category** (not by person) with collapsible sections
- **Category filter pills** at top (Medical, Insurance, NDIS, Home & Services, etc.)
- **Categories**: Medical, Massage, Pharmacy, NDIS, Insurance, Home & Services, Recreation, Food & Lifestyle, Government
- **Copy button**: Clipboard icon on each contact card
- **Export CSV**: Downloads filtered contacts
- **For Person**: Multi-select checkboxes (Family, Cath, Andrew, Sarah, Russell)

## House Projects
- **Zone filter pills**: Left Shed, Left Fence, Garage, Front Fence, Front Garden Bed, Right Fence, Right Shed, Back Deck, House, Pool Deck, Side of House
- **Collapsible zones**: Each zone is a collapsible card with done count
- Zones stored in `notes` field as "Zone: Left Shed" etc.
- Status: Not Started, In Progress, Complete
- Priority: Low, Medium, High, Urgent

## Dates (Important Dates)
- **Month timeline**: Apr 2026 to Mar 2027, collapsible months
- **Week grouping**: Within each month, grouped by week (collapsible)
- **Categories**: Council, Family, Cath, Andrew, Sarah, Russell, Public Holidays, Financial, House, Other
- **Baker AI**: Must ask which category before adding a date
- **Timezone fix**: daysDiff/daysUntil compare midnight-to-midnight to avoid AEST/UTC off-by-one errors

## Habits & Rhythms
- **Weekly objective banner**: "By Friday, the house is tidy enough to enjoy the weekend"
- **Filter pills**: All, Weekly, Fortnightly, Monthly, 6-Monthly, Annual
- **Weekly Checklist Items**: Management section at bottom — add/edit/delete checklist items that appear on the dashboard. Each item has label, icon, week (A/B/Both), phone, sub text.

## Animals
- **Filter pills**: All, Gypsy, Ellie, Rosie (built dynamically from data)
- **Pets**: Gypsy (Tonkinese cat), Ellie (Tonkinese kitten), Rosie (Maltese Cross dog)
- **Shared vet**: Belrose Veterinary Hospital, 02 9452 3155, info@belrosevet.com.au, 70 Pringle Avenue Belrose NSW 2085
- **Quick stats on cards**: Latest weight, tick treatment due date (auto-calculated 3 months after last, colour coded)
- **Medical records grouped by type**: Weight Check (blue), Tick & Flea Treatment (red), Vaccination (green), Worming (purple), Vet Visit (yellow), Treatment (grey)
- **Add medical records**: Form with type, date, description, cost, vet, notes. Click any record to edit/delete.
- **Animal File**: OneDrive link
- **DB columns**: name, type, breed, dob, microchip_number, desexed, desexed_date, vet details, insurance details, notes

## Kids
- **Filter pills**: All, Sarah, Russell
- **Sarah Baker**: Phone +61 405 814 750, OneDrive files link, MS & Epilepsy Protocol page link, key medical info, university timetable (2026)
- **Russell Baker**: Phone +61 413 787 552, OneDrive files link, NSBL Basketball info
- **Sarah Protocol**: Standalone page `sarah-protocol.html` with annual cycle, regular requirements, specialist contacts, planning reminders. Back button returns to Kids page.

## AisleMate (Shopping)
- **In Baker Hub**: Full AisleMate section with weekly shop, master list (142 items), family, receipts, spending, history, meal plan, QR code
- **Standalone**: `shopping.html` — mobile-friendly with PWA manifest (blue Sh icon), add items (comma-separated for multiple), quantity controls, delete buttons, weekly Monday clear prompt
- **Receipt scanning**: Uses `claude-sonnet-4-5` via claude-proxy for accurate extraction. Enhanced prompt for Australian receipts (Woolworths/Coles), handles quantities, discounts, member deals.
- **Master list**: `esc()` function must be defined in AisleMate script block (was missing, caused silent failure)
- **Shared data**: Both standalone and in-app use same `shopping_items` and `master_items` Supabase tables
- **Baker AI integration**: "Add to shopping list" pill and `add_shopping` tool — adds to same tables

## Baker AI
- **Popup**: Purple B button bottom-right on all pages
- **Standalone**: `ai.html` with own PWA manifest (purple)
- **Model**: `claude-haiku-4-5` for chat, `claude-sonnet-4-5` for receipt scanning
- **System prompt**: Stored in Supabase `ai_settings` table (not hardcoded)
- **Quick action pills**: Add to Dates, Add To-Do, Fiona Task, Add Contact, Shopping List
- **Date format**: System messages show Australian format (e.g. "11 April 2026") not YYYY-MM-DD
- **Category prompt**: AI asks which category before adding dates
- **XSS protection**: AI responses HTML-escaped before rendering markdown formatting
- **Auto-refresh**: After any action, reloads data from Supabase and re-renders active screen
- **Tools**:
  - add_todo, complete_todo, delete_todo
  - add_date (must ask for category)
  - add_project
  - update_ndis_status
  - add_contact
  - add_fiona_task, complete_fiona_task, delete_fiona_task
  - add_shopping (comma-separated items, matches against master list)
- **AI Tool Rules**: Every DB operation checks for errors. Dedicated handlers per action. Never silent failures.

## Apps Hub Directory
- `apps-directory.html` — compact tile grid of all apps
- Gradient header (teal to purple), own PWA manifest
- **Tiles**: Baker Hub, Cath Hub, Baker AI, Cath AI, Morning, AisleMate (blue Sh), IAS, Coach4U Hub, C4U Bot, Coach4U Hub (old), Professional Dev, Resources, ThriveHQ

## About Page
- **Built With**: GitHub Pages (hosting), Supabase (database), Claude Code (AI coder — does not own the code), Claude (AI provider for Baker AI chat)
- **Stack**: Vanilla HTML/CSS/JS, Supabase, GitHub Pages, Claude Code, PWA manifest
- **Features**: All 13 sections listed
- **Supabase Tables**: All tables listed

## Supabase Tables

| Table | Purpose | ID Type |
|-------|---------|---------|
| ndis_funds | Funding bucket budgets | auto bigint |
| ndis_transactions | Transaction history + receipt paths | auto bigint |
| ndis_providers | Provider defaults (name, NDIS#, fund) | auto bigint |
| insurance_policies | Insurance, super & investment policies (has `category` column) | auto bigint |
| contacts | Family contacts with categories (includes Insurance category) | auto bigint |
| house_projects | House projects with zones in notes field | auto bigint |
| important_dates | Important dates & events (has House category) | auto bigint |
| todos | To-do list | auto bigint |
| animals | Pet records (name, type, breed, dob, microchip, vet, insurance) | auto bigint |
| animal_medical_records | Vaccinations, treatments, weight checks, tick treatments | auto bigint |
| habits | Habits & rhythms with frequency tracking | auto bigint |
| fiona_tasks | Fiona cleaner task list | manual (Date.now()) |
| ai_settings | Baker AI system prompt & model configuration | bigint (always 1) |
| checklist_items | Weekly dashboard checklist items (label, icon, week A/B/Both) | auto bigint |
| weekly_checklist | Weekly checklist done state (JSON per week) | text (week key) |
| bills | Recurring bills tracker | auto bigint |
| shopping_items | AisleMate shopping list | auto UUID |
| master_items | AisleMate master item catalogue (142 items) | auto UUID |
| receipts | AisleMate receipts | auto UUID |
| receipt_items | AisleMate receipt line items | auto UUID |

All tables have RLS enabled with `allow_all` policy (FOR ALL USING true WITH CHECK true).

## Supabase Storage
- **Bucket**: `ndis-invoices` (public) — receipt/invoice uploads

## Key Files
| File | Purpose |
|------|---------|
| index.html | Main dashboard (all HTML/CSS/JS — 3 script blocks) |
| ai.html | Standalone Baker AI page |
| config.js | Supabase credentials |
| shopping.html | AisleMate standalone shopping page |
| sarah-protocol.html | Sarah's MS & Epilepsy Protocol page |
| ndis.html | Standalone mobile NDIS page (not linked from nav) |
| apps-directory.html | Apps directory page |
| sw.js | Service worker for Baker Hub |
| shopping-sw.js | Service worker for AisleMate |
| manifest.json | Baker Hub PWA manifest |
| ai-manifest.json | Baker AI PWA manifest |
| shopping-manifest.json | AisleMate PWA manifest (blue Sh icon) |
| apps-manifest.json | Apps directory PWA manifest |
| .claude/hooks/session-start.sh | Session start hook — installs htmlhint for linting |
| .claude/settings.json | Hook registration |
| Personal-hub/CLAUDE.md | This file — project memory for future sessions |
| supabase-*.sql | SQL setup scripts (reference, not auto-run) |

## Design System
- **Top bar / sidebar / drawer**: Teal `#0d9488`
- **AI theme**: Purple `#7c3aed`
- **Background**: `#f0f4f8` or `#f8fafc`
- **Cards**: White, border `#e2e8f0`, radius 10-16px
- **Font**: Segoe UI / system font stack
- **Mobile**: Slide-out drawer from left, safe-area-inset padding
- **Forms**: 2-column grid desktop, single column mobile
- **Filter pills**: `.todo-filter-btn` class, tappable, with active state
- **Collapsible sections**: Click header to toggle, arrow indicator
- **Toast notifications**: Non-blocking, auto-dismiss, role="alert" aria-live="polite"
- **Save buttons**: Disable + show "Saving..." during async operations

## Important Technical Notes
- The main `index.html` has 3 separate `<script>` blocks, each with its own `sb` Supabase client
- AisleMate script block needs its own `esc()` function defined (not shared with other blocks)
- `FIONA_TASKS` must be declared at the top with other data variables
- For `fiona_tasks` inserts, always include `id: Date.now()` — table doesn't auto-generate IDs
- Dates and contacts support comma-separated multi-values for categories/people
- `daysDiff` and `daysUntil` use midnight-to-midnight comparison to avoid AEST timezone issues
- Service worker cache version must be bumped when deploying significant changes (currently `baker-hub-v2`)
- All delete operations need RLS DELETE policy (use `allow_all` policy)
- When adding new Supabase queries to the initial data load, update: the Promise.all array, the error check array, the return object, and the destructuring
