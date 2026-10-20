# NovaSense — Image and asset direction

Status: v1 concept exploration. Use the built-in image generation tool. Generated imagery is fictional product visualization.

## Generated candidate

- File: `assets/brand/novasense-product-hero-v1.png`
- Generation method: built-in image generation tool; exact prompt below.
- Visual review: wordmark and Starter Kit label are legible; one patch and one carton; adhesive perimeter, indicator dot, restrained materials, and clear left-side space match the brief. Suitable for discussing the physical direction. The carton is a folded paperboard interpretation rather than an explicit sleeve construction; resolve construction in the kit detail image after discussion. No engineering dimensions can be inferred from the photograph.
- Status: review candidate, not an approved master reference.

## Consistency workflow

1. Generate a canonical product photograph from the product definition.
2. Inspect geometry, materials, branding, and text.
3. Discuss the physical direction before generating a large asset family.
4. Use the selected image as an explicit product reference for later variations. Preserve patch shape, thickness, seam, indicator, adhesive perimeter, and packaging colors.
5. Save each selected image in the project with a versioned filename and its prompt. Never replace a selected image silently.
6. Generate each distinct asset separately. Do not crop an asset board into supposed production photographs.

The first image is a concept candidate; subsequent reference-based assets follow after discussion. The product specification is the source of truth if generation drifts.

## Asset inventory

| Asset | Purpose | Composition | Status |
| --- | --- | --- | --- |
| Product hero v1 | Review product and packaging direction | Wide, product on right, left clear | Generated; awaiting discussion |
| Patch cutout | Reusable product card asset | Single patch, true transparency | After product direction accepted |
| Starter kit flat lay | Explain kit contents | Carton, tray, guide, pouch | After kit contents accepted |
| Wear context | Establish scale and discretion | Upper arm detail, natural setting | After placement direction accepted |
| Material detail | Show build and texture | Macro of patch and adhesive edge | After product direction accepted |
| Editorial lifestyle | Give the brand a human setting | Ordinary calm moment, no outcome claims | After audience discussion |

Do not generate app screenshots before the screen structure is agreed. Real logo masters, icons, typography, and interface text should be vector or native UI assets rather than baked into generated photographs.

## Exact prompt — product hero v1

```text
Use case: product-mockup
Asset type: fictional wearable brand product hero, first concept candidate
Primary request: Create a photorealistic premium but approachable product photograph for NovaSense, an imaginary cycle-awareness wearable brand. This is a physical product visualization, not a website mockup or a brand board.
Scene/backdrop: seamless warm off-white plaster studio surface and background, color #F9F8F6, very subtle real material texture.
Subject: one discreet wearable patch resting in front of a closed small sage-green rectangular starter-kit carton. The patch is a softly rounded oval approximately 34 mm wide and 26 mm tall, with a thin warm sand adhesive perimeter extending evenly around a smaller matte off-white oval sensor housing. Housing about 4 mm high, smooth bevel, understated seam, one tiny slate-blue indicator dot near one end. No screen, buttons, exposed electronics, or glowing lights. Carton has a subtle paper texture, sage #A3B19B, small charcoal lettering.
Style/medium: credible industrial-design studio photography, tactile materials, restrained editorial art direction, realistic geometry and shadows.
Composition/framing: wide landscape frame, camera at a gentle elevated three-quarter angle; patch and carton grouped in the right half with plenty of uncluttered negative space in the left half for future live webpage copy; believable small wearable scale; all objects fully inside the frame. The patch is the focus and its adhesive edge is visible.
Lighting/mood: soft broad daylight from upper left, warm and composed, delicate contact shadows, no dramatic spotlight or haze.
Color palette: plaster #F9F8F6, sage #A3B19B, sand #D3BBA5, slate #697A8D, charcoal #333333.
Text (verbatim): carton front only: "NovaSense" and below it "Starter Kit". No other text anywhere.
Constraints: one patch, one closed carton, no phone or app UI, no person, no flowers, no stones, no medical badges, no clinical claims, no watermark, no decorative overlaid typography. Keep carton typography modest and precise. Product should feel like a considered everyday health device rather than a cosmetic jar or futuristic gadget.
```

## Review checklist

- Patch silhouette and adhesive perimeter match the canonical definition.
- Carton reads NovaSense / Starter Kit without additional invented claims.
- Objects have plausible scale and consistent lighting.
- Palette stays warm and restrained.
- Left-side negative space remains useful for future layouts.
- Inspect the generated image before treating it as a selected production asset.
