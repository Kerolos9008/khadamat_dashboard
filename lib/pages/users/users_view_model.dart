import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/view_model.dart';

class UsersViewModel extends ViewModel {
  PageController pageController = PageController();
  late Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('/Admins').snapshots();

  Map<String, dynamic>? toModify;

  modifyAdmin(Map<String, dynamic>? admin) {
    toModify = admin;
    notifyListeners();
    pageController.jumpToPage(2);
  }

  deleteAdmin(Map<String, dynamic>? admin) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) => AlertDialog(
        alignment: Alignment.center,
        actionsAlignment: MainAxisAlignment.spaceAround,
        buttonPadding: const EdgeInsets.all(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Center(
          heightFactor: 1.5,
          child: Text(
            'تأكيد الحذف',
            style: TextStyle(
              color: Color(0xFFDE0F0F),
              fontSize: 24,
            ),
          ),
        ),
        content: const Center(
          heightFactor: 1.5,
          child: Text(
            'هل أنت متأكد من حذف الإداري بدر ابراهيم؟',
            style: TextStyle(
              color: Color(0xFF43617D),
              fontSize: 24,
            ),
          ),
        ),
        elevation: 2,
        actions: [
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF43617D),
                  )),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.15,
              child: const Text(
                'تراجع',
                style: TextStyle(
                  color: Color(0xFF43617D),
                  fontSize: 20,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFDE0F0F),
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.15,
              child: const Text(
                'حذف',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            onTap: () {
              FirebaseFirestore.instance
                  .collection("/Admins")
                  .doc(admin!["id"])
                  .delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
      context: context,
    );
  }
}
