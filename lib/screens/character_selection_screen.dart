import 'dart:io';
import 'package:critter_clash/screens/fight_screen.dart';
import 'package:critter_clash/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:player_model/player.dart';

class CharacterSelectionScreen extends StatefulWidget {
  const CharacterSelectionScreen({super.key});

  @override
  State<CharacterSelectionScreen> createState() => _CharacterSelectionScreenState();
}

class _CharacterSelectionScreenState extends State<CharacterSelectionScreen> {
  final List<String> _fighters = [
    'assets/images/fighter1.png',
    'assets/images/fighter2.png',
    'assets/images/fighter3.png',
    'assets/images/fighter4.png',
  ];

  final Map<Player, String?> _playerSelections = {};
  bool _didPrecache = false;

  @override
  void initState() {
    super.initState();
    final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    for (var player in playerProvider.players) {
      _playerSelections[player] = null;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_didPrecache) {
      precacheImage(const AssetImage('assets/images/fightclub1.gif'), context);
      precacheImage(const AssetImage('assets/images/fightclub1.png'), context);
      _didPrecache = true;
    }
  }

  void _clearSelections() {
    setState(() {
      _playerSelections.updateAll((key, value) => null);
    });
  }

  @override
  Widget build(BuildContext context) {
    final players = Provider.of<PlayerProvider>(context).players;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Your Fighter'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final bool isPortrait = orientation == Orientation.portrait;

          final fighterGrid = Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isPortrait ? 2 : 2,
                childAspectRatio: isPortrait ? 1.0 : 2.0,
              ),
              itemCount: _fighters.length,
              itemBuilder: (context, index) {
                final fighter = _fighters[index];
                return DragTarget<Player>(
                  builder: (context, candidateData, rejectedData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        fighter,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                  onAccept: (player) {
                    setState(() {
                      _playerSelections[player] = fighter;
                    });
                  },
                );
              },
            ),
          );

          final playerWidgets = players.map((player) {
            final selectedFighter = _playerSelections[player];
            ImageProvider playerImage;
            if (player.imagePath.startsWith('assets')) {
              playerImage = AssetImage(player.imagePath, package: 'player_model');
            } else {
              playerImage = FileImage(File(player.imagePath));
            }

            return Draggable<Player>(
              data: player,
              feedback: CircleAvatar(backgroundImage: playerImage, radius: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(backgroundImage: playerImage, radius: isPortrait ? 40 : 50),
                      if (selectedFighter != null)
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(isPortrait ? 15 : 25),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Image.asset(selectedFighter, width: isPortrait ? 40 : 50),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text('${player.name}: ${player.score}'),
                  ),
                ],
              ),
            );
          }).toList();

          final buttons = isPortrait
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _clearSelections,
                      child: const Text('Clear'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FightScreen(
                              playerSelections: _playerSelections,
                            ),
                          ),
                        );
                      },
                      child: const Text('Fight'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FightScreen(
                              playerSelections: _playerSelections,
                            ),
                          ),
                        );
                      },
                      child: const Text('Fight'),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: _clearSelections,
                      child: const Text('Clear'),
                    ),
                  ],
                );

          if (isPortrait) {
            return Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: playerWidgets,
                  ),
                ),
                fighterGrid,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: buttons,
                ),
              ],
            );
          } else {
            return Row(
              children: [
                SizedBox(
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: playerWidgets,
                  ),
                ),
                fighterGrid,
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: buttons,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
