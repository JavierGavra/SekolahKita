import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sekolah_kita/core/utils/valdator/input_validator.dart';
import 'package:sekolah_kita/core/widgets/custom_snackbar.dart';
import 'package:sekolah_kita/core/widgets/loading_widget.dart';
import 'package:sekolah_kita/features/auth/bloc/auth_bloc.dart';
import 'package:sekolah_kita/features/auth/views/pages/email_verification_page.dart';
import 'package:sekolah_kita/features/auth/views/widgets/auth_switch_button.dart';
import 'package:sekolah_kita/features/auth/views/widgets/auth_text_field.dart';
import 'package:sekolah_kita/features/auth/views/widgets/google_auth_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _performRegister() {
    if (_formKey.currentState!.validate()) {
      context.pushTransition(
        type: PageTransitionType.fade,
        child: LoadingWidget.dialogFullscreen(canPop: false),
      );
      context.read<AuthBloc>().add(
        RegisterRequested(
          name: _usernameController.text,
          email: _emailController.text,
          password: _confirmController.text,
        ),
      );
    }
  }

  void _listerner(BuildContext context, AuthState state) async {
    if (state.status == AuthStateStatus.authenticated) {
      Navigator.maybePop(context);
      context.pushTransition(
        curve: Curves.easeOut,
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 300),
        childBuilder: (context) => EmailVerificationPage(),
      );
    } else if (state.status == AuthStateStatus.failure) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      showSnackBar(context, SnackBarType.failed, message: state.errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(color),
            Spacer(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buat akun untuk mendapat akses SekolahKita',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: color.primary,
                        height: 1.428,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      label: "Nama kamu",
                      controller: _usernameController,
                      prefixIcon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 6),
                    AuthTextField(
                      label: "Email",
                      controller: _emailController,
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) =>
                          InputValidator().emailValidator(value),
                    ),
                    const SizedBox(height: 6),
                    AuthTextField.password(
                      label: "Password",
                      controller: _passwordController,
                      validator: (value) =>
                          InputValidator().passwordValidator(value),
                    ),
                    const SizedBox(height: 6),
                    AuthTextField.password(
                      label: "Konfirmasi Password",
                      controller: _confirmController,
                      validator: (value) =>
                          InputValidator().retypePasswordValidator(
                            value,
                            _passwordController.text,
                          ),
                    ),
                    const SizedBox(height: 12),
                    _buildAuthButton(color),
                    const SizedBox(height: 16),
                    GoogleAuthButton.register(),
                    const SizedBox(height: 24),
                    AuthSwitchButton.isToLogin(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme color) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Ayo Mulai !",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 1.1875,
              color: color.onPrimary,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Belajar Bersama, Tumbuh Bersama",
            style: TextStyle(fontSize: 16, height: 1.5, color: color.onPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthButton(ColorScheme color) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: _listerner,
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _performRegister,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              "Daftar",
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        );
      },
    );
  }
}
