# NovaSense — Layout study 01

Completed for visual review: 21 October 2026. This is a local website layout prototype, not the full DXP implementation.

## Design direction

An editorial field journal: oversized serif type, an offset opening composition, narrow marginal annotations, a product photograph paired with a forest-green text panel, and a personal journal interaction. The layout changes rhythm between sections instead of repeating feature-card grids.

The packaging v2 uses an off-white contour graphic across its sage sleeve. Related line graphics appear on the site, giving the physical and digital experience a shared visual vocabulary. The wordmark and graphic are exploratory, not approved identity masters.

## Pages

- Home: opening statement → product introduction → brand idea → interactive sample journal → everyday-use story → kit invitation → FAQs.
- Product: editorial wear image → patch/kit/companion tabs → membership explanation → sample-journal invitation.
- Review: desktop (1440 px), tablet (768 px), and mobile (390 px) preview controls, with Home/Product selection. Frames scale to fit the review panel.

## Working interactions

- Navigation between pages and sections.
- Mobile menu, with dismissal on link selection and Escape.
- Three illustrative journal entries that change the note, summary, pattern, and active indicator.
- Product tabs with arrow-key, Home, and End handling.
- Native kit-details dialog, with close button and Escape handling.
- Native question and setup disclosures.
- Reduced-motion styling, visible focus indicators, and skip links.

## Verification performed

- Local server returned HTTP 200.
- Desktop and mobile layouts inspected in the browser using the review frame.
- Corrected a mobile heading wrap and product-image crop found during inspection.
- Journal entry switching verified at desktop and mobile widths.
- Product tab switching and right-arrow keyboard activation verified.
- Kit dialog opening and Escape dismissal verified.
- Mobile menu opening and closing after section selection verified.
- FAQ disclosure verified.
- JavaScript syntax checked; all three HTML pages checked for duplicate IDs, missing local assets, and broken local page/anchor references.

This is targeted layout/interaction verification, not a complete accessibility audit or cross-browser test suite. Tablet sizing is available for review but was not separately visually audited in this milestone.

## Implementation choices

Buildless HTML, CSS, and JavaScript keep this layout study independent of the eventual Next.js application. Standard controls use browser-native behavior. Font pairing is Newsreader with DM Sans for this study, a proposal that differs from the earlier Geist Sans direction. Fonts currently load from Google Fonts with system fallbacks.

The production component-library decision remains open. No paid tools, remote data collection, authentication, payment handling, database, or admin implementation was added.

## Review next

Discuss the layout's visual character, packaging direction, headline/copy, information hierarchy, and product-page content. Then extract agreed foundations into design tokens and reusable components before expanding customer states.

Image source files and exact built-in generation prompts are recorded in `docs/brand/04-layout-image-prompts.md`.
