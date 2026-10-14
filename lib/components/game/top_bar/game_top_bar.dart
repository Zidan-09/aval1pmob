import 'package:aval1pmob/components/game/stats/session_stats_variant.dart';
import 'package:aval1pmob/components/game/stats/stats_menu_button.dart';
import 'package:aval1pmob/components/game/top_bar/game_top_bar_slot.dart';
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
                GameTopBarSlot(title: 'Categoria', label: category.labelPt),
                const SizedBox(width: 8),
                GameTopBarSlot(title: 'Dificuldade', label: difficulty.labelPt),
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
