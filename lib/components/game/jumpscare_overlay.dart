import 'package:flutter/material.dart';

class JumpscareOverlay extends StatelessWidget {
  final String imageAsset;

  const JumpscareOverlay({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        child: SizedBox.expand(
          child: Image(image: AssetImage(imageAsset), fit: BoxFit.cover),
        ),
      ),
    );
  }
}
