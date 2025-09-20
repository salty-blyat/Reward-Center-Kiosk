import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/util/theme.dart';

class PlayerClassBadge extends StatelessWidget {
  const PlayerClassBadge({super.key, required this.playerClass, this.size = 14});
  final double size;
  final String playerClass;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
          color: AppTheme.primaryColor.withAlpha(20),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(
            Icons.star_outline,
            color: AppTheme.primaryColor,
            size: size,
          ),
          const SizedBox(
            width: 4,
          ),
          Text(playerClass,
              style: TextStyle(
                  fontSize: size,
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
