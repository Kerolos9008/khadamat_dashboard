import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/homeScreen/home_view.dart';
import 'package:khadamat_dashboard/services/toast_service.dart';
import 'package:pmvvm/pmvvm.dart';

class OTPViewModel extends ViewModel {
  final String phoneNumber;
  ConfirmationResult firebaseAuthPhone;

  OTPViewModel(this.phoneNumber, this.firebaseAuthPhone);

  DateTime resendTimer = DateTime.now().add(
    const Duration(minutes: 2),
  );
  String resendTimerText = "2:00";
  bool allowResend = false;
  bool buttonLoading = false;
  String otp = "";

  @override
  init() {
    setTimerInterval();
  }

  setTimerInterval() {
    resendTimer = DateTime.now().add(
      const Duration(minutes: 2),
    );
    allowResend = false;
    resendTimerText = "1:59";

    Timer.periodic(const Duration(seconds: 1), (timer) {
      Duration remaining = resendTimer.difference(DateTime.now());
      resendTimerText = remaining.toString().substring(3, 7);
      if (remaining.inSeconds <= 0) {
        timer.cancel();
        allowResend = true;
      }
      notifyListeners();
    });
  }

  resendOTP() async {
    if (allowResend) {
      firebaseAuthPhone =
          await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
    }
  }

  verifyOTP() {
    buttonLoading = true;
    notifyListeners();
    debugPrint(otp);
    firebaseAuthPhone.confirm(otp).then((value) {
      debugPrint(value.toString());
      buttonLoading = false;
      notifyListeners();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => true,
      );
    }).catchError((error) {
      buttonLoading = false;
      notifyListeners();
      ToastService.showErrorToast(message: "الرقم الذي ادخلته غير صحيح");
    });
  }
}
