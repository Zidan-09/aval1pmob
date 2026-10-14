import 'package:flutter/material.dart';

class MemberArtwork extends StatelessWidget {
  final String? imageAsset;
  final String name;

  const MemberArtwork({super.key, this.imageAsset, required this.name});

  static const double aspect = 9 / 16;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double width = (screenWidth * 0.21).clamp(60.0, 76.0).toDouble();
    final double height = width / aspect;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: imageAsset == null
          ? const Icon(Icons.person_outline, color: Colors.white38, size: 36)
          : Image.asset(
              imageAsset!,
              width: width,
              height: height,
              fit: BoxFit.contain,
              semanticLabel: name,
            ),
    );
  }
}
