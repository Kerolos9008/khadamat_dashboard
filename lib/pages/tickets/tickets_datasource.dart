import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/widgets/sensitivity_widget.dart';
import 'package:khadamat_dashboard/widgets/status_widget.dart';

class TicketsDataSource extends DataTableSource {
  final BuildContext context;
  final List<QueryDocumentSnapshot<Object?>> _ticketsList;
  final Function(Map<String, dynamic>?) open;

  TicketsDataSource(
    this._ticketsList,
    this.context, {
    required this.open,
  });

  @override
  DataRow? getRow(int index) {
    Map<String, dynamic> data =
        _ticketsList[index].data()! as Map<String, dynamic>;
    data["id"] = _ticketsList[index].id;
    print(data);
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 147.616,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              data["customer"]["project"],
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 147.616,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              DateTime.fromMillisecondsSinceEpoch(data["createdAt"])
                  .toString()
                  .split(" ")[0],
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["id"],
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["customer"]["building"],
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["customer"]["appartment"],
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["service"],
              textDirection: TextDirection.ltr,
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: SensitivityWidget(
              sensitivity: SensitivityEnum.values[data["sensitivity"]],
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 147.616,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["customer"]["name"],
              textDirection: TextDirection.rtl,
              style: const TextStyle(
                color: Color(0xFF43617D),
                fontSize: 20,
              ),
            ),
          ),
        ),
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: StatusWidget(
              status: StatusEnum.values[data["status"]],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _ticketsList.length;

  @override
  int get selectedRowCount => 0;
}
