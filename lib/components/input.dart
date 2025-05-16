import 'package:bookhair/data/constants/colors.dart';
import 'package:flutter/material.dart';

enum InputType { search, text, password }

class CustomInput extends StatefulWidget {
  final String label;
  final String hintText;
  final IconData icon;
  final IconData? actionIcon;
  final InputType type;
  final VoidCallback? onActionPressed;
  final TextEditingController? controller;

  const CustomInput({
    super.key,
    this.label = '',
    required this.hintText,
    required this.icon,
    this.actionIcon,
    this.type = InputType.text,
    this.onActionPressed,
    this.controller,
  });

  @override
  State<CustomInput> createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    final isPassword = widget.type == InputType.password;
    final isSearch = widget.type == InputType.search;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(widget.label),
          ),
        TextField(
          controller: widget.controller,
          obscureText: isPassword ? obscureText : false,
          style: const TextStyle(color: AppColors.gray400),
          decoration: InputDecoration(
            prefixIcon: Icon(widget.icon, color: AppColors.gray400),
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColors.gray400),
            suffixIcon:
                isPassword
                    ? IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.gray400,
                      ),
                      onPressed:
                          () => setState(() => obscureText = !obscureText),
                    )
                    : (widget.actionIcon != null
                        ? IconButton(
                          icon: Icon(
                            widget.actionIcon,
                            color: AppColors.gray400,
                          ),
                          onPressed: widget.onActionPressed,
                        )
                        : null),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  isSearch
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.gray200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  isSearch
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.gray200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  isSearch
                      ? BorderSide.none
                      : const BorderSide(color: AppColors.gray200),
            ),
            filled: isSearch,
            fillColor: isSearch ? AppColors.gray800 : null,
          ),
        ),
      ],
    );
  }
}
