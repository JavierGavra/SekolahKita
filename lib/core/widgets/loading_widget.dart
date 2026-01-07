import 'package:flutter/material.dart';

enum LoadingWidgetType { page, dialogFullscreen, dialog }

class LoadingWidget extends StatelessWidget {
  final bool canPop;
  final Color? color;
  final LoadingWidgetType type;

  const LoadingWidget.page({super.key, this.color, this.canPop = true})
    : type = LoadingWidgetType.page;

  const LoadingWidget.dialog({super.key, this.color, this.canPop = true})
    : type = LoadingWidgetType.dialog;

  const LoadingWidget.dialogFullscreen({
    super.key,
    this.color,
    this.canPop = true,
  }) : type = LoadingWidgetType.dialogFullscreen;

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    if (type == LoadingWidgetType.page) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: color ?? Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else if (type == LoadingWidgetType.dialogFullscreen) {
      return PopScope(
        canPop: canPop,
        child: Dialog.fullscreen(
          backgroundColor: Colors.black26,
          child: Center(
            child: CircularProgressIndicator(
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
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
