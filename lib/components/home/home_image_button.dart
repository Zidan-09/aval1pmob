import 'package:flutter/material.dart';

class HomeImageButton extends StatelessWidget {
  final VoidCallback onTap;
  final Animation<double> scale;
  final String imageAsset;
  final double? width;
  final String? semanticLabel;

  const HomeImageButton({
    super.key,
    required this.onTap,
    required this.scale,
    required this.imageAsset,
    this.width,
    this.semanticLabel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: ClipRect(
        child: Align(
          alignment: Alignment.center,
          heightFactor: 0.6,
          child: ScaleTransition(
            scale: scale,
            child: Image.asset(
              imageAsset,
              width: width,
              fit: BoxFit.contain,
              semanticLabel: semanticLabel,
            ),
          ),
        ),
      ),
    );
  }
}
