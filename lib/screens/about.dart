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
                    padding: const EdgeInsets.only(left: 8, top: 2),
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
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
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
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...teamMembers.map(
                          (member) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _MemberCard(member: member),
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
      padding: const EdgeInsets.fromLTRB(8, 5, 12, 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22).withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12),
        border: const Border(
          left: BorderSide(color: Colors.redAccent, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _MemberArtwork(imageAsset: member.imageAsset, name: member.name),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  member.role,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
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

class _MemberArtwork extends StatelessWidget {
  final String? imageAsset;
  final String name;

  const _MemberArtwork({this.imageAsset, required this.name});

  static const double _aspect = 9 / 16;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final double width = (screenWidth * 0.21).clamp(60.0, 76.0).toDouble();
    final double height = width / _aspect;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: imageAsset == null
          ? const Icon(
              Icons.person_outline,
              color: Colors.white38,
              size: 36,
            )
          : Image.asset(
              imageAsset!,
              width: width,
              height: height,
              fit: BoxFit.contain,
              semanticLabel: name,
            ),
    );
  }
}