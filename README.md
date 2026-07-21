# Property Manager

A lightweight, mobile-friendly property management app using the same basic structure as the Saltwrights app:

- One static `index.html` file, suitable for GitHub + Netlify
- Supabase email/password login
- One private JSON app-state record per user
- Private Supabase Storage for photos and documents
- No build process or npm installation

## Set up

1. Create a new Supabase project.
2. Open **SQL Editor**, paste in `schema.sql`, and run it once.
3. In Supabase, copy the **Project URL** and **Publishable/anon key**.
4. Open the deployed app and enter those values on the connection screen.
5. Sign up with your email and password. Depending on your Supabase Auth settings, you may need to confirm your email.
6. Upload `index.html` to a GitHub repository and deploy that repository on Netlify.

Never put a Supabase secret or service-role key into this app. Use only the browser-safe publishable/anon key.

## Main sections

- **Home:** portfolio summary, upcoming/overdue legal checks, and rapid issue logging
- **Properties:** address, ownership notes, rent, mortgage, insurance and property photos
- **Tenants:** contact details, tenancy dates, deposit information and emergency contact
- **Issues:** property-linked maintenance log with priority, status, cost, contractor and photos
- **Legal:** gas safety, EICR, EPC, insurance, smoke/CO checks and custom records
- **Files:** photos/documents grouped against a property
- **Settings:** Supabase connection, export/import backup, sign out

## Data and security

Row Level Security limits the app-state record and uploaded files to the logged-in user. Files are stored in a private bucket and opened using short-lived signed URLs.

## Added in version 2
- Add as many properties as needed using **Properties > Add property**.
- Keep a dated note/activity history for every property (email, phone call, visit, contractor, letter or general note).
- Log rent received, rent paid and property expenses with historic dates.
- Filter money records by month and property, then download either a CSV or a formatted HTML monthly statement.
- Historic legal records are supported: add each old gas safety, EICR, EPC or other certificate as a separate record using its original completed and expiry dates.

Existing Supabase projects do not need a database migration because the app stores these new sections inside the existing JSON record.
