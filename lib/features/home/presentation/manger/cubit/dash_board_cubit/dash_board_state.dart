part of 'dash_board_cubit.dart';

abstract class DashBoardState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// الحالة المبدئية
class DashBoardInitial extends DashBoardState {}

/// تحميل جميع الأعضاء (Stream)
class DashBoardLoading extends DashBoardState {}

class DashBoardLoaded extends DashBoardState {
  final List<DashBoardModel> dashBoard;

  DashBoardLoaded(this.dashBoard);

  @override
  List<Object?> get props => [dashBoard];
}

class DashBoardError extends DashBoardState {
  final String message;

  DashBoardError(this.message);

  @override
  List<Object?> get props => [message];
}
