import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/widgets/loading_widget.dart';
import 'package:sekolah_kita/features/auth/views/widgets/logout_dialog.dart';
import 'package:sekolah_kita/features/profiles/cubit/profile_cubit.dart';
import '../widgets/stat_card.dart';
import '../widgets/achievement_card.dart';
import '../widgets/menu_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..loadProfile(),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (_, state) {
          if (state.status == ProfileStateStatus.loading) {
            return const LoadingWidget.page();
          }

          final profile = state.profile!;
          return Scaffold(
            backgroundColor: const Color(0xFFF6F9FC),
            body: RefreshIndicator.adaptive(
              onRefresh: () => context.read<ProfileCubit>().loadProfile(),
              child: Column(
                children: [
                  // HEADER
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
                    width: double.infinity,
                    color: const Color(0xFF1C678A),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Profil Saya',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Center(
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white30,
                                child: Icon(
                                  Icons.person,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                profile.nama,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                profile.kelas,
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // CONTENT
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            StatCard(
                              icon: Icons.star,
                              label: 'Total Bintang',
                              value: profile.bintang.toString(),
                            ),
                            const SizedBox(width: 8),
                            StatCard(
                              icon: Icons.timer,
                              label: 'Waktu Belajar',
                              value: '${profile.jamBelajar} Jam',
                            ),
                            const SizedBox(width: 8),
                            StatCard(
                              icon: Icons.book,
                              label: 'Modul Selesai',
                              value: profile.modul.toString(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Pencapaian Terbaru',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const AchievementCard(),
                        const SizedBox(height: 16),
                        MenuTile(
                          icon: Icons.settings,
                          title: 'Pengaturan',
                          onTap: () {},
                        ),
                        MenuTile(
                          icon: Icons.logout,
                          title: 'Keluar',
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => const LogoutDialog(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
