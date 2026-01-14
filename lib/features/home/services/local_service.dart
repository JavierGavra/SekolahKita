import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/data/module_data.dart';

class LocalService {
  double getCourseProgress(CourseType type) {
    final lastModuleIndex = LocalDataPersisance().getLastModuleIndex(type);
    final moduleAmount = switch (type) {
      CourseType.reading => ModuleData().getReadingModules(),
      CourseType.writing => ModuleData().getReadingModules(),
      CourseType.numeration => ModuleData().getReadingModules(),
    }.length;

    return lastModuleIndex! / moduleAmount;
  }

  int getOverallProgress() {
    final sum =
        getCourseProgress(CourseType.reading) +
        getCourseProgress(CourseType.writing) +
        getCourseProgress(CourseType.numeration);

    return ((sum / 3) * 100).round();
  }
}
