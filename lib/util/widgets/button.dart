import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reward_center_kiosk/util/theme.dart'; 

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool loading;
  final IconData? icon;
  final bool disabled;
  final Color? color;
  final Color? textColor;
  final EdgeInsets? padding;
  final double? fontSize;

  const MyButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.loading = false,
      this.disabled = false,
      this.icon,
      this.color,
      this.textColor,
      this.padding = const EdgeInsets.all(0) ,
      this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: AppTheme.style.copyWith(fontSize: fontSize),
        padding: padding, 
        // minimumSize: const Size(double.infinity, 24),
        backgroundColor: disabled
            ? Theme.of(context).disabledColor
            : color ?? Theme.of(context).colorScheme.primary,
        foregroundColor: disabled
            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.38)
            : textColor ?? Theme.of(context).colorScheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: AppTheme.borderRadius,
        ),
        disabledBackgroundColor:
            (color ?? Theme.of(context).colorScheme.primary).withOpacity(0.38),
        disabledForegroundColor: Colors.white,
      ),
      onPressed: disabled ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: fontSize),
            const SizedBox(width: 8),
          ],
          Text(label.tr),
        ],
      ),
    );
  }
}
