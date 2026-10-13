import 'package:aval1pmob/entities/player_stats.dart';
import 'package:flutter/material.dart';


enum SessionStatsVariant { home, inGame }

class SessionStatsDialog extends StatelessWidget {
  final PlayerStats stats;
  final SessionStatsVariant variant;
  final VoidCallback? onGoHome;

  const SessionStatsDialog({
    super.key,
    required this.stats,
    required this.variant,
    this.onGoHome,
  });

  @override
  Widget build(BuildContext context) {
    final total = stats.games.toInt();
    final wins = stats.wins.toInt();
    final losses = stats.loses.toInt();
    final winPct = stats.winsPercentage.toStringAsFixed(1);
    final lossPct = stats.lossesPercentage.toStringAsFixed(1);

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color(0xFF2B2B36),
      title: const Text('Estatísticas da sessão',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Rodadas: $total', style: const TextStyle(color: Colors.white)),
          Text('Vitórias: $wins ($winPct%)', style: const TextStyle(color: Colors.white)),
          Text('Derrotas: $losses ($lossPct%)', style: const TextStyle(color: Colors.white)),
          Text('Erros totais: ${stats.errors}', style: const TextStyle(color: Colors.white)),
          Text('Dicas usadas: ${stats.tipsUseds}', style: const TextStyle(color: Colors.white)),
        ],
      ),
      actions: [
        if (variant == SessionStatsVariant.inGame) ...[
          TextButton(
            onPressed: onGoHome, // vai para home
            child: const Text('Ir para home'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(), // continuar = só fecha
            child: const Text('Continuar'),
          ),
        ] else
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
      ],
    );
  }
}