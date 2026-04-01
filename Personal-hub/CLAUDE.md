# Project: Baker Hub — Personal Dashboard

## User Context
- **Location**: Australia (Northern Beaches, Sydney)
- **Currency**: Australian Dollars (AUD, $). Always use `$` symbol with Australian formatting.
- **Date format**: DD/MM/YYYY (Australian standard)
- **Locale**: en-AU for all formatting (dates, currency, numbers)

## Architecture
- **Hosting**: GitHub Pages at `cathcoach4u.github.io/personal-baker-hub/`
- **Database**: Supabase (project ID: `ziwycymhaqghdiznyhhw`)
- **Entry point**: `index.html` (root of repo)
- **Config**: `config.js` (Supabase URL + anon key)
- **Stack**: Vanilla HTML/CSS/JS, Supabase JS CDN, no frameworks
- **PWA**: Web app manifest for home screen install (standalone mode)

## Dashboard Sections

### 1. Dashboard (Home)
- **Greeting**: Time-based (Good morning/afternoon/evening) with Week A/B badge
- **This Week widget**: Combined bin collection + cleaners/Fiona schedule
  - Week A = Cleaners + Red & Yellow bins
  - Week B = Fiona + Red & Green bins
  - Reference: Thursday 2 April 2026 = Week A
  - "Wrong week? Swap" toggle (persists in localStorage)
- **Important Reminders**: Bulky waste countdown, outstanding NDIS, upcoming premiums
- **NDIS Funding**: Compact fund cards with budget/spent/remaining
- **Upcoming Premiums**: Next 7 days

### 2. NDIS Transactions
- Transaction table with provider, invoice, date, fund, amount, status, receipt
- **Add/Edit form**: Provider dropdown (auto-fills NDIS number & fund), receipt upload
- **Providers table**: Saved providers for reuse with defaults
- Filters: status, fund, search

### 3. Insurance & Superannuation
- **Grouped by owner**: Cathrine Baker, Andrew Baker (collapsible sections)
- Monthly/annual premium totals per person
- **Add/Edit form**: All policy fields
- Filters: cover type, person, search

### 4. Contacts
- Contact cards with name, person, phone (clickable), category, person tag
- **Categories**: Medical, Health & Wellness, Pharmacy, Home & Services, Entertainment, Food & Lifestyle, Government, NDIS
- **Person tags**: Family, Cath, Andrew, Sarah, Russell
- **Add/Edit form**: Tap any card to edit
- Filters: category, person, search

### 5. House Projects
- Project cards with title, description, priority, status, due date
- **Statuses**: Not Started, In Progress, Complete
- **Priorities**: Low, Medium, High, Urgent
- **Add/Edit form**: Tap any card to edit
- Filters: status, priority, search

### 6. Important Dates
- Date cards with title, description, dates, time, location, category
- **Categories**: Council, Family, Financial, Other
- "Coming up" badge for dates within 30 days
- **Add/Edit form**: Tap any card to edit
- Filters: category, search

### 7. About
- Built With: GitHub, Claude AI, Supabase
- Stack details
- Feature list
- Supabase table reference

## Supabase Tables

| Table | Purpose | RLS |
|-------|---------|-----|
| `ndis_funds` | Funding bucket budgets | SELECT |
| `ndis_transactions` | Transaction history + receipt paths | SELECT, INSERT, UPDATE |
| `ndis_providers` | Provider defaults (name, NDIS#, fund) | SELECT, INSERT |
| `insurance_policies` | Insurance & super policies | SELECT, INSERT, UPDATE |
| `contacts` | Family contacts with categories | SELECT, INSERT, UPDATE |
| `house_projects` | House project tracking | SELECT, INSERT, UPDATE |
| `important_dates` | Important dates & council events | SELECT, INSERT, UPDATE |

## Supabase Storage
- **Bucket**: `ndis-invoices` (public)
- Stores receipt/invoice uploads for NDIS transactions

## Weekly Schedule
- **Collection day**: Thursday
- **Week A**: Cleaners + Yellow bin (Recycling)
- **Week B**: Fiona + Green bin (Vegetation/Organics)
- **Red bin**: Every week (General Waste)
- **Bulky waste**: Booked 11 May 2026 (1 of 2 free per year)

## Council Info (Northern Beaches)
- Chemical CleanOut: 27-28 June 2026
- Food Waste Pilot Phase 2: April-September 2026
- Bulky waste: 2 free per 12 months, book via council portal

## Design Consistency
- Sidebar colour: `#1e293b` (dark navy)
- Accent colour: `#3b82f6` (blue)
- Theme colour: `#16a34a` (green)
- Font: Segoe UI / system font stack
- Cards: white with subtle border, 10px radius
- Mobile: Hamburger dropdown nav, single-column forms

## Files
| File | Purpose |
|------|---------|
| `index.html` | Main dashboard (all HTML/CSS/JS) |
| `config.js` | Supabase credentials |
| `manifest.json` | PWA manifest |
| `icon-192.svg` | App icon (192px) |
| `icon-512.svg` | App icon (512px) |
| `supabase-setup.sql` | Initial table creation + seed data |
| `supabase-contacts.sql` | Contacts table + seed data |
| `supabase-providers.sql` | NDIS providers table |
| `supabase-house-dates.sql` | House projects + important dates tables |
| `supabase-bulky-waste.sql` | Bulky waste date update |
| `supabase-ndis-edit-upload.sql` | Receipt column + update policy |
| `Personal-hub/` | Legacy files (original WordPress version) |
