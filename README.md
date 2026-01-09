# Manager Game Project

## 🏗 Architecture
This project follows a **Feature-Based Clean Architecture**. The codebase is organized by features (e.g., `players`, `clubs`, `transfers`), where each feature contains its own:
- **Domain Layer**: Entities, UseCases, Repository Interfaces.
- **Data Layer**: DataSources (Drift Tables), Models, Repository Implementations.
- **Presentation Layer**: Pages, Widgets, State Management (Providers).
- **Core Layer**: Shared utilities, error handling, and the central database definition.

## 🛠 Tech Stack
- **Flutter**: UI Framework.
- **Dart**: Programming Language.
- **Riverpod 2.0**: State Management (using `AsyncNotifier` and `ProviderScope`).
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

## 🧩 State Management (Riverpod)
The project uses **Riverpod 2.0** for dependency injection and state management.

- **Providers Location**: Each feature has a `providers` folder (e.g., `lib/features/players/providers/`).
- **Pattern**: 
  - **Repository Provider**: Exposes the repository implementation (e.g., `playerRepositoryProvider`).
  - **AsyncNotifierProvider**: Manages the UI state (e.g., `playersProvider` returns `AsyncValue<List<Player>>`).

### Usage Example
#### Reading Data in UI
```dart
class PlayerList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to rebuild on changes
    final playersAsync = ref.watch(playersProvider);
    
    return playersAsync.when(
      data: (players) => ListView.builder(
        itemCount: players.length,
        itemBuilder: (ctx, index) => Text(players[index].name),
      ),
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
```

#### Modifying Data
```dart
// Access the notifier to call methods like add/update
ref.read(playersProvider.notifier).addPlayer(newPlayer);
```

## 📦 Repository Pattern
We use the Repository pattern to decouple the Domain layer from the Data layer.

1.  **Domain**: Defines the `Repository` interface (contract). 
    *   *Path*: `lib/features/[feature]/domain/repositories/`
2.  **Data**: Implements the repository using Drift.
    *   *Path*: `lib/features/[feature]/data/repositories/`
3.  **Core**: `Failure` classes in `lib/core/error/` describe potential errors, returned via `Either<Failure, Type>`.

This ensures that the business logic (UseCases/State) remains independent of the database implementation.
