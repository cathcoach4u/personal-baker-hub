# Project: Baker Hub — Personal Dashboard

## Working Style & Preferences
- **Don't apologise** — just action the request
- **Default to main** — ALWAYS commit and push directly to `main` unless the session configuration specifies a feature branch. If a session-config branch is active, develop there, create a PR targeting main, and then **always ask the user: "Ready to merge to main?"** — then action it immediately when they say yes. Before ending any session, verify the push succeeded with `git log --oneline origin/main -1`.
- **Bump version on every change** — every single commit that touches code MUST increment the version (e.g. v5.91 → v5.92). No exceptions, no skipping. The 4 locations to update each time: (1) mobile top bar badge in `index.html`, (2) sidebar header badge in `index.html`, (3) `sw.js` cache name (`baker-hub-vX.Y`), (4) the version line in this CLAUDE.md. Forgetting the version bump means users will see cached old pages.
- **Be the full coder** — Claude's role is to code, push, and complete tasks end-to-end
- **Australian English** — all text, dates (DD/MM/YYYY), currency (AUD $), locale en-AU
- **No uppercase headings** — use normal case for section labels
- **Use filter pills** — not dropdowns, for mobile-friendly category filtering
- **Collapsible sections** — group content into collapsible cards where possible
- **Don't add emojis** unless the user asks

## Which Model to Use
- **Sonnet** — Good balance for feature building, bug fixes, moderate complexity.
- **Haiku** — Quick simple changes (rename a label, change a colour, swap a word). Cheapest and fastest.

## Tips for Faster & Cheaper Sessions
- **Be specific** — say which function/section to edit (e.g. "in renderThisWeek() around line 1475") instead of vague requests
- **Reference script blocks** — index.html has 3 separate script blocks:
  - Script 1: Main app (dashboard, NDIS, insurance, contacts, dates, todos, habits, animals, kids, house projects)
  - Script 2: Baker AI popup — the purple B chat bubble inside Baker Hub (NOT the standalone page). Starts after `<!-- Baker AI Chat Popup -->`
  - Script 3: AisleMate shopping — the shopping section inside Baker Hub. Starts with `// ═══════ AISLEMATE ═══════`
- **Baker AI exists in two places** — both need updating when changing AI tools/features:
  - `index.html` Script block 2 = the chat popup inside Baker Hub (purple B button, bottom-right)
  - `ai.html` = standalone full-screen Baker AI page (separate file, own PWA)
- **Say "only change X"** — prevents unnecessary edits to other parts
- **Use Haiku for small changes** — changing a label, colour, or word doesn't need Opus
- **Reference CLAUDE.md** — say "as documented in CLAUDE.md" to point the session to existing context
- **Start fresh sessions** — long sessions slow down. Start new ones when switching topics
- **Keep CLAUDE.md updated** — update it at the end of each session so the next one has full context

## User Context
- **Owner**: Cathrine Baker (cathcoach4u)
- **Location**: Northern Beaches, Sydney, Australia (AEST)
- **Currency**: Australian Dollars (AUD, $)
- **Date format**: DD/MM/YYYY (Australian standard)
- **Family members**: Cath, Andrew, Sarah, Russell
- **Address**: 11 Castle Crescent, Belrose NSW 2085

## Architecture & Technology Stack

### Infrastructure (owned by Baker family)
- **Hosting**: GitHub Pages at `cathcoach4u.github.io/personal-baker-hub/` — Free
- **Database**: Supabase (project ID: `ziwycymhaqghdiznyhhw`) — Free tier (22+ tables, file storage, Edge Functions)
- **Code**: Vanilla HTML/CSS/JS, Supabase JS CDN, no frameworks, no build tools
- **PWA**: Web app manifests + service workers for home screen install
- **Config**: `config.js` (Supabase URL + anon key)

### AI Services (3 separate services, all replaceable)
1. **Claude Code** ($20/mo Max plan) — AI coder that builds/updates the app. Does NOT own the code. Only needed during development. Alternatives: GitHub Copilot, Cursor, Windsurf, any developer.
2. **Claude Haiku API** (~$0.003/message) — Powers Baker AI chat. Model: `claude-haiku-4-5-20251001`. Runs via Supabase Edge Function `claude-proxy`. Alternatives: OpenAI GPT-4o-mini, Google Gemini Flash, Groq.
3. **Claude Sonnet API** (~$0.02/scan) — Receipt scanning in AisleMate. Model: `claude-sonnet-4-6`. Same Edge Function, different model. Separate from chat. Alternatives: OpenAI GPT-4o Vision, Google Vision API, AWS Textract.

### Code Structure
- **CSS scope**: `#personalHub` for main app
- **Script blocks**: index.html has 3 separate `<script>` blocks, each with its own `sb` Supabase client:
  1. Main app (dashboard, NDIS, insurance, contacts, dates, todos, habits, animals, kids, house projects)
  2. Baker AI popup
  3. AisleMate shopping
- **Service Workers**: `sw.js` (Baker Hub), `shopping-sw.js` (AisleMate), `apps-sw.js` (Apps Hub)

## What is Baker Hub
Baker Hub is the Baker family's personal dashboard — a single-page web app that manages everything for the household:
- **Finance**: NDIS funding, insurance policies (with due date tracking and auto-advance), superannuation, investments, recurring bills, home loans, bank accounts, Medicare Safety Net tracker
- **Budget & Cashflow**: 6-month projection with bank balances, bills, loan repayments, project costs, travel commitments. Accounting & Planning Agent integration.
- **Travel**: Trip planning with budget tracking and expense logging. Integrated into cashflow projection.
- **Health**: Sarah's MS & epilepsy protocol (medical tracker on dashboard sourced from Dates), animal medical records, vet tracking, tick treatments, HCF health claims
- **Household**: House projects (with is_project flag separating projects from items), zone-based collapsible view, weekly bin schedule, cleaner/Fiona tasks
- **Family**: Kids profiles (Sarah & Russell) with files and schedules, contacts directory, important dates
- **Shopping**: AisleMate shopping list with master items, receipt scanning, and Baker AI integration
- **AI Assistant**: Baker AI chat can add todos, dates, contacts, shopping items, and manage tasks. Includes Accounting & Planning Agent context (finance, bills, loans, bank balances).

The app is owned by the Baker family. Claude Code built it but does not own the code. All data lives in Supabase. The app runs on GitHub Pages with no backend server — just static HTML/CSS/JS connecting directly to Supabase.

## Navigation
Sidebar (desktop) + slide-out drawer (mobile, 768px breakpoint):
1. Dashboard (home)
2. To-Do
3. Fiona Tasks
4. NDIS
5. Finance & Insurance
6. Medical
7. Contacts
8. House Projects
9. Dates
10. Habits & Rhythms
11. Animals
12. Kids
13. AisleMate
14. About

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
- **Sarah Medical Tracker**: Always-visible card sourced from Dates with category "Sarah Medical". Shows colour-coded status (red=overdue, amber=upcoming, green=done). "Mark Done" advances date_start to next occurrence and records in `sarah_medical_history`. Expandable history per item. Clickable titles navigate to the date in Dates section. Dates section is the single source of truth.
- **Medicare Safety Net Summary**: Progress bar showing out-of-pocket costs towards general threshold ($2,699.10). Shows amount, percentage, and message like "Spend $X more to reach the threshold". Tapping navigates to Finance > Health. Stored in localStorage.
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
- **Top-level view tabs**: Finance | Budget & Cashflow (two dark-slate tabs at the top of the Finance screen)
- **Finance pills** (inside Finance tab): Bills (default), Personal Insurance, Household, Car, Health, Superannuation, Investments, Loans, Bank Accounts
- **Finance Files**: OneDrive link at top
- **Grouped by person**: Cathrine Baker, Andrew Baker, Russell Baker etc.
- **Sub-grouped by payment source**: "Paid Personally" (credit card) vs "Paid via Super" (Macquarie Super, MLC Masterkey) — collapsible
- **Form includes**: Person, Category, Insurer/Provider, Policy No, Cover Type, Premium, Frequency, Payment Method, Next Due, Paid To, Advanced (Product Type, State, Start/Expiry/Review dates)
- **Due date tracking**: Cards show colour-coded due dates (red=overdue, amber=within 30 days). "Mark Paid" button advances due date to next period. Auto-advance on page load: any overdue due_date is moved forward to the next future occurrence based on frequency.
- **Policy reminders in Dates**: Annual policy payments appear in Dates 1 month before due, monthly policies 1 week before. Auto-generated from insurance_policies data, shown with amber left border under Financial category. No manual entries needed.
- **Key insurance facts**:
  - Acenda = provider for several policies, Customer Number: 7150590, portal: https://my.acenda.com.au/documents
  - AIA = underlying insurer for Acenda policies, Adviser: Joanne Brassett 0282682900
  - ClearView = formerly Zurich (Andrew's Income Protection 51825896)
  - Budget Direct = Andrew's car insurance (White Commodore), policy 111952900
  - Policies paid via Macquarie Super get 15% super rebate
- **Bills tab**: Finance Overview at top (insurance premiums, bills, loan repayments totals with monthly/annual breakdown, upcoming/overdue payments list with exact dates). Below that: recurring bills tracker with category pills, totals, add/edit/delete
- **Health tab**: HCF Health claims with receipt upload. HCF policy card with membership details and brochure links. (Medicare Safety Net moved to dedicated Medical section in v5.37.)
- **Loans tab**: Home loans with balance, interest rate, repayment tracking. Cards show lender, account, property, offset accounts, rate type. Quick-update buttons with date picker for balance, rate and repayment. Loan Files OneDrive link at top. Table: `home_loans`
- **Bank Accounts pill**: Tracks bank accounts and credit cards. Table: `bank_accounts` (name, balance, account_type: savings/cheque/credit/offset, bank_name, account_number, updated_at). Weekly snapshots stored in `bank_balance_history` (account_id, balance, snapshot_date). Add/update balance with date.
- **Super/Investments tabs**: Balance cards with date picker for update tracking. Contact button links to matching contact.
- **Super tab extras**:
  - **ASFA Retirement Standard tracker**: Shows total super vs $730k target (comfortable home-owning couple). Progress bar, gap amount, status message. Moneysmart link. Rendered dynamically in `phSuperView()`.
  - **Contribution caps (FY)**: Per-person card (Cath & Andrew) showing concessional and non-concessional contributions for current FY. Progress bars against caps ($30k concessional, $110k non-concessional). Edit/Enter buttons.
  - **FY planned targets**: Each person can set a total planned contribution for the year. "Still to contribute" calculated as planned minus already paid. Feeds into Budget & Cashflow cashflow projection.
  - **Storage**: All stored in localStorage. `super_contribs_{fyStart}` (amounts paid in, per person). `super_planned_{fyStart}` (planned FY target, per person). Keys auto-scope to financial year (fyStart = year July starts, e.g. 2025 for FY 2025-26). Defaults: Cath concessional $5,360.83, non-concessional $0; Andrew concessional TBC; Cath planned $20k, Andrew planned $10k.
  - **Functions**: `phSuperView()` renders all. `phUpdateSuperContrib(name, type)` edits paid amounts. `phUpdateSuperPlanned(name)` edits FY target.
- **Contact button**: Insurance cards have a Contact button that navigates to the matching contact card in Contacts section (resets filters, expands groups, highlights with blue outline)
- **Linked contact on policies**: `contact_id` column on `insurance_policies` allows an explicit contact link. Form includes a "Linked Contact" dropdown (`#if-contact`). Explicit `contact_id` lookup takes priority over fuzzy insurer name match when navigating to a contact.
- **Bills tab totals**: Finance Overview shows two separate cards — **Outstanding** (orange, unpaid bills total) and **Completed / Paid** (green, paid bills total) — split for clarity

## Budget & Cashflow Tab
- **Accessed via**: Second tab in Finance screen (dark-slate tab "Budget & Cashflow"), rendered by `phRenderBudget()` (async)
- **Stat cards** (top row, auto-fit grid):
  - Bank balances (blue) — total of all `bank_accounts` balances
  - Monthly bills (red) — recurring bills normalised to monthly (weekly×52/12, quarterly÷3, annual÷12)
  - Loan repayments (red-rose) — total `home_loans.repayment` monthly
  - Project costs / open (orange) — sum of open parent projects with cost
  - Travel commitments (purple) — remaining travel budget across active trips
  - Super contributions (green) — remaining planned super contributions this FY (from `super_planned_{FY}` localStorage, only shown if > 0)
- **Accounting & Planning Agent callout**: Gradient banner (teal→purple) with "Chat with Baker AI" button
- **6-month cashflow projection**: Table of 6 months (Month 1–6). Each row shows net flow (income not tracked yet, shows outflows). Tapping a row expands the breakdown:
  - Recurring bills (separate from loans — each listed individually)
  - Loan repayments (separate from bills)
  - Project costs (allocated to month 1 only)
  - Travel (allocated to the month the trip starts, or month 1 if no start_date)
  - Super contributions remaining (allocated to month 1, named per person)
- **Project costs breakdown**: Grid of open projects with cost and zone
- **Travel plans breakdown**: Cards per active trip with budget, spent, remaining, progress bar
- **Monthly cashflow detail**: Bottom section showing Recurring bills / Loan repayments / Monthly total
- **Variables**: `BILLS` (array), `HOME_LOANS` (array), `BANK_ACCOUNTS` (array), `TRIPS`, `EXPENSES`, `PROJECTS`
- **`monthlyBills`**: Sum of bills with frequency normalisation (weekly→×52/12, quarterly→÷3, annually→÷12)
- **`monthlyLoans`**: Sum of `HOME_LOANS[].repayment`
- **Cost deduplication**: `countsTowardsTotal()` excludes child items when parent has a cost to prevent double-counting

## Travel
- **Section**: `id="ph-travel"` — top-level navigation item in sidebar
- **Trips**: Table `travel_trips` (id, name, destination, start_date, end_date, budget, notes, status: planning/booked/completed)
- **Expenses**: Table `travel_expenses` (id, trip_id, description, amount, category, date, notes)
- **Trip card**: Shows budget, amount spent (sum of expenses), remaining, progress bar
- **Add expense**: Form on trip card — description, amount, category, date
- **Rendered by**: `phRenderTravel()`
- **Budget & Cashflow integration**: Active trips (status planning/booked) contribute to travel commitments stat card. Trip allocated to month in 6-month projection based on `start_date` (month 0 if no date).

## Medical
- Dedicated top-level section (added v5.37) — sibling of Finance in the nav
- **Medicare Safety Net tracker**: Threshold (default $2,699.10) + out-of-pocket costs side by side, progress bar, remaining amount, colour-coded (teal < 75%, amber 75-99%, green at/above threshold)
- **Add Cost**: Prompt for description, amount, date — appends to localStorage
- **Threshold button**: Prompt to update threshold value
- **Cost entries list**: Sorted newest first with delete buttons
- **Storage**: Supabase table `medicare_safety_net` (singleton row id=1, columns: threshold numeric, costs jsonb, updated_at). localStorage `medicareSafetyNet` kept as a cache. v5.37 migration: any existing localStorage data auto-pushes to Supabase on first load if Supabase row is empty.
- **Dashboard tile**: `#ph-dash-safety-net` shows just the Remaining amount, navigates to Medical on click. Auto-syncs with Medical — `phRenderSafetyNet()` chains `phRenderDashSafetyNet()` so any add/delete/threshold change updates the dashboard immediately.
- HCF health claims remain in Finance > Health (separate — HCF is insurance-related)

## Contacts
- **Grouped by category** (not by person) with collapsible sections
- **Category filter pills** at top (Medical, Insurance, NDIS, Home & Services, etc.)
- **Categories**: Medical, Vet, Massage, Pharmacy, NDIS, Insurance & Super, Home & Services, Recreation, Food & Lifestyle, Government (+ any custom categories added by user)
- **Dynamic categories**: Dropdown built from existing data + defaults. "Add new category" option lets user type any name — it persists with the contact and appears in future dropdowns/pills. No separate table needed.
- **Copy button**: Clipboard icon on each contact card
- **Export CSV**: Downloads filtered contacts
- **For Person**: Multi-select checkboxes (Family, Cath, Andrew, Sarah, Russell)
- **Open button on links**: Each contact link field has an "Open" button that opens the URL in a new tab. Protocol prefix (`https://`) is auto-added if the stored URL has no `http://` or `https://`

## House Projects
- **Three tabs**: Items to be Completed | Projects (dark-slate tabs)
- **`is_project` boolean column**: `house_projects.is_project` — `true` = project (parent), `false`/null = item (child/task)
- **Items tab** (`is_project = false`): Checklist of individual tasks. Zone filter pills. Collapsible zone cards with done count. Shows only active (non-completed) items. "Hide completed" toggle.
- **Projects tab** (`is_project = true`): Project cards grouped by zone. Each project is collapsible (collapsed by default). Collapse/Expand all buttons. Add item button on each project opens form to add a child item linked to that project. Sub-tasks shown inside project (active only — completed filtered out). Cost field shown for both projects and items.
- **`phExpandedProjects` Set**: Stored in `localStorage('ph-expanded-projects')`. Tracks which project IDs the user has manually expanded. Empty by default = all collapsed.
- **Cost model (dual mode)**: Items AND projects can carry individual costs. Two modes:
  - **House Tasks** (pinned project, title=`'House Tasks'`): Always uses item rollup — individual sub-item costs sum automatically. Always pinned at top of Projects list. Always starts collapsed. Orphan items (no `parent_id`) are auto-assigned to House Tasks on load. Default parent when adding a new item.
  - **All other projects**: Fixed project cost takes priority if set. If no fixed project cost, rolls up from individual item costs.
  - `effCost(p)` — calculates effective cost per project using the above logic
  - `countsTowardsTotal()` — excludes child items when their parent already has a cost (prevents double-counting)
- **Sub-task row "Move to..."**: Each sub-task row has a dropdown to move it to another project instantly (`phQuickReparent(id, newParentId)` — updates `parent_id` in Supabase and re-renders)
- **Complete project flow**: Marking a project Complete when it still has active sub-tasks prompts the user to move those items to House Tasks before completing
- **Active project count**: Dashboard/summary counts only non-Complete projects (`status !== 'Complete'`)
- **Zone filter pills**: Left Shed, Left Fence, Garage, Front Fence, Front Garden Bed, Right Fence, Right Shed, Back Deck, House, Pool Deck, Side of House
- **Assigned To**: Andrew or Cath (`assigned_to` column). Existing items default to Andrew.
- **Expand all / Collapse all**: Buttons in Projects tab to open or close all project cards
- **Print**: Opens printable checklist grouped by zone with checkboxes and assignee names
- **Zone dropdown in form**: Pick zone when adding/editing (stored in `notes` as "Zone: Left Shed")
- Status: Not Started, In Progress, Complete
- Priority: Low, Medium, High, Urgent
- **Budget & Cashflow**: Open projects with cost feed into the 6-month projection (month 1 allocation)

## Dates (Important Dates)
- **Month timeline**: Apr 2026 to Mar 2027, collapsible months
- **Week grouping**: Within each month, grouped by week (collapsible)
- **Categories**: Council, Family, Cath, Andrew, Sarah, Russell, Public Holidays, Financial, House, Sarah Medical, Other
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
- **Quick stats on cards**: Latest weight, tick treatment due date (auto-calculated 3 months after last, colour coded), age calculated from DOB (e.g. "3yr 6mo old")
- **Medical records grouped by type**: Weight Check (blue), Tick & Flea Treatment (red), Vaccination (green), Worming (purple), Vet Visit (yellow), Treatment (grey)
- **Add medical records**: Form with type, date, description, cost, vet, notes. Click any record to edit/delete.
- **Animal File**: OneDrive link
- **DB columns**: name, type, breed, dob, microchip_number, desexed, desexed_date, vet details, insurance details, notes

## Kids
- **Filter pills**: All, Sarah, Russell
- **Sarah Baker**: Phone +61 405 814 750, OneDrive files link, MS & Epilepsy Protocol page link, key medical info, university timetable (2026)
- **Russell Baker**: Phone +61 413 787 552, OneDrive files link, NSBL Basketball info
- **Sarah Medical Checklist**: Shows in Kids section, sourced from Dates with category "Sarah Medical" (same data as Dashboard tracker). Clickable to mark done.
- **Sarah Protocol**: Standalone page `sarah-protocol.html` with annual cycle (JC Virus: Mar & Sep, MRI: Jun & Dec, Neurologist: Jun telehealth & Dec face-to-face, Full Blood Test: Mar), regular requirements, specialist contacts, planning reminders. Back button returns to Kids page.

## AisleMate (Shopping)
- **In Baker Hub**: Full AisleMate section with weekly shop, master list (142 items), family, receipts, spending, history, meal plan, QR code
- **Standalone**: `shopping.html` — mobile-friendly with PWA manifest (blue Sh icon), add items (comma-separated for multiple), quantity controls, delete buttons, weekly Monday clear prompt
- **Receipt scanning**: Uses `claude-sonnet-4-6` via claude-proxy for accurate extraction. Enhanced prompt for Australian receipts (Woolworths/Coles), handles quantities, discounts, member deals.
- **Master list**: `esc()` function must be defined in AisleMate script block (was missing, caused silent failure)
- **Shared data**: Both standalone and in-app use same `shopping_items` and `master_items` Supabase tables
- **Baker AI integration**: "Add to shopping list" pill and `add_shopping` tool — adds to same tables

## Baker AI
- **Popup**: Purple B button bottom-right on all pages
- **Standalone**: `ai.html` with own PWA manifest (purple)
- **Model**: `claude-haiku-4-5-20251001` for chat, `claude-sonnet-4-6` for receipt scanning
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
- **URL**: https://cathcoach4u.github.io/personal-businessapps/
- **Repo**: `cathcoach4u/personal-businessapps` (separate repository — moved out of baker-hub)
- **Design**: Gradient header (teal to purple), own PWA manifest (black A icon), installable on home screen
- **Sections and tiles**:
  - **Personal Hubs**: Baker Hub, Cath Hub, Baker AI, Cath AI, Morning, AisleMate (blue Sh icon)
  - **Coach4U — Clients**: IAS (red)
  - **Coach4U — Internal**: Coach4U Hub, C4U Bot (chat bubble icon), Coach4U Hub (old, dimmed)
  - **Coach4U — External**: Professional Dev, Resources, ThriveHQ
- This is the central launch page for all apps — should be the home screen shortcut
- When adding new apps/pages, add a tile here so it's accessible from one place

## About Page
- **Built With**: GitHub Pages (hosting), Supabase (database), Claude Code (AI coder — does not own the code), Claude (AI provider for Baker AI chat)
- **Stack**: Vanilla HTML/CSS/JS, Supabase, GitHub Pages, Claude Code, PWA manifest
- **Features**: All sections listed
- **Supabase Tables**: All tables listed (28 as of v5.92)
- **AI Agents section**: Lists all active agents with description and cost. As of v5.92:
  - Baker AI — family assistant (claude-haiku-4-5-20251001 via Supabase Edge Function)
  - Receipt Scanner — AisleMate receipt OCR (claude-sonnet-4-6)
  - Accounting & Planning Agent — finance/budget analysis (claude-haiku-4-5, accessible via Budget & Cashflow tab)
  - Claude Code — development agent (not in-app)

## Supabase Tables

| Table | Purpose | ID Type |
|-------|---------|---------|
| ndis_funds | Funding bucket budgets | auto bigint |
| ndis_transactions | Transaction history + receipt paths | auto bigint |
| ndis_providers | Provider defaults (name, NDIS#, fund) | auto bigint |
| insurance_policies | Insurance, super & investment policies (has `category` column) | auto bigint |
| contacts | Family contacts with categories (includes Insurance & Super category) | auto bigint |
| house_projects | House projects with zones in notes field | auto bigint |
| important_dates | Important dates & events (has House, Sarah Medical categories) | auto bigint |
| sarah_medical_history | Completion history for Sarah medical items | auto bigint |
| todos | To-do list | auto bigint |
| animals | Pet records (name, type, breed, dob, microchip, vet, insurance) | auto bigint |
| animal_medical_records | Vaccinations, treatments, weight checks, tick treatments | auto bigint |
| habits | Habits & rhythms with frequency tracking | auto bigint |
| fiona_tasks | Fiona cleaner task list | manual (Date.now()) |
| ai_settings | Baker AI system prompt & model configuration | bigint (always 1) |
| checklist_items | Weekly dashboard checklist items (label, icon, week A/B/Both) | auto bigint |
| weekly_checklist | Weekly checklist done state (JSON per week) | text (week key) |
| bills | Recurring bills tracker | auto bigint |
| home_loans | Home loan balances, rates and repayments | auto bigint |
| health_claims | HCF health insurance claims with receipt uploads | auto bigint |
| shopping_items | AisleMate shopping list | auto UUID |
| master_items | AisleMate master item catalogue (142 items) | auto UUID |
| receipts | AisleMate receipts | auto UUID |
| receipt_items | AisleMate receipt line items | auto UUID |
| medicare_safety_net | Medicare Safety Net threshold + costs (singleton row id=1, costs as jsonb) | bigint (always 1) |
| bank_accounts | Bank accounts and credit cards (name, balance, account_type, bank_name, account_number, updated_at) | auto bigint |
| bank_balance_history | Weekly balance snapshots per account (account_id, balance, snapshot_date) | auto bigint |
| travel_trips | Travel trips (name, destination, start_date, end_date, budget, notes, status: planning/booked/completed) | auto bigint |
| travel_expenses | Travel expenses per trip (trip_id, description, amount, category, date, notes) | auto bigint |

All tables have RLS enabled with `allow_all` policy (FOR ALL USING true WITH CHECK true).

## Supabase Storage
- **Bucket**: `ndis-invoices` (public) — receipt/invoice uploads
- **Bucket**: `hcf-claims` (public) — HCF health claim receipts

## Key Files
| File | Purpose |
|------|---------|
| index.html | Main dashboard (all HTML/CSS/JS — 3 script blocks) |
| ai.html | Standalone Baker AI page |
| config.js | Supabase credentials |
| shopping.html | AisleMate standalone shopping page |
| sarah-protocol.html | Sarah's MS & Epilepsy Protocol page |
| japan-2026.html | Japan family trip planner (25 Sep – 9 Oct 2026). Auth-protected. Checklist + notes saved in localStorage. Linked from Travel section. |
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
| CLAUDE.md | Root project memory file — auto-loaded by Claude Code (imports Personal-hub/CLAUDE.md) |
| Personal-hub/CLAUDE.md | Full project memory — edit this file to update context |
| supabase-*.sql | SQL setup scripts (reference, not auto-run) |
| supabase-home-loans.sql | Home loans table setup |

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
- Service worker cache version must be bumped when deploying significant changes (currently `baker-hub-v6.3`)
- All delete operations need RLS DELETE policy (use `allow_all` policy)
- When adding new Supabase queries to the initial data load, update: the Promise.all array, the error check array, the return object, and the destructuring

## Limitations to Know
- **Claude Code cannot run SQL on Supabase** — provide SQL to the user to run manually in the Supabase SQL Editor. Always provide complete copy-paste-ready SQL.
- **Claude Code cannot access OneDrive/SharePoint links** — just store the URLs as-is in the code, don't try to open or read them.
- **Claude Code cannot access the Supabase dashboard** — can only work with the code and provide SQL for data changes.
- **Current version** — v6.3. Major structural shifts bump the major version (e.g. v5.x → v6.0); all other changes bump the minor version. See Working Style for the 4 bump locations.
- **Service worker caching** — cache name must match version (currently `baker-hub-v6.3`). Bump after every change or users will see stale cached pages.
- **GitHub Pages deployment** — takes 1-2 minutes after push. If user reports not seeing changes, suggest hard refresh or clearing cache.
- **The user prefers to see changes immediately** — push to main, not PRs. Don't wait for approval unless asked.

## Login / Auth
- Login added in v3.5 using Supabase Auth (`sb.auth.getSession()` / `sb.auth.signInWithPassword()`)
- `index.html`: Shows a full-screen login overlay before loading the app if no session. On success, reloads. Sign-out button in sidebar footer and mobile drawer footer.
- `shopping.html` and `ai.html`: Redirect to `index.html` if no session.
- RLS policies are still `allow_all` — do NOT change until intentionally locking down
- User account is the same one used for Cath Hub (same Supabase project `ziwycymhaqghdiznyhhw`)

## Start of Session Checklist
Before writing any code, orient quickly:
1. Check current version: `grep "baker-hub-v" sw.js`
2. Check recent commits: `git log --oneline -5`
3. Confirm active branch matches the session config (default: `main`)
4. Ask the user: "What are we working on today?" if the task isn't already clear
5. Note the 3 script blocks in `index.html` — edit the right one

## End of Session Checklist
Before ending a session, ensure:
1. All code is pushed to main
2. Version number bumped (every change = minor bump, structural shift = major bump)
3. Service worker cache name matches version
4. Any SQL needed is provided to the user
5. CLAUDE.md is updated with new features, decisions, or context
6. No open branches or PRs left behind
7. About page updated if features were added
