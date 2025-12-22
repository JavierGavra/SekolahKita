import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroSlideView extends StatelessWidget {
  const IntroSlideView({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  final String icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          Container(
            height: 130,
            width: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: title.contains("Pantau")
                  ? color.primary
                  : color.surfaceContainer,
            ),
            child: SizedBox(
              child: SvgPicture.asset(
                icon,
                height: 64,
                width: 64,
                fit: BoxFit.none,
              ),
            ),
          ),
          const SizedBox(height: 50),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              height: 1.417,
              color: () {
                if (title.contains("Membaca") || title.contains("Pantau")) {
                  return color.primary;
                } else if (title.contains("Menulis")) {
                  return color.tertiary;
                } else if (title.contains("Numerasi")) {
                  return color.secondary;
                }
              }(),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 332,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                height: 1.625,
                color: color.onSurfaceVariant.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
