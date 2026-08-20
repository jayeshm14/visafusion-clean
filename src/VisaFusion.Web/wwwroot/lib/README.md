# CoreUI Vendored Assets

## Source
- **Repository**: https://github.com/coreui/coreui-free-bootstrap-admin-template
- **Version**: v5.6.0
- **Commit**: d4003cd (2026-08-13)
- **License**: MIT (copyright 2026 creativeLabs Łukasz Holeczek)

## Vendored Assets

### CoreUI Free Bootstrap Admin Template
- **Package**: @coreui/coreui-free-bootstrap-admin-template v5.6.0
- **Source Commit**: d4003cd
- **Files**: Compiled CSS/JS from src/scss/style.scss and src/js/

### Vendor Dependencies (pinned versions from package.json)

| Package | Version | Purpose |
|---------|---------|---------|
| @coreui/coreui | ^5.9.0 | UI component library (CSS + JS) |
| @coreui/icons | ^3.1.0 | SVG icon set (cil-*, cib-*, cif-*) |
| @coreui/chartjs | ^4.2.0 | CoreUI-styled Chart.js helpers |
| @coreui/utils | ^2.0.2 | Utils (getStyle, rgbToHex) |
| chart.js | ^4.5.1 | Charts engine |
| simplebar | ^6.3.3 | Custom scrollbars |

### Vendored Files Structure

`
wwwroot/lib/coreui/
├── js/
│   ├── config.js           # Theme URL param → localStorage
│   ├── color-modes.js      # Light/dark/auto switcher
│   ├── tooltips.js         # Auto-init tooltips (excluded from bundle)
│   ├── popovers.js         # Auto-init popovers (excluded from bundle)
│   ├── toasts.js           # Toast init
│   └── main.js             # Chart init
├── vendors/
│   ├── coreui.min.css      # @coreui/coreui compiled CSS
│   ├── coreui.bundle.min.js # @coreui/coreui compiled JS
│   ├── simplebar.min.css   # simplebar CSS
│   ├── simplebar.min.js    # simplebar JS
│   ├── chart.umd.min.js    # chart.js
│   ├── coreui-chartjs.min.css # @coreui/chartjs CSS
│   ├── coreui-chartjs.min.js  # @coreui/chartjs JS
│   └── coreui-utils.min.js    # @coreui/utils JS
├── fonts/                  # Font files (if any)
└── README.md               # This file
`

### Application Assets

`
wwwroot/
├── css/
│   ├── vf-coreui.css       # VisaFusion --cui-* token overrides
│   └── vf-component-styles.css # VisaFusion component + shell styles
├── js/
│   └── vf-coreui.js        # Bundled CoreUI JS behaviors
├── icons/
│   ├── cil/                # CoreUI free icons
│   └── cif/                # CoreUI flag icons
└── lib/coreui/             # Vendored CoreUI assets (this folder)
`

## Version Pinning

All versions pinned to match CoreUI Free Admin Template v5.6.0 (commit d4003cd) package.json:

- @coreui/coreui: ^5.9.0
- @coreui/icons: ^3.1.0
- @coreui/chartjs: ^4.2.0
- @coreui/utils: ^2.0.2
- chart.js: ^4.5.1
- simplebar: ^6.3.3

## Adoption Path

Path (b) per COREUI_DEPENDENCY_MAP.md §9: Vendored static copies of pinned dist files committed to wwwroot/ (no node toolchain in .NET pipeline).

## Excluded Assets

- Demo-only content: examples.scss, charts.js, widgets.js, style.scss, simplebar.scss (removed 2026-08-20, SPEC-0009 T085)
- PRO components: External links to PRO versions
- Build toolchain: pug, sass, postcss, eslint, stylelint, prettier, etc.
- node_modules/ (not committed)

## Verification

Run CoreUIAssetTests (TS-001) to verify:
- All assets present in wwwroot/
- No CDN references in .cshtml files
- No demo/PRO content included
- Icon set scope matches VisaFusion usage
