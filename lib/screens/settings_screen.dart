import 'package:critter_clash/providers/player_provider.dart';
import 'package:critter_clash/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final SettingsService _settingsService = SettingsService();
  final TextEditingController _winValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadWinValue();
  }

  Future<void> _loadWinValue() async {
    final winValue = await _settingsService.getWinValue();
    _winValueController.text = winValue.toString();
  }

  Future<void> _saveWinValue() async {
    final winValue = int.tryParse(_winValueController.text) ?? 1;
    await _settingsService.setWinValue(winValue);
  }

  void _showClearScoresConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Scores?'),
        content: const Text('Are you sure you want to clear all player scores? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final playerProvider = Provider.of<PlayerProvider>(context, listen: false);
              playerProvider.clearAllScores();
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _winValueController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Win Value',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                _saveWinValue();
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showClearScoresConfirmationDialog,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Clear All Scores'),
            ),
          ],
        ),
      ),
    );
  }
}
