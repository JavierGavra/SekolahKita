import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/static/models/module_model.dart';

class ModuleData {
  List<ModuleModel> getReadingModules() {
    return [
      ModuleModel(
        id: 1,
        title: 'Pengenalan Huruf Vokal',
        type: ModuleType.lesson,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 2,
        title: 'Kuis Huruf Vokal',
        type: ModuleType.quiz,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 3,
        title: 'Pengenalan Huruf Konsonan',
        type: ModuleType.lesson,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 4,
        title: 'Kuis Huruf Konsonan',
        type: ModuleType.quiz,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 5,
        title: 'Membaca Suku Kata',
        type: ModuleType.lesson,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 6,
        title: 'Kuis Suku Kata',
        type: ModuleType.quiz,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 7,
        title: 'Membaca Kata Sederhana',
        type: ModuleType.lesson,
        course: CourseType.reading,
      ),
      ModuleModel(
        id: 8,
        title: 'Kuis Kata Sederhana',
        type: ModuleType.quiz,
        course: CourseType.reading,
      ),
    ];
  }

  List<ModuleModel> getWritingModules() {
    return [
      ModuleModel(
        id: 1,
        title: 'Cara Memegang Pensil',
        type: ModuleType.lesson,
        course: CourseType.writing,
      ),
      ModuleModel(
        id: 2,
        title: 'Latihan Menulis Huruf A-E',
        type: ModuleType.lesson,
        course: CourseType.writing,
      ),
      ModuleModel(
        id: 3,
        title: 'Kuis Menulis Vokal',
        type: ModuleType.quiz,
        course: CourseType.writing,
      ),
      ModuleModel(
        id: 4,
        title: 'Latihan Menulis Huruf F-J',
        type: ModuleType.lesson,
        course: CourseType.writing,
      ),
      ModuleModel(
        id: 5,
        title: 'Latihan Menulis Huruf K-O',
        type: ModuleType.lesson,
        course: CourseType.writing,
      ),
      ModuleModel(
        id: 6,
        title: 'Menulis Kata Sederhana',
        type: ModuleType.lesson,
        course: CourseType.writing,
      ),
    ];
  }

  List<ModuleModel> getNumerationModules() {
    return [
      ModuleModel(
        id: 1,
        title: 'Mengenal Angka 1–10',
        type: ModuleType.lesson,
        course: CourseType.numeration,
      ),
      ModuleModel(
        id: 2,
        title: 'Kuis Mengenal Angka 1–10',
        type: ModuleType.quiz,
        course: CourseType.numeration,
      ),
      ModuleModel(
        id: 3,
        title: 'Menghitung Benda',
        type: ModuleType.lesson,
        course: CourseType.numeration,
      ),
      ModuleModel(
        id: 4,
        title: 'Kuis Menghitung Benda',
        type: ModuleType.quiz,
        course: CourseType.numeration,
      ),
      ModuleModel(
        id: 5,
        title: 'Penjumlahan Dasar',
        type: ModuleType.lesson,
        course: CourseType.numeration,
      ),
      ModuleModel(
        id: 6,
        title: 'Kuis Penjumlahan',
        type: ModuleType.quiz,
        course: CourseType.numeration,
      ),

      ModuleModel(
        id: 7,
        title: 'Pengurangan Dasar',
        type: ModuleType.lesson,
        course: CourseType.numeration,
      ),
      ModuleModel(
        id: 8,
        title: 'Kuis Pengurangan',
        type: ModuleType.quiz,
        course: CourseType.numeration,
      ),
    ];
  }
}
