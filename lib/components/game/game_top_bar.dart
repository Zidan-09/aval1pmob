import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:flutter/material.dart';

class GameTopBar extends StatelessWidget {
  final AnswerCategory category;
  final Difficulty difficulty;
  final VoidCallback? onMenuPressed;

  const GameTopBar({
    super.key,
    required this.category,
    required this.difficulty,
    this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _InfoCard(label: category.labelPt)),
        const SizedBox(width: 8),
        Expanded(child: _InfoCard(label: difficulty.labelPt)),
        const SizedBox(width: 8),
        _MenuButton(onPressed: onMenuPressed),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;

  const _InfoCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 47,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(13),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const _MenuButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFD9D9D9),
      borderRadius: BorderRadius.circular(13),
      child: InkWell(
        borderRadius: BorderRadius.circular(13),
        onTap: onPressed ??
            () {
              // TODO: open session stats / back to home. Not implemented yet.
            },
        child: const SizedBox(
          width: 47,
          height: 47,
          child: Icon(
            Icons.menu,
            color: Colors.black,
            size: 28,
          ),
        ),
      ),
    );
  }
}
