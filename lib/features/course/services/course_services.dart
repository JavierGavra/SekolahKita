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
          type: ModuleType.material,
          status: ModulStatus.available,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '2',
          title: 'Latihan Menulis Huruf A-E',
          type: ModuleType.material,
          status: ModulStatus.available,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '3',
          title: 'Kuis Menulis Vokal',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
          // icon: Icons.assignment,
        ),
        ModuleModel(
          id: '4',
          title: 'Latihan Menulis Huruf F-J',
          type: ModuleType.material,
          status: ModulStatus.locked,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '5',
          title: 'Latihan Menulis Huruf K-O',
          type: ModuleType.material,
          status: ModulStatus.locked,
          // icon: Icons.menu_book,
        ),
        ModuleModel(
          id: '6',
          title: 'Menulis Kata Sederhana',
          type: ModuleType.material,
          status: ModulStatus.locked,
          // icon: Icons.menu_book,
        ),
      ],
    );
  }
}
