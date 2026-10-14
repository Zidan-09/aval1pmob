import 'package:aval1pmob/components/about/member_card.dart';
import 'package:aval1pmob/components/app/app_scaffold.dart';
import 'package:aval1pmob/entities/team_member.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  static const String backgroundAsset =
      'lib/assets/images/backgrounds/about-background.png';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgrounds: [
        Image.asset(backgroundAsset, fit: BoxFit.cover),
        Container(color: Colors.black.withValues(alpha: 0.6)),
      ],
      children: [
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, top: 2),
                  child: Material(
                    color: Colors.black54,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      tooltip: 'Voltar',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'SOBRE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'MEMBROS DA EQUIPE E INFORMAÇÕES TRABALHO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Jogo da Forca inspirado no universo de Sonic.exe ',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                      const SizedBox(height: 12),
                      ...teamMembers.map(
                        (member) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: MemberCard(member: member),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'DESENVOLVIDO EM EQUIPE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'TECNOLOGIAS: FLUTTER • DART',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 11,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
