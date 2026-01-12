
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/office_staff.dart';

abstract class OfficeRepository {
  Future<Either<Failure, List<OfficeStaff>>> getStaff(int agentId);
  Future<Either<Failure, void>> hireStaff(int agentId, StaffType type, int level);
  Future<Either<Failure, void>> fireStaff(int agentId, StaffType type, int level);
}
