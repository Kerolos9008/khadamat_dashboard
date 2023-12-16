import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class MessageWidget extends StatelessWidget {
  final Map<String, dynamic> _message;
  final intl.DateFormat _dateFormat = intl.DateFormat("dd/MM/yyyy");
  final intl.DateFormat _timeFormat = intl.DateFormat("hh:mm a");

  MessageWidget(this._message, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.08,
        bottom: 8,
      ),
      color: _message["isFromAdmin"] ? const Color(0xFFCBE6F8) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 1,
                  child: _message["image"] != null
                      ? Container(
                          height: 72,
                          width: 92,
                          margin: const EdgeInsetsDirectional.only(
                            end: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              image: NetworkImage(_message["image"]!),
                              fit: BoxFit.cover,
                            ),
                            color: Colors.grey[200],
                          ),
                        )
                      : Container(),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _message["isFromAdmin"]
                        ? const Text(
                            "رد الدعم الفني",
                            style: TextStyle(
                              color: Color(0xFF1177B8),
                              fontSize: 12,
                            ),
                          )
                        : Container(),
                    Text(
                      _message["senderName"],
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
                      _message["text"],
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
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _timeFormat.format(
                    DateTime.fromMillisecondsSinceEpoch(
                      _message["createdAt"],
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
                      _message["createdAt"],
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
