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
}
