import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/home/data/models/model/dash_board_model.dart';

abstract class DashBoardRepo {
  Future<Either<Failure, Stream<List<DashBoardModel>>>> getAllDashBoard();
  Future<Either<Failure, Unit>> updateDashBoard(
    String id,
    Map<String, dynamic> data,
  );
}
