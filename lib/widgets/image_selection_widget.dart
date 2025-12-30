import 'dart:io';
//import 'package:critter_clash/widgets/avatar_selection_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player_model/widgets/avatar_selection_dialog.dart';

class ImageSelectionWidget extends StatefulWidget {
  final Function(String) onImageSelected;
  final String? initialImagePath;
  final double radius;

  const ImageSelectionWidget({
    super.key,
    required this.onImageSelected,
    this.initialImagePath,
    this.radius = 50,
  });

  @override
  State<ImageSelectionWidget> createState() => _ImageSelectionWidgetState();
}

class _ImageSelectionWidgetState extends State<ImageSelectionWidget> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = widget.initialImagePath;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
      widget.onImageSelected(pickedFile.path);
    }
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Image Source'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text('Avatars'),
              onTap: () {
                Navigator.of(context).pop();
                _showAvatarDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAvatarDialog() {
    showDialog(
      context: context,
      builder: (context) => AvatarSelectionDialog(
        onAvatarSelected: (avatarPath) {
          setState(() {
            _imagePath = avatarPath;
          });
          widget.onImageSelected(avatarPath);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider? backgroundImage;
    if (_imagePath != null) {
      if (_imagePath!.startsWith('assets')) {
        backgroundImage = AssetImage(_imagePath!);
      } else {
        backgroundImage = FileImage(File(_imagePath!));
      }
    }

    return GestureDetector(
      onTap: _showImageSourceDialog,
      child: CircleAvatar(
        radius: widget.radius,
        backgroundImage: backgroundImage,
        child: _imagePath == null ? Icon(Icons.add_a_photo, size: widget.radius) : null,
      ),
    );
  }
}
