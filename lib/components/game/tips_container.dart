import 'package:aval1pmob/entities/word_challenge.dart';
import 'package:flutter/material.dart';

const Duration kTipsAutoCloseDuration = Duration(seconds: 5);

const Color kTipsBackgroundColor = Color(0xFFD9D9D9);

class TipsContainer extends StatefulWidget {
  final WordChallenge challenge;
  final VoidCallback? onHintUsed;

  const TipsContainer({super.key, required this.challenge, this.onHintUsed});

  @override
  State<TipsContainer> createState() => _TipsContainerState();
}

class _TipsContainerState extends State<TipsContainer> {
  int shownIndex = 0;
  bool usedThisRound = false;

  void _showHint() {
    if (!widget.challenge.hasTips) return;

    final tip = widget.challenge.hints[shownIndex];
    if (shownIndex < widget.challenge.hints.length - 1) {
      shownIndex++;
    }

    if (!usedThisRound) {
      usedThisRound = true;
      widget.onHintUsed?.call();
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        Future.delayed(kTipsAutoCloseDuration, () {
          if (dialogContext.mounted && Navigator.of(dialogContext).canPop()) {
            Navigator.of(dialogContext).pop();
          }
        });
        return AlertDialog(
          title: const Text('Dica'),
          content: Text(tip),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasTips = widget.challenge.hasTips;
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: hasTips ? _showHint : null,
        child: Opacity(
          opacity: hasTips ? 1.0 : 0.4,
          child: Image.asset(
            'lib/assets/images/dailog.png',
            width: 47,
            height: 47,
            fit: BoxFit.contain,
            semanticLabel: 'Dica',
          ),
        ),
      ),
    );
  }
}
