import 'package:flutter/material.dart';

class HangmanFigure extends StatelessWidget {
  final int errors;

  const HangmanFigure({super.key, required this.errors});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 190,
      child: Stack(
        children: [
          // Poste vertical da forca.
          Positioned(
            left: 16,
            top: 0,
            child: Container(width: 8, height: 190, color: Colors.brown[800]),
          ),
          // Trave horizontal da forca.
          Positioned(
            left: 16,
            top: 0,
            child: Container(width: 110, height: 8, color: Colors.brown[800]),
          ),
          // Corda.
          Positioned(
            left: 112,
            top: 8,
            child: Container(width: 4, height: 22, color: Colors.brown[300]),
          ),
          // Boneco pendurado na corda.
          Positioned(
            left: 74,
            top: 30,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _BodyPart(visible: errors >= 1, child: _head),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _BodyPart(visible: errors >= 3, child: _arm),
                    _BodyPart(visible: errors >= 2, child: _trunk),
                    _BodyPart(visible: errors >= 4, child: _arm),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _BodyPart(visible: errors >= 5, child: _leg),
                    const SizedBox(width: 6),
                    _BodyPart(visible: errors >= 6, child: _leg),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _head = _PartBox.rounded(34);

  static const _trunk = _PartBox.bar(10, 48);

  static const _arm = _PartBox.bar(26, 8);

  static const _leg = _PartBox.bar(10, 40);
}

class _BodyPart extends StatelessWidget {
  final bool visible;
  final Widget child;

  const _BodyPart({required this.visible, required this.child});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: child,
    );
  }
}

class _PartBox extends StatelessWidget {
  final double width;
  final double height;
  final bool rounded;

  const _PartBox.bar(this.width, this.height) : rounded = false;

  const _PartBox.rounded(double size)
    : width = size,
      height = size,
      rounded = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: rounded ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: rounded ? null : BorderRadius.circular(4),
      ),
    );
  }
}
