import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/core/widgets/custom_snackbar.dart';
import 'package:sekolah_kita/features/auth/bloc/auth_bloc.dart';
import 'package:sekolah_kita/features/auth/views/widgets/auth_switch_button.dart';
import 'package:sekolah_kita/features/auth/views/widgets/auth_text_field.dart';
import 'package:sekolah_kita/features/auth/views/widgets/google_auth_button.dart';
import 'package:sekolah_kita/features/navigation/views/pages/bottom_navigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  void _performLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailcontroller.text,
          password: _passwordcontroller.text,
        ),
      );
      print("Login performed");
    }
  }

  void _listerner(BuildContext context, AuthState state) {
    if (state.status == AuthStateStatus.authenticated) {
      Navigate.pushReplacement(context, const BottomNavigation());
    } else if (state.status == AuthStateStatus.failure) {
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
                      'Masukkan akun untuk kembali belajar',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: color.primary,
                        height: 1.428,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AuthTextField(
                      label: "Email",
                      controller: _emailcontroller,
                      prefixIcon: Icons.person_outline_rounded,
                    ),
                    const SizedBox(height: 6),
                    AuthTextField.password(
                      label: "Password",
                      controller: _passwordcontroller,
                    ),
                    _buildForgotPasswordButton(),
                    const SizedBox(height: 24),
                    _buildAuthButton(color),
                    const SizedBox(height: 16),
                    GoogleAuthButton.login(),
                    const SizedBox(height: 24),
                    AuthSwitchButton.toRegister(),
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
            "Selamat Datang",
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

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 32,
        child: TextButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text("Lupa Password?"),
        ),
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
            onPressed: _performLogin,
            style: FilledButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: (state.status == AuthStateStatus.loading)
                ? SizedBox.square(
                    dimension: 24,
                    child: CircularProgressIndicator(color: color.onPrimary),
                  )
                : const Text(
                    "Masuk",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
          ),
        );
      },
    );
  }
}
