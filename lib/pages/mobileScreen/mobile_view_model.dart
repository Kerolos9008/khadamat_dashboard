import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/notRegisteredScreen/not_registered_view.dart';
import 'package:khadamat_dashboard/pages/otpScreen/otp_view.dart';
import 'package:pmvvm/pmvvm.dart';

import '../../widgets/shake_widget.dart';

class MobileViewModel extends ViewModel {
  final shakeKey = GlobalKey<ShakeWidgetState>();
  bool buttonLoading = false;

  String? phoneNumber;

  void submitMobile() async {
    if (RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
        .hasMatch(phoneNumber ?? "")) {
      buttonLoading = true;
      notifyListeners();
      final user = await FirebaseFirestore.instance
          .collection("/Admins")
          .where("phone", isEqualTo: phoneNumber)
          .count()
          .get();

      if (user.count == 1) {
        FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber!).then((value) {
          buttonLoading = false;
          notifyListeners();

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                phone: phoneNumber!,
                firebaseAuthPhone: value,
              ),
            ),
          );
        });
      } else {
        buttonLoading = false;
        notifyListeners();

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const NotRegisteredScreen(),
          ),
        );
      }
    } else {
      shakeKey.currentState?.shakeWidget();
    }
  }
}
