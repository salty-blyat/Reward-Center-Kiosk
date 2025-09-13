import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:reward_center_kiosk/util/theme.dart'; 

class Avartar extends StatelessWidget {
  final String? imageUrl; // Base64 or network image URL
  final double? iconSize;
  final isCircular;

  const Avartar({
    super.key,
    this.imageUrl,
    this.isCircular = true,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    if (imageUrl != null && imageUrl!.startsWith('data:image')) {
      try {
        final String base64Str = imageUrl!.split(',').last;
        bytes = base64Decode(base64Str);
      } catch (e) {
        bytes = null; // If decoding fails, fallback to icon
      }
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          shape: isCircular ? BoxShape.circle : BoxShape.rectangle,
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.2),
            width: 1,
          ),
          color: Colors.black.withOpacity(0.05),
        ),
        child: ClipRRect(
          borderRadius: isCircular
              ? BorderRadius.circular(100)
              : BorderRadius.circular(0),
          child: bytes != null
              ? Image.memory(bytes, fit: BoxFit.contain)
              : imageUrl != null && imageUrl!.isNotEmpty
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return _buildIcon();
                      },
                    )
                  : _buildIcon(),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Center(
        child: Icon(Icons.person_outline_outlined, size: iconSize),
      ),
    );
  }
}
