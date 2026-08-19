# ROLE-BASED NATIVE PAGES ARCHITECTURE

## 1. PRIMARY RULE

The existing VisaFusion application's **role-based native pages architecture is an authoritative migration reference**.

Do not replace it with a generic CoreUI dashboard architecture.

CoreUI provides the:

- visual design system
- layout system
- component system
- navigation presentation
- responsive behavior
- interaction patterns

The existing VisaFusion role-based native-page architecture provides the:

- functional page structure
- role boundaries
- page ownership
- navigation hierarchy
- workflow organization
- permission boundaries
- role-specific dashboards
- role-specific actions
- role-specific menus
- role-specific page composition

The final architecture MUST combine both.

```text
Existing VisaFusion Role-Based Architecture
                    +
             CoreUI Design System
                    ↓
          Modern VisaFusion UI
```

---

# 2. DO NOT FLATTEN ROLE ARCHITECTURE

Do NOT create one generic application dashboard and expose all functionality through it.

Do NOT merge role-specific navigation.

Do NOT expose pages merely because they exist.

Do NOT remove role-specific pages because CoreUI provides a generic equivalent.

Do NOT redesign business workflows solely for visual consistency.

Role-specific native pages must remain role-specific unless an approved specification explicitly changes them.

---

# 3. DISCOVER EXISTING ROLE ARCHITECTURE

Before implementing CoreUI, inspect the complete existing application and identify:

- roles
- users
- permissions
- claims
- authorization rules
- role-specific navigation
- role-specific menus
- role-specific pages
- role-specific dashboards
- role-specific actions
- role-specific reports
- role-specific workflows
- role-specific forms
- role-specific tables
- role-specific landing pages
- role-specific redirects
- role-specific page access
- role-specific API access

Create:

docs/ui/ROLE_BASED_NATIVE_PAGES_INVENTORY.md

---

# 4. ROLE-PAGE MATRIX

Create a deterministic matrix:

| Role | Native Page | Route | Menu | Permission | Workflow | CoreUI Target | Status |
|---|---|---|---|---|---|---|---|

Every existing role-based native page must be accounted for.

Allowed statuses:

IMPLEMENTED
MAPPED
PARTIAL
BLOCKED
NOT_REQUIRED

UNKNOWN is not permitted after analysis.

---

# 5. ROLE-BASED NAVIGATION

The existing role-based navigation hierarchy is authoritative.

Map it to CoreUI Sidebar/Header/Navigation components.

Example conceptual model:

```text
Role
 ↓
Permission
 ↓
Navigation Group
 ↓
Menu
 ↓
Submenu
 ↓
Native Page
 ↓
Feature
 ↓
Workflow
```

Do not hard-code different navigation trees inside individual Razor pages.

Create a centralized role-aware navigation model.

---

# 6. ROLE-BASED APPLICATION SHELL

The CoreUI shell must support role-aware rendering.

Conceptually:

```text
VisaFusion Application Shell
│
├── Header
│
├── Role Context
│
├── Role-Aware Sidebar
│   ├── Menu Group
│   ├── Menu
│   └── Submenu
│
├── Breadcrumb
│
├── Page Header
│
├── Native Role Page
│
└── Footer
```

The shell is reusable.

The content and navigation are role-aware.

---

# 7. ROLE-SPECIFIC LANDING PAGES

Inspect existing role-specific landing/dashboard pages.

Do not replace them with a generic dashboard unless the approved specification explicitly requires it.

Instead:

```text
Existing Role Dashboard
        ↓
CoreUI Layout
        ↓
CoreUI Cards / Tables / Alerts / Charts
        ↓
Existing VisaFusion Data
```

CoreUI changes presentation.

VisaFusion determines what information is displayed.

---

# 8. ROLE-SPECIFIC PAGE MIGRATION

For every native role-based page:

1. Identify its role.
2. Identify its permission requirements.
3. Identify its route.
4. Identify its navigation location.
5. Identify its business workflow.
6. Identify its APIs/use cases.
7. Identify its database dependencies.
8. Identify its existing UI elements.
9. Map each UI element to CoreUI.
10. Preserve its functional behavior.
11. Preserve authorization.
12. Preserve validation.
13. Preserve workflow.
14. Apply CoreUI presentation.

Create a mapping:

```text
Native Role Page
       ↓
Feature Specification
       ↓
Role / Permission
       ↓
CoreUI Layout
       ↓
CoreUI Components
       ↓
Existing Business Workflow
       ↓
API / Application Use Case
       ↓
Database
```

---

# 9. ROLE-AWARE COMPONENTS

Reusable components must support role-aware behavior where required.

Examples:

- RoleAwareNavigation
- PermissionAwareMenu
- RoleAwarePageHeader
- PermissionAwareAction
- RoleAwareDashboard
- RoleAwareTableActions

Do not duplicate components for every role unless the behavior genuinely differs.

Prefer:

```text
One Component
      +
Role/Permission Configuration
```

instead of:

```text
AdminComponent
AgentComponent
ManagerComponent
UserComponent
```

unless separate implementations are justified by the existing architecture.

---

# 10. AUTHORIZATION RULE

UI visibility is NOT authorization.

CoreUI navigation must hide unauthorized functionality for usability.

However:

```text
UI visibility
      ≠
Authorization
```

Server-side authorization remains mandatory.

Every protected native page must retain server-side authorization.

Every protected API must retain server-side authorization.

Never rely on hiding a menu item as a security mechanism.

---

# 11. ROLE-BASED ROUTING

Inspect existing role-based routing and redirects.

Preserve:

- login redirects
- default landing pages
- unauthorized redirects
- access-denied behavior
- role-specific entry points
- post-login navigation
- workflow redirects

Map them to the modern ASP.NET Core architecture without changing behavior.

---

# 12. ROLE-BASED BREADCRUMBS

Breadcrumbs must reflect the actual role-specific navigation hierarchy.

Example:

```text
Role
 ↓
Module
 ↓
Feature
 ↓
Native Page
```

Do not generate arbitrary breadcrumbs from URL segments when the existing application has a meaningful navigation hierarchy.

---

# 13. ROLE-BASED PAGE LAYOUTS

Use CoreUI's layout system to represent the existing native-page hierarchy.

Possible structure:

```text
Role Shell
 ├── Header
 ├── Sidebar
 ├── Breadcrumb
 ├── Page Header
 ├── Main Content
 │    ├── Summary
 │    ├── Forms
 │    ├── Tables
 │    ├── Actions
 │    └── Details
 └── Footer
```

Do not force every native page into the same visual structure.

Use the CoreUI component system while preserving each page's functional composition.

---

# 14. ROLE-BASED KNOWLEDGE GRAPH

The AI-native Knowledge Graph MUST explicitly model role architecture.

Create nodes:

Role
Permission
Claim
NavigationGroup
Menu
SubMenu
NativePage
Dashboard
Workflow
Action
API
Feature
Component

Create relationships:

```text
ROLE
 ├── has_permission → PERMISSION
 ├── sees → NAVIGATION
 ├── accesses → PAGE
 ├── uses → FEATURE
 └── executes → WORKFLOW

NAVIGATION
 └── routes_to → PAGE

PAGE
 ├── implements → FEATURE
 ├── uses → COMPONENT
 ├── calls → API
 └── secured_by → PERMISSION
```

---

# 15. ROLE-BASED TRACEABILITY

Every role-based page must be traceable:

```text
Role
 ↓
Permission
 ↓
Navigation
 ↓
Page
 ↓
Feature
 ↓
Specification
 ↓
Application Use Case
 ↓
API
 ↓
Database
 ↓
Test
```

No orphan role page is permitted.

No orphan permission is permitted.

No orphan navigation item is permitted.

No orphan protected API is permitted.

---

# 16. ROLE-BASED TESTING

For every role verify:

- login
- landing page
- navigation
- menus
- submenu
- page access
- unauthorized access
- actions
- forms
- validation
- APIs
- reports
- logout

Create a role-based test matrix:

| Role | Page | Permission | Authorized | Unauthorized | Navigation | API | Test |
|---|---|---|---|---|---|---|---|

---

# 17. ROLE-BASED VISUAL VALIDATION

For every role:

1. Login as the role.
2. Verify landing page.
3. Verify header.
4. Verify sidebar.
5. Verify menus.
6. Verify submenu.
7. Verify breadcrumbs.
8. Verify native pages.
9. Verify actions.
10. Verify responsive behavior.
11. Verify unauthorized pages.
12. Verify logout.

Do not validate only with an administrator account.

Every supported role must be validated.

---

# 18. ROLE ARCHITECTURE PRESERVATION GATE

Before declaring CoreUI integration complete:

- [ ] Every role identified
- [ ] Every permission identified
- [ ] Every native role page identified
- [ ] Every role-based navigation item mapped
- [ ] Every role-specific landing page mapped
- [ ] Every role-specific workflow preserved
- [ ] Every protected route preserved
- [ ] Every protected API preserved
- [ ] Role-aware navigation implemented
- [ ] Role-aware breadcrumbs implemented
- [ ] Role-specific pages migrated
- [ ] Role-based tests implemented
- [ ] Knowledge Graph updated
- [ ] SpecKit updated
- [ ] Traceability complete

---

# 19. FINAL ARCHITECTURAL RULE

The modernization must produce:

```text
                 VisaFusion
                     │
          ┌──────────┴──────────┐
          │                     │
   Business Architecture    UI Architecture
          │                     │
   Existing Role Model       CoreUI
          │                     │
   Roles / Permissions      Components
   Workflows                Layouts
   Native Pages             Styling
   Navigation               Responsive UI
          │                     │
          └──────────┬──────────┘
                     │
             ASP.NET Core
                     │
          Clean Architecture
                     │
             Domain / App
                     │
             Infrastructure
                     │
                SQL Server
```

CoreUI must modernize the **presentation architecture**.

It must NOT replace the existing **role-based functional architecture**.

The final VisaFusion system must retain the existing role-based native-page model while providing a consistent, professional, responsive CoreUI-based experience.