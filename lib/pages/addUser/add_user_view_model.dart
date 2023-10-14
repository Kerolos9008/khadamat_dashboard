import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/services/toast_service.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/view_model.dart';

class AddUserViewModel extends ViewModel {
  AddUserViewModel({
    required this.user,
    required this.onBackPressed,
  });
  final void Function() onBackPressed;
  final Map<String, dynamic>? user;
  String? phoneNumber;
  String? name;
  String? project;
  String? building;
  String? appartment;

  bool buttonLoading = false;

  final mobileShakeKey = GlobalKey<ShakeWidgetState>();
  final nameShakeKey = GlobalKey<ShakeWidgetState>();
  final projectShakeKey = GlobalKey<ShakeWidgetState>();
  final buildingShakeKey = GlobalKey<ShakeWidgetState>();
  final appartmentShakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void init() {
    name = user?["name"];
    phoneNumber = user?["phone"];
    project = user?["project"];
    building = user?["building"];
    appartment = user?["appartment"];

    super.init();
  }

  bool validateMobile() {
    if (RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
        .hasMatch(phoneNumber ?? "")) {
      return true;
    } else {
      debugPrint(name);
      mobileShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateName() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      debugPrint(name);
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateProject() {
    if (project?.isNotEmpty ?? false) {
      return true;
    } else {
      debugPrint(name);
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateBuilding() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      debugPrint(name);
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateAppartment() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      debugPrint(name);
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  submit() async {
    if (validateName() &&
        validateMobile() &&
        validateProject() &&
        validateBuilding() &&
        validateAppartment()) {
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
          .collection("/Users")
          .where("phone", isEqualTo: phoneNumber)
          .count()
          .get();

      if (count.count == 0 && user == null) {
        await FirebaseFirestore.instance.collection("/Users").add({
          "name": name,
          "phone": phoneNumber,
          "project": project,
          "building": building,
          "appartment": appartment,
          "ticketCount": 0,
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "updatedAt": DateTime.now().millisecondsSinceEpoch,
        });
        buttonLoading = false;
        notifyListeners();

        onBackPressed();
        ToastService.showSuccessToast(message: "تم اضافة الاداري بنجاح");
      } else if (user != null && count.count == 1) {
        await FirebaseFirestore.instance
            .collection("/Users")
            .doc(user!["id"])
            .set({
          "name": name,
          "phone": phoneNumber,
          "project": project,
          "building": building,
          "appartment": appartment,
          "ticketCount": user?["ticketCount"],
          "createdAt": user?["createdAt"],
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
