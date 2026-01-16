import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/data/module_data.dart';

class LocalService {
  double getCourseProgress(CourseType type) {
    final lastModuleIndex = LocalDataPersisance().getLastModuleIndex(type);
    final moduleAmount = switch (type) {
      CourseType.reading => ModuleData().getReadingModules(),
      CourseType.writing => ModuleData().getWritingModules(),
      CourseType.numeration => ModuleData().getNumerationModules(),
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

  int getTotalModule() {
    final localData = LocalDataPersisance();
    return localData.getLastModuleIndex(CourseType.reading)! +
        localData.getLastModuleIndex(CourseType.writing)! +
        localData.getLastModuleIndex(CourseType.numeration)!;
  }

  Future<int> getStars() async {
    return await DatabaseHelper.instance.getStars();
  }
}
