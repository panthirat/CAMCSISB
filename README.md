# Auditorium Seating Planner (Apple HIG Edition + Supabase)

## Quick 3-Step Setup to Link Your Supabase Database

1. **Create a Supabase Project**
   - Go to [supabase.com](https://supabase.com), create a new project, and open **SQL Editor**.
   - Paste the contents of `supabase/schema.sql` and click **Run**.

2. **Copy Your Project Credentials**
   - In Supabase, go to **Project Settings -> API** (or **Connect**).
   - Copy your **Project URL** (`https://xxxx.supabase.co`) and **Anon / Publishable Key**.

3. **Connect the App (Choose Either Method)**
   - **Option A (In the Browser UI):** Open `index.html`, click the **`Local Mode`** pill button at the top-left, paste your **Project URL** and **Anon Key**, and click **Connect & Sync**.
   - **Option B (Hardcode for Team Deployment):** Paste your URL and Anon Key into `supabase-config.js` before hosting on Netlify, Vercel, or GitHub Pages.
