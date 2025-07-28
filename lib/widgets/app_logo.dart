import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatelessWidget {
  final double? width;
  final double? height;
  const AppLogo({super.key, this.width = 120, this.height = 120});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoAsset = isDark
        ? 'assets/images/logo.svg'
        : 'assets/images/light-logo.svg';
    return SvgPicture.asset(
      logoAsset,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
