import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/widgets/sensitivity_widget.dart';

class TicketDetailsWidget extends StatelessWidget {
  final Map<String, dynamic> _ticket;

  const TicketDetailsWidget(this._ticket, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFF3F7F8),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _ticket["title"],
                      style: const TextStyle(
                        color: Color(0xFF1177B8),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      _ticket["status"] == 0
                          ? "مفتوحة"
                          : _ticket["status"] == 1
                              ? "إنتهت"
                              : "مغلقة",
                      style: TextStyle(
                        color: _ticket["status"] == 0
                            ? const Color(0xFF669B2D)
                            : _ticket["status"] == 1
                                ? const Color(0xFF8A8A8A)
                                : const Color(0xFFDE0F0F),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SensitivityWidget(
                  sensitivity: SensitivityEnum.values[_ticket["sensitivity"]],
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 19,
                      color: Color(0xFF414042),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "مشروع ${_ticket["customer"]["project"]} / عمارة ${_ticket["customer"]["building"]} / شقة ${_ticket["customer"]["appartment"]}",
                      style: const TextStyle(
                        color: Color(0xFF414042),
                        fontSize: 19,
                      ),
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xFFE7F2F9),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Text(
                    _ticket["service"],
                    style: const TextStyle(
                      color: Color(0xFF1177B8),
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
