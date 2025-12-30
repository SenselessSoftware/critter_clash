import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:player_model/player.dart';
import 'package:critter_clash/providers/player_provider.dart';
import 'package:critter_clash/services/settings_service.dart';

enum FightState { initial, fighting, finished }

class FightScreen extends StatefulWidget {
  final Map<Player, String?> playerSelections;

  const FightScreen({
    super.key,
    required this.playerSelections,
  });

  @override
  State<FightScreen> createState() => _FightScreenState();
}

class _FightScreenState extends State<FightScreen> {
  static final Random _random = Random();
  final SettingsService _settingsService = SettingsService();
  FightState _fightState = FightState.initial;
  int? _winner;

  @override
  void initState() {
    super.initState();
    // Allow both portrait and landscape orientations
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    // Reset orientation when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  Future<void> _startFight() async {
    final winnerNumber = _random.nextInt(4) + 1;
    final winValue = await _settingsService.getWinValue();

    // Evict the image from the cache so it replays from the beginning
    const AssetImage('assets/images/fightclub1.gif').evict().then((value) {
      if (mounted) {
        setState(() {
          _fightState = FightState.fighting;
        });
      }
    });

    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
        final winningFighter = 'assets/images/fighter$winnerNumber.png';

        final winners = widget.playerSelections.entries
            .where((entry) => entry.value == winningFighter)
            .map((entry) => entry.key)
            .toList();

        for (final winner in winners) {
          final winnerIndex = playerProvider.players.indexWhere((p) => p.id == winner.id);
          if (winnerIndex != -1) {
            final currentScore = playerProvider.players[winnerIndex].score;
            playerProvider.updatePlayer(
              winnerIndex,
              Player(
                id: winner.id,
                name: winner.name,
                imagePath: winner.imagePath,
                score: currentScore + winValue,
              ),
            );
          }
        }

        setState(() {
          _winner = winnerNumber;
          _fightState = FightState.finished;
        });
      }
    });
  }

  Widget _buildFightContent() {
    switch (_fightState) {
      case FightState.initial:
        return Image.asset('assets/images/fightclub1.png', fit: BoxFit.contain);
      case FightState.fighting:
        return Image.asset('assets/images/fightclub1.gif', key: UniqueKey(), fit: BoxFit.contain);
      case FightState.finished:
        if (_winner != null) {
          return Image.asset('assets/images/fighter${_winner}_win.png', fit: BoxFit.contain);
        }
        return const SizedBox.shrink(); // Should not happen
    }
  }

  Widget _buildPlayerWidget(MapEntry<Player, String?> entry, {double playerImageSize = 100}) {
    final player = entry.key;
    final fighter = entry.value;
    final isWinner = _fightState == FightState.finished &&
        _winner != null &&
        fighter == 'assets/images/fighter${_winner}.png';

    ImageProvider playerImage;
    if (player.imagePath.startsWith('assets')) {
      playerImage = AssetImage(player.imagePath);
    } else {
      playerImage = FileImage(File(player.imagePath));
    }

    return Consumer<PlayerProvider>(
      builder: (context, playerProvider, child) {
        final latestPlayer = playerProvider.players.firstWhere((p) => p.id == player.id);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: isWinner
                  ? BoxDecoration(
                      border: Border.all(color: Colors.yellow, width: 4.0),
                    )
                  : null,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(backgroundImage: playerImage, radius: playerImageSize / 2),
                  if (fighter != null)
                    Positioned.fill(
                      child: Container(
                        margin: const EdgeInsets.all(25), // to make overlay smaller
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Image.asset(fighter, width: playerImageSize / 2),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('${latestPlayer.name}: ${latestPlayer.score}'),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildActionButtons() {
    if (_fightState == FightState.initial) {
      return [
        ElevatedButton(
          onPressed: _startFight,
          child: const Text('Fight!'),
        ),
      ];
    } else if (_fightState == FightState.finished) {
      return [
        ElevatedButton(
          onPressed: _startFight,
          child: const Text('Fight Again'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('New Game'),
        ),
      ];
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final activePlayers = widget.playerSelections.entries
        .where((entry) => entry.value != null)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('THE FIGHT'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: activePlayers.map((entry) => _buildPlayerWidget(entry, playerImageSize: 80)).toList(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildFightContent(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: _buildActionButtons(),
                ),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ...activePlayers.map((entry) => _buildPlayerWidget(entry)).toList(),
                      ..._buildActionButtons(),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildFightContent(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
