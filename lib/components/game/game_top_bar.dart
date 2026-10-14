import 'package:aval1pmob/components/game/session_stats_dialog.dart';
import 'package:aval1pmob/components/game/stats_menu_button.dart';
import 'package:aval1pmob/entities/answer_category.dart';
import 'package:aval1pmob/entities/difficulty.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:flutter/material.dart';

class GameTopBar extends StatelessWidget {
  final AnswerCategory category;
  final Difficulty difficulty;
  final PlayerStats stats;
  final VoidCallback? onGoHome;

  const GameTopBar({
    super.key,
    required this.category,
    required this.difficulty,
    required this.stats,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 55),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: _LabeledCard(
                      title: 'Categoria',
                      child: _InfoCard(label: category.labelPt),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 130),
                    child: _LabeledCard(
                      title: 'Dificuldade',
                      child: _InfoCard(label: difficulty.labelPt),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 23),
              child: StatsMenuButton(
                stats: stats,
                variant: SessionStatsVariant.inGame,
                onGoHome: onGoHome,
                child: Image.asset(
                  'lib/assets/images/buttons/pause-button.png',
                  width: 47,
                  height: 47,
                  fit: BoxFit.contain,
                  semanticLabel: 'Menu',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _LabeledCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        child,
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String label;

  const _InfoCard({required this.label});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 788 / 317,
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/assets/images/buttons/panel.png'),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
