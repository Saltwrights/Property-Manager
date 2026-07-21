-- Run this once in Supabase > SQL Editor.
create table if not exists public.property_app_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.property_app_state enable row level security;

create policy "Users can read own property data"
on public.property_app_state for select
to authenticated using (auth.uid() = user_id);

create policy "Users can insert own property data"
on public.property_app_state for insert
to authenticated with check (auth.uid() = user_id);

create policy "Users can update own property data"
on public.property_app_state for update
to authenticated using (auth.uid() = user_id)
with check (auth.uid() = user_id);

create policy "Users can delete own property data"
on public.property_app_state for delete
to authenticated using (auth.uid() = user_id);

insert into storage.buckets (id, name, public)
values ('property-files', 'property-files', false)
on conflict (id) do nothing;

-- Each file path begins with the logged-in user's UUID.
create policy "Users can view own property files"
on storage.objects for select
to authenticated
using (bucket_id = 'property-files' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "Users can upload own property files"
on storage.objects for insert
to authenticated
with check (bucket_id = 'property-files' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "Users can update own property files"
on storage.objects for update
to authenticated
using (bucket_id = 'property-files' and (storage.foldername(name))[1] = auth.uid()::text)
with check (bucket_id = 'property-files' and (storage.foldername(name))[1] = auth.uid()::text);

create policy "Users can delete own property files"
on storage.objects for delete
to authenticated
using (bucket_id = 'property-files' and (storage.foldername(name))[1] = auth.uid()::text);

grant select, insert, update, delete on public.property_app_state to authenticated;
