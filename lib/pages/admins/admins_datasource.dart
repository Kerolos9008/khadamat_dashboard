import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminsDataSource extends DataTableSource {
  final BuildContext context;
  final List<QueryDocumentSnapshot<Object?>> _adminsList;
  final Function(Map<String, dynamic>?) modify;
  final Function(Map<String, dynamic>?) delete;

  AdminsDataSource(this._adminsList, this.context, {required this.modify,required this.delete});

  @override
  DataRow? getRow(int index) {
    Map<String, dynamic> data =
        _adminsList[index].data()! as Map<String, dynamic>;
    data["id"] = _adminsList[index].id;
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: MediaQuery.of(context).size.width * 0.17,
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
            width: MediaQuery.of(context).size.width * 0.17,
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
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
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
        DataCell(
          Container(
            alignment: Alignment.center,
            height: 60,
            width: MediaQuery.of(context).size.width * 0.17,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F7F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: InkWell(
              onTap: () {
                delete(data);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFDE0F0F),
                  ),
                ),
                child: const Text(
                  "حذف",
                  style: TextStyle(
                    color: Color(0xFFDE0F0F),
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
  int get rowCount => _adminsList.length;

  @override
  int get selectedRowCount => 0;
}
