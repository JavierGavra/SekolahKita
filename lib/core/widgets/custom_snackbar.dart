import 'package:flutter/material.dart';

SnackBar _createSnackBar(
  BuildContext context,
  SnackBarType type,
  String? message,
) {
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
  } else if (type == SnackBarType.failed) {
    content = Row(
      children: [
        Icon(Icons.warning, size: 18, color: color.error),
        SizedBox(width: 15),
        Expanded(
          child: Text(
            message ?? "Ada masalah",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: color.onError),
          ),
        ),
      ],
    );
  }

  return SnackBar(
    duration: (type == SnackBarType.failed)
        ? const Duration(seconds: 2)
        : const Duration(seconds: 1),
    content: content,
    showCloseIcon: true,
  );
}

enum SnackBarType { commingSoon, failed }

void showSnackBar(BuildContext context, SnackBarType type, {String? message}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(_createSnackBar(context, type, message));
}
