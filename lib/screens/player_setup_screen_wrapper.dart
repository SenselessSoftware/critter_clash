import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:player_model/screens/player_setup_screen.dart' as pkg;
import 'package:critter_clash/providers/player_provider.dart';
import 'package:critter_clash/screens/character_selection_screen.dart';
import 'package:critter_clash/screens/settings_screen.dart';

class PlayerSetupScreenWrapper extends StatelessWidget {
  const PlayerSetupScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final playerProvider = Provider.of<PlayerProvider>(context);

    return pkg.PlayerSetupScreen(
      players: playerProvider.players,
      onPlayersUpdated: (updatedPlayers) {
        for (int i = 0; i < updatedPlayers.length; i++) {
          if (i < playerProvider.players.length) {
            playerProvider.updatePlayer(i, updatedPlayers[i]);
          } else {
            playerProvider.addPlayer(updatedPlayers[i]);
          }
        }
      },
      onContinue: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CharacterSelectionScreen(),
          ),
        );
      },
      onSettingsPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SettingsScreen(),
          ),
        );
      },
    );
  }
}
