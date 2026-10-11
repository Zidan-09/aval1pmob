import 'package:aval1pmob/entities/word_challenge.dart';
import 'package:flutter/material.dart';

const Duration kTipsAutoCloseDuration = Duration(seconds: 5);

const Color kTipsBackgroundColor = Color(0xFFD9D9D9);
class TipsContainer extends StatefulWidget {
  final WordChallenge challenge;

  const TipsContainer({super.key, required this.challenge});

  @override
  State<TipsContainer> createState() => _TipsContainerState();
}

class _TipsContainerState extends State<TipsContainer> {
  late String tip;

  void _showHint() {
    if (!widget.challenge.hasTips) return;

    setState(() {
      tip = widget.challenge.consumeTip();
    });

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
      child: Material(
        color: kTipsBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: hasTips ? _showHint : null,
          child: SizedBox(
            width: 47,
            height: 47,
            child: Icon(
              Icons.lightbulb_outline,
              color: hasTips ? Colors.black : Colors.black38,
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
