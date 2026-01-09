import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import '../../../../core/database/app_database.dart' hide Transfer;
import '../../../../core/error/failures.dart';
import '../../domain/repositories/transfer_repository.dart';
import '../../domain/entities/transfer.dart';


class TransferRepositoryImpl implements TransferRepository {
  final AppDatabase database;

  TransferRepositoryImpl(this.database);

  @override
  Future<Either<Failure, List<Transfer>>> getTransfers() async {
    try {
      final rows = await database.select(database.transfers).get();
      final list = rows.map((row) => Transfer(
        id: row.id,
        playerId: row.playerId,
        fromClubId: row.fromClubId,
        toClubId: row.toClubId,
        date: row.date,
        feeAmount: row.feeAmount,
        type: row.type,
      )).toList();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> createTransfer(Transfer transfer) async {
    try {
      final companion = TransfersCompanion(
        playerId: Value(transfer.playerId),
        fromClubId: Value(transfer.fromClubId),
        toClubId: Value(transfer.toClubId),
        date: Value(transfer.date),
        feeAmount: Value(transfer.feeAmount),
        type: Value(transfer.type),
      );
      final id = await database.into(database.transfers).insert(companion);
      return Right(id);
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
