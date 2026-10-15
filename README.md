# Jogo da Forca do Sonic.exe

## Integrantes

- Paulo Henrique Alves Vieira
- Samuel da Penha Nascimento
- Gabriel Lima Silva Oliveira
- Erick Vieira da Silva Costa

## Breve descrição

Jogo da Forca temática do universo **Sonic.exe** desenvolvido em **Flutter** como trabalho de avaliação da disciplina de Programação Mobile (AVAL1 - PMOB).

O jogador escolhe uma **categoria** e uma **dificuldade**, tenta adivinhar a palavra secreta usando um teclado virtual e, a cada erro, a figura do Sonic avança (até 6 erros). O jogo conta com sistema de dicas, evita repetição de palavras na sessão e exibe estatísticas de desempenho.

Dados das palavras/desafios carregados localmente a partir de JSON (`lib/assets/data/hangman.json`).

## Principais funcionalidades

- **Tela inicial (Home)**
  - Botão Começar com animação.
  - Botão Sobre.
  - Acesso rápido às estatísticas da sessão.
  - Fundo e artes personalizadas do Sonic.

- **Configuração da partida**
  - Seleção de categoria: Animais, Corpo humano, Esportes, Tecnologia.
  - Seleção de dificuldade: Fácil, Médio, Difícil.
  - Validação: impede iniciar combinação sem palavras restantes na sessão.

- **Tela de jogo**
  - Figura da forca progressiva com imagens do Sonic (`0.jpg` a `6.jpg`, máximo de 6 erros).
  - Exibição da resposta com letras reveladas / ocultas (`_`).
  - Teclado virtual com letras já usadas desabilitadas.
  - Contador de erros (`Erros: X/6`).
  - Barra superior com categoria e dificuldade da rodada.
  - Suporte a acentos via normalização (ex.: `A` acerta `Ã`, `Ç`, etc.).

- **Dicas**
  - Contêiner de dicas por desafio.
  - Contabiliza dicas usadas nas estatísticas.

- **Fluxo de rodada**
  - Sorteio sem repetição por sessão (repositório controla palavras já usadas).
  - Diálogo de resultado (vitória/derrota) com resposta, erros e dicas usadas.
  - Ações: nova rodada, trocar categoria/dificuldade ou voltar ao início.
  - Revela resposta completa em caso de derrota.

- **Estatísticas da sessão**
  - Total de partidas, vitórias, derrotas, erros acumulados, dicas usadas.
  - Percentual de vitórias/derrotas.
  - Diálogo acessível na Home e durante o jogo.

- **Tela Sobre**
  - Apresentação do jogo e lista dos membros da equipe com arte dos personagens.
  - Tecnologias utilizadas.

## Tecnologias utilizadas

- **Flutter** (Material Design)
- **Dart** (`sdk: ^3.13.2`)
- Pacotes:
  - `cupertino_icons: ^1.0.8`
  - `flutter_lints: ^6.0.0` (dev)
  - `flutter_launcher_icons: ^0.14.4` (dev)
  - `flutter_test` (dev, SDK)
- Assets locais: imagens (`lib/assets/images/`, `sonic/`, `characters/`), dados JSON (`lib/assets/data/hangman.json`)
- Arquitetura simples por camadas:
  - `lib/screens/` — Home, Game, About
  - `lib/components/` — widgets reutilizáveis por contexto (`app/`, `about/`, `dialog/`, `home/` com `setup/`, `game/` com `keyboard/`, `top_bar/`, `board/`, `result/`, `stats/`, `tips/`)
  - `lib/entities/` — `WordChallenge`, `GameRound`, `PlayerStats`, `Difficulty`, `AnswerCategory`, `TeamMember`
  - `lib/services/` + `lib/utils/` — repositório de desafios, parsing JSON e normalização de texto

## Instruções para obtenção e execução do projeto

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado (compatível com Dart `^3.13.2`).
- Android Studio / VS Code com extensões Flutter + Dart (opcional, mas recomendado).
- Emulador Android, iOS Simulator, navegador (Chrome) ou dispositivo físico com depuração USB.
- Git instalado.

Verifique a instalação:

```bash
flutter doctor
```

### 1. Obter o projeto

Clone o repositório (substitua pela URL real do seu repositório):

```bash
git clone https://github.com/Zidan-09/hangman_game.git
cd hangman_game
```

Ou, se já recebeu a pasta do projeto, apenas abra a pasta `hangman_game` no terminal/VS Code.

### 2. Instalar dependências

```bash
flutter pub get
```

### 3. Executar o projeto

Listar dispositivos disponíveis:

```bash
flutter devices
```

Rodar em modo debug (escolha um dispositivo conectado):

```bash
flutter run
```

Para rodar em dispositivo específico:

```bash
flutter run -d chrome
flutter run -d android
```

### Estrutura resumida

```
lib/
  main.dart                    # Inicialização, carrega repositório JSON
  load_error_app.dart          # Tela de erro de carregamento dos dados
  screens/                     # home.dart, game.dart, about.dart
  components/
    app/                       # scaffold base + fundo da status bar
    about/                     # cards dos membros da equipe
    dialog/                    # primitivos de popup (painel, estilo, título)
    home/                      # botão da home + setup/ (diálogo de configuração)
    game/
      keyboard/                # teclado virtual
      top_bar/                 # barra superior da partida
      board/                   # figura da forca + exibição da resposta
      result/                  # diálogo de resultado + jumpscare
      stats/                   # estatísticas da sessão
      tips/                    # contêiner de dicas
  entities/                    # regras da rodada, estatísticas e enums
  services/ + utils/           # repositório WordChallenge + JSON
  assets/
    images/ (backgrounds/ + buttons/ + characters/ + sonic/ + logo/)
    data/hangman.json
```
