import 'package:flutter/material.dart';

class SensitivityWidget extends StatelessWidget {
  const SensitivityWidget({
    Key? key,
    required this.sensitivity,
  }) : super(key: key);

  final SensitivityEnum sensitivity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: sensitivity.index == 0
            ? const Color(0xFF669B2D).withOpacity(0.2)
            : sensitivity.index == 1
                ? const Color(0xFFFFA800).withOpacity(0.2)
                : const Color(0xFFDE0F0F).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Text(
        sensitivity.index == 0
            ? "منخفضة الأهمية"
            : sensitivity.index == 1
                ? "متوسطة الأهمية"
                : "عالية الأهمية",
        style: TextStyle(
          color: sensitivity.index == 0
              ? const Color(0xFF669B2D)
              : sensitivity.index == 1
                  ? const Color(0xFFFFA800)
                  : const Color(0xFFDE0F0F),
          fontSize: 14,
        ),
      ),
    );
  }
}

enum SensitivityEnum {
  high,
  medium,
  low,
}
