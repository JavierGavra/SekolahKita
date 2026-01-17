import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/constant/enum.dart';
import 'package:sekolah_kita/features/course/cubit/course_detail/course_detail_cubit.dart';
import '../widgets/course_detail_header.dart';
import '../widgets/module_card.dart';
import '../widgets/info_card.dart';

class CourseDetailPage extends StatelessWidget {
  final CourseType type;

  const CourseDetailPage({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    final cubit = CourseDetailCubit();

    return BlocProvider(
      create: (context) => cubit..initData(type),
      child: Scaffold(
        backgroundColor: color.primary,
        body: BlocBuilder<CourseDetailCubit, CourseDetailState>(
          builder: (context, state) {
            if (state.status == CourseDetailStateStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CourseDetailHeader(
                    completedModules: state.lastModuleIndex,
                    totalModules: state.modules.length,
                    progress: state.progress,
                    type: type,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 24, 16, 48),
                    decoration: BoxDecoration(
                      color: color.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Daftar Modul',
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 24),
                        ...state.modules.map(
                          (module) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ModuleCard(
                              key: ValueKey("${module.id}|${module.isStar}"),
                              module: module,
                              type: type,
                              isLocked: module.id > state.lastModuleIndex + 1,
                              isCompleted: module.id <= state.lastModuleIndex,
                              isStar: module.isStar,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const InfoCard(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
