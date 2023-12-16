import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class TicketDescriptionWidget extends StatelessWidget {
  final Map<String, dynamic> _ticket;
  final intl.DateFormat _dateFormat = intl.DateFormat("dd/MM/yyyy");
  final intl.DateFormat _timeFormat = intl.DateFormat("hh:mm a");

  TicketDescriptionWidget(this._ticket, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
      color: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 72,
                  width: 92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(_ticket["image"]),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.grey[200],
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _ticket["customer"]["name"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1177B8),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      _ticket["description"],
                      maxLines: 5,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF414042),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _timeFormat.format(
                    DateTime.fromMillisecondsSinceEpoch(
                      _ticket["createdAt"],
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    color: Color(0xFF43617D),
                    fontSize: 10,
                  ),
                ),
                Text(
                  _dateFormat.format(
                    DateTime.fromMillisecondsSinceEpoch(
                      _ticket["createdAt"],
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    color: Color(0xFF43617D),
                    fontSize: 10,
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
