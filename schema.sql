-- ============================================================================
-- Auditorium Seating Planner — Supabase PostgreSQL + Realtime Schema
-- Run this entire script in your Supabase Dashboard -> SQL Editor -> New Query
-- ============================================================================

-- 1. Create the main table for storing auditorium event seating layouts
create table if not exists public.auditorium_events (
  id text primary key,
  event_name text not null unique,
  seat_data jsonb not null default '{}'::jsonb,
  extra_seat_list jsonb not null default '[]'::jsonb,
  balcony_seat_list jsonb not null default '{"L": [], "R": []}'::jsonb,
  walkway_seat_list jsonb not null default '[]'::jsonb,
  updated_at timestamptz not null default now()
);

-- 2. Automatically update `updated_at` whenever a layout is modified
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

drop trigger if exists trg_auditorium_events_updated_at on public.auditorium_events;
create trigger trg_auditorium_events_updated_at
before update on public.auditorium_events
for each row execute function public.set_updated_at();

-- 3. Enable Row Level Security (RLS) with open policy for event coordinators
alter table public.auditorium_events enable row level security;

drop policy if exists "Allow full access to auditorium_events" on public.auditorium_events;
create policy "Allow full access to auditorium_events"
on public.auditorium_events
for all
using (true)
with check (true);

-- 4. Enable Realtime replication so live changes sync across all open browsers
do $$
begin
  if not exists (
    select 1
    from pg_publication_tables
    where pubname = 'supabase_realtime'
      and schemaname = 'public'
      and tablename = 'auditorium_events'
  ) then
    alter publication supabase_realtime add table public.auditorium_events;
  end if;
end $$;
