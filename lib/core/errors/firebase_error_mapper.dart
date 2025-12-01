import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:power_gym/core/errors/failure.dart';

Failure handleFirebaseException(e) {
  if (e is FirebaseException) {
    return FirebaseFailure(
      e.message ?? "Firebase error occurred",
      code: e.code,
      details: e.stackTrace,
    );
  } else if (e is SocketException) {
    return NetworkFailure("No internet connection");
  } else if (e is TimeoutException) {
    return NetworkFailure("Request timed out");
  } else {
    return UnknownFailure("Unknown error", details: e.toString());
  }
}
