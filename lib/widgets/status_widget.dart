import 'package:flutter/material.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  final StatusEnum status;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: status.index == 0
            ? const Color(0xFF669B2D).withOpacity(0.2)
            : status.index == 1
                ? const Color(0xFF8A8A8A).withOpacity(0.2)
                : const Color(0xFFDE0F0F).withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      child: Text(
        status.index == 0
            ? "مفتوحة"
            : status.index == 1
                ? "إنتهت"
                : "مغلقة",
        style: TextStyle(
          color: status.index == 0
              ? const Color(0xFF669B2D)
              : status.index == 1
                  ? const Color(0xFF8A8A8A)
                  : const Color(0xFFDE0F0F),
          fontSize: 14,
        ),
      ),
    );
  }
}

enum StatusEnum {
  open,
  closed,
  done,
}
