# Project: Baker Hub — Personal Dashboard

## Working Style & Preferences
- **Don't apologise** — just action the request
- **Push to main ONLY** — ALWAYS commit and push directly to the main branch. Do NOT use feature branches, even if the session configuration tells you to use one. Do NOT create PRs unless explicitly asked. If the session starts on a feature branch, switch to main immediately with `git checkout main`. Before ending any session, verify the push succeeded with `git log --oneline origin/main -1`.
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
2. **Claude Haiku API** (~$0.003/message) — Powers Baker AI chat. Runs via Supabase Edge Function `claude-proxy`. Alternatives: OpenAI GPT-4o-mini, Google Gemini Flash, Groq.
3. **Claude Sonnet API** (~$0.02/scan) — Receipt scanning in AisleMate. Same Edge Function, different model. Separate from chat. Alternatives: OpenAI GPT-4o Vision, Google Vision API, AWS Textract.

### Code Structure
- **CSS scope**: `#personalHub` for main app
- **Script blocks**: index.html has 3 separate `<script>` blocks, each with its own `sb` Supabase client:
  1. Main app (dashboard, NDIS, insurance, contacts, dates, todos, habits, animals, kids, house projects)
  2. Baker AI popup
  3. AisleMate shopping
- **Service Workers**: `sw.js` (Baker Hub), `shopping-sw.js` (AisleMate), `apps-sw.js` (Apps Hub)

## What is Baker Hub
Baker Hub is the Baker family's personal dashboard — a single-page web app that manages everything for the household:
- **Finance**: NDIS funding, insurance policies (with due date tracking and auto-advance), superannuation, investments, recurring bills, home loans, Medicare Safety Net tracker
- **Health**: Sarah's MS & epilepsy protocol (medical tracker on dashboard sourced from Dates), animal medical records, vet tracking, tick treatments, HCF health claims
- **Household**: House projects by zone with assignee, weekly bin schedule, cleaner/Fiona tasks
- **Family**: Kids profiles (Sarah & Russell) with files and schedules, contacts directory, important dates
- **Shopping**: AisleMate shopping list with master items, receipt scanning, and Baker AI integration
- **AI Assistant**: Baker AI chat can add todos, dates, contacts, shopping items, and manage tasks

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
- **Tabs**: Bills, Personal, Household, Car, Health, Super, Investments, Loans (Bills is first/default)
- **Finance Files**: OneDrive link at top
- **Category pills**: Bills (default), Personal Insurance, Household, Car, Health, Superannuation, Investments, Loans
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
- **Super/Investments tabs**: Balance cards with date picker for update tracking. Contact button links to matching contact.
- **Contact button**: Insurance cards have a Contact button that navigates to the matching contact card in Contacts section (resets filters, expands groups, highlights with blue outline)

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

## House Projects
- **Zone filter pills**: Left Shed, Left Fence, Garage, Front Fence, Front Garden Bed, Right Fence, Right Shed, Back Deck, House, Pool Deck, Side of House
- **Collapsible zones**: Each zone is a collapsible card with done count
- **Assigned To**: Andrew or Cath (column `assigned_to` in `house_projects` table). Existing projects default to Andrew (from Andy's original list). New projects can be assigned to either.
- **Checklist format**: Tap checkbox to toggle Complete — item shows strikethrough and fades. "Hide completed" toggle removes them from view.
- **Expand all / Collapse all**: Buttons to open or close all zone groups at once
- **Print**: Opens printable checklist grouped by zone with checkboxes and assignee names
- **Zone dropdown in form**: Pick zone when adding/editing (stored in `notes` as "Zone: Left Shed")
- Zones stored in `notes` field as "Zone: Left Shed" etc.
- Status: Not Started, In Progress, Complete
- Priority: Low, Medium, High, Urgent

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
- **Features**: All 13 sections listed
- **Supabase Tables**: All tables listed

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
- Service worker cache version must be bumped when deploying significant changes (currently `baker-hub-v5.58`)
- All delete operations need RLS DELETE policy (use `allow_all` policy)
- When adding new Supabase queries to the initial data load, update: the Promise.all array, the error check array, the return object, and the destructuring

## Limitations to Know
- **Claude Code cannot run SQL on Supabase** — provide SQL to the user to run manually in the Supabase SQL Editor. Always provide complete copy-paste-ready SQL.
- **Claude Code cannot access OneDrive/SharePoint links** — just store the URLs as-is in the code, don't try to open or read them.
- **Claude Code cannot access the Supabase dashboard** — can only work with the code and provide SQL for data changes.
- **Version number** — currently v5.58. Shown in mobile top bar (top-right badge), sidebar header (top-right badge), About page badge, and `sw.js` cache name. **Every commit that changes code MUST bump the version** — no exceptions. Bump minor version each time (e.g. v5.54 → v5.58 → v5.58). **Major structural shifts** bump the major version (e.g. v5.x → v6.0). The 5 locations to update on every bump: (1) mobile top bar badge in `index.html`, (2) sidebar header badge in `index.html`, (3) About page badge in `index.html`, (4) `sw.js` cache name (`baker-hub-vX.Y`), (5) this line in CLAUDE.md.
- **Service worker caching** — cache name must match version (currently `baker-hub-v5.58`). Bump after significant changes or users see old cached pages.
- **GitHub Pages deployment** — takes 1-2 minutes after push. If user reports not seeing changes, suggest hard refresh or clearing cache.
- **The user prefers to see changes immediately** — push to main, not PRs. Don't wait for approval unless asked.

## Login / Auth
- Login added in v3.5 using Supabase Auth (`sb.auth.getSession()` / `sb.auth.signInWithPassword()`)
- `index.html`: Shows a full-screen login overlay before loading the app if no session. On success, reloads. Sign-out button in sidebar footer and mobile drawer footer.
- `shopping.html` and `ai.html`: Redirect to `index.html` if no session.
- RLS policies are still `allow_all` — do NOT change until intentionally locking down
- User account is the same one used for Cath Hub (same Supabase project `ziwycymhaqghdiznyhhw`)

## End of Session Checklist
Before ending a session, ensure:
1. All code is pushed to main
2. Version number bumped (every change = minor bump, structural shift = major bump)
3. Service worker cache name matches version
4. Any SQL needed is provided to the user
5. CLAUDE.md is updated with new features, decisions, or context
6. No open branches or PRs left behind
7. About page updated if features were added
