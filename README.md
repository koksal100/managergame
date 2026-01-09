# Manager Game Project

## 🏗 Architecture
This project follows a **Feature-Based Clean Architecture**. The codebase is organized by features (e.g., `players`, `clubs`, `transfers`), where each feature contains its own:
- **Domain Layer**: Entities, UseCases, Repository Interfaces.
- **Data Layer**: DataSources (Drift Tables), Models, Repository Implementations.
- **Presentation Layer**: Pages, Widgets, State Management.
- **Core Layer**: Shared utilities, error handling, and the central database definition.

## 🛠 Tech Stack
- **Flutter**: UI Framework.
- **Dart**: Programming Language.
- **Drift**: Reactive persistence library for SQLite (Database).
- **SQLite**: Local database engine.
- **Equatable**: Value equality for Dart classes.
- **Dartz**: Functional programming (Either type for error handling).
- **Build Runner**: Code generation tool.

## 💾 Database
The project uses **Drift** for local data persistence. The database is located at `lib/core/database/app_database.dart`.

### Database Schema (Tables)
The database consists of the following tables, defined in their respective feature modules:

1.  **Players** (Feature: `players`)
    *   `id` (PK), `name`, `age`, `position`
    *   `ca` (Current Ability), `pa` (Potential Ability), `reputation`
    *   Foreign Keys: `clubId` -> `Clubs`, `agentId` -> `Agents`, `currentContractId` -> `Contracts`

2.  **Clubs** (Feature: `clubs`)
    *   `id` (PK), `name`, `reputation`
    *   `transferBudget`, `wageBudget`
    *   Foreign Key: `leagueId` -> `Leagues`

3.  **Agents** (Feature: `agents`)
    *   `id` (PK), `name`, `balance`
    *   Skills: `negotiationSkill`, `scoutingSkill`, `level`
    *   `reputation`

4.  **Leagues** (Feature: `leagues`)
    *   `id` (PK), `name`, `countryId`, `reputation`

5.  **Contracts** (Feature: `contracts`)
    *   `id` (PK), `status`
    *   `startDate`, `endDate`, `wage`, `releaseClause`
    *   Foreign Keys: `playerId` -> `Players`, `agentId` -> `Agents`

6.  **Transfers** (Feature: `transfers`)
    *   `id` (PK), `date`, `feeAmount`, `type` (e.g., Loan/Permanent)
    *   Foreign Keys: `playerId` -> `Players`, `fromClubId` -> `Clubs`, `toClubId` -> `Clubs`

7.  **ValueHistories** (Feature: `players`)
    *   `id` (PK), `date`, `value`
    *   Foreign Key: `playerId` -> `Players`

8.  **Relationships** (Feature: `relationships`)
    *   `id` (PK), `score`
    *   Polymorphic Links: `fromId`, `toId`, `fromType`, `toType`

### Code Generation
To regenerate the database code after modifying any table definition, run:
```bash
dart run build_runner build --delete-conflicting-outputs
```
