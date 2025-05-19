import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';

enum BarberCardVariant { showcase, selectable }

class BarberCard extends StatelessWidget {
  final String name;
  final String? role;
  final String? imageUrl;
  final Color backgroundColor;
  final BarberCardVariant variant;
  final VoidCallback? onTap;
  final bool isSelected;

  const BarberCard({
    super.key,
    required this.name,
    this.role,
    this.imageUrl,
    this.backgroundColor = AppColors.gray200,
    this.variant = BarberCardVariant.showcase,
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final isSelectable = variant == BarberCardVariant.selectable;
    final showRole = role != null && variant == BarberCardVariant.showcase;

    final avatar = CircleAvatar(
      radius: isSelectable ? 32 : 36,
      backgroundColor: backgroundColor,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
      child:
          imageUrl == null
              ? const Icon(Icons.person, size: 30, color: AppColors.gray500)
              : null,
    );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        avatar,
        const SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.gray900,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (showRole)
          Text(
            role!,
            style: const TextStyle(fontSize: 13, color: AppColors.gray500),
          ),
      ],
    );

    final widget =
        isSelectable
            ? GestureDetector(onTap: onTap, child: content)
            : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.gray200),
                borderRadius: BorderRadius.circular(16),
              ),
              child: content,
            );

    return SizedBox(width: 100, child: widget);
  }
}
