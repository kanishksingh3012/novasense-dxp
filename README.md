# NovaSense

A fictional cycle-awareness brand and digital experience platform study. The project explores the public website, product discovery, and an adaptive customer experience.

## Current phase

Database foundation is prepared and tested locally. The existing website layout is an earlier study awaiting a substantial revamp. No hosted Supabase project, production application, admin panel, payments, or native mobile application is deployed.

Start with [the running project log](PROJECT-LOG.md) for confirmed decisions, current progress, and next steps.

## Run the layout preview

From the repository root:

```sh
python3 -m http.server 4173 --bind 127.0.0.1 --directory design-preview
```

Open `http://127.0.0.1:4173` for the homepage or `http://127.0.0.1:4173/product.html` for the product page. Stop the server with Ctrl+C.

Open `http://127.0.0.1:4173/review.html` for desktop/tablet/mobile sizing controls and page selection. See [layout review notes](docs/05-layout-review.md) for the design direction and verification performed.

The preview uses HTML, CSS, and JavaScript with no build step. Fonts load from Google Fonts with local serif/sans-serif fallbacks. Product photography is generated and saved locally. Journal entries and patterns are illustrative.

## Project map

- `PROJECT-LOG.md`: living progress and decision record.
- `docs/brand/`: brand foundation, product definition, asset direction, and exact image prompts.
- `docs/04-website-and-customer-journey.md`: proposed journeys and adaptation rules.
- `design-preview/`: responsive homepage and product layout study.
- `assets/brand/`: original generated concept images, retained by version.
- `supabase/migrations/` and `supabase/seed.sql`: database setup and synthetic data.
- `database-tests/`: reproducible embedded PostgreSQL checks.
- `docs/06-database-setup.md`: schema map, security model, and Supabase setup steps.
- `novasense_dxp_prd_and_claude_code_instructions.md`: original project brief.

## Milestone workflow

Update the running log as decisions change and work completes. Check affected layouts/interactions, commit completed milestones, and push them to the public repository. Keep proposals distinct from user-confirmed decisions.

## Concept scope

NovaSense is an imaginary brand. Images represent proposed product design; displayed patterns are simulated and do not establish sensor capabilities, medical accuracy, or clinical guidance. This preview does not collect payments or connect to real health data.
