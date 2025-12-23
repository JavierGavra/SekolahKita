import 'package:flutter/material.dart';

SnackBar _createSnackBar(BuildContext context, SnackBarType type) {
  final color = Theme.of(context).colorScheme;
  Widget content = SizedBox();

  if (type == SnackBarType.commingSoon) {
    content = Row(
      children: [
        Icon(Icons.construction, size: 18, color: color.inversePrimary),
        SizedBox(width: 15),
        Text("Comming Soon!", style: TextStyle(color: color.onInverseSurface)),
      ],
    );
  }

  return SnackBar(
    duration: const Duration(seconds: 1),
    content: content,
    showCloseIcon: true,
  );
}

enum SnackBarType { commingSoon }

void showSnackBar(BuildContext context, SnackBarType type) {
  ScaffoldMessenger.of(context).showSnackBar(_createSnackBar(context, type));
}
