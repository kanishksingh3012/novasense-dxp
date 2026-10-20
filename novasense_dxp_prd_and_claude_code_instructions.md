# NovaSense DXP Prototype - Agent Instructions

## Context

You are tasked with building a functional Digital Experience Platform (DXP) prototype for a dummy brand called **NovaSense**. NovaSense is a continuous hormone and metabolic monitoring platform (a hardware wearable patch + software subscription). 

The goal of this prototype is to demonstrate "Contextual Churn Prevention." The platform must dynamically change its UI based on real-time biological and behavioral data controlled via a separate admin panel.

## Architecture & Tech Stack

* **Framework:** Next.js (App Router)
* **Styling:** Tailwind CSS
* **Animations:** Framer Motion
* **Database / Real-time Backend:** Supabase (PostgreSQL + Realtime WebSockets)
* **Data Visualization:** Recharts
* **Dummy Data Generation:** `@faker-js/faker`

## Brand Identity: "Clinical Earth"

The UI must feel clinical yet warm, deeply empathetic, and trustworthy. Avoid all hyper-vibrant or aggressive "tech-bro" colors. Use a dual-typography system: a modern Serif (e.g., Newsreader or Playfair Display) for empathetic headings, and a clean Sans-Serif (e.g., Inter or Geist) for UI and data.

**Tailwind CSS Configuration Requirements:**
Please extend the Tailwind theme with these exact colors:
* `background`: `#F9F8F6` (Off-white, soft plaster texture for all main backgrounds)
* `sage-green`: `#A3B19B` (Used for stable/healthy states and primary accents)
* `warm-sand`: `#D3BBA5` (Used for baseline, waiting states, or muted UI)
* `slate-blue`: `#697A8D` (Used for clinical data lines and secondary typography)
* `charcoal`: `#333333` (Used for primary text; strictly avoid pure black)

**Data Visualization Rules (Recharts):**
* No sharp, jagged lines. Use smooth Bezier curves (`type="monotone"`).
* Use Area charts (`<AreaChart>`) with semi-transparent gradient fills instead of thin line charts.
* Use Glassmorphism (backdrop-blur) for overlays when a user is in a "Churn Risk" state to reduce cognitive load.

## 1. Database Schema (Supabase)

The backbone of this DXP is the `users` table. The UI adapts based on the `dxp_bucket`.

```sql
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS users (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  full_name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  avatar_url TEXT,
  
  -- DXP Lifecycle State (The 5 Buckets)
  dxp_bucket TEXT NOT NULL CHECK (
    dxp_bucket IN ('prospect', 'pre_arrival', 'stable_baseline', 'peak_phase', 'churn_risk')
  ),
  
  -- Hardware & Sensor Data
  hardware_status TEXT NOT NULL CHECK (
    hardware_status IN ('none', 'shipping', 'active', 'disconnected')
  ),
  
  -- Biological State
  biological_phase TEXT CHECK (
    biological_phase IN ('unknown', 'baseline', 'fertile_window', 'luteal_wait', 'menstruation')
  ),
  
  -- Behavioral Attributes
  last_login_hours INT DEFAULT 0,
  primary_goal TEXT CHECK (
    primary_goal IN ('discovery', 'ttc', 'pcos_management', 'biohacking')
  ),
  
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Enable Realtime for the client app to listen to changes
ALTER PUBLICATION supabase_realtime ADD TABLE users;
```

## 2. DXP States & Expected UI Behaviors

When the `dxp_bucket` changes in the database, the client-facing UI (`/`) must instantly adapt:

1. **`prospect` (Anonymous/Discovery):** 
   * **UI:** Show a Hormone Assessment Quiz, hardware imagery, and a "Buy Starter Kit" CTA. No dashboard UI.
2. **`pre_arrival` (Onboarding):** 
   * **UI:** Show a shipping tracker, patch application video placeholders, and a cycle baseline questionnaire. Hide all data charts.
3. **`stable_baseline` (Habitual):** 
   * **UI:** Show a calm "Daily Readiness Score" and basic lifestyle nudges. Use `sage-green` tones heavily.
4. **`peak_phase` (High Intent):** 
   * **UI:** Show high-density clinical charts (Recharts), peak fertility alerts, and urgent CTAs. Use `slate-blue` for precise data representation.
5. **`churn_risk` (Disengaged):** 
   * **UI:** Hide raw charts entirely using a frosted glass blur overlay. Show muted/soft UI (`warm-sand` tones), an emotional check-in form, and a 1-click "Book a Coach" button.

## 3. Step-by-Step Execution Plan

**Agent, please execute the following steps sequentially. Pause and confirm after each major phase.**

### Phase 1: Environment Setup
1. Initialize the Next.js project with Tailwind CSS.
2. Install dependencies: `@supabase/supabase-js`, `framer-motion`, `recharts`, `@faker-js/faker`, `lucide-react`.
3. Update `tailwind.config.ts` with the "Clinical Earth" custom colors specified above.
4. Set up the routing structure:
   * `app/(client)/page.tsx` -> The dynamic user-facing app.
   * `app/(admin)/admin/page.tsx` -> The DXP control panel.
   * Create separate layout files for both route groups to ensure the admin panel styling doesn't leak into the client app.

### Phase 2: Supabase Integration & Seeding
1. Create `lib/supabaseClient.ts` to initialize the Supabase client using environment variables.
2. Create a setup/seed script (`scripts/seed.ts`) that uses Faker.js to generate 50 mock users distributed across the 5 `dxp_bucket` states (10 prospect, 10 pre_arrival, 15 stable_baseline, 10 peak_phase, 5 churn_risk). 
3. Run the script to populate the Supabase `users` table.

### Phase 3: The DXP Control Panel (`/admin`)
1. Build a dashboard layout with a sidebar.
2. Create a data table displaying the 50 seeded users.
3. Add clickable filter pills to filter users by `dxp_bucket`.
4. **Crucial Feature:** Add an "Impersonate & Edit" modal. When an admin clicks a user, they can manually change that user's `dxp_bucket`, `hardware_status`, and `biological_phase` via dropdowns, which triggers a Supabase `UPDATE`. 
5. Add a master toggle/button that says "Set as Active Demo User" (this writes to a separate state or table so the client side knows which specific user's data to display).

### Phase 4: The Reactive Client UI (`/`)
1. Create a React hook `useDXPUser()` that listens to Supabase Realtime for changes to the currently "Active Demo User".
2. Build the dynamic dashboard in `app/(client)/page.tsx`.
3. Use a Switch statement or component mapping based on the user's `dxp_bucket` to render the 5 specific UI layouts detailed in Section 2.
4. Implement `<AnimatePresence>` from Framer Motion so the layout shifts fluidly when the admin changes the user's bucket in real-time.