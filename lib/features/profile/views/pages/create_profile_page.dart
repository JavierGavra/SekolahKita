import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sekolah_kita/core/widgets/custom_snackbar.dart';
import 'package:sekolah_kita/core/widgets/loading_widget.dart';
import 'package:sekolah_kita/features/navigation/views/pages/bottom_navigation.dart';
import 'package:sekolah_kita/features/profile/bloc/profile_bloc.dart';
import 'package:sekolah_kita/features/profile/views/widgets/username_text_field.dart';

class CreateProfilePage extends StatefulWidget {
  const CreateProfilePage({super.key});

  @override
  State<CreateProfilePage> createState() => _CreateProfilePageState();
}

class _CreateProfilePageState extends State<CreateProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.3);
  final _currentAvatarIndex = ValueNotifier<int>(0);
  final _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _avatars = [
    {'image': 'avatar_1.png', 'name': 'T-rex'},
    {'image': 'avatar_2.png', 'name': 'Pipi'},
    {'image': 'avatar_3.png', 'name': 'Angel'},
    {'image': 'avatar_4.png', 'name': 'Ocil'},
  ];

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      context.pushTransition(
        type: PageTransitionType.fade,
        child: LoadingWidget.dialogFullscreen(
          canPop: false,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
      );
      context.read<ProfileBloc>().add(
        CreateProfile(
          avatar: _avatars[_currentAvatarIndex.value]['image'],
          username: _nameController.text,
        ),
      );
    }
  }

  void _listerner(BuildContext context, ProfileState state) async {
    if (state.status == ProfileStateStatus.success) {
      context.pushAndRemoveUntilTransition(
        curve: Curves.easeOut,
        predicate: (route) => false,
        type: PageTransitionType.fade,
        duration: const Duration(milliseconds: 300),
        childBuilder: (context) => BottomNavigation(),
      );
    } else if (state.status == ProfileStateStatus.failure) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      showSnackBar(context, SnackBarType.failed, message: state.errorMessage);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: _listerner,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [color.primary, Color(0xFF0F4A5F)],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 40),
                Text(
                  'Buat Profil Kamu',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: color.onPrimary,
                  ),
                ),
                const Spacer(),
                ..._buildChooseAvatar(color),
                const Spacer(),
                _buildForm(color),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChooseAvatar(ColorScheme color) {
    return [
      SizedBox(
        height: 200,
        child: ValueListenableBuilder(
          valueListenable: _currentAvatarIndex,
          builder: (_, value, __) {
            return PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                _currentAvatarIndex.value = index;
              },
              itemCount: _avatars.length,
              itemBuilder: (context, index) {
                final scale = value == index ? 1.0 : 0.7;
                return TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 250),
                  tween: Tween<double>(begin: scale, end: scale),
                  builder: (context, double value, child) {
                    return Transform.scale(scale: value, child: child);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: color.surfaceContainerLow,
                      shape: BoxShape.circle,
                      border: Border.all(color: color.outlineVariant),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/images/avatars/${_avatars[index]['image']}',
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: color.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ValueListenableBuilder(
          valueListenable: _currentAvatarIndex,
          builder: (_, value, _) {
            return Text(
              _avatars[value]['name'],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color.primary,
                height: 1.5,
              ),
            );
          },
        ),
      ),
    ];
  }

  Widget _buildForm(ColorScheme color) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Siapa nama kamu?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: color.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            UsernameTextField(controller: _nameController),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _onSubmit,
                style: FilledButton.styleFrom(
                  backgroundColor: color.primary,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  "Mulai Belajar",
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
