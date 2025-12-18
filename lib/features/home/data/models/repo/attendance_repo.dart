import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';

abstract class AttendanceRepo {
  Future<Either<Failure, Unit>> markAttendance(
    String id,
    String memberId,
    String memberName,
  );
  Stream<List<String>> getTodayAttendanceIds();
}
