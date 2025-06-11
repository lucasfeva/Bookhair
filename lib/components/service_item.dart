import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:bookhair/screens/agendarservico.dart';
import 'package:provider/provider.dart';
import '../core/api_client.dart';

class ServiceItem extends StatelessWidget {
  final String name;
  final String price;
  final int serviceId;

  const ServiceItem({
    super.key,
    required this.name,
    required this.price,
    required this.serviceId,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final token =
            Provider.of<ApiClient>(context, listen: false).token ?? '';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => AgendarServicoScreen(
                  token: token,
                  serviceId: serviceId,
                  serviceName: name,
                ),
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}
