// lib/features/quiz/views/quiz_review_screen.dart

import 'package:flutter/material.dart';
import '../models/quiz_models.dart';

class QuizReviewScreen extends StatefulWidget {
  final QuizResult result;
  final Quiz quiz;

  const QuizReviewScreen({super.key, required this.result, required this.quiz});

  @override
  State<QuizReviewScreen> createState() => _QuizReviewScreenState();
}

class _QuizReviewScreenState extends State<QuizReviewScreen> {
  String _filter = 'all';

  List<QuestionResult> get _filteredQuestions {
    if (_filter == 'correct') {
      return widget.result.questionResults.where((q) => q.isCorrect).toList();
    } else if (_filter == 'wrong') {
      return widget.result.questionResults.where((q) => !q.isCorrect).toList();
    }
    return widget.result.questionResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF1A6585)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('📝', style: TextStyle(fontSize: 28)),
            SizedBox(width: 12),
            Text(
              'Lihat Jawaban',
              style: TextStyle(
                color: Color(0xFF1A6585),
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Big Filter Buttons
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: _buildBigFilterButton(
                    emoji: '📚',
                    label: 'Semua',
                    count: widget.result.questionResults.length,
                    value: 'all',
                    color: const Color(0xFF1A6585),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBigFilterButton(
                    emoji: '✅',
                    label: 'Benar',
                    count: widget.result.correctAnswers,
                    value: 'correct',
                    color: const Color(0xFF4CAF50),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBigFilterButton(
                    emoji: '❌',
                    label: 'Salah',
                    count: widget.result.wrongAnswers,
                    value: 'wrong',
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),

          // Questions List
          Expanded(
            child: _filteredQuestions.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('🎉', style: TextStyle(fontSize: 80)),
                        const SizedBox(height: 20),
                        Text(
                          _filter == 'wrong' ? 'Sempurna!' : 'Tidak ada soal',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: _filteredQuestions.length,
                    itemBuilder: (context, index) {
                      final questionResult = _filteredQuestions[index];
                      return _buildReviewCard(questionResult);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBigFilterButton({
    required String emoji,
    required String label,
    required int count,
    required String value,
    required Color color,
  }) {
    final isSelected = _filter == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          _filter = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(colors: [color, color.withOpacity(0.8)])
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey[300]!,
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: color.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 6),
              ),
          ],
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 32)),
            const SizedBox(height: 8),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(QuestionResult questionResult) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: questionResult.isCorrect
              ? const Color(0xFF4CAF50)
              : Colors.red,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color:
                (questionResult.isCorrect
                        ? const Color(0xFF4CAF50)
                        : Colors.red)
                    .withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Header
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: questionResult.isCorrect
                        ? [const Color(0xFF4CAF50), const Color(0xFF66BB6A)]
                        : [Colors.red[400]!, Colors.red[600]!],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '${questionResult.questionNumber}',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: questionResult.isCorrect
                        ? const Color(0xFF4CAF50).withOpacity(0.15)
                        : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        questionResult.isCorrect ? '✅' : '❌',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        questionResult.isCorrect ? 'BENAR' : 'SALAH',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: questionResult.isCorrect
                              ? const Color(0xFF4CAF50)
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Question Text
          Text(
            questionResult.questionText,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          // Answer Options
          ...questionResult.options.asMap().entries.map((entry) {
            final idx = entry.key;
            final option = entry.value;
            final letter = String.fromCharCode(65 + idx);
            final isCorrect = option.id == questionResult.correctAnswerId;
            final isSelected = questionResult.selectedOptionIds.contains(
              option.id,
            );

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: isCorrect
                    ? const LinearGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
                      )
                    : null,
                color: isCorrect
                    ? null
                    : (isSelected && !isCorrect
                          ? Colors.red[50]
                          : Colors.grey[100]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isCorrect
                      ? Colors.transparent
                      : (isSelected && !isCorrect
                            ? Colors.red
                            : Colors.grey[300]!),
                  width: 3,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: isCorrect
                          ? Colors.white
                          : (isSelected && !isCorrect
                                ? Colors.red
                                : Colors.white),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isCorrect
                            ? Colors.white
                            : (isSelected && !isCorrect
                                  ? Colors.red
                                  : Colors.grey[400]!),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isCorrect
                              ? const Color(0xFF4CAF50)
                              : (isSelected && !isCorrect
                                    ? Colors.white
                                    : Colors.black54),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      option.text,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isCorrect
                            ? Colors.white
                            : (isSelected && !isCorrect
                                  ? Colors.red[700]
                                  : Colors.black87),
                      ),
                    ),
                  ),
                  if (isCorrect || (isSelected && !isCorrect))
                    Text(
                      isCorrect ? '✅' : '❌',
                      style: const TextStyle(fontSize: 32),
                    ),
                ],
              ),
            );
          }),

          // Motivational Message for wrong answers
          if (!questionResult.isCorrect) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  Text('💡', style: TextStyle(fontSize: 32)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Jangan sedih! Belajar dari kesalahan membuat kita lebih pintar!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
