enum ModuleType { material, quiz }

enum ModulStatus { locked, available, completed }

class ModuleModel {
  final String id;
  final String title;
  final ModuleType type;
  final ModulStatus status;

  ModuleModel({
    required this.id,
    required this.title,
    required this.type,
    this.status = ModulStatus.locked,
  });

  bool get isLocked => (status == ModulStatus.locked);
  bool get isCompleted => (status == ModulStatus.completed);
}
