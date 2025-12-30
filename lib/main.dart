import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critter_clash/providers/player_provider.dart';
import 'package:critter_clash/screens/player_setup_screen_wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlayerProvider(),
      child: MaterialApp(
        title: 'Critter Clash',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const PlayerSetupScreenWrapper(),
      ),
    );
  }
}
