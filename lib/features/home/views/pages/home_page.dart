import 'package:flutter/material.dart';
import 'package:sekolah_kita/features/home/views/widgets/greeting_card.dart';
import 'package:sekolah_kita/features/home/views/widgets/header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          HeaderSection(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lanjutkan Belajar',
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                GreetingCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
