import 'package:flutter/material.dart';

/*
class AvatarSelectionDialog extends StatelessWidget {
  final Function(String) onAvatarSelected;

  const AvatarSelectionDialog({super.key, required this.onAvatarSelected});

  @override
  Widget build(BuildContext context) {
    final List<String> avatars = [
      'assets/images/avatars/male01.png',
      'assets/images/avatars/male02.png',
      'assets/images/avatars/male03.png',
      'assets/images/avatars/male04.png',
      'assets/images/avatars/male05.png',
      'assets/images/avatars/male06.png',
      'assets/images/avatars/male07.png',
      'assets/images/avatars/male08.png',
      'assets/images/avatars/male09.png',
      'assets/images/avatars/male10.png',
      'assets/images/avatars/male11.png',
      'assets/images/avatars/male12.png',
      'assets/images/avatars/female01.png',
      'assets/images/avatars/female02.png',
      'assets/images/avatars/female03.png',
      'assets/images/avatars/female04.png',
      'assets/images/avatars/female05.png',
      'assets/images/avatars/female06.png',
      'assets/images/avatars/female07.png',
      'assets/images/avatars/female08.png',
      'assets/images/avatars/female09.png',
      'assets/images/avatars/female10.png',
      'assets/images/avatars/female11.png',
      'assets/images/avatars/female12.png',
      'assets/images/avatars/blankPlayer.jpg',
    ];

    return AlertDialog(
      title: const Text('Select an Avatar'),
      content: SizedBox(
        width: double.maxFinite,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: avatars.length,
          itemBuilder: (context, index) {
            final avatar = avatars[index];
            return GestureDetector(
              onTap: () {
                onAvatarSelected(avatar);
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                backgroundImage: AssetImage(avatar),
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}

 */
