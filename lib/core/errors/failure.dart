abstract class Failure {
  final String message;
  final String? code; // كود الخطأ (اختياري)
  final dynamic details; // تفاصيل إضافية لو محتاجها
  const Failure(this.message, {this.code, this.details});
}

class ServerFailure extends Failure {
  const ServerFailure(String message, {String? code, dynamic details})
    : super(message, code: code, details: details);
}

class NetworkFailure extends Failure {
  const NetworkFailure(String message, {String? code, dynamic details})
    : super(message, code: code, details: details);
}

class AuthFailure extends Failure {
  const AuthFailure(String message, {String? code, dynamic details})
    : super(message, code: code, details: details);
}

class CacheFailure extends Failure {
  const CacheFailure(String message, {String? code, dynamic details})
    : super(message, code: code, details: details);
}

class UnknownFailure extends Failure {
  const UnknownFailure(String message, {String? code, dynamic details})
    : super(message, code: code, details: details);
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(String message, {String? code, dynamic details})
    : super(message, code: code, details: details);
}
