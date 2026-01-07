import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/features/auth/bloc/auth_bloc.dart';
import 'package:sekolah_kita/features/profile/bloc/profile_bloc.dart';

class Provider {
  static List<BlocProvider> get providers {
    return [
      BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      BlocProvider<ProfileBloc>(create: (context) => ProfileBloc()),
    ];
  }
}
