import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/core/database/database_helper.dart';
import 'package:sekolah_kita/core/database/local_data_persisance.dart';
import 'package:sekolah_kita/core/database/static/models/module_model.dart';
import 'package:sekolah_kita/features/course/services/local_service.dart';

part 'course_detail_state.dart';

class CourseDetailCubit extends Cubit<CourseDetailState> {
  final _localService = LocalService();
  late final CourseType type;

  CourseDetailCubit() : super(CourseDetailState.initial());

  void initData(CourseType type) {
    this.type = type;
    loadData();
  }

  void loadData() async {
    emit(state.copyWith(status: CourseDetailStateStatus.loading));

    final lastModuleIndex = LocalDataPersisance().getLastModuleIndex(type)!;

    final modules = switch (type) {
      CourseType.reading => _localService.getReadingModules(),
      CourseType.writing => _localService.getWritingModules(),
      CourseType.numeration => _localService.getNumerationModules(),
    };

    final starredIds = await DatabaseHelper.instance.getStarredModuleIds(
      courseType: type,
    );

    final modulesWithStar = modules.map((module) {
      return module.copyWith(isStar: starredIds.contains(module.id));
    }).toList();

    print(starredIds);
    print(modulesWithStar.map((e) => e.isStar).toList());

    final progress = _localService.getCourseProgress(type);

    emit(
      state.copyWith(
        status: CourseDetailStateStatus.success,
        lastModuleIndex: lastModuleIndex,
        moduleAmount: modules.length,
        modules: modulesWithStar,
        progress: progress,
      ),
    );
  }
}
