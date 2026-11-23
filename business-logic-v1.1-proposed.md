# Proposed Business Logic v1.1

> Development of an `Android and Web` `Multi-Center Barangay Health Services Management Platform` using `Kotlin, Web Technologies, and Supabase` for `Barangay Residents and Authorized Barangay Health Personnel`

**Status:** Proposed MVP scope for review

**Based on:** `business-logic-v1.0.md`

## 1. Executive Summary

Aurelia is a low-friction digital health service directory and coordination platform for residents and barangay health centers. It helps residents locate health centers, understand available services and schedules, join or monitor queues, request appointments, and receive operational announcements.

Authorized center staff and administrators maintain accurate center information and manage resident-facing requests. The MVP prioritizes timely access to health services, not clinical diagnosis, records, or advanced financial and administrative functions.

## 2. Problem and Opportunity

- Residents may not know which barangay health center serves their needs or when it operates.
- Health center schedules and announcements change, but residents often receive updates through fragmented channels.
- Manual queues and appointment requests create avoidable waiting and repeated inquiries.
- Staff need one controlled operational view instead of scattered messages and personal records.

The opportunity is to provide one mobile-first source of truth for public center information and basic service coordination across multiple barangays.

## 3. Value Proposition

For residents, Aurelia reduces uncertainty by centralizing center details, service availability, schedules, queue status, appointment requests, and announcements.

For health workers and administrators, Aurelia reduces manual coordination by organizing center operations and request queues in one system.

For partner local governments, Aurelia provides a shared platform that can scale across participating centers without introducing a separate system for every barangay.

## 4. Product Positioning

| Item | Position |
|---|---|
| Primary platform | Android |
| Secondary platform | Web for residents and authorized staff |
| Core service | Resident-to-center information and coordination |
| Primary users | Residents and barangay health personnel |
| MVP differentiator | Multi-center discovery combined with queues and appointments |
| Explicitly not a clinical system | No diagnosis, teleconsultation, e-prescriptions, or medical record platform |

## 5. Project Details

- Company/Startup/Team Name: `Oliva`
- Project Code Name: `Aurelia`
- Project Short Code: `AU`
- Short Description: `A multi-center barangay health services platform that lets residents find health centers and services, view schedules, monitor queues, request appointments, and receive announcements. Authorized personnel manage center information, schedules, queues, appointment requests, and announcements.`
- Long Description: `Aurelia provides a single, mobile-first access point for local residents to discover participating barangay health centers and the services they offer. Residents can review center operating information, submit appointment requests, join or monitor queues where supported, and receive official announcements. Administrators and health workers can maintain accurate center and schedule information, review appointment requests, update queues, and publish announcements. Aurelia is not a replacement for emergency response, clinical judgment, or the formal health-record systems required for regulated care.`

## 6. User Levels

| User Level | Description | MVP Responsibility |
|---|---|---|
| A. System Administrator | Maintains platform settings, accounts, backups, and protected configuration. | Platform availability and controlled maintenance |
| B. Barangay Administrator | Manages an assigned center or barangay, staff access, reports, and operating settings. | Center governance and reporting |
| C. Health Worker | Updates assigned center operations and handles resident-facing service requests. | Schedules, queues, appointments, and announcements |
| D. Registered Resident | Uses an authenticated account to request and monitor local services. | Personal appointments, queue participation, and account profile |
| E. Guest | Views limited public information without an account. | Centers, services, schedules, and public announcements |

## 7. Core User Stories

1. As a guest or resident, I can find nearby or participating health centers and view their public services and operating information.
2. As a resident, I can sign in and request an available appointment at a participating center.
3. As a resident, I can view the status of my appointment request and join or monitor an applicable queue.
4. As a health worker, I can update schedules, queues, appointment requests, and center announcements.
5. As an administrator, I can control staff access and view only aggregated operational reports.
6. As a system administrator, I can manage protected configuration and perform approved backups.

## 8. System Requirements

1. The app shall allow users to authenticate with Google Sign-In and retain role-based access.
2. The app shall allow guests and residents to search and filter participating health centers.
3. The app shall display a center's public services, address, contact information, operating hours, and announcements.
4. The app shall allow registered residents to request appointments for services offered by a center.
5. The app shall allow residents to join supported queues and view a current status without exposing unnecessary personal information.
6. The app shall allow authorized center staff to update schedules, queues, appointment requests, and announcements.
7. The app shall allow barangay administrators to manage staff assignments, center information, and aggregated reports.

## 9. Required Solution Layers

1. Security and privacy by design, including Data Privacy Act compliance.
2. Role-based authorization at both API and database boundaries.
3. Location information controls that avoid collecting precise location unless required for an essential task.
4. Retention limits for account, appointment, queue, and audit data.
5. Aggregated analytics with thresholds that prevent identification of small groups or individuals.
6. No sale or secondary use of personal data; obtain consent when a separate purpose requires it.
7. Secure audit logs that do not create avoidable per-user location or activity trails.
8. Android and web clients consume the same documented API contract.

## 10. MVP Features and Access

| # | Feature | Access | MVP Scope |
|---|---|---|---|
| 1 | Account and role access | A,B,C,D,E | Google Sign-In for D/C/B/A; guest browsing for E |
| 2 | Center and service discovery | A,B,C,D,E | Search, center details, public services, and operating information |
| 3 | Public announcements | A,B,C,D,E | View official center or barangay announcements |
| 4 | Appointment requests | A,B,C,D | Residents submit requests; authorized staff approve or decline |
| 5 | Queue status | A,B,C,D,E | View public queue status; registered residents join supported queues |
| 6 | Center operations | A,B,C | Staff update assigned center information, schedules, appointments, and queues |
| 7 | Administration and audit | A,B | Staff assignments, system reports, backup oversight, and restricted audit review |

## 11. Minimum Success Criteria

1. A guest can find and open center information without creating an account.
2. A resident can sign in with Google and submit a valid appointment request.
3. A health worker can approve or decline an appointment and update the assigned center schedule.
4. A resident can see a queue status update with stale or unavailable status clearly identified.
5. A staff member cannot access another assigned center's protected operations.
6. Public analytics do not expose counts or patterns below the approved aggregation threshold.
7. The web and Android clients display the same source of truth from the API.

## 12. MVP Exclusions

The following are deferred to avoid slowing the initial launch:

- Clinical diagnosis and medical decision support.
- Teleconsultation and video calling.
- Electronic medical records and prescription management.
- Payment processing and insurance integration.
- Real-time GPS tracking or resident heat maps.
- Automated public health alerts based on individual location.
- AI-based triage, chatbots, or recommendation engines.
- Third-party advertising and personal-data resale.
- Advanced forecasting, external dashboards, or custom reporting.

## 13. Assumptions and Decisions to Confirm

1. Google Sign-In is the sole resident and staff authentication method for MVP.
2. Barangay health centers act as independent operational units with assigned staff.
3. Public center information, schedules, announcements, and queue status do not require personal identity.
4. Appointment acceptance and queue status are updated manually by authorized staff.
5. Data Privacy Act requirements take precedence over convenience features.
6. Participating centers and an accountable barangay administrator must be designated before launch.
7. The MVP does not replace emergency hotlines, official health records, or face-to-face clinical workflows.

## 14. Risks and Mitigations

| Risk | Why it matters | MVP mitigation |
|---|---|---|
| Staff cannot keep information current | Outdated schedules and appointments undermine trust | Assigned center owners and a small, clear update workflow |
| Queue status is inaccurate | Residents may travel unnecessarily | Timestamp updates, mark stale status, and permit manual correction |
| Appointment requests exceed capacity | Staff receives unmanageable demand | Request status, simple capacity fields, and staff review queue |
| Unauthorized access | Health or personal data may be exposed | Google identity, server/database authorization, and least-privilege roles |
| Precise location is over-collected | Location data creates privacy and retention risk | Address and city/barangay-level data only unless a separate approved need exists |
| Feature scope expands | Launch is delayed and quality drops | Enforce the exclusions in Section 12 |

## 15. Launch Readiness Checklist

1. Approve this MVP scope and named role assignments.
2. Confirm participating centers, center owners, public data, and operating schedules.
3. Define data retention periods and aggregation thresholds.
4. Complete API, database, role, and privacy authorization rules.
5. Test guest, resident, health worker, administrator, and system-administrator flows.
6. Confirm backup, restore, incident, and account-recovery procedures.
7. Obtain the required privacy, consent, and local-government approvals.
8. Publish the Android release and web interface only after system and integration testing.

## Notes

- This proposal preserves v1.0's Android-first health-services concept and Google Sign-In requirement.
- This proposal should be reviewed by barangay stakeholders and privacy/legal reviewers before implementation.
- Platform, role, feature, retention, and analytics details marked as assumptions require sign-off; they should not be silently treated as final.
