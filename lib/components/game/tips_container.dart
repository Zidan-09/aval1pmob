import 'package:flutter/material.dart';

const Duration kTipsAutoCloseDuration = Duration(seconds: 5);

const Color kTipsBackgroundColor = Color(0xFFD9D9D9);

class TipsContainer extends StatelessWidget {
  final String hint;

  const TipsContainer({super.key, required this.hint});

  void _showHint(BuildContext context) {
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
          content: Text(hint),
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
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: kTipsBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        child: InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: () => _showHint(context),
          child: const SizedBox(
            width: 47,
            height: 47,
            child: Icon(Icons.lightbulb_outline, color: Colors.black, size: 26),
          ),
        ),
      ),
    );
  }
}
