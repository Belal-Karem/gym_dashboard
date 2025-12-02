import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/core/errors/failure.dart';

Failure handleFirebaseException(e) {
  if (e is FirebaseException) {
    return FirebaseFailure(
      e.message ?? "حدث خطأ في Firebase",
      code: e.code,
      details: e.stackTrace,
    );
  } else if (e is SocketException) {
    return NetworkFailure("لا يوجد اتصال بالإنترنت");
  } else if (e is TimeoutException) {
    return NetworkFailure("انتهت مهلة الطلب");
  } else {
    return UnknownFailure("خطأ غير معروف", details: e.toString());
  }
}
