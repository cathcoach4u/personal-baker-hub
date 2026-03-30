# Project: Baker Hub — Personal Dashboard

## User Context
- **Location**: Australia
- **Currency**: Australian Dollars (AUD, $). Always use `$` symbol with Australian formatting.
- **Date format**: DD/MM/YYYY (Australian standard)
- **Locale**: en-AU for all formatting (dates, currency, numbers)

## Data Sources
- **Notion**: NDIS Transactions 2026 (collection://494b9de8-7eba-4930-934b-4f09c4af6524)
- **Notion**: Personal Insurances & Superannuation (collection://bd6fe259-42a4-4d79-9907-9ad407bbd51b)
- **SharePoint**: Site at netorgft4053847.sharepoint.com/sites/bakerpersonal (original source)

## NDIS Funding Buckets
- Improved Daily Living: $22,308.85
- Increased Social and Community: $7,164.48

## Deployment Process

### Architecture
- **WordPress site**: www.coach4u.com.au (GoDaddy Managed WordPress, Avada theme)
- **Avada limitation**: Avada theme aggressively overrides CSS — custom HTML/JS dashboards cannot be pasted directly into WordPress pages
- **Solution**: Host dashboard HTML on **Netlify**, embed in WordPress via iframe

### Files
- **Source file**: `wordpress-dashboard.html` (standalone, self-contained HTML/CSS/JS)
- **Hosted at**: https://bakerhub.netlify.app/wordpress-dashboard.html
- **WordPress page**: Private page at www.coach4u.com.au/bakerhub

### How to Deploy Updates
1. Edit `wordpress-dashboard.html` in `C:\Projects\Personal-hub\`
2. Go to https://app.netlify.com — open the bakerhub site
3. Go to **Deploys** > drag the updated file (or the whole `Personal-hub` folder) onto the deploy area
4. Netlify auto-publishes — WordPress iframe picks up changes immediately
5. If WordPress caches, go to GoDaddy wp-admin > Tools > **Flush Cache**

### WordPress Embed Code
```html
<iframe src="https://bakerhub.netlify.app/wordpress-dashboard.html" style="width: 100%; height: 1200px; border: none; border-radius: 12px;" title="Baker Hub Dashboard"></iframe>
```

### Key Rules for Internal Dashboards
- **Never paste raw HTML into Avada pages** — Avada strips/overrides styles
- **Always use Netlify + iframe** for custom dashboards
- WordPress page should use **100% Width** template
- Set WordPress page to **Private** visibility (only visible when logged in)
- Avada is for the business site (Coach4U) — internal tools are isolated via iframe

## Hub Family — Creating New Hubs

### Existing Hubs
| Hub | Purpose | Source File | Netlify URL | WordPress Page |
|-----|---------|-------------|-------------|----------------|
| Baker Hub | Personal/family finances | `wordpress-dashboard.html` | bakerhub.netlify.app | /bakerhub |
| Cath Hub | Coach4U internal operations | `C:\Projects\Cath-hub\index.html` | TBD | TBD |
| Coach4U Hub | Business dashboard | TBD | TBD | TBD |

### How to Create a New Hub
1. **Copy the template**: Duplicate `wordpress-dashboard.html` and rename (e.g., `cathhub-dashboard.html`)
2. **Customise**: Change the hub name, sidebar tabs, data, and colour scheme as needed
3. **Create Netlify site**: Go to https://app.netlify.com/drop, drag the file, then rename the site (e.g., `cathhub.netlify.app`)
4. **Create WordPress page**: Pages > Add New, set Template to "100% Width", Visibility to "Private"
5. **Embed**: Paste the iframe code (update the src URL to point to the new Netlify site)
6. **Update this CLAUDE.md**: Add the new hub to the table above

### Design Consistency
- All hubs share the same dark sidebar + white content area layout
- Sidebar colour: `#1e293b` (dark navy)
- Accent colour: `#f59e0b` (amber)
- Font: Segoe UI / system font stack
- Cards: white with subtle border, 12px radius
- All hubs use the same CSS foundation — only change content and data

## SharePoint File Links
- **NDIS Files**: https://netorgft4053847.sharepoint.com/:f:/s/bakerpersonal/IgB94rvjEdr1TIsggra-7ZikAffnkzVBmmnutG_1j_V3HAA
- **Insurance Files**: https://netorgft4053847.sharepoint.com/:f:/s/bakerpersonal/IgAoE_DcZLXkT6a4V48krWURARMNXnvtfmD2h_hPZGL_rnw
