import 'package:flutter/material.dart';

enum LoadingWidgetType { page, dialog }

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final LoadingWidgetType type;

  const LoadingWidget.page({super.key, this.color})
    : type = LoadingWidgetType.page;
  const LoadingWidget.dialog({super.key, this.color})
    : type = LoadingWidgetType.dialog;

  @override
  Widget build(BuildContext context) {
    if (type == LoadingWidgetType.page) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else if (type == LoadingWidgetType.dialog) {
      return Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Center(
          child: CircularProgressIndicator(
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    }

    return Expanded(
      child: Center(
        child: CircularProgressIndicator(
          color: color ?? Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
