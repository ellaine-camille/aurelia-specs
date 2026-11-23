-- Aurelia MVP database snapshot v1.0.0
-- Target: Supabase PostgreSQL
-- Idempotent full snapshot: safe to execute repeatedly on an initialized database.

create extension if not exists pgcrypto;

do $$ begin
  create type public.account_role as enum ('system_admin','barangay_admin','health_worker','resident');
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.appointment_status as enum ('pending','approved','declined','cancelled','completed');
exception when duplicate_object then null;
end $$;

do $$ begin
  create type public.queue_entry_status as enum ('waiting','serving','served','cancelled','skipped');
exception when duplicate_object then null;
end $$;

create table if not exists public.account (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  auth_user_uuid uuid unique,
  role public.account_role not null default 'resident',
  display_name text,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create index if not exists idx_account_auth_user on public.account(auth_user_uuid) where archived_at is null;

create table if not exists public.barangay_center (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  name text not null,
  address text,
  barangay text,
  municipality text,
  contact_number text,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create index if not exists idx_barangay_center_location on public.barangay_center(barangay, municipality) where archived_at is null;

create table if not exists public.health_service (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  name text not null,
  description text,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);

create table if not exists public.center_service (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  center_uuid uuid not null,
  service_uuid uuid not null,
  is_available boolean not null default true,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create unique index if not exists idx_center_service_live
  on public.center_service(center_uuid, service_uuid) where archived_at is null;
create index if not exists idx_center_service_center on public.center_service(center_uuid) where archived_at is null;
create index if not exists idx_center_service_service on public.center_service(service_uuid) where archived_at is null;

create table if not exists public.center_schedule (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  center_uuid uuid not null,
  service_uuid uuid,
  day_of_week smallint not null check (day_of_week between 0 and 6),
  opens_at time,
  closes_at time,
  valid_from date,
  valid_until date,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz,
  check (opens_at is null or closes_at is null or opens_at < closes_at)
);
create index if not exists idx_center_schedule_center on public.center_schedule(center_uuid) where archived_at is null;
create index if not exists idx_center_schedule_service on public.center_schedule(service_uuid) where archived_at is null;

create table if not exists public.announcement (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  center_uuid uuid,
  title text not null,
  body text not null,
  published_at timestamptz,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create index if not exists idx_announcement_center on public.announcement(center_uuid) where archived_at is null;
create index if not exists idx_announcement_published on public.announcement(published_at desc) where archived_at is null;

create table if not exists public.staff_assignment (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  account_uuid uuid not null,
  center_uuid uuid not null,
  role public.account_role not null check (role in ('barangay_admin','health_worker')),
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create unique index if not exists idx_staff_assignment_live
  on public.staff_assignment(account_uuid, center_uuid) where archived_at is null;
create index if not exists idx_staff_assignment_account on public.staff_assignment(account_uuid) where archived_at is null;
create index if not exists idx_staff_assignment_center on public.staff_assignment(center_uuid) where archived_at is null;

create table if not exists public.appointment_request (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  resident_account_uuid uuid not null,
  center_uuid uuid not null,
  service_uuid uuid not null,
  requested_at timestamptz,
  status public.appointment_status not null default 'pending',
  staff_note text,
  approved_by uuid,
  approved_at timestamptz,
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create index if not exists idx_appointment_resident on public.appointment_request(resident_account_uuid) where archived_at is null;
create index if not exists idx_appointment_center on public.appointment_request(center_uuid) where archived_at is null;
create index if not exists idx_appointment_status on public.appointment_request(status) where archived_at is null;

create table if not exists public.queue_entry (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  center_uuid uuid not null,
  service_uuid uuid not null,
  resident_account_uuid uuid,
  ticket_number text not null,
  status public.queue_entry_status not null default 'waiting',
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create unique index if not exists idx_queue_entry_live_ticket
  on public.queue_entry(center_uuid, service_uuid, ticket_number) where archived_at is null;
create index if not exists idx_queue_entry_resident on public.queue_entry(resident_account_uuid) where archived_at is null;
create index if not exists idx_queue_entry_center_status on public.queue_entry(center_uuid, status) where archived_at is null;

create table if not exists public.queue_status (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  center_uuid uuid not null,
  service_uuid uuid,
  current_number text,
  waiting_count integer not null default 0 check (waiting_count >= 0),
  estimated_wait_minutes integer check (estimated_wait_minutes >= 0),
  status text not null default 'open' check (status in ('open','paused','closed')),
  created_by uuid,
  created_at timestamptz not null default now(),
  updated_at timestamptz,
  archived_at timestamptz
);
create unique index if not exists idx_queue_status_live
  on public.queue_status(center_uuid, service_uuid)
  where archived_at is null and service_uuid is not null;
create unique index if not exists idx_queue_status_center_live
  on public.queue_status(center_uuid)
  where archived_at is null and service_uuid is null;

create table if not exists public.audit_log (
  id bigint generated always as identity primary key,
  uuid uuid not null unique,
  actor_account_uuid uuid,
  action text not null,
  entity_type text not null,
  entity_uuid uuid,
  details jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);
create index if not exists idx_audit_log_actor on public.audit_log(actor_account_uuid);
create index if not exists idx_audit_log_entity on public.audit_log(entity_type, entity_uuid);
create index if not exists idx_audit_log_created on public.audit_log(created_at desc);

create or replace function public.current_account_uuid()
returns uuid
language sql
stable
security definer
set search_path = ''
as $$
  select a.uuid
  from public.account a
  where a.auth_user_uuid = auth.uid()
    and a.archived_at is null
  limit 1;
$$;

create or replace function public.has_center_role(p_center_uuid uuid, p_roles text[])
returns boolean
language sql
stable
security definer
set search_path = ''
as $$
  select exists (
    select 1
    from public.account a
    join public.staff_assignment s
      on s.account_uuid = a.uuid
    where a.auth_user_uuid = auth.uid()
      and a.archived_at is null
      and s.center_uuid = p_center_uuid
      and s.archived_at is null
      and s.role::text = any(p_roles)
  );
$$;

alter table public.account enable row level security;
alter table public.barangay_center enable row level security;
alter table public.health_service enable row level security;
alter table public.center_service enable row level security;
alter table public.center_schedule enable row level security;
alter table public.announcement enable row level security;
alter table public.staff_assignment enable row level security;
alter table public.appointment_request enable row level security;
alter table public.queue_entry enable row level security;
alter table public.queue_status enable row level security;
alter table public.audit_log enable row level security;

drop policy if exists account_self_read on public.account;
create policy account_self_read on public.account
  for select to authenticated
  using (auth_user_uuid = auth.uid() and archived_at is null);

drop policy if exists account_self_create on public.account;
create policy account_self_create on public.account
  for insert to authenticated
  with check (auth_user_uuid = auth.uid() and role = 'resident');

drop policy if exists account_system_admin_update on public.account;
create policy account_system_admin_update on public.account
  for update to authenticated
  using (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  )
  with check (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

drop policy if exists barangay_center_public_read on public.barangay_center;
create policy barangay_center_public_read on public.barangay_center
  for select to anon, authenticated
  using (archived_at is null);

drop policy if exists health_service_public_read on public.health_service;
create policy health_service_public_read on public.health_service
  for select to anon, authenticated
  using (archived_at is null);

drop policy if exists barangay_center_system_admin_insert on public.barangay_center;
create policy barangay_center_system_admin_insert on public.barangay_center
  for insert to authenticated
  with check (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

drop policy if exists health_service_system_admin_insert on public.health_service;
create policy health_service_system_admin_insert on public.health_service
  for insert to authenticated
  with check (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

drop policy if exists health_service_system_admin_update on public.health_service;
create policy health_service_system_admin_update on public.health_service
  for update to authenticated
  using (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  )
  with check (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

drop policy if exists center_service_public_read on public.center_service;
create policy center_service_public_read on public.center_service
  for select to anon, authenticated
  using (archived_at is null);

drop policy if exists center_schedule_public_read on public.center_schedule;
create policy center_schedule_public_read on public.center_schedule
  for select to anon, authenticated
  using (archived_at is null);

drop policy if exists announcement_public_read on public.announcement;
create policy announcement_public_read on public.announcement
  for select to anon, authenticated
  using (
    archived_at is null
    and published_at is not null
    and published_at <= now()
  );

drop policy if exists queue_status_public_read on public.queue_status;
create policy queue_status_public_read on public.queue_status
  for select to anon, authenticated
  using (archived_at is null);

drop policy if exists barangay_center_staff_update on public.barangay_center;
create policy barangay_center_staff_update on public.barangay_center
  for update to authenticated
  using (public.has_center_role(uuid, array['barangay_admin','health_worker']))
  with check (public.has_center_role(uuid, array['barangay_admin','health_worker']));

drop policy if exists center_service_staff_insert on public.center_service;
create policy center_service_staff_insert on public.center_service
  for insert to authenticated
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists center_service_staff_update on public.center_service;
create policy center_service_staff_update on public.center_service
  for update to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']))
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists center_schedule_staff_insert on public.center_schedule;
create policy center_schedule_staff_insert on public.center_schedule
  for insert to authenticated
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists center_schedule_staff_update on public.center_schedule;
create policy center_schedule_staff_update on public.center_schedule
  for update to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']))
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists announcement_staff_insert on public.announcement;
create policy announcement_staff_insert on public.announcement
  for insert to authenticated
  with check (
    center_uuid is null
    or public.has_center_role(center_uuid, array['barangay_admin','health_worker'])
  );

drop policy if exists announcement_staff_update on public.announcement;
create policy announcement_staff_update on public.announcement
  for update to authenticated
  using (
    center_uuid is not null
    and public.has_center_role(center_uuid, array['barangay_admin','health_worker'])
  )
  with check (
    center_uuid is not null
    and public.has_center_role(center_uuid, array['barangay_admin','health_worker'])
  );

drop policy if exists appointment_resident_read on public.appointment_request;
create policy appointment_resident_read on public.appointment_request
  for select to authenticated
  using (resident_account_uuid = public.current_account_uuid() and archived_at is null);

drop policy if exists appointment_resident_create on public.appointment_request;
create policy appointment_resident_create on public.appointment_request
  for insert to authenticated
  with check (
    resident_account_uuid = public.current_account_uuid()
    and status = 'pending'
  );

drop policy if exists appointment_resident_cancel on public.appointment_request;
create policy appointment_resident_cancel on public.appointment_request
  for update to authenticated
  using (resident_account_uuid = public.current_account_uuid() and archived_at is null)
  with check (resident_account_uuid = public.current_account_uuid() and status = 'cancelled');

drop policy if exists appointment_staff_read on public.appointment_request;
create policy appointment_staff_read on public.appointment_request
  for select to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists appointment_staff_update on public.appointment_request;
create policy appointment_staff_update on public.appointment_request
  for update to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']))
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists queue_resident_read on public.queue_entry;
create policy queue_resident_read on public.queue_entry
  for select to authenticated
  using (resident_account_uuid = public.current_account_uuid() and archived_at is null);

drop policy if exists queue_resident_create on public.queue_entry;
create policy queue_resident_create on public.queue_entry
  for insert to authenticated
  with check (
    resident_account_uuid = public.current_account_uuid()
    and status = 'waiting'
  );

drop policy if exists queue_staff_read on public.queue_entry;
create policy queue_staff_read on public.queue_entry
  for select to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists queue_staff_update on public.queue_entry;
create policy queue_staff_update on public.queue_entry
  for update to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']))
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists staff_assignment_read on public.staff_assignment;
create policy staff_assignment_read on public.staff_assignment
  for select to authenticated
  using (
    account_uuid = public.current_account_uuid()
    or public.has_center_role(center_uuid, array['barangay_admin'])
  );

drop policy if exists staff_assignment_admin_insert on public.staff_assignment;
create policy staff_assignment_admin_insert on public.staff_assignment
  for insert to authenticated
  with check (
    public.has_center_role(center_uuid, array['barangay_admin'])
    or exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

drop policy if exists staff_assignment_admin_update on public.staff_assignment;
create policy staff_assignment_admin_update on public.staff_assignment
  for update to authenticated
  using (
    public.has_center_role(center_uuid, array['barangay_admin'])
    or exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  )
  with check (
    public.has_center_role(center_uuid, array['barangay_admin'])
    or exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

drop policy if exists queue_status_staff_insert on public.queue_status;
create policy queue_status_staff_insert on public.queue_status
  for insert to authenticated
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists queue_status_staff_update on public.queue_status;
create policy queue_status_staff_update on public.queue_status
  for update to authenticated
  using (public.has_center_role(center_uuid, array['barangay_admin','health_worker']))
  with check (public.has_center_role(center_uuid, array['barangay_admin','health_worker']));

drop policy if exists audit_admin_read on public.audit_log;
create policy audit_admin_read on public.audit_log
  for select to authenticated
  using (
    exists (
      select 1
      from public.account a
      where a.auth_user_uuid = auth.uid()
        and a.role = 'system_admin'
        and a.archived_at is null
    )
  );

grant usage on schema public to anon, authenticated;
grant select on public.barangay_center, public.health_service, public.center_service,
  public.center_schedule, public.announcement, public.queue_status
  to anon, authenticated;
grant select, insert, update on public.account to authenticated;
grant select, insert, update on public.barangay_center, public.health_service
  to authenticated;
grant select, insert, update on public.appointment_request, public.queue_entry
  to authenticated;
grant select, insert, update on public.staff_assignment to authenticated;
grant update on public.barangay_center to authenticated;
grant select, insert, update on public.center_service, public.center_schedule,
  public.announcement to authenticated;
grant select, insert, update on public.queue_status to authenticated;
grant select on public.queue_entry to authenticated;
grant select on public.appointment_request to authenticated;
grant execute on function public.current_account_uuid() to authenticated;
grant execute on function public.has_center_role(uuid, text[]) to authenticated;
