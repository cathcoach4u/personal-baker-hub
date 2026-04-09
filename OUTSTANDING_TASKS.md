# Outstanding Tasks — Baker Hub

## Completed This Session
- ✅ Configurable AI settings stored in Supabase
- ✅ Animals section with pet tracking & medical records
- ✅ Monthly Tasks (organized by weeks 1-4 + catch-up week 5)
- ✅ Habits & Rhythms (frequency-based: Weekly, Fortnightly, Monthly, 6-Monthly, Annual)
- ✅ Apps Hub color scheme (Baker/Cath Hub teal, IAS red, gradient header)
- ✅ Deployed all features to main branch and live site

## Outstanding Tasks

### 1. AisleMate Separation
**Status**: Closed (not needed)  
**Description**: AisleMate remains shared with Cath Hub. Now works as a standalone PWA with its own manifest and icon, and is listed on the Apps Hub directory.

---

### 2. Date Deletion Persistence
**Status**: Fixed  
**Description**: Dates reappeared on refresh because the Supabase RLS policy only allowed SELECT.

**Root Cause & Fix**:
- `important_dates` table had SELECT-only RLS policy — deletes were silently rejected
- Changed to `allow_all` policy across all affected tables (`important_dates`, `house_projects`, `ndis_funds`, `ndis_transactions`, `insurance_policies`, `ndis_providers`)

---

### 3. Dashboard Error Handling
**Status**: Fixed  
**Description**: Added graceful error handling for Supabase connection failures.

**What was added**:
- Auto-retry: if data load fails, waits 2s and retries once automatically
- Retry button: if both attempts fail, shows error message with a Retry button
- Toast notifications: all error/success alerts replaced with non-blocking toast popups
- Error detail: Supabase error messages now shown to help diagnose issues

---

### 4. add_contact Reliability
**Status**: Fixed  
**Description**: The AI tool `add_contact` had reliability issues due to missing columns and RLS policies.

**Root Causes Found & Fixed**:
- `supabase-contacts.sql` was missing `email`, `meeting_link`, `notes`, `for_person` columns — inserts with these fields would fail
- RLS policy only allowed SELECT (no INSERT/UPDATE/DELETE) — changed to `allow_all` policy
- `index.html` handler lacked `if(!data)` safety check — aligned with the more robust `ai.html` version
- Improved error messages for better user feedback

---

### 5. Update Navigation Documentation
**Status**: Fixed  
**Description**: Added Habits & Rhythms to the CLAUDE.md navigation list.

---

## Session Notes
- All three new Supabase tables (`monthly_tasks`, `animals`, `habits`) are now live with sample data
- Code has been merged from `claude/add-ai-settings-Puxi0` to `main` branch
- GitHub Pages deployment is live at `cathcoach4u.github.io/personal-baker-hub/`
- Config.js Supabase credentials are valid and working

## Quick Reference — File Paths
| File | Purpose |
|------|---------|
| `index.html` | Main dashboard (all HTML/CSS/JS) |
| `ai.html` | Standalone Baker AI page |
| `apps-directory.html` | Apps Hub with color scheme |
| `shopping.html` | AisleMate standalone |
| `config.js` | Supabase credentials |
| `Personal-hub/CLAUDE.md` | Project documentation |
| `OUTSTANDING_TASKS.md` | This file |
