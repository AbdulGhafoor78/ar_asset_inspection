# Enterprise AR Asset Inspection & Maintenance Platform

**Case Study:** Ezitech Engineering Framework (EEF) --- FLUTTER-005\
**Submission type:** Individual\
**Application:** Flutter / Dart\
**Backend:** Node.js, Express, Prisma ORM\
**Database:** Microsoft SQL Server\
**Project status:** Internship case-study implementation; see the
implementation status and limitations below.

## 1. Project Overview

The Enterprise AR Asset Inspection & Maintenance Platform is a Flutter
application intended to support engineers with asset management,
inspection workflows, inspection evidence, AR-style guided checks, and
maintenance records.

The project uses a modular feature structure and separates presentation,
domain, and data responsibilities. Riverpod is used for application
state management. Drift provides local persistence for
inspection-related records. The Asset Management feature communicates
with a REST API backed by SQL Server.

> **Scope note:** This README describes the source code reviewed for
> this submission. It distinguishes implemented functionality from
> planned or incomplete case-study requirements. The current AR
> inspection experience is a guided inspection workflow; the reviewed
> source does not integrate ARCore/ARKit or render live 3D camera
> overlays.

## 2. Technology Stack

### Flutter application

-   Flutter and Dart
-   Riverpod (`flutter_riverpod`) for state management
-   Clean Architecture-inspired feature separation
-   Repository pattern and use cases
-   Drift and SQLite for local persistence
-   `http` for REST API requests
-   `image_picker` for selecting/capturing image evidence
-   `path_provider` and `path` for local file paths

### Backend

-   Node.js
-   Express
-   Prisma ORM
-   Microsoft SQL Server
-   REST endpoints for Asset CRUD operations

## 3. Implemented Application Features

The following describes the implementation found in the submitted source
and the functionality tested during development.

### Authentication

-   Login, logout, current-engineer state, and authentication gate
    screens.
-   The current repository uses a mock engineer and an in-memory
    session.
-   JWT authentication, biometric authentication, secure device
    registration, and persistent offline login are not implemented in
    the reviewed source.

### Asset Management

-   View the asset list and asset details.
-   Create, update, and delete assets.
-   Asset data is retrieved and persisted through the backend REST API
    and SQL Server.
-   CRUD operations were tested in the Flutter web application,
    including a temporary asset deletion verified in SQL Server.

### Inspection Workflow

-   Create and view inspections.
-   Track inspection status and completion.
-   Work with inspection checklist items.
-   Add, view, and delete image evidence records.
-   Inspection, checklist, and evidence records are stored locally using
    Drift.

### AR Inspection Workflow

-   View the available AR inspection records.
-   Start and complete an AR inspection.
-   Follow guided inspection points such as oil level, temperature,
    vibration, leakage, and motor condition.
-   Save pass/fail inspection results locally.
-   Create a maintenance record when an AR-guided inspection point
    fails.

**AR limitation:** The reviewed implementation provides an
AR-themed/guided inspection flow. It does not currently demonstrate
real-world plane detection, object tracking, ARCore/ARKit integration,
or live 3D overlays.

### Maintenance

-   Create maintenance records.
-   View maintenance records.
-   Update maintenance status.
-   Generate a maintenance record from a failed AR inspection point.
-   Maintenance records are stored locally using Drift.

### Dashboard

-   Display summary counts for assets, inspections, and maintenance
    records.
-   The unread notification count currently uses a fixed sample value.

### Notifications

-   Display sample notifications.
-   Mark a notification as read.
-   Notifications are currently held in an in-memory sample repository;
    push notifications and persistent notification storage are not
    implemented.

### Offline Sync Foundation

-   Store sync operations in a local Drift table.
-   Track pending, syncing, synced, and failed states.
-   Store retry counts and the last error.
-   List pending/all operations and reset failed operations for retry.

**Offline sync limitation:** The reviewed code provides a local
sync-operation queue and status management. An automatic background
synchronization worker that sends queued inspection/report data to a
remote API is not implemented in the reviewed source.

## 4. Architecture

The Flutter application follows a feature-based, Clean
Architecture-inspired organization.

Each major feature separates responsibilities into:

-   **Presentation:** Screens, Riverpod providers/notifiers, and UI
    state.
-   **Domain:** Entities, repository contracts, and use cases.
-   **Data:** Models and repository implementations.

Simplified project structure:


```text
lib/
|-- app.dart
|-- main.dart
|-- core/
|   |-- database/
|   |-- theme/
|-- features/
    |-- authentication/
    |-- assets/
    |-- inspection/
    |-- ar_inspection/
    |-- maintenance/
    |-- dashboard/
    |-- notifications/
    |-- offline_sync/
```


`ProviderScope` is initialized in `main.dart`. The application uses
Riverpod providers to construct repositories and use cases and to expose
feature state to the presentation layer.

## 5. Backend API

The backend project is maintained separately from the Flutter
application.

### API endpoints

Base path: `/api`

Method   Endpoint        Purpose
  -------- --------------- -------------------------
GET      `/health`       Backend health check
GET      `/assets`       Retrieve all assets
GET      `/assets/:id`   Retrieve an asset by ID
POST     `/assets`       Create an asset
PUT      `/assets/:id`   Update an asset
DELETE   `/assets/:id`   Delete an asset

The Prisma schema reviewed for this submission defines the `Asset` model
with:

-   `id`
-   `name`
-   `assetCode` (unique)
-   `location`
-   `status`
-   `createdAt`
-   `updatedAt`

The reviewed backend currently exposes Asset endpoints only. Inspection,
AR results, maintenance, spare-parts, defect-reporting, and
authentication APIs are not present in the reviewed backend source.

## 6. Prerequisites

Install the following before running the project:

-   Flutter SDK compatible with the Dart SDK constraint in
    `pubspec.yaml` (`^3.11.5`).
-   Dart SDK.
-   Android Studio and Android SDK for Android builds.
-   Node.js and npm for the backend.
-   Microsoft SQL Server with a database created for the application.
-   A code editor such as Android Studio or Visual Studio Code.

The development environment used during implementation included Flutter
3.41.9, Dart 3.11.5, Node.js 20.15.0, and npm 10.7.0.

## 7. Run the Flutter Application

1.  Open a terminal in the Flutter project root (the folder containing
    `pubspec.yaml`).

2.  Install dependencies:

    ``` bash
    flutter pub get
    ```

3.  Run static analysis:

    ``` bash
    flutter analyze
    ```

4.  Run on Chrome:

    ``` bash
    flutter run -d chrome
    ```

The Asset API must be running when using Asset Management features.


### API host configuration

The Asset API base URL is configurable using Dart's `--dart-define` option.

The Flutter application reads the `API_BASE_URL` compile-time environment variable. If no value is supplied, it defaults to:

```text
http://localhost:3000/api
```

Configure the API address according to the target environment:

**Chrome on the development computer:**

```bash
flutter run -d chrome
```

**Standard Android Emulator:**

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api
```

**Physical Android device:**

Use the development computer's LAN IP address. Ensure both devices are connected to the same network and that the backend is running.

```bash
flutter run --dart-define=API_BASE_URL=http://YOUR_PC_LAN_IP:3000/api
```

Replace `YOUR_PC_LAN_IP` with the computer's actual local network IP address.

**Production deployment:**

Supply the HTTPS URL of the deployed backend:

```bash
flutter run --dart-define=API_BASE_URL=https://YOUR_API_DOMAIN/api
```

Do not commit personal LAN IP addresses, production credentials, or other environment-specific secrets.

## 8. Run the Backend API

1.  Open a terminal in the backend project root (the folder containing
    `package.json`).

2.  Install dependencies:

    ``` bash
    npm install
    ```

3.  Create a local `.env` file containing the SQL Server connection
    string:

    ``` env
    DATABASE_URL="sqlserver://YOUR_SQL_SERVER_HOST:YOUR_PORT;database=ArAssetInspectionDB;user=YOUR_DATABASE_USER;password=YOUR_DATABASE_PASSWORD;encrypt=true;trustServerCertificate=true"
    ```

    Replace the placeholders with the connection details for the SQL
    Server instance. Do not commit or distribute the real `.env` file or
    database credentials.

4.  Generate the Prisma client:

    ``` bash
    npx prisma generate
    ```

5.  If setting up a new database/schema, verify the target database and
    schema first, then apply the Prisma schema using the database
    migration/synchronization approach approved for that environment. Do
    not run schema changes against a production database without a
    backup.

6.  Start the API:

    ``` bash
    node server.js
    ```

The server listens on port `3000` by default. It also supports a custom port through the `PORT` environment variable.

Verify the API health endpoint using:

``` text
http://localhost:3000/api/health
```

The backend package defines an `npm start` script that runs `node server.js`.

## 9. Local Database

The Flutter application defines Drift tables for:

-   Inspections
-   Inspection checklist items
-   Inspection evidence records
-   AR inspection records
-   AR inspection result records
-   Maintenance records
-   Sync operations

The backend Prisma schema separately defines the SQL Server `Asset`
table/model. In the reviewed implementation, inspection, AR result,
evidence, maintenance, and sync queue data are stored locally in the
Flutter Drift database rather than being synchronized to corresponding
backend endpoints.

## 10. Android APK Build

From the Flutter project root:

``` bash
flutter build apk --release --dart-define=API_BASE_URL=http://YOUR_PC_LAN_IP:3000/api
```

The expected APK output location is:
For a physical Android device, replace `YOUR_PC_LAN_IP` with the development computer's LAN IP address. Ensure both devices are connected to the same network and the backend is running.

For an Android Emulator, use `http://10.0.2.2:3000/api` instead.

``` text
build/app/outputs/flutter-apk/app-release.apk
```

The APK must be installed and tested on a physical Android device or
emulator before submission. Confirm that the API host is reachable from
the Android target.

**Signing note:** The reviewed Android Gradle configuration currently
uses the debug signing configuration for the release build. This may be
acceptable for an internal evaluation build if permitted by the
evaluator, but it is not a production release-signing setup. Configure a
proper release keystore before production distribution.

## 11. Current Scope and Known Limitations

The FLUTTER-005 case study also lists requirements that are not
implemented or not verified in the reviewed source. These should not be
represented as completed features.

  -----------------------------------------------------------------------
Case-study requirement              Status in reviewed source
  ----------------------------------- -----------------------------------
Asset CRUD with REST API and SQL    Implemented and tested
Server

Local inspection/checklist/evidence Implemented
persistence

Guided AR inspection checklist and  Implemented
saved results

Native ARCore/ARKit and live 3D     Not implemented
overlays

QR/barcode scanning and NFC         Not implemented
recognition

JWT, biometric login, secure device Not implemented
registration

Automatic background                Not implemented
synchronization to remote APIs

Video capture, voice notes, digital Not implemented/verified
signatures

Spare-parts module                  Not found in reviewed source

Defect reporting and photo          Not found in reviewed source
annotation

Firebase push notifications         Not implemented

Full analytics (failure trends,     Not implemented; only basic
downtime, cost, productivity)       dashboard summary is present

Android release APK                 Build and device test still
required
  -----------------------------------------------------------------------

## 12. Submission Checklist

Before submitting, verify each item:

-   [ ] Flutter source code included.
-   [ ] Backend source code included.
-   [ ] Real `.env` files, passwords, and secrets excluded.
-   [ ] `node_modules`, `.gradle`, `.dart_tool`, `build`, and `.git`
    excluded from source archives where applicable.
-   [ ] `pubspec.yaml`, `pubspec.lock`, `package.json`, and
    `package-lock.json` included.
-   [ ] SQL Server setup instructions and safe example environment
    configuration included.
-  [x] `flutter analyze` completed successfully.
-   [x] `flutter test` completed successfully (3 tests passed).
-   [x] Android APK built and tested on a physical Android device.
-   [x] Architecture documentation prepared.
-   [ ] Technical presentation prepared.
-   [ ] Live demonstration flow rehearsed.

## 13. Demonstration Flow

A suggested demonstration of the implemented functionality:

1.  Launch the application and show the authentication gate/login flow.
2.  Open the dashboard and show the summary information.
3.  Open Asset Management and demonstrate listing, creating, editing,
    and deleting a test asset.
4.  Show that Asset changes are persisted in SQL Server.
5.  Start an inspection and demonstrate checklist completion.
6.  Add inspection image evidence and show the saved evidence.
7.  Open AR Inspection and complete the guided inspection points.
8.  Demonstrate a failed inspection point creating a local maintenance
    record.
9.  Show the maintenance record and local sync queue/status
    functionality.
10. Explain the current limitations and planned future enhancements
    honestly.

------------------------------------------------------------------------

**Prepared for:** Individual FLUTTER-005 internship case-study
submission\
**Project:** Enterprise AR Asset Inspection & Maintenance Platform

## Related Repository

**Node.js Backend:** [ar_asset_inspection_api](https://github.com/AbdulGhafoor78/ar_asset_inspection_api)

The backend provides REST API endpoints for asset management using Node.js, Express, Prisma, and SQL Server.


