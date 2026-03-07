import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<void> handleResult(
  BuildContext context,
  Either<String, dynamic> result,
  String successMessage,
) async {
  result.fold(
    (error) => showMessage(context, 'حدث خطأ: $error'),
    (_) => showMessage(context, successMessage),
  );
}
