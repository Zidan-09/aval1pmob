import 'package:aval1pmob/entities/player_stats.dart';
import 'package:flutter/material.dart';

enum SessionStatsVariant { home, inGame }

class SessionStatsDialog extends StatelessWidget {
  static const String popupAsset = 'lib/assets/images/buttons/panel-popup.png';

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

    final size = MediaQuery.sizeOf(context);
    final sidePadding = (size.width * 0.10).clamp(36.0, 52.0);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.05,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 400,
          maxHeight: size.height * 0.90,
        ),
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: const DecorationImage(
              image: AssetImage(popupAsset),
              fit: BoxFit.fill,
              centerSlice: Rect.fromLTWH(24, 24, 460, 444),
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(sidePadding, 56, sidePadding, 48),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Estatísticas da sessão',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _StatRow(label: 'Rodadas', value: '$total'),
                      _StatRow(label: 'Vitórias', value: '$wins ($winPct%)'),
                      _StatRow(label: 'Derrotas', value: '$losses ($lossPct%)'),
                      _StatRow(label: 'Erros totais', value: '${stats.errors}'),
                      _StatRow(
                        label: 'Dicas usadas',
                        value: '${stats.tipsUseds}',
                        isLast: true,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 17),
                if (variant == SessionStatsVariant.inGame)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: onGoHome,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3A3A46),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        
                          side: const BorderSide(color: Colors.white24),
                        ),
                        child: const Text('Tela incial'),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Continuar'),
                      ),
                    ],
                  )
                  
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                          shape: const StadiumBorder(),
                          textStyle: const TextStyle(fontSize: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          minimumSize: const Size(0, 32),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isLast;

  const _StatRow({
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
