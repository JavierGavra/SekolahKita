import 'package:flutter/material.dart';

showAlertDialog(
  BuildContext context, {
  String? title,
  String? description,
  String? yesLabel,
  String? noLabel,
  Function()? onYes,
  Function()? onNo,
  Color? yesBackground,
}) {
  final color = Theme.of(context).colorScheme;
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: (title == null) ? null : Text(title),
        content: (description == null) ? null : Text(description),
        actions: [
          TextButton(
            onPressed: onNo ?? () => Navigator.of(context).pop(false),
            child: Text(noLabel ?? 'Tidak'),
          ),
          FilledButton(
            onPressed: onYes ?? () => Navigator.of(context).pop(false),
            style: FilledButton.styleFrom(
              backgroundColor: yesBackground ?? color.primary,
            ),
            child: Text(yesLabel ?? 'Ya'),
          ),
        ],
      );
    },
  );
}
