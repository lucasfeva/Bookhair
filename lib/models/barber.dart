import 'package:flutter/material.dart';

class Barber {
  final String name;
  final String? role;
  final String? imageUrl;
  final Color backgroundColor;
  final int? id;
  final int? barbeariaId;

  const Barber({
    required this.name,
    this.role,
    this.imageUrl,
    this.backgroundColor = const Color(0xFFE4E4E7),
    this.id,
    this.barbeariaId,
  });
}
