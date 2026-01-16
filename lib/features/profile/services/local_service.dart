import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';

class LocalService {
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
