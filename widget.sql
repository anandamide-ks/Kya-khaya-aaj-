-- Berry Blast iPhone widget: run once in Supabase > SQL Editor > New query.  anandamide.ks
-- A private copy of your cycle summary for the widget. Only you can read or change it;
-- partners never see it, and it holds no symptoms, notes or sexual activity.
create table if not exists public.widget_state (
  owner_id   uuid primary key references auth.users (id) on delete cascade,
  summary    jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.widget_state enable row level security;
revoke all on public.widget_state from anon;
grant select, insert, update, delete on public.widget_state to authenticated;
drop policy if exists "owner only" on public.widget_state;
create policy "owner only" on public.widget_state
  for all to authenticated
  using (owner_id = auth.uid())
  with check (owner_id = auth.uid());
