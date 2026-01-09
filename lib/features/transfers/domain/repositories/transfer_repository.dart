import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/transfer.dart';

abstract class TransferRepository {
  Future<Either<Failure, List<Transfer>>> getTransfers();
  Future<Either<Failure, int>> createTransfer(Transfer transfer);
}
