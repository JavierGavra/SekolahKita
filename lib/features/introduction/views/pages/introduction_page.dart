import 'package:flutter/material.dart';
import 'package:sekolah_kita/core/constant/svg_assets.dart';
import 'package:sekolah_kita/core/utils/navigate/navigate.dart';
import 'package:sekolah_kita/features/introduction/views/widgets/intro_slide_view.dart';
import 'package:sekolah_kita/features/navigation/views/pages/bottom_navigation.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<Widget> get slideViews => [
    IntroSlideView(
      icon: SvgAssets.introReadingIcon,
      title: 'Belajar Membaca',
      description:
          'Tingkatkan kemampuan literasi membaca dengan modul yang mudah dipahami dan menyenangkan',
    ),
    IntroSlideView(
      icon: SvgAssets.introWritingIcon,
      title: 'Belajar Menulis',
      description:
          'Kembangkan keterampilan menulis dengan latihan yang terstruktur dan interaktif',
    ),
    IntroSlideView(
      icon: SvgAssets.introNumerationIcon,
      title: 'Belajar Numerasi',
      description:
          'Kuasai dasar-dasar matematika dan berhitung dengan cara yang sederhana',
    ),
    IntroSlideView(
      icon: SvgAssets.introEndIcon,
      title: 'Pantau Progress',
      description:
          'Lihat perkembangan belajarmu dan raih pencapaian baru setiap hari',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _skipToLastPage() {
    _pageController.animateToPage(
      slideViews.length - 1,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _nextPage() {
    if (_currentPage < slideViews.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigate.pushReplacement(context, BottomNavigation());
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final isLastPage = _currentPage == slideViews.length - 1;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 68),
          Visibility(
            visible: !isLastPage,
            maintainAnimation: true,
            maintainSize: true,
            maintainState: true,
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: TextButton(
                  onPressed: isLastPage ? null : _skipToLastPage,
                  child: Text(
                    "Lewati",
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: color.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          Expanded(
            child: PageView(controller: _pageController, children: slideViews),
          ),
          _buildPageIndicator(),
          SizedBox(height: 32),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16),
            child: FilledButton(
              onPressed: _nextPage,
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                isLastPage ? "Mulai Sekarang" : "Lanjutkan",
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ),
          SizedBox(height: 130),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        slideViews.length,
        (index) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 32 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
