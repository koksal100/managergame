import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/database_provider.dart';
import '../domain/services/transfer_engine.dart';
import 'package:drift/drift.dart';

final transferEngineProvider = Provider<TransferEngine>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return TransferEngine(database);
});

// Provider to get all transfer needs
final transferNeedsProvider = StreamProvider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.transferNeeds).watch();
});

// Provider to get buy needs only (Sorted by Budget DESC)
final buyNeedsProvider = StreamProvider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transferNeeds)
    ..where((t) => t.type.equals('buy'))
    ..where((t) => t.isFulfilled.equals(false))
    ..orderBy([(t) => OrderingTerm(expression: t.maxTransferBudget, mode: OrderingMode.desc)]))
    .watch();
});

// Provider to get sell needs only (Sorted by Fee DESC)
final sellNeedsProvider = StreamProvider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transferNeeds)
    ..where((t) => t.type.equals('sell'))
    ..where((t) => t.isFulfilled.equals(false))
    ..orderBy([(t) => OrderingTerm(expression: t.minimumFee, mode: OrderingMode.desc)]))
    .watch();
});

enum TransferSort { dateDesc, feeDesc }

final completedTransfersSortProvider = StateProvider<TransferSort>((ref) => TransferSort.dateDesc);

// Provider to get completed transfers (Sorted by Fee DESC)
final completedTransfersProvider = StreamProvider((ref) {
  final db = ref.watch(appDatabaseProvider);
  final sort = ref.watch(completedTransfersSortProvider);
  
  return (db.select(db.transfers)
    ..orderBy([
      (t) => sort == TransferSort.feeDesc 
          ? OrderingTerm(expression: t.feeAmount, mode: OrderingMode.desc)
          : OrderingTerm(expression: t.date, mode: OrderingMode.desc)
    ]))
    .watch();
});

// Provider to get active (pending) offers (Sorted by Amount DESC)
final activeOffersProvider = StreamProvider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return (db.select(db.transferOffers)
    ..where((t) => t.status.equals('pending'))
    ..orderBy([(t) => OrderingTerm(expression: t.offerAmount, mode: OrderingMode.desc)]))
    .watch();
});
