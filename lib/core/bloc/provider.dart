import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/features/course/cubit/course/course_cubit.dart';
import 'package:sekolah_kita/features/profile/bloc/profile_bloc.dart';

class Provider {
  static List<BlocProvider> get providers {
    return [
      BlocProvider<CourseCubit>(create: (context) => CourseCubit()),
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
    ];
  }
}
