import 'package:sekolah_kita/features/course/models/course_model.dart';
import 'package:sekolah_kita/features/course/models/module_model.dart';

class LocalService {
  CourseModel getReadingCourse() {
    return CourseModel(
      title: 'Literasi Membaca',
      completedModules: 2,
      totalModules: 6,
      progress: 0.33,
      modules: [
        // ===== KELAS 1 (6–7 TAHUN) =====
        ModuleModel(
          id: 'materi_huruf_vokal',
          title: 'Pengenalan Huruf Vokal',
          type: ModuleType.material,
          status: ModulStatus.completed,
        ),
        ModuleModel(
          id: 'kuis_huruf_vokal',
          title: 'Kuis Huruf Vokal',
          type: ModuleType.quiz,
          status: ModulStatus.completed,
        ),

        ModuleModel(
          id: 'materi_huruf_konsonan',
          title: 'Pengenalan Huruf Konsonan',
          type: ModuleType.material,
          status: ModulStatus.completed,
        ),
        ModuleModel(
          id: 'kuis_huruf_konsonan',
          title: 'Kuis Huruf Konsonan',
          type: ModuleType.quiz,
          status: ModulStatus.available,
        ),

        ModuleModel(
          id: 'materi_suku_kata',
          title: 'Membaca Suku Kata',
          type: ModuleType.material,
          status: ModulStatus.available,
        ),
        ModuleModel(
          id: 'kuis_suku_kata',
          title: 'Kuis Suku Kata',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
        ),

        // ===== KELAS 2–3 (7–9 TAHUN) =====
        ModuleModel(
          id: 'materi_kata_sederhana',
          title: 'Membaca Kata Sederhana',
          type: ModuleType.material,
          status: ModulStatus.locked,
        ),
        ModuleModel(
          id: 'kuis_kata_sederhana',
          title: 'Kuis Kata Sederhana',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
        ),

        ModuleModel(
          id: 'materi_kalimat_pendek',
          title: 'Membaca Kalimat Pendek',
          type: ModuleType.material,
          status: ModulStatus.locked,
        ),
        ModuleModel(
          id: 'kuis_kalimat_pendek',
          title: 'Kuis Kalimat Pendek',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
        ),

        // ===== KELAS 4 (9–10 TAHUN) =====
        ModuleModel(
          id: 'materi_cerita_pendek',
          title: 'Membaca Cerita Pendek',
          type: ModuleType.material,
          status: ModulStatus.locked,
        ),
        ModuleModel(
          id: 'kuis_cerita_pendek',
          title: 'Kuis Cerita Pendek',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
        ),

        // ===== KELAS 5–6 (10–12 TAHUN) =====
        ModuleModel(
          id: 'materi_ide_pokok',
          title: 'Menemukan Ide Pokok Bacaan',
          type: ModuleType.material,
          status: ModulStatus.locked,
        ),
        ModuleModel(
          id: 'kuis_ide_pokok',
          title: 'Kuis Ide Pokok',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
        ),

        ModuleModel(
          id: 'materi_intonasi',
          title: 'Membaca dengan Intonasi',
          type: ModuleType.material,
          status: ModulStatus.locked,
        ),
        ModuleModel(
          id: 'kuis_intonasi',
          title: 'Kuis Intonasi Membaca',
          type: ModuleType.quiz,
          status: ModulStatus.locked,
        ),
      ],
    );
  }

  CourseModel getWrittingCourse() {
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
