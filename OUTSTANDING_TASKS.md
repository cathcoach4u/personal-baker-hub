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
**Status**: Pending  
**Description**: AisleMate currently shares Supabase tables with Cath Hub. Clarify scope:
- Should it remain shared?
- Should it be separated into Baker Hub's own shopping system?
- What tables/features does it need?

**Related Code**: `shopping.html` (standalone AisleMate page)  
**Tables**: `shopping_items`, `master_items`, `receipts`, `receipt_items` (currently shared with Cath Hub)

---

### 2. Date Deletion Persistence
**Status**: Pending  
**Description**: When dates are deleted from the Important Dates section, they sometimes reappear on refresh. Need to ensure deletion is permanent.

**Related Code**: `index.html` - phDates() and phDelDate() functions  
**Table**: `important_dates`  
**Issue**: Likely RLS policy or Supabase sync issue

---

### 3. Dashboard Error Handling
**Status**: Pending  
**Description**: Add graceful error handling for missing data or Supabase connection failures.

**Current State**: Shows generic error message when data fails to load (line 1162 in index.html)  
**Needs**: 
- Retry mechanism for failed data loads
- Offline mode support or cached data fallback
- User-friendly error messages per section
- Toast notifications for transient errors

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
**Status**: Pending  
**Description**: CLAUDE.md navigation list (lines 24-35) is missing Monthly Tasks and Habits & Rhythms sections.

**File**: `Personal-hub/CLAUDE.md`  
**Action**: Add to sidebar navigation list:
- Monthly Tasks (Week-based organization)
- Habits & Rhythms (Frequency-based tracking)

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
