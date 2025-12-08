import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:power_gym/constants.dart';
import 'package:power_gym/features/members/data/models/member_model/member_model.dart';
import 'package:power_gym/features/members/data/models/repo/member_repo.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/errors/firebase_error_mapper.dart';

class MemberRepoImpl implements MemberRepo {
  final CollectionReference membersRef = FirebaseFirestore.instance.collection(
    kMemberCollections,
  );

  final DocumentReference counterRef = FirebaseFirestore.instance
      .collection('counters')
      .doc('memberCounter');

  // تجيب memberId الجديد
  Future<int> getNextMemberId() async {
    final doc = await counterRef.get();
    int lastId = doc.exists ? int.parse(doc['lastId'].toString()) : 0;
    int newId = lastId + 1;
    await counterRef.set({'lastId': newId});
    return newId;
  }

  @override
  Future<Either<Failure, Stream<List<MemberModel>>>> getAllMembers() async {
    try {
      final stream = membersRef.snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return MemberModel.fromJson(
            doc.data() as Map<String, dynamic>,
            doc.id,
          );
        }).toList();
      });
      return Right(stream);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> addMember(MemberModel member) async {
    try {
      int newMemberId = await getNextMemberId();
      final newMember = member.copyWith(memberId: newMemberId.toString());
      await membersRef.add(newMember.toJson());
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, String>> addMemberAndReturnId(
    MemberModel member,
  ) async {
    try {
      int newMemberId = await getNextMemberId();
      final newMember = member.copyWith(memberId: newMemberId.toString());

      final docRef = await membersRef.add(newMember.toJson());
      return Right(docRef.id); // هنا بنرجع الـ Firebase doc ID
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateMember(
    String id,
    Map<String, dynamic> data,
  ) async {
    try {
      await membersRef.doc(id).update(data);
      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteMember(String id) async {
    try {
      await membersRef.doc(id).delete();

      final snapshot = await membersRef.orderBy('memberId').get();

      int lastId = 0;
      int counter = 1;
      for (var doc in snapshot.docs) {
        await doc.reference.update({'memberId': counter.toString()});
        lastId = counter;
        counter++;
      }

      await counterRef.set({'lastId': lastId});

      return const Right(unit);
    } catch (e) {
      return Left(handleFirebaseException(e));
    }
  }
}

// class MemberRepoImpl implements MemberRepo {
//   final CollectionReference membersRef = FirebaseFirestore.instance.collection(
//     kMemberCollections,
//   );

//   final DocumentReference counterRef = FirebaseFirestore.instance
//       .collection('counters')
//       .doc('memberCounter');

//   Future<int> getNextMemberId() async {
//     final doc = await counterRef.get();
//     int lastId = doc.exists ? int.parse(doc['lastId'].toString()) : 0;
//     int newId = lastId + 1;
//     await counterRef.set({'lastId': newId});
//     return newId;
//   }

//   @override
//   Future<Either<Failure, Stream<List<MemberModel>>>> getAllMembers() async {
//     try {
//       final stream = membersRef.snapshots().map((snapshot) {
//         return snapshot.docs.map((doc) {
//           return MemberModel.fromJson(
//             doc.data() as Map<String, dynamic>,
//             doc.id,
//           );
//         }).toList();
//       });

//       return Right(stream);
//     } catch (e) {
//       return Left(handleFirebaseException(e));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> addMember(MemberModel member) async {
//     try {
//       int newMemberId = await getNextMemberId();

//       final newMember = member.copyWith(memberid: newMemberId.toString());

//       await membersRef.doc(member.id).set(newMember.toJson());
//       return const Right(unit);
//     } catch (e) {
//       return Left(handleFirebaseException(e));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> updateMember(
//     String id,
//     Map<String, dynamic> data,
//   ) async {
//     try {
//       await membersRef.doc(id).update(data);
//       return const Right(unit);
//     } catch (e) {
//       return Left(handleFirebaseException(e));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> deleteMember(String id) async {
//     try {
//       await membersRef.doc(id).delete();
//       return const Right(unit);
//     } catch (e) {
//       return Left(handleFirebaseException(e));
//     }
//   }
// }


// @override
  // Future<Either<Failure, Unit>> addMember(MemberModel member) async {
  //   try {
  //     await membersRef.doc(member.id).set(member.toJson());
  //     return const Right(unit);
  //   } catch (e) {
  //     return Left(handleFirebaseException(e));
  //   }
  // }