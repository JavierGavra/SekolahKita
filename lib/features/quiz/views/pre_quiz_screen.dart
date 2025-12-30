// lib/features/quiz/views/pre_quiz_screen.dart

import 'package:flutter/material.dart';
import '../models/quiz_models.dart';
import '../services/quiz_services.dart';
import '../views/widgets/quiz_widgets.dart';
import 'quiz_screen.dart';

class PreQuizScreen extends StatefulWidget {
  final String moduleId;

  const PreQuizScreen({super.key, required this.moduleId});

  @override
  State<PreQuizScreen> createState() => _PreQuizScreenState();
}

class _PreQuizScreenState extends State<PreQuizScreen>
    with SingleTickerProviderStateMixin {
  final QuizService _quizService = QuizService();
  Quiz? _quiz;
  bool _isLoading = true;
  late AnimationController _bounceController;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    _loadQuiz();

    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _bounceAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  Future<void> _loadQuiz() async {
    try {
      final quiz = await _quizService.getQuiz(widget.moduleId);
      setState(() {
        _quiz = quiz;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Gagal memuat quiz: $e')));
      }
    }
  }

  void _startQuiz() {
    if (_quiz != null) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              QuizScreen(quiz: _quiz!),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.easeInOutCubic;
            var tween = Tween(
              begin: begin,
              end: end,
            ).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A6585)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('🎮', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 24),
                  const CircularProgressIndicator(
                    color: Color(0xFF1A6585),
                    strokeWidth: 6,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Menyiapkan Quiz...',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A6585),
                    ),
                  ),
                ],
              ),
            )
          : _quiz == null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('😕', style: TextStyle(fontSize: 80)),
                  const SizedBox(height: 16),
                  const Text(
                    'Ups! Ada masalah',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _loadQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A6585),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 48,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 8,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Coba Lagi',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Character mascot with greeting
                  const CharacterAvatar(emoji: '🦁', message: 'Siap belajar?'),
                  const SizedBox(height: 28),

                  // Course Title with emoji
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF1A6585), Color(0xFF2196F3)],
                      ),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1A6585).withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text('🎯', style: TextStyle(fontSize: 56)),
                        const SizedBox(height: 16),
                        Text(
                          _quiz!.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Quiz Info Card
                  QuizInfoCard(
                    totalQuestions: _quiz!.totalQuestions,
                    timeLimit: _quiz!.timeLimit,
                    questionTypes: _quiz!.questionTypes.join(', '),
                    passingScore: _quiz!.passingScore,
                  ),
                  const SizedBox(height: 24),

                  // Simplified Rules
                  QuizRulesList(rules: _quiz!.rules),
                  const SizedBox(height: 40),

                  // Big Start Button with animation
                  AnimatedBuilder(
                    animation: _bounceAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, -_bounceAnimation.value),
                        child: child,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _startQuiz,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('🚀', style: TextStyle(fontSize: 36)),
                            SizedBox(width: 16),
                            Text(
                              'MULAI!',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }
}
