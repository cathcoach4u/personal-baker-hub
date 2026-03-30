# Personal Hub — PowerApps Canvas App Build Guide

## Overview
A sidebar-navigation canvas app connecting to 2 SharePoint lists:
- **NDIS Transactions 2026** (11 items)
- **Personal Insurances & Superannuation** (15 items)

**Dashboard shows:**
- Outstanding NDIS payments (overdue >7 days)
- Total NDIS spend vs remaining budget
- Insurance premiums due this week

---

## STEP 1: Create the App

1. Go to **make.powerapps.com**
2. Click **+ Create** → **Blank app** → **Blank canvas app**
3. Name: `Personal Hub`
4. Format: **Tablet**
5. Click **Create**

---

## STEP 2: Connect Your SharePoint Lists

1. In the left panel, click **Data** (cylinder icon)
2. Click **+ Add data**
3. Search for **SharePoint**
4. Enter your site URL: `https://netorgft4053847.sharepoint.com/sites/bakerpersonal`
5. Select both lists:
   - ☑ **NDIS Transactions 2026**
   - ☑ **Personal Insurances & Superannuation**
6. Click **Connect**

---

## STEP 3: Create the Screens

Create these 3 screens (Insert → New screen → Blank):

| Screen Name     | Purpose                        |
|-----------------|--------------------------------|
| `scrHome`       | Dashboard with KPIs            |
| `scrNDIS`       | NDIS Transactions list & forms |
| `scrInsurance`  | Insurance & Super list & forms |

---

## STEP 4: Build the Sidebar (on every screen)

### 4a. Add a Rectangle for the sidebar background

On `scrHome`:
1. **Insert → Shape → Rectangle**
2. Set properties:

```
Name:   rectSidebar
X:      0
Y:      0
Width:  260
Height: Parent.Height
Fill:   RGBA(30, 41, 59, 1)
```

### 4b. Add the App Title

1. **Insert → Text label**
2. Properties:

```
Name:       lblAppTitle
Text:       "Personal Hub"
X:          20
Y:          20
Width:      220
Height:     50
Font:       Font.'Segoe UI'
Size:       20
FontWeight: FontWeight.Bold
Color:      White
```

### 4c. Add Navigation Buttons

**Home button:**
```
Name:           btnNavHome
Text:           "🏠  Dashboard"
X:              10
Y:              100
Width:          240
Height:         45
Fill:           If(App.ActiveScreen = scrHome, RGBA(59, 130, 246, 0.2), Transparent)
Color:          White
BorderColor:    Transparent
HoverFill:      RGBA(59, 130, 246, 0.15)
Font:           Font.'Segoe UI'
Size:           14
Align:          Align.Left
PaddingLeft:    20
OnSelect:       Navigate(scrHome, ScreenTransition.None)
```

**NDIS button:**
```
Name:           btnNavNDIS
Text:           "💰  NDIS Transactions"
X:              10
Y:              150
Width:          240
Height:         45
Fill:           If(App.ActiveScreen = scrNDIS, RGBA(59, 130, 246, 0.2), Transparent)
Color:          White
BorderColor:    Transparent
HoverFill:      RGBA(59, 130, 246, 0.15)
Font:           Font.'Segoe UI'
Size:           14
Align:          Align.Left
PaddingLeft:    20
OnSelect:       Navigate(scrNDIS, ScreenTransition.None)
```

**Insurance button:**
```
Name:           btnNavInsurance
Text:           "🛡️  Insurance & Super"
X:              10
Y:              200
Width:          240
Height:         45
Fill:           If(App.ActiveScreen = scrInsurance, RGBA(59, 130, 246, 0.2), Transparent)
Color:          White
BorderColor:    Transparent
HoverFill:      RGBA(59, 130, 246, 0.15)
Font:           Font.'Segoe UI'
Size:           14
Align:          Align.Left
PaddingLeft:    20
OnSelect:       Navigate(scrInsurance, ScreenTransition.None)
```

### 4d. Copy Sidebar to Other Screens

1. Select ALL sidebar controls (rectSidebar, lblAppTitle, btnNavHome, btnNavNDIS, btnNavInsurance)
2. **Ctrl+C**, go to `scrNDIS`, **Ctrl+V**
3. Repeat for `scrInsurance`

---

## STEP 5: Build the Dashboard (scrHome)

All content starts at **X: 290** (to the right of sidebar).

### 5a. App.OnStart — Set the Budget Variable

Click on the **App** object in the tree view, set **OnStart**:

```
Set(varNDISBudget, 50000);
// ⬆️ CHANGE THIS to your actual NDIS plan budget
```

> **To update your budget later:** Change the number and re-run App.OnStart, or add an edit icon that uses `UpdateContext({locEditBudget: true})` to show an input field.

### 5b. Page Header

```
Name:       lblDashHeader
Text:       "Dashboard"
X:          290
Y:          20
Width:      500
Height:     50
Size:       24
FontWeight: FontWeight.Bold
Color:      RGBA(30, 41, 59, 1)
```

### 5c. KPI Card 1 — Total NDIS Spend

**Card background (Rectangle):**
```
Name:           rectKPI1
X:              290
Y:              90
Width:          280
Height:         140
Fill:           White
BorderColor:    RGBA(226, 232, 240, 1)
BorderThickness: 1
```

**Label — title:**
```
Name:   lblKPI1Title
Text:   "Total NDIS Spend"
X:      310
Y:      100
Width:  240
Height: 30
Size:   12
Color:  RGBA(100, 116, 139, 1)
```

**Label — value:**
```
Name:       lblKPI1Value
Text:       Text(
                Sum('NDIS Transactions 2026', Amount),
                "$#,##0.00"
            )
X:          310
Y:          130
Width:      240
Height:     40
Size:       28
FontWeight: FontWeight.Bold
Color:      RGBA(30, 41, 59, 1)
```

**Label — remaining:**
```
Name:   lblKPI1Sub
Text:   "Remaining: " & Text(
            varNDISBudget - Sum('NDIS Transactions 2026', Amount),
            "$#,##0.00"
        )
X:      310
Y:      175
Width:  240
Height: 30
Size:   12
Color:  If(
            varNDISBudget - Sum('NDIS Transactions 2026', Amount) < 5000,
            RGBA(239, 68, 68, 1),
            RGBA(34, 197, 94, 1)
        )
```

### 5d. KPI Card 2 — Overdue NDIS Payments (>7 days)

**Card background:**
```
Name:           rectKPI2
X:              590
Y:              90
Width:          280
Height:         140
Fill:           White
BorderColor:    RGBA(226, 232, 240, 1)
BorderThickness: 1
```

**Label — title:**
```
Name:   lblKPI2Title
Text:   "Overdue Payments (>7 days)"
X:      610
Y:      100
Width:  240
Height: 30
Size:   12
Color:  RGBA(100, 116, 139, 1)
```

**Label — count:**
```
Name:       lblKPI2Value
Text:       Text(
                CountRows(
                    Filter(
                        'NDIS Transactions 2026',
                        Status.Value <> "Paid" &&
                        DateDiff(Date, Today(), TimeUnit.Days) > 7
                    )
                ),
                "0"
            )
X:          610
Y:          130
Width:      240
Height:     40
Size:       28
FontWeight: FontWeight.Bold
Color:      RGBA(239, 68, 68, 1)
```

**Label — total overdue amount:**
```
Name:   lblKPI2Sub
Text:   "Total: " & Text(
            Sum(
                Filter(
                    'NDIS Transactions 2026',
                    Status.Value <> "Paid" &&
                    DateDiff(Date, Today(), TimeUnit.Days) > 7
                ),
                Amount
            ),
            "$#,##0.00"
        )
X:      610
Y:      175
Width:  240
Height: 30
Size:   12
Color:  RGBA(100, 116, 139, 1)
```

### 5e. KPI Card 3 — Insurance Premiums Due This Week

**Card background:**
```
Name:           rectKPI3
X:              890
Y:              90
Width:          280
Height:         140
Fill:           White
BorderColor:    RGBA(226, 232, 240, 1)
BorderThickness: 1
```

**Label — title:**
```
Name:   lblKPI3Title
Text:   "Premiums Due This Week"
X:      910
Y:      100
Width:  240
Height: 30
Size:   12
Color:  RGBA(100, 116, 139, 1)
```

**Label — count:**
```
Name:       lblKPI3Value
Text:       Text(
                CountRows(
                    Filter(
                        'Personal Insurances & Superannuation',
                        DateDiff(
                            Today(),
                            DateValue('Due / Next Due Date'),
                            TimeUnit.Days
                        ) >= 0 &&
                        DateDiff(
                            Today(),
                            DateValue('Due / Next Due Date'),
                            TimeUnit.Days
                        ) <= 7
                    )
                ),
                "0"
            )
X:          910
Y:          130
Width:      240
Height:     40
Size:       28
FontWeight: FontWeight.Bold
Color:      RGBA(234, 179, 8, 1)
```

**Label — total premium amount:**
```
Name:   lblKPI3Sub
Text:   "Total: " & Text(
            Sum(
                Filter(
                    'Personal Insurances & Superannuation',
                    DateDiff(
                        Today(),
                        DateValue('Due / Next Due Date'),
                        TimeUnit.Days
                    ) >= 0 &&
                    DateDiff(
                        Today(),
                        DateValue('Due / Next Due Date'),
                        TimeUnit.Days
                    ) <= 7
                ),
                Premium
            ),
            "$#,##0.00"
        )
X:      910
Y:      175
Width:  240
Height: 30
Size:   12
Color:  RGBA(100, 116, 139, 1)
```

### 5f. Overdue NDIS Transactions Gallery

```
Name:       galOverdueNDIS
X:          290
Y:          260
Width:      580
Height:     400

Items:      Sort(
                Filter(
                    'NDIS Transactions 2026',
                    Status.Value <> "Paid" &&
                    DateDiff(Date, Today(), TimeUnit.Days) > 7
                ),
                Date,
                SortOrder.Ascending
            )

TemplateSize:   70
TemplatePadding: 5
```

**Inside the gallery template, add these labels:**

Provider name:
```
Text:       ThisItem.Title
X:          15
Y:          10
FontWeight: FontWeight.Semibold
Size:       14
```

Invoice & date:
```
Text:       "Inv: " & ThisItem.'Invoice No.' & "  |  " & Text(ThisItem.Date, "dd MMM yyyy")
X:          15
Y:          35
Size:       11
Color:      RGBA(100, 116, 139, 1)
```

Amount:
```
Text:       Text(ThisItem.Amount, "$#,##0.00")
X:          400
Y:          10
Width:      150
Align:      Align.Right
FontWeight: FontWeight.Bold
Size:       16
Color:      RGBA(239, 68, 68, 1)
```

Days overdue:
```
Text:       Text(DateDiff(ThisItem.Date, Today(), TimeUnit.Days), "0") & " days overdue"
X:          400
Y:          35
Width:      150
Align:      Align.Right
Size:       11
Color:      RGBA(239, 68, 68, 1)
```

### 5g. Upcoming Insurance Premiums Gallery

```
Name:       galUpcomingPremiums
X:          890
Y:          260
Width:      380
Height:     400

Items:      Sort(
                Filter(
                    'Personal Insurances & Superannuation',
                    DateDiff(
                        Today(),
                        DateValue('Due / Next Due Date'),
                        TimeUnit.Days
                    ) >= 0 &&
                    DateDiff(
                        Today(),
                        DateValue('Due / Next Due Date'),
                        TimeUnit.Days
                    ) <= 30
                ),
                DateValue('Due / Next Due Date'),
                SortOrder.Ascending
            )

TemplateSize:   60
TemplatePadding: 5
```

**Inside gallery template:**

Policy name:
```
Text:       ThisItem.Title & " — " & ThisItem.Insurer
FontWeight: FontWeight.Semibold
Size:       13
```

Due date & amount:
```
Text:       "Due: " & ThisItem.'Due / Next Due Date' & "  |  $" & Text(ThisItem.Premium, "#,##0.00")
Size:       11
Color:      RGBA(100, 116, 139, 1)
```

---

## STEP 6: NDIS Transactions Screen (scrNDIS)

### 6a. Header
```
Name:   lblNDISHeader
Text:   "NDIS Transactions 2026"
X:      290
Y:      20
Width:  500
Height: 50
Size:   24
FontWeight: FontWeight.Bold
```

### 6b. Status Filter Dropdown
```
Name:           drpStatus
X:              290
Y:              80
Width:          200
Items:          ["All", "Paid", "Pending", "Overdue"]
Default:        "All"
```

### 6c. Full Transactions Gallery
```
Name:       galNDIS
X:          290
Y:          130
Width:      Parent.Width - 310
Height:     Parent.Height - 150

Items:      Sort(
                If(
                    drpStatus.Selected.Value = "All",
                    'NDIS Transactions 2026',
                    Filter(
                        'NDIS Transactions 2026',
                        Status.Value = drpStatus.Selected.Value
                    )
                ),
                Date,
                SortOrder.Descending
            )

TemplateSize: 75
```

**Gallery template labels (same pattern as dashboard gallery):**
- Title (provider name) — bold, left
- Invoice No. + Date + Funded Supports — small, grey, below title
- Amount — bold, right aligned
- Status — color-coded badge:

```
// Status label
Text:   ThisItem.Status.Value
Color:  Switch(
            ThisItem.Status.Value,
            "Paid", RGBA(34, 197, 94, 1),
            "Pending", RGBA(234, 179, 8, 1),
            "Overdue", RGBA(239, 68, 68, 1),
            RGBA(100, 116, 139, 1)
        )
```

---

## STEP 7: Insurance & Super Screen (scrInsurance)

### 7a. Header
```
Name:   lblInsHeader
Text:   "Personal Insurances & Superannuation"
X:      290
Y:      20
Width:  600
Height: 50
Size:   24
FontWeight: FontWeight.Bold
```

### 7b. Full List Gallery
```
Name:       galInsurance
X:          290
Y:          90
Width:      Parent.Width - 310
Height:     Parent.Height - 110

Items:      SortByColumns(
                'Personal Insurances & Superannuation',
                "Due_x0020__x002f__x0020_Next_x0020_Due_x0020_Date",
                SortOrder.Ascending
            )

TemplateSize: 85
```

**Gallery template labels:**

Policy name + Insurer:
```
Text:       ThisItem.Title
FontWeight: FontWeight.Bold
Size:       14
```

Details row:
```
Text:       ThisItem.Insurer & "  |  Policy: " & ThisItem.'Policy No' & "  |  " & ThisItem.'Cover Type'
Size:       11
Color:      RGBA(100, 116, 139, 1)
```

Premium info:
```
Text:       "$" & Text(ThisItem.Premium, "#,##0.00") & " " & ThisItem.'Premium Frequency' & "  |  Due: " & ThisItem.'Due / Next Due Date' & "  |  Paid to: " & ThisItem.'Paid To Date'
Size:       11
Color:      RGBA(100, 116, 139, 1)
```

Payment method:
```
Text:       "Payment: " & ThisItem.'Payment Method'
Size:       11
Color:      RGBA(100, 116, 139, 1)
```

---

## STEP 8: Set Background Colors

On each screen, set:
```
Fill:   RGBA(248, 250, 252, 1)
```
This gives a light grey background that makes the white cards pop.

---

## STEP 9: Publish

1. **File → Save**
2. **File → Publish**
3. Open on your phone via the **Power Apps mobile app**

---

## Quick Reference — Column Names for Formulas

### NDIS Transactions 2026
| Display Name     | Use in formulas as              |
|------------------|---------------------------------|
| Title            | `ThisItem.Title`                |
| Invoice No.      | `ThisItem.'Invoice No.'`        |
| Date             | `ThisItem.Date`                 |
| Amount           | `ThisItem.Amount`               |
| Status           | `ThisItem.Status.Value`         |
| Notes            | `ThisItem.Notes`                |
| NDIS No.         | `ThisItem.'NDIS No.'`           |
| Funded Supports  | `ThisItem.'Funded Supports'.Value` |

### Personal Insurances & Superannuation
| Display Name           | Use in formulas as                    |
|------------------------|---------------------------------------|
| Title                  | `ThisItem.Title`                      |
| Insurer                | `ThisItem.Insurer`                    |
| Policy No              | `ThisItem.'Policy No'`                |
| Superannuation Amount  | `ThisItem.'Superannuation Amount'`    |
| Premium Frequency      | `ThisItem.'Premium Frequency'`        |
| Premium                | `ThisItem.Premium`                    |
| Payment Method         | `ThisItem.'Payment Method'`           |
| Cover Type             | `ThisItem.'Cover Type'`               |
| Due / Next Due Date    | `ThisItem.'Due / Next Due Date'`      |
| Paid To Date           | `ThisItem.'Paid To Date'`             |
| Notes                  | `ThisItem.Notes`                      |
| SharePoint Filing      | `ThisItem.'Sharepoint Filing'`        |

---

## Notes

- **Due / Next Due Date** and **Paid To Date** are stored as "Single line of text" in your SharePoint list. The formulas above use `DateValue()` to convert them. If these don't parse correctly, you may want to change those SharePoint columns to **Date and Time** type for more reliable date filtering.
- **Budget variable** (`varNDISBudget`) is set in App.OnStart. Change the value there to match your plan.
- The sidebar uses `App.ActiveScreen` to highlight the current page.
