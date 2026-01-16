import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/data/module_data.dart';
import 'package:sekolah_kita/core/database/static/models/module_model.dart';

class LocalService {
  final data = ModuleData();

  List<ModuleModel> getReadingModules() {
    return data.getReadingModules();
  }

  List<ModuleModel> getWritingModules() {
    return data.getWritingModules();
  }

  List<ModuleModel> getNumerationModules() {
    return data.getNumerationModules();
  }

  double getCourseProgress(CourseType type) {
    final lastModuleIndex = LocalDataPersisance().getLastModuleIndex(type);
    final moduleAmount = switch (type) {
      CourseType.reading => data.getReadingModules(),
      CourseType.writing => data.getWritingModules(),
      CourseType.numeration => data.getNumerationModules(),
    }.length;

    return lastModuleIndex! / moduleAmount;
  }

  double getOverallProgress() {
    final sum =
        getCourseProgress(CourseType.reading) +
        getCourseProgress(CourseType.writing) +
        getCourseProgress(CourseType.numeration);

    return sum / 3;
  }

  Future<int> getStarsByCourse(CourseType type) async {
    return await DatabaseHelper.instance.getStarsByCourse(courseType: type);
  }
}
