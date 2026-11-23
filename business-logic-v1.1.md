# Business Logic

> Development of an `Android and Web` `Multi-Center Barangay Health Services Management Platform` using `Kotlin, Web Technologies, and Supabase` for `Barangay Residents and Authorized Barangay Health Personnel`

- Allowed Platforms: Web, Android

## Project Details

- Company/Startup/Team Name: `Oliva`
- Project Code Name: `Aurelia`
- Project Short Code: `AU`
- Short Description: `A multi-center barangay health services platform that lets residents find health centers and services, view schedules, monitor queues, request appointments, and receive announcements. Authorized personnel manage center information, schedules, queues, appointment requests, and announcements.`
- Long Description: `Aurelia provides a mobile-first access point for residents to discover participating barangay health centers and the services they offer. Residents can review center operating information, submit appointment requests, join or monitor supported queues, and receive official announcements. Administrators and health workers can maintain accurate center and schedule information, review appointment requests, update queues, and publish announcements. Aurelia is not a replacement for emergency response, clinical judgment, or formal health-record systems.`

## User Levels

| User Level | Description |
|---|---|
| A. System Administrator | Maintains platform settings, protected configuration, accounts, and approved backups. |
| B. Barangay Administrator | Manages an assigned center or barangay, staff access, center settings, and aggregated reports. |
| C. Health Worker | Updates assigned center information, schedules, queues, appointment requests, and announcements. |
| D. Registered Resident | Uses an authenticated account to request and monitor local health services. |
| E. Guest | Views limited public center information without creating an account. |

## System Requirements

1. The app shall allow users to authenticate using Google Sign-In and retain role-based access.
2. The app shall allow guests and residents to search and view participating health centers.
3. The app shall display a center's public services, address, contact information, operating hours, and announcements.
4. The app shall allow registered residents to request appointments for services offered by a center.
5. The app shall allow residents to join supported queues and view current queue status without exposing unnecessary personal information.
6. The app shall allow authorized health workers to update center schedules, queues, appointment requests, and announcements.
7. The app shall allow barangay administrators to manage staff assignments, center information, and aggregated reports.

## Required Solution Layers

1. Security and privacy by design. Implement Data Privacy Act compliance, location protection, retention limits, restricted audit logs, aggregation thresholds, and consent for purposes beyond the core service.
2. Role-based authorization shall be enforced at both the API and database boundaries.
3. Android and web clients shall consume the same documented API contract.

## MVP Features and Access

> See the User Levels table for reference.

| Feature | Access |
|---|---|
| 1. Account and role access | A,B,C,D,E |
| 2. Center and service discovery | A,B,C,D,E |
| 3. Public announcements | A,B,C,D,E |
| 4. Appointment requests | A,B,C,D |
| 5. Queue status | A,B,C,D,E |
| 6. Center operations | A,B,C |
| 7. Administration and audit | A,B |

## Notes

- The MVP prioritizes public information, appointment requests, queue coordination, and official announcements.
- The MVP does not include clinical diagnosis, teleconsultation, electronic medical records, prescriptions, payments, insurance, live GPS tracking, AI triage, or third-party data resale.
- Appointment acceptance and queue status may be updated manually by authorized center staff.
- Participating centers and accountable barangay administrators must be confirmed before launch.
- Retention periods and analytics aggregation thresholds require privacy review and final approval.
