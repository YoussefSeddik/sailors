import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class ThemedSvgIcon extends StatelessWidget {
  final String assetPath;
  final double size;
  final Color color;

  const ThemedSvgIcon({
    super.key,
    required this.assetPath,
    this.size = 24.0,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
