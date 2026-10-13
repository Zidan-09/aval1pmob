import 'package:flutter/material.dart';

class TeamMember {
  final String name;
  final String role;
  final String? imageAsset;

  const TeamMember({required this.name, required this.role, this.imageAsset});
}

const String _charactersPath = 'lib/assets/images/characters';

const List<TeamMember> teamMembers = [
    TeamMember(
    name: 'Samuel da Penha Nascimento',
    role: 'Responsabilidade a definir',
    imageAsset: '$_charactersPath/shadow-select.png',
  ),
    TeamMember(
    name: 'Gabriel Lima Silva Oliveira',
    role: 'Responsabilidade a definir',
    imageAsset: '$_charactersPath/tails-select.png',
  ),
    TeamMember(
    name: 'Paulo Henrique Alves Vieira',
    role: 'Responsabilidade a definir',
    imageAsset: '$_charactersPath/werehog-select.png',
  ),
  TeamMember(
    name: 'Erick Vieira da Silva Costa',
    role: 'Responsabilidade a definir',
    imageAsset: '$_charactersPath/sonic-select.png',
  ),
];

class AboutScreen extends StatelessWidget {
  static const String backgroundAsset =
      'lib/assets/images/about-background.png';

  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundAsset, fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.6)),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, top: 4),
                    child: Material(
                      color: Colors.black54,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        tooltip: 'Voltar',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'SOBRE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'MEMBROS DA EQUIPE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Jogo da Forca inspirado no universo de Sonic.exe, ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...teamMembers.map(
                          (member) => Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _MemberCard(member: member),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'DESENVOLVIDO EM EQUIPE',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'TECNOLOGIAS: FLUTTER • DART',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 12,
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
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  final TeamMember member;

  const _MemberCard({required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Colors.redAccent, width: 4),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _MemberArtwork(imageAsset: member.imageAsset, name: member.name),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    member.role,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberArtwork extends StatelessWidget {
  final String? imageAsset;
  final String name;

  const _MemberArtwork({this.imageAsset, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 132,
      height: 220,
      color: Colors.black45,
      alignment: Alignment.center,
      child: imageAsset == null
          ? const Icon(
              Icons.person_outline,
              color: Colors.white38,
              size: 48,
            )
          : Image.asset(
              imageAsset!,
              width: 132,
              height: 220,
              fit: BoxFit.contain,
              semanticLabel: name,
            ),
    );
  }
}
