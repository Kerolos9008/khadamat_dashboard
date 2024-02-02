import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/services/toast_service.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/view_model.dart';

class AddAdminViewModel extends ViewModel {
  AddAdminViewModel({
    required this.admin,
    required this.onBackPressed,
  });
  final void Function() onBackPressed;
  final Map<String, dynamic>? admin;
  String? phoneNumber;
  String? name;

  bool checkboxTouched = false;
  bool buttonLoading = false;
  bool closeTicket = false;
  bool openTicket = false;
  bool addAdmins = false;

  final mobileShakeKey = GlobalKey<ShakeWidgetState>();
  final nameShakeKey = GlobalKey<ShakeWidgetState>();
  final checkboxShakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void init() {
    name = admin?["name"];
    phoneNumber = admin?["phone"];
    openTicket = admin?["roles"]?["openTicket"] ?? false;
    closeTicket = admin?["roles"]?["closeTicket"] ?? false;
    addAdmins = admin?["roles"]?["addAdmins"] ?? false;
    super.init();
  }

  bool checkRole() {
    return closeTicket || openTicket || addAdmins || !checkboxTouched;
  }

  void toggleCloseTicket(bool? value) {
    closeTicket = value ?? false;
    checkboxTouched = true;
    notifyListeners();
  }

  void toggleOpenTicket(bool? value) {
    openTicket = value ?? false;
    checkboxTouched = true;
    notifyListeners();
  }

  void toggleAddAdmins(bool? value) {
    addAdmins = value ?? false;
    checkboxTouched = true;
    notifyListeners();
  }

  bool validateMobile() {
    if (RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
        .hasMatch(phoneNumber ?? "")) {
      return true;
    } else {
      mobileShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateName() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validatecheckBoxGroup() {
    checkboxTouched = true;
    if (checkRole()) {
      return true;
    } else {
      checkboxShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  submit() async {
    if (validateName() && validateMobile() && validatecheckBoxGroup()) {
      buttonLoading = true;
      notifyListeners();
      final users = await FirebaseFirestore.instance
          .collection("/Admins")
          .where(
            "phone",
            isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber,
          )
          .get();
      final userCanAddAdmins = users.docs.first.data()["roles"]["addAdmins"];
      if (userCanAddAdmins == false) {
        buttonLoading = false;
        notifyListeners();
        ToastService.showErrorToast(message: "ليس لديك الصلاحيات المطلوبة");
        return;
      }
      final count = await FirebaseFirestore.instance
          .collection("/Admins")
          .where("phone", isEqualTo: phoneNumber)
          .count()
          .get();

      if (count.count == 0) {
        await FirebaseFirestore.instance.collection("/Admins").add({
          "name": name,
          "phone": phoneNumber,
          "roles": {
            "openTicket": openTicket,
            "closeTicket": closeTicket,
            "addAdmins": addAdmins,
          },
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "updatedAt": DateTime.now().millisecondsSinceEpoch,
        });
        buttonLoading = false;
        notifyListeners();

        onBackPressed();
        ToastService.showSuccessToast(message: "تم اضافة الاداري بنجاح");
      } else if (admin != null && count.count == 1) {
        await FirebaseFirestore.instance
            .collection("/Admins")
            .doc(admin!["id"])
            .set({
          "name": name,
          "phone": phoneNumber,
          "roles": {
            "openTicket": openTicket,
            "closeTicket": closeTicket,
            "addAdmins": addAdmins,
          },
          "createdAt": admin?["createdAt"],
          "updatedAt": DateTime.now().millisecondsSinceEpoch,
        });
        buttonLoading = false;
        notifyListeners();

        onBackPressed();
        ToastService.showSuccessToast(
            message: "تم تعديل صلاحيات الاداري بنجاح");
      } else {
        buttonLoading = false;
        notifyListeners();

        ToastService.showErrorToast(message: "هذا الرقم موجود بالفعل");
      }
    } else {
      buttonLoading = false;
      notifyListeners();

      return;
    }
  }
}
