class ModuleModel {
  final String id;
  final String title;
  final String type;
  final bool isCompleted;
  final bool isLocked;

  ModuleModel({
    required this.id,
    required this.title,
    required this.type,
    required this.isCompleted,
    this.isLocked = false,
  });
}
