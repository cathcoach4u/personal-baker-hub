# Project: Baker Hub — Personal Dashboard

## User Context
- **Location**: Australia
- **Currency**: Australian Dollars (AUD, $). Always use `$` symbol with Australian formatting.
- **Date format**: DD/MM/YYYY (Australian standard)
- **Locale**: en-AU for all formatting (dates, currency, numbers)

## Data Sources
- **Supabase**: Primary database — 3 tables: `ndis_funds`, `ndis_transactions`, `insurance_policies`
- **Notion** (archived): NDIS Transactions 2026 (collection://494b9de8-7eba-4930-934b-4f09c4af6524)
- **Notion** (archived): Personal Insurances & Superannuation (collection://bd6fe259-42a4-4d79-9907-9ad407bbd51b)
- **SharePoint** (archived): Site at netorgft4053847.sharepoint.com/sites/bakerpersonal

## NDIS Funding Buckets
- Improved Daily Living: $22,308.85
- Increased Social and Community: $7,164.48

## Deployment Process

### Architecture
- **Hosting**: GitHub Pages (static site served from repo root)
- **Database**: Supabase (client-side JS via supabase-js CDN)
- **Live URL**: https://cathcoach4u.github.io/personal-baker-hub/

### Files
- **Entry point**: `index.html` (root of repo — full HTML document with Supabase integration)
- **Config**: `config.js` (Supabase project URL and anon key)
- **DB schema**: `supabase-setup.sql` (table creation, RLS policies, seed data)
- **Legacy**: `Personal-hub/wordpress-dashboard.html` (original hardcoded version, kept for reference)

### How to Deploy Updates
1. Edit `index.html` (or other files) and push to the branch configured for GitHub Pages
2. GitHub Pages auto-deploys within a few minutes
3. Access at https://cathcoach4u.github.io/personal-baker-hub/

### Managing Data
- Data is stored in **Supabase** — manage it via the Supabase Dashboard (Table Editor)
- Go to your Supabase project > Table Editor to add, edit, or delete records
- Changes appear on the dashboard immediately (no code changes needed)
- The `config.js` file contains the Supabase project URL and anon key (safe to commit — RLS enforces read-only access)

## Supabase Setup

### Initial Setup (one-time)
1. Create a project at https://supabase.com
2. Go to SQL Editor and run the contents of `supabase-setup.sql`
3. Go to Settings > API and copy the **Project URL** and **anon public key**
4. Update `config.js` with the real values
5. Commit and push

### Tables
| Table | Purpose | Records |
|-------|---------|---------|
| `ndis_funds` | NDIS funding bucket budgets | 2 |
| `ndis_transactions` | NDIS transaction history | 11 |
| `insurance_policies` | Insurance and superannuation policies | 15 |

### Security
- Row Level Security (RLS) is enabled on all tables
- Only `SELECT` is allowed for the `anon` role (read-only from the browser)
- To add/edit/delete data, use the Supabase Dashboard or a service role key

## GitHub Pages Setup
1. Go to the repo on GitHub > Settings > Pages
2. Set Source to "Deploy from a branch"
3. Select the branch (e.g. `main`) and folder `/` (root)
4. Save — the site will be live at https://cathcoach4u.github.io/personal-baker-hub/

## Design Consistency
- All hubs share the same dark sidebar + white content area layout
- Sidebar colour: `#1e293b` (dark navy)
- Accent colour: `#f59e0b` (amber)
- Font: Segoe UI / system font stack
- Cards: white with subtle border, 12px radius

## SharePoint File Links (archived)
- **NDIS Files**: https://netorgft4053847.sharepoint.com/:f:/s/bakerpersonal/IgB94rvjEdr1TIsggra-7ZikAffnkzVBmmnutG_1j_V3HAA
- **Insurance Files**: https://netorgft4053847.sharepoint.com/:f:/s/bakerpersonal/IgAoE_DcZLXkT6a4V48krWURARMNXnvtfmD2h_hPZGL_rnw
