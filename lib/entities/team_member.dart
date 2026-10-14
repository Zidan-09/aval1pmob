class TeamMember {
  final String name;
  final String role;
  final String? imageAsset;

  const TeamMember({required this.name, required this.role, this.imageAsset});
}

const String charactersPath = 'lib/assets/images/characters';

const List<TeamMember> teamMembers = [
  TeamMember(
    name: 'Samuel da Penha Nascimento',
    role: 'Lógica do jogo e dados',
    imageAsset: '$charactersPath/shadow-select.png',
  ),
  TeamMember(
    name: 'Gabriel Lima Silva Oliveira',
    role: 'Telas e jogabilidade',
    imageAsset: '$charactersPath/tails-select.png',
  ),
  TeamMember(
    name: 'Paulo Henrique Alves Vieira',
    role: 'Popups e interface',
    imageAsset: '$charactersPath/werehog-select.png',
  ),
  TeamMember(
    name: 'Erick Vieira da Silva Costa',
    role: 'Regras de letras e tela Sobre',
    imageAsset: '$charactersPath/sonic-select.png',
  ),
];
