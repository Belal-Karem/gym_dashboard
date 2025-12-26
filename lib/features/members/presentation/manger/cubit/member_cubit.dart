import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/core/errors/failure.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';
import 'package:power_gym/features/members/presentation/manger/cubit/member_state.dart';

// class MembersCubit extends Cubit<MembersState> {
//   final MemberRepo repo;

//   StreamSubscription? _membersSubscription;

//   MembersCubit(this.repo) : super(MembersInitial());

//   Future<void> loadMembers() async {
//     emit(MembersLoading());

//     final result = await repo.getAllMembers();

//     result.fold((failure) => emit(MembersError(failure.message)), (stream) {
//       _membersSubscription = stream.listen(
//         (members) {
//           emit(MembersLoaded(members));
//         },
//         onError: (error) {
//           emit(MembersError(error.toString()));
//         },
//       );
//     });
//   }

//   Future<void> addMember(MemberModel member) async {
//     emit(AddMemberLoading());

//     final result = await repo.addMember(member);

//     result.fold(
//       (failure) => emit(AddMemberError(failure.message)),
//       (_) => emit(AddMemberSuccess()),
//     );
//   }

//   Future<void> updateMember(String id, Map<String, dynamic> data) async {
//     emit(UpdateMemberLoading());

//     final result = await repo.updateMember(id, data);

//     result.fold(
//       (failure) => emit(UpdateMemberError(failure.message)),
//       (_) => emit(UpdateMemberSuccess()),
//     );
//   }

//   Future<void> deleteMember(String id) async {
//     emit(DeleteMemberLoading());

//     final result = await repo.deleteMember(id);

//     result.fold(
//       (failure) => emit(DeleteMemberError(failure.message)),
//       (_) => emit(DeleteMemberSuccess()),
//     );
//   }

//   Future<Either<Failure, String>> addMemberAndReturnId(
//     MemberModel member,
//   ) async {
//     emit(AddMemberLoading());
//     final result = await repo.addMemberAndReturnId(member);

//     return result;
//   }

//   @override
//   Future<void> close() {
//     _membersSubscription?.cancel();
//     return super.close();
//   }
// }

class MembersCubit extends Cubit<MembersState> {
  final MemberRepo repo;
  StreamSubscription? _membersSubscription;

  // 🔹 Original data from stream
  List<MemberModel> _allMembers = [];

  // 🔹 Filters state
  String _searchQuery = '';
  String _statusFilter = 'all'; // all | active | inactive

  MembersCubit(this.repo) : super(MembersInitial());

  // =========================
  // Load Members (Stream)
  // =========================
  Future<void> loadMembers() async {
    emit(MembersLoading());

    final result = await repo.getAllMembers();

    result.fold((failure) => emit(MembersError(failure.message)), (stream) {
      _membersSubscription?.cancel();
      _membersSubscription = stream.listen(
        (members) {
          _allMembers = members;
          _applyFilters();
        },
        onError: (error) {
          emit(MembersError(error.toString()));
        },
      );
    });
  }

  void searchMembers(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  // =========================
  // Filter by Status
  // =========================
  void filterByStatus(String status) {
    _statusFilter = status; // all | active | inactive
    _applyFilters();
  }

  void _applyFilters() {
    List<MemberModel> filtered = List.from(_allMembers);

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((member) {
        return member.name.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    if (_statusFilter != 'all') {
      filtered = filtered.where((member) {
        return member.status == _statusFilter;
      }).toList();
    }

    emit(MembersLoaded(filtered));
  }

  void resetFilters() {
    _searchQuery = '';
    _statusFilter = 'all';
    _applyFilters();
  }

  Future<void> addMember(MemberModel member) async {
    emit(AddMemberLoading());

    final result = await repo.addMember(member);

    result.fold(
      (failure) => emit(AddMemberError(failure.message)),
      (_) => emit(AddMemberSuccess()),
    );
  }

  // =========================
  // Update Member
  // =========================
  Future<void> updateMember(String id, Map<String, dynamic> data) async {
    emit(UpdateMemberLoading());

    final result = await repo.updateMember(id, data);

    result.fold(
      (failure) => emit(UpdateMemberError(failure.message)),
      (_) => emit(UpdateMemberSuccess()),
    );
  }

  // =========================
  // Delete Member
  // =========================
  Future<void> deleteMember(String id) async {
    emit(DeleteMemberLoading());

    final result = await repo.deleteMember(id);

    result.fold(
      (failure) => emit(DeleteMemberError(failure.message)),
      (_) => emit(DeleteMemberSuccess()),
    );
  }

  // =========================
  // Add Member & Return ID
  // =========================
  Future<Either<Failure, String>> addMemberAndReturnId(
    MemberModel member,
  ) async {
    emit(AddMemberLoading());
    return await repo.addMemberAndReturnId(member);
  }

  // =========================
  // Dispose
  // =========================
  @override
  Future<void> close() {
    _membersSubscription?.cancel();
    return super.close();
  }
}
