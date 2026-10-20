# NovaSense — Product definition

Status: fictional product concept v1. All physical specifications below are design assumptions, not validated engineering specifications.

Audience confirmed on 2026-10-21: cycle awareness and understanding personal patterns. The proposed product value is to bring cycle observations and personal check-ins together, explain patterns over time, and make daily reflection approachable. Detailed features and adaptation rules will be defined in the next phase.

## Product family

| Product | Role | Proposed contents |
| --- | --- | --- |
| NovaSense Website | Brand discovery and product evaluation | Brand story, product details, how it works, membership information, FAQs, and purchase journey |
| NovaSense Starter Kit | Initial physical product | One demonstration patch, application guide, sealed patch tray |
| NovaSense App | Customer companion | Simulated trends, check-ins, explanations, device connection status |
| NovaSense Membership | Recurring service concept | App access and ongoing patch supply; frequency and pricing undecided |
| NovaSense Coaching | Optional human support concept | Booking flow; service scope and qualifications remain to be defined |

## Experience surfaces

The website is a primary project surface, including visitors who have not purchased or created an account. Its proposed role is to introduce the brand, explain the patch and membership, help visitors evaluate fit, and support purchase consideration. Exact pages, checkout scope, and personalization rules will be agreed during journey mapping.

The customer app supports ongoing use through observations, check-ins, and explanations. Whether the prototype represents this as responsive authenticated web screens, mobile app designs, or both remains undecided; mentioning a mobile app does not establish a separate native application build.

The admin panel controls the demonstration context across the agreed website and customer experiences. Anonymous visitor context and known customer context will need separate consideration during data and adaptation planning.

Do not assume the consumer needs a charger, hub, applicator, or removable transmitter. These would require explicit product decisions and a revised asset reference.

## Canonical patch appearance

- A small, softly rounded oval patch, approximately 34 mm wide and 26 mm tall for visual scale only.
- Thin sand-colored adhesive perimeter, with a smaller matte off-white oval sensor housing centered above it.
- Housing about 4 mm high as a visual assumption; smooth bevel, understated seam, no screen, no buttons, no exposed electronics.
- Tiny slate-blue indicator dot near one end; no animated glow.
- No printed hormone values or clinical labels on the device.
- Product imagery may show upper-arm placement as an illustrative concept. Placement, wear duration, water resistance, insertion method, and replacement schedule are not validated.

## Canonical packaging

- Small rectangular rigid carton, soft sage outer sleeve, warm off-white inner tray.
- Charcoal “NovaSense” wordmark on the sleeve, with “Starter Kit” as the only secondary front-facing label.
- One patch in a shallow molded tray. Guide and pouch appear only when a dedicated kit composition is requested.
- Paper textures are subtle and clean. Avoid luxury perfume styling, cosmetic jars, and decorative botanical props.

## What the prototype represents

The original brief imagines continuous hormone and metabolic monitoring. The prototype can tell that fictional story, but readings must be labeled as simulated. No real sensor integration or medical interpretation is established.

Before data modeling, define the exact simulated metrics, units, cadence, reference explanations, and missing-data behavior. Do not invent validated hormone ranges, fertility thresholds, accuracy percentages, or diagnosis logic to fill interface space.

The app’s proposed role is to organize observations, explain the fictional demonstration data, and help someone decide what to explore next. A coach booking represents support; it must not imply medical diagnosis.

## Scope boundaries for this phase

Planning progress: the next-phase website and customer journey proposal is now recorded in `docs/04-website-and-customer-journey.md`. The scope below describes the original brand deliverable; detailed UI and implementation work remain pending.

Included: brand narrative, product family, physical art direction, initial generated image, reusable asset prompts, open decisions.

Deferred: customer journey, adaptation priorities, screen inventory, design system components, UI library selection, schema design, authentication, admin panel, realtime integration, payment or booking integrations.

## Reuse policy for implementation

Use established libraries for accessible UI primitives, forms, tables, charts, icons, and motion. Apply NovaSense’s own typography, tokens, imagery, and content above them. Select and verify the exact library stack when the screen and interaction requirements are defined; do not install dependencies during brand exploration.
