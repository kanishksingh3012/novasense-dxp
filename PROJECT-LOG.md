# NovaSense — Running project log

Last updated: 21 October 2026 · Current phase: website layout exploration

This is the living record of progress and decisions. Update at meaningful milestones, when the user changes direction, and before each work handoff. Record confirmed decisions separately from proposals. Dates use Asia/Kolkata.

## Current status

**Ready for review:** a local, interactive homepage and product-page layout prototype. The direction is editorial and asymmetrical, using distinctive typography, product photography, a recurring contour motif, and a sample journal interaction. Desktop and mobile layouts and core interactions have been checked.

**Next:** review the visual direction with the user before extracting the design system and expanding the application. The initial milestone has been pushed to the public repository.

## Confirmed decisions

| Decision | Source / date |
| --- | --- |
| Establish brand and product, then journeys and rules, then UI system/components and data/admin planning before full implementation. | User, 21 Oct 2026 |
| Use established libraries where appropriate instead of recreating standard UI infrastructure. | User, 21 Oct 2026 |
| Primary audience: cycle awareness and understanding personal patterns. | User selection, 21 Oct 2026 |
| The public website is a core UX focus, including visitors discovering and evaluating the brand. | User, 21 Oct 2026 |
| Include NovaSense Website explicitly in the product family. “Family” did not mean a family-oriented audience. | User clarification, 21 Oct 2026 |
| The first packaging image looks too simple and needs stronger branding. | User feedback, 21 Oct 2026 |
| The website layout must be unconventional and visually distinctive. | User, 21 Oct 2026 |
| Maintain this running document beside the work and update it regularly. | User, 21 Oct 2026 |
| Create a public GitHub repository and push ongoing completed work. | User, 21 Oct 2026 |

## Working proposals — not yet confirmed

- Brand line: “A clearer sense of your cycle.”
- Clinical Earth identity: plaster, sage, sand, slate, and charcoal; editorial serif plus clean interface typography. Inherited from the initial brief and developed into a proposal.
- Small oval patch, sage kit packaging, companion app, membership, optional coaching.
- Website direction: a field-journal feel, asymmetrical compositions, generous typography, product close-ups, and a contour graphic shared with packaging.
- Website navigation: Product, How it works, Membership, Learn, Support. The layout prototype may group destinations into page sections while content scope is refined.
- Separate lifecycle, device, data availability, and support context; retain the original five buckets as demonstration presets.
- Keep data/history accessible during support scenarios; prioritize relevant help without forcing an emotional check-in.
- Prototype checkout will be simulated; pricing, commercial terms, and sensor metrics are undecided.

## Progress ledger

| Date | Work | Status / result |
| --- | --- | --- |
| 21 Oct | Read the project folder and original PRD | Complete. One original Markdown file found. |
| 21 Oct | Draft brand foundation and product definition | Complete as proposals; primary audience subsequently confirmed. |
| 21 Oct | Generate first product photograph | Complete. Saved as product hero v1; packaging requires refinement. |
| 21 Oct | Add website to experience scope and product family | Complete. |
| 21 Oct | Draft website/customer journey and adaptation proposal | Complete for discussion; no database or application implementation. |
| 21 Oct | Develop unconventional homepage and product layout | Complete for review. Local visual prototype with desktop/tablet/mobile review controls. |
| 21 Oct | Generate refined packaging and editorial wear imagery | Complete. Product hero v2 and editorial wear v1 saved with exact prompts; earlier assets preserved. |
| 21 Oct | Establish running project log | Complete; opened beside the work. |
| 21 Oct | Create public GitHub repository | Complete: https://github.com/kanishksingh3012/novasense-dxp. Visibility verified as PUBLIC; default branch is main. |
| 21 Oct | Verify layout and interactions | Complete. Desktop/mobile inspection; navigation, journal, tabs/keyboard, dialog, and FAQ checks passed. Fixed mobile headline wrap and image cropping. Local asset/link and JS syntax checks passed. |
| 21 Oct | Push initial milestone | Complete. Commit `72d2176` pushed to `origin/main`: brand, journey, generated assets, responsive layout study, and running log. |

## Current deliverables

- [Original project brief](novasense_dxp_prd_and_claude_code_instructions.md)
- [Brand foundation](docs/brand/01-brand-foundation.md)
- [Product definition](docs/brand/02-product-definition.md)
- [Asset direction and first image prompt](docs/brand/03-asset-direction.md)
- [Website and customer journey](docs/04-website-and-customer-journey.md)
- [First product image](assets/brand/novasense-product-hero-v1.png)
- [Homepage layout source](design-preview/index.html)
- [Product layout source](design-preview/product.html)
- [Desktop/tablet/mobile review](design-preview/review.html)
- [Layout review notes and verification](docs/05-layout-review.md)
- [New image prompts and review](docs/brand/04-layout-image-prompts.md)
- Public repository: https://github.com/kanishksingh3012/novasense-dxp

## Source-control workflow

Visibility is public, as explicitly requested. Update this log at meaningful milestones, check affected work, commit a cohesive change, and push it to the repository. Preserve secrets and local machine files through `.gitignore`. Public source publication and hosted website deployment are separate actions; no hosted website has been deployed in this milestone.

Local review while the server is running: http://127.0.0.1:4173/review.html. Use the review controls to switch between pages and desktop/tablet/mobile widths. Restart instructions are in README.md.

## Open design/product decisions

1. Review the new visual direction and refined packaging.
2. Finalize product contents, membership structure, and commercial copy.
3. Review proposed adaptation behavior and the original five-state model.
4. Define simulated metrics and their explanations before creating charts or schemas for the actual product.
5. Confirm the prototype's customer-area/mobile scope before application implementation.

## Implementation boundary

Current work is a local layout study with browser-local interactions. Production authentication, database, admin console, checkout, coaching integration, and a native mobile app have not been built. No hosted site has been published.
