class CourseModel {
  final String title;
  final int completedModules;
  final int totalModules;
  final double progress;
  final List modules;

  CourseModel({
    required this.title,
    required this.completedModules,
    required this.totalModules,
    required this.progress,
    required this.modules,
  });
}