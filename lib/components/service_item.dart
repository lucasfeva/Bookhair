import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatelessWidget {
  final String name;
  final String price;

  const ServiceItem({super.key, required this.name, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, color: AppColors.gray950),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.gray500,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
