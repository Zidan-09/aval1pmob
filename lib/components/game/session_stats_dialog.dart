import 'package:aval1pmob/components/dialog/popup_panel.dart';
import 'package:aval1pmob/components/dialog/popup_style.dart';
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

    final style = PopupStyle.resolve(
      MediaQuery.sizeOf(context),
      maxDialogWidth: 400,
    );

    return PopupPanel(
      backgroundAsset: popupAsset,
      style: style,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Estatísticas da sessão',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: style.titleSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: style.gapSection),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _StatRow(
                  label: 'Rodadas',
                  value: '$total',
                  fontSize: style.labelSize,
                ),
                _StatRow(
                  label: 'Vitórias',
                  value: '$wins ($winPct%)',
                  fontSize: style.labelSize,
                ),
                _StatRow(
                  label: 'Derrotas',
                  value: '$losses ($lossPct%)',
                  fontSize: style.labelSize,
                ),
                _StatRow(
                  label: 'Erros totais',
                  value: '${stats.errors}',
                  fontSize: style.labelSize,
                ),
                _StatRow(
                  label: 'Dicas usadas',
                  value: '${stats.tipsUseds}',
                  fontSize: style.labelSize,
                  isLast: true,
                ),
              ],
            ),
          ),
          SizedBox(height: style.gapSection),
          if (variant == SessionStatsVariant.inGame)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: onGoHome,
                    style:
                        popupButtonStyle(
                          popupOptionBackground,
                          Colors.white,
                          style,
                        ).copyWith(
                          side: const WidgetStatePropertyAll(
                            BorderSide(color: popupOptionBorder),
                          ),
                        ),
                    child: const Text(
                      'Tela incial',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: ElevatedButton(
                    style: popupButtonStyle(
                      popupPrimaryBackground,
                      Colors.black,
                      style,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      'Continuar',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: popupButtonStyle(
                    popupPrimaryBackground,
                    Colors.black,
                    style,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Fechar'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  final double fontSize;
  final bool isLast;

  const _StatRow({
    required this.label,
    required this.value,
    required this.fontSize,
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
            style: TextStyle(color: Colors.white70, fontSize: fontSize),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              maxLines: 1,
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: popupPrimaryBackground,
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
