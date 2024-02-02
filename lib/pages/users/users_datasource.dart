import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource {
  final BuildContext context;
  final List<QueryDocumentSnapshot<Object?>> _usersList;
  final Function(Map<String, dynamic>?) modify;

  UsersDataSource(
    this._usersList,
    this.context, {
    required this.modify,
  });

  @override
  DataRow? getRow(int index) {
    Map<String, dynamic> data =
        _usersList[index].data()! as Map<String, dynamic>;
    data["id"] = _usersList[index].id;
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: 167.616,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Text(
              data["name"],
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
            width: 167.616,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["phone"],
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
            width: 167.616,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
            ),
            child: Text(
              data["project"],
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
              data["building"],
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
              data["appartment"],
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
              data["ticketCount"].toString(),
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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: InkWell(
              onTap: () {
                modify(data);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF43617D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "تعديل",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _usersList.length;

  @override
  int get selectedRowCount => 0;
}
