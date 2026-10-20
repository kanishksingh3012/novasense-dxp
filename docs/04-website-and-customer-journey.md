# NovaSense — Website and customer journey

Status: proposed experience plan v1 for discussion, 2026-10-21. Audience confirmed: cycle awareness and understanding personal patterns. Website confirmed as a core product-family surface. This document specifies proposed behavior; it does not implement it.

## Experience structure

Discovery → product understanding → evaluation → purchase → preparation → activation → everyday understanding → support and return.

Visitors can move backwards, skip educational content, return later, or seek support at any point. The public website remains available to customers after purchase.

Three connected surfaces:

1. Public website: brand discovery, product education, evaluation, and purchase consideration.
2. Customer experience: order preparation, onboarding, and ongoing cycle awareness; responsive web is the proposed prototype format, with mobile layouts expressing the companion-app experience.
3. Admin studio: select a simulated visitor or customer, change relevant context, and inspect the resulting experience and its reason.

## Stage 1 — Discover the brand

- Person's question: What is NovaSense, and is this relevant to me?
- Entry: first visit to the homepage or a shared product page.
- Content elements: brand headline, patch and kit hero image, concise explanation, three concrete benefits, short how-it-works preview, and introductory FAQ.
- Primary action: Explore NovaSense.
- Secondary action: See how it works.
- Adaptation: show a complete default experience when nothing is known about the visitor. A self-selected interest can influence supporting copy later.
- Information needed: no personal or biological data. Optional current-session navigation events for the prototype.
- Next-stage signal: visitor opens product details or how-it-works content.
- Evaluation: a visitor can explain what the product is and who it serves after viewing the opening sections; track product-detail visits as a directional demo event, not proof of comprehension.

## Stage 2 — Understand the product

- Person's question: What does the patch do, and what would using it involve?
- Entry: product page or How it works.
- Content elements: patch detail image, illustrative wear context, kit contents, patch/app relationship, setup overview, sample insights labeled as demonstration data, and product limitations explained in plain language.
- Primary action: Explore the starter kit.
- Secondary action: View a sample experience.
- Adaptation: allow explicit choices such as “Understand my patterns” or “See everyday use” to expand the relevant explanation. Keep the complete product information accessible.
- Information needed: selected interest and viewed section, if available. Do not infer a health condition from browsing.
- Next-stage signal: visitor opens membership details or the starter-kit offer.
- Evaluation: kit contents, ongoing membership, and the purpose of the companion app are understandable without starting a quiz.

## Stage 3 — Evaluate fit and value

- Person's question: Does this fit my routine, and what am I committing to?
- Entry: starter-kit details, membership page, or returning to the offer.
- Content elements: what is included initially and over time, commercial terms once defined, recurring-cost explanation, practical FAQ, support options, and optional short preference finder.
- Primary action: Choose the starter kit.
- Secondary action: Ask a question / read FAQs.
- Adaptation: an explicit question about membership can reveal a relevant FAQ or explanation. Returning visitors may resume a selected kit when session context exists. Repeated visits alone do not justify urgency, discounts, or emotional assumptions.
- Information needed: selected kit and optional stated preference; no account required to read the offer.
- Next-stage signal: start checkout.
- Evaluation: the visitor can distinguish an initial kit purchase from a recurring service. Pricing, supply frequency, cancellation terms, and return policy are open product decisions, not invented facts.

## Stage 4 — Purchase

- Person's question: What will I pay, what happens next, and can I correct mistakes?
- Entry: selected starter kit.
- Content elements: order summary, explicit recurring-service terms, contact and shipping fields, validation, review step, and confirmation.
- Primary action: Place demo order.
- Secondary action: Edit order / return to product.
- Adaptation: preserve entered values after errors; use explicit selection to determine the order summary. Do not rearrange fields while a person is typing.
- Information needed: synthetic contact/address data and selected offering in the demonstration.
- Next-stage signal: successful simulated order creation. A button click alone is not a completed purchase.
- Evaluation: success, validation failure, and retry paths are clear; retries must not create duplicate orders.
- Prototype scope proposal: simulated checkout with no real charge or real payment-card collection. A live commerce integration is a separate scope decision.

## Stage 5 — Prepare for arrival

- Person's question: Where is my kit, and what can I do while I wait?
- Entry: confirmed order, before device activation.
- Content elements: order confirmation, delivery timeline, kit preview, preparation checklist, and optional introduction questionnaire.
- Primary action: Prepare for your patch.
- Secondary action: View order details / get delivery help.
- Adaptation: delivery progress determines the next preparation step. A returning signed-in visitor can see “View your order” on the public website; order details belong in their customer area.
- Information needed: order state and completed preparation steps.
- Next-stage signal: kit received and setup started.
- Evaluation: no charts imply readings exist before activation; delayed and missing-delivery states have a clear support path.

## Stage 6 — Activate and learn

- Person's question: Is it connected, and when will there be something to understand?
- Entry: kit received, setup started.
- Content elements: illustrative setup steps, simulated connection status, first check-in, baseline-learning explanation, and progress based on available demonstration data.
- Primary action: Complete setup; then add a check-in.
- Secondary action: Get setup help.
- Adaptation: disconnected → connection guidance; connected without sufficient data → learning state; sufficient demonstration data → patterns become available.
- Information needed: device status, onboarding completion, data availability, and check-ins.
- Next-stage signal: setup completed and enough simulated data for the chosen demonstration scenario.
- Evaluation: distinguish connection failure from normal learning time. Do not invent a clinically meaningful baseline duration.

## Stage 7 — Understand everyday patterns

- Person's question: What can I learn about my patterns today?
- Entry: active device and usable demonstration data.
- Content elements: plain-language daily summary, recent pattern visualization, check-in, explanatory captions, device freshness indicator, and access to history.
- Primary action: View your patterns.
- Secondary action: Add a check-in.
- Adaptation: support brief summaries and optional deeper detail according to explicit preference. Highlight an illustrative change only when backed by the current simulated scenario; explain why it is shown.
- Information needed: simulated observations, freshness, check-ins, and selected detail preference.
- Next-stage signal: continued use or an explicit request for help; inactivity alone does not establish emotional distress.
- Evaluation: a person can identify what changed, what is unknown, and how to inspect detail. Any proposed readiness score requires a separately defined explanation and calculation before inclusion.

## Stage 8 — Get support and return

- Person's question: Can I get help or restart without feeling behind?
- Entry: help request, setup difficulty, or return after a simulated period away.
- Content elements: concise welcome-back summary, resume action, optional check-in, device troubleshooting where relevant, and coach/support options.
- Primary action: Resume where you left off; use Resolve connection when device status is the actual obstacle.
- Secondary action: Talk to support / view coaching options.
- Adaptation: use the known obstacle to prioritize help. Keep charts and history reachable. Do not treat missing readings as disengagement or force an emotional check-in.
- Information needed: unresolved task, device status, available data, optional stated support need, and simulated recent activity.
- Next-stage signal: resumed activity, resolved issue, or completed simulated support booking.
- Evaluation: people can dismiss support suggestions, inspect their data, and return to the standard experience. Booking success requires a selected available slot and confirmation, not merely opening the booking panel.

## Proposed website information architecture

| Surface | Main content | Main action |
| --- | --- | --- |
| Home | Brand promise, product introduction, everyday value, how-it-works preview | Explore NovaSense |
| The patch / Starter kit | Product detail, imagery, kit contents, practical questions | Choose starter kit |
| How it works | Setup, observations, personal check-ins, sample experience | Explore starter kit |
| Membership | Initial vs ongoing offering, terms, cost explanation | Review offering |
| Learn | Introductory cycle-awareness content; editorial scope to be defined | Read an explanation |
| Support | FAQs, product assistance, contact options | Find help |
| Checkout | Review and simulated purchase | Place demo order |
| Customer area | Order, preparation, onboarding, patterns, settings | Contextual next step |
| Admin studio | Scenario controls, current context, resulting experience | Apply a scenario |

Proposed desktop navigation: Product, How it works, Membership, Learn, Support; utility action: Sign in; primary CTA: Explore the kit. Mobile preserves the same destinations with a compact menu. Final navigation labels and page grouping belong in wireframes.

Home section order proposal: hero → what NovaSense is → patch and app together → how it fits into a day → example patterns → kit and membership → FAQs → final exploration CTA. Use product explanations in place of fabricated testimonials or evidence.

## Adaptation model

The original five buckets mix purchase lifecycle, biological context, and engagement. Preserve them as convenient demo presets while using separate underlying context in the proposed model:

| Context | Example values | Role |
| --- | --- | --- |
| Identity | anonymous visitor, signed-in customer | Determines access to personal information |
| Lifecycle | browsing, evaluating, ordered, preparing, learning, active | Determines relevant next step |
| Device | none, shipping, connected, disconnected | Determines setup and connection guidance |
| Data availability | absent, learning, usable, stale | Determines whether observations can be presented |
| Engagement/support | ordinary, returning, help requested | Determines optional assistance |
| Explicit preference | overview, detail, selected topic | Determines presentation depth |
| Simulated cycle context | unknown or configured scenario | Supplies illustrative content inside the customer experience |

### Rule precedence

1. Respect access boundaries: a public visitor never receives personal readings or order information.
2. Respect the current task: retain navigation, active forms, focus, and entered values during updates. Do not redirect on every context change.
3. Check data availability: absent or stale readings cannot become fresh insights through a display-state override.
4. Choose the lifecycle-appropriate primary action: evaluation, order preparation, setup, or pattern exploration.
5. Add help for a concrete obstacle or stated need. Support is available alongside the primary experience.
6. Apply explicit presentation preferences and relevant illustrative cycle context.

Realtime changes should update appropriate modules without replacing the entire public website with a dashboard. In the admin demo, selecting a different simulated person is an explicit preview-context switch and may reset that preview's temporary form state with a visible explanation.

### Mapping the original presets

| Existing preset | Proposed interpretation |
| --- | --- |
| prospect | Public discovery or evaluation with no personal readings |
| pre_arrival | Confirmed order plus delivery/preparation content |
| stable_baseline | Active customer with usable data and an everyday summary |
| peak_phase | Detailed illustrative pattern exploration; fertility messaging is not the default for the confirmed audience |
| churn_risk | Returning/help scenario with optional support; preserve access to history and detail |

These are proposed revisions to the original brief. Resolve exact thresholds and preset names before schema implementation. For the first demo, explicit scenario controls can exercise the logic without inventing production prediction models.

## Demonstration scenarios

| Scenario | Admin changes | Expected visible result |
| --- | --- | --- |
| First-time visitor | Anonymous, browsing, no data | Brand and product discovery; no dashboard |
| Interested return visitor | Evaluating, starter kit selected | Resume kit evaluation; stable navigation and full product access |
| Recent purchaser | Signed in, confirmed order, shipping | Customer area shows delivery and preparation; public site offers order access |
| Learning customer | Connected, insufficient data | Baseline-learning explanation and check-in; no fabricated charts |
| Everyday customer | Connected, usable data, overview preference | Daily summary and optional detailed patterns |
| Curious customer | Usable data, detail preference | Expanded pattern explanation with access to the concise view |
| Customer with connection trouble | Disconnected, stale data | Connection guidance and timestamped history; no fresh-data implication |
| Returning customer | Return scenario, usable data | Resume summary and optional support; history remains accessible |

For each scenario, the admin should show input context, selected modules, primary action, and a short reason. Restore the preset to repeat a demonstration. Later implementation must scope preview selection to the demo session rather than switching every visitor globally.

## Next design work and open decisions

1. Refine packaging: user feedback says the first box is too simple. Explore a recognizable brand graphic, clearer panel hierarchy, and coordinated website imagery; keep the initial hero as v1.
2. Discuss this journey and the proposed changes to the original bucket behavior.
3. Define wireframes for Home, Product, Membership, and one customer-state screen first; these establish the website and product relationship.
4. Specify design-system foundations, then select established UI primitives and libraries against actual screen requirements.
5. Define demo pricing/terms, simulated metrics, coaching scope, and exact persistence requirements before data schemas.

No application scaffolding, native mobile build, production health inference, or external payment/booking integration is part of this planning deliverable.
