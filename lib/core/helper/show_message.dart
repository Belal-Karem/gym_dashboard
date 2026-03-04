import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

void _showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<void> _handleResult(
  BuildContext context,
  Either<String, dynamic> result,
  String successMessage,
) async {
  result.fold(
    (error) => _showMessage(context, 'حدث خطأ: $error'),
    (_) => _showMessage(context, successMessage),
  );
}
