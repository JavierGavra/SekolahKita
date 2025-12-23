import '../models/module_model.dart';
import '../models/course_model.dart';

class CourseService {
  static CourseModel getCourseData() {
    return CourseModel(
      title: 'Literasi Menulis',
      completedModules: 2,
      totalModules: 6,
      progress: 0.33,
      modules: [
        ModuleModel(
          id: '1',
          title: 'Cara Memegang Pensil',
          type: 'Materi',
          isCompleted: true,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '2',
          title: 'Latihan Menulis Huruf A-E',
          type: 'Materi',
          isCompleted: true,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '3',
          title: 'Kuis Menulis Vokal',
          type: 'Kuis',
          isCompleted: false,
          // icon: Icons.assignment,
        ),
        ModuleModel(
          id: '4',
          title: 'Latihan Menulis Huruf F-J',
          type: 'Materi',
          isCompleted: false,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '5',
          title: 'Latihan Menulis Huruf K-O',
          type: 'Materi',
          isCompleted: false,
          isLocked: true,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '6',
          title: 'Menulis Kata Sederhana',
          type: 'Materi',
          isCompleted: false,
          isLocked: true,
          // icon: Icons.menu_book,
        ),
      ],
    );
  }
}
