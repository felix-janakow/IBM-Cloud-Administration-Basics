# TTA-Advantage

IBM Cloud Administration Basics Workshop

## Repository Structure

```
TTA-Advantage/
├── docs/                          # GitHub Pages content
│   ├── index.md                   # Main workshop page (bilingual EN/DE)
│   ├── _config.yml                # Jekyll configuration
│   └── screenshots/               # All workshop screenshots
├── basics-instructions/           # Additional instruction materials
├── drafts/                        # Work in progress (excluded from git)
└── README.md                      # This file
```

## GitHub Pages Setup

This repository uses the `/docs` folder for GitHub Pages.

### Configuration Steps:

1. Go to your GitHub repository settings
2. Navigate to **Pages** section
3. Under **Source**, select:
   - Branch: `main`
   - Folder: `/docs`
4. Click **Save**

The site will be published at: `https://[username].github.io/TTA-Advantage/`

### Local Development

To test the site locally:

```bash
cd docs
bundle install
bundle exec jekyll serve
```

Then open `http://localhost:4000/TTA-Advantage/` in your browser.

## Content

The workshop covers:
- IBM Cloud Portal basics
- Multi-Factor Authentication (MFA)
- Resource Groups
- Identity and Access Management (IAM)
- Billing and Usage
- Enterprise Accounts
- Best Practices

## Language Support

The workshop content is available in both English and German with a language toggle button.

## Author

Felix Janakow (felix.janakow@ibm.com)