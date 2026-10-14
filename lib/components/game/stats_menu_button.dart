import 'package:aval1pmob/components/game/session_stats_dialog.dart';
import 'package:aval1pmob/components/game/session_stats_variant.dart';
import 'package:aval1pmob/entities/player_stats.dart';
import 'package:flutter/material.dart';

class StatsMenuButton extends StatelessWidget {
  final PlayerStats stats;
  final SessionStatsVariant variant;
  final VoidCallback? onGoHome;
  final Widget child;
  final BorderRadius borderRadius;

  const StatsMenuButton({
    super.key,
    required this.stats,
    required this.variant,
    required this.child,
    this.onGoHome,
    this.borderRadius = const BorderRadius.all(Radius.circular(13)),
  });

  void _open(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => SessionStatsDialog(
        stats: stats,
        variant: variant,
        onGoHome: onGoHome == null
            ? null
            : () {
                Navigator.of(dialogContext).pop();
                onGoHome!();
              },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: borderRadius,
      onTap: () => _open(context),
      child: child,
    );
  }
}
