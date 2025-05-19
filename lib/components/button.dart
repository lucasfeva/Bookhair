import 'package:flutter/material.dart';
import '../data/constants/colors.dart';

enum ButtonVariant { primary, outline, ghost }

class Button extends StatelessWidget {
  final String text;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double? iconSize;

  const Button({
    super.key,
    required this.text,
    this.variant = ButtonVariant.primary,
    this.onPressed,
    this.icon,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final isPrimary = variant == ButtonVariant.primary;
    final isOutline = variant == ButtonVariant.outline;
    final isGhost = variant == ButtonVariant.ghost;

    final buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null)
          Icon(
            icon,
            size: iconSize ?? 18, 
            color: isPrimary ? Colors.white : AppColors.slate500,
          ),
        if (icon != null && text.isNotEmpty) const SizedBox(width: 8),
        if (text.isNotEmpty)
          Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.white : AppColors.slate500,
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        elevation: WidgetStateProperty.all(0),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (isPrimary) return AppColors.slate500;
          if (isGhost) return AppColors.slate500.withOpacity(0.05);
          return Colors.transparent;
        }),
        overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
          if (states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.pressed)) {
            return AppColors.slate300.withOpacity(0.15);
          }
          return null;
        }),
        foregroundColor: WidgetStateProperty.all(AppColors.slate500),
        side: WidgetStateProperty.all(
          isOutline ? BorderSide(color: AppColors.slate500) : BorderSide.none,
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        minimumSize: isGhost ? WidgetStateProperty.all(Size.zero) : null,
        padding: WidgetStateProperty.all(
          isGhost
              ? const EdgeInsets.all(22)
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        visualDensity: VisualDensity.standard,
        alignment: Alignment.center,
      ),
      child: buttonChild,
    );
  }
}