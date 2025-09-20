import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class NetworkImg extends StatelessWidget {
  final String? src;
  final double height;
  final String? badge;
  final double? width;

  const NetworkImg({
    super.key,
    this.src,
    required this.height,
    this.width = double.infinity,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;

    if (src != null && src!.startsWith('data:image')) {
      try {
        final String base64Str = src!.split(',').last;
        bytes = base64Decode(base64Str);
      } catch (e) {
        bytes = null; 
      }
    }
    return Stack(
      children: [
        bytes != null
            ? Image.memory(
                bytes,
                fit: BoxFit.cover,
                width: width,
                height: height,
              )
            : (src != null && src!.isNotEmpty
                ? Image.network(
                    src!,
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: height,
                        width: width,
                        color: Colors.grey[300],
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return _placeholder(height, width);
                    },
                  )
                : _placeholder(height, width)),

        // only show badge if it's non-null and non-empty
        if (badge != null && badge!.isNotEmpty)
          Positioned(
            top:  4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                badge!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
Widget _placeholder(double? height, double? width) {
  return Container(
    height: height,
    width: width,
    color: Colors.grey[300],
    child: const Icon(Icons.image_not_supported, color: Colors.grey),
  );
}
