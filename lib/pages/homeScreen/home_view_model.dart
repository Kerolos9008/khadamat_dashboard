import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/mobileScreen/mobile_view.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeViewModel extends ViewModel {
  SideMenuController sideMenuController = SideMenuController();
  PageController pageController = PageController();
  Map? user;
  String searchValue = "";

  @override
  void init() {
    FirebaseFirestore.instance
        .collection("/Admins")
        .where(
          "phone",
          isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber,
        )
        .get()
        .then((value) {
      user = value.docs.first.data();
      notifyListeners();
    });

    sideMenuController.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.init();
  }

  void search(String value) {
    searchValue = value;
    notifyListeners();
  }

  logout() {
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
            'تسجيل الخروج',
            style: TextStyle(
              color: Color(0xFFDE0F0F),
              fontSize: 24,
            ),
          ),
        ),
        content: const Center(
          heightFactor: 1.5,
          child: Text(
            'هل أنت متأكد من تسجيل الخروج؟',
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
                'تسجيل الخروج',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MobileScreen(),
                ),
                (route) => true,
              );
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
