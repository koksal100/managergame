import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../domain/services/transfer_engine.dart';
import 'package:drift/drift.dart';

final transferEngineProvider = Provider<TransferEngine>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return TransferEngine(database);
});

// Provider to get all transfer needs
final transferNeedsProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.transferNeeds).get();
});

// Provider to get buy needs only (Sorted by Budget DESC)
final buyNeedsProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transferNeeds)
    ..where((t) => t.type.equals('buy'))
    ..where((t) => t.isFulfilled.equals(false))
    ..orderBy([(t) => OrderingTerm(expression: t.maxTransferBudget, mode: OrderingMode.desc)]))
    .get();
});

// Provider to get sell needs only (Sorted by Fee DESC)
final sellNeedsProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transferNeeds)
    ..where((t) => t.type.equals('sell'))
    ..where((t) => t.isFulfilled.equals(false))
    ..orderBy([(t) => OrderingTerm(expression: t.minimumFee, mode: OrderingMode.desc)]))
    .get();
});

// Provider to get completed transfers (Sorted by Fee DESC)
final completedTransfersProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transfers)
    ..orderBy([(t) => OrderingTerm(expression: t.feeAmount, mode: OrderingMode.desc)]))
    .get();
});

// Provider to get active (pending) offers (Sorted by Amount DESC)
final activeOffersProvider = FutureProvider((ref) async {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transferOffers)
    ..where((t) => t.status.equals('pending'))
    ..orderBy([(t) => OrderingTerm(expression: t.offerAmount, mode: OrderingMode.desc)]))
    .get();
});
