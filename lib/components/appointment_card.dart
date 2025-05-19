import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';
import 'button.dart';

class AppointmentCard extends StatelessWidget {
  final DateTime dateTime;
  final String status;
  final String barbershopName;
  final String address;
  final String services;
  final String imageUrl;
  final bool showActions;
  final VoidCallback? onCancel;
  final VoidCallback? onMessage;

  const AppointmentCard({
    super.key,
    required this.dateTime,
    required this.status,
    required this.barbershopName,
    required this.address,
    required this.services,
    required this.imageUrl,
    this.showActions = false,
    this.onCancel,
    this.onMessage,
  });

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'concluído':
        return Colors.green.withOpacity(0.15);
      case 'cancelado':
        return Colors.red.withOpacity(0.15);
      case 'confirmado':
        return Colors.blue.withOpacity(0.15);
      default:
        return AppColors.gray200;
    }
  }

  Color _getStatusTextColor() {
    switch (status.toLowerCase()) {
      case 'concluído':
        return Colors.green;
      case 'cancelado':
        return Colors.red;
      case 'confirmado':
        return Colors.blue;
      default:
        return AppColors.gray500;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        '${dateTime.day.toString().padLeft(2, '0')} '
        '${_getMonthName(dateTime.month)} '
        '${dateTime.year}';
    final formattedTime =
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';

    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray200),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text.rich(
                TextSpan(
                  text: '$formattedDate • ',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.gray950,
                  ),
                  children: [
                    TextSpan(
                      text: formattedTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.gray400, 
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              if (!showActions)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: _getStatusTextColor(),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 8),
            child: const Divider(),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 108,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (_, __, ___) => Container(
                        width: 80,
                        height: 108,
                        color: AppColors.gray200,
                        child: const Icon(
                          Icons.image,
                          color: AppColors.gray500,
                        ),
                      ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      barbershopName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: AppColors.gray950,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Serviços:',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: AppColors.gray700,
                      ),
                    ),
                    Text(
                      services,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showActions) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Button(
                    text: 'Cancelar',
                    variant: ButtonVariant.outline,
                    onPressed: onCancel,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Button(
                    text: 'Mensagem',
                    variant: ButtonVariant.primary,
                    onPressed: onMessage,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    return months[month - 1];
  }
}
