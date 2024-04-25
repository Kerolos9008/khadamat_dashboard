import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/services/toast_service.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/view_model.dart';
import 'package:dio/dio.dart';

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
  String? location;
  String? appartment;

  bool buttonLoading = false;

  final mobileShakeKey = GlobalKey<ShakeWidgetState>();
  final nameShakeKey = GlobalKey<ShakeWidgetState>();
  final projectShakeKey = GlobalKey<ShakeWidgetState>();
  final buildingShakeKey = GlobalKey<ShakeWidgetState>();
  final appartmentShakeKey = GlobalKey<ShakeWidgetState>();
  final locationShakeKey = GlobalKey<ShakeWidgetState>();

  @override
  void init() {
    name = user?["name"];
    phoneNumber = user?["phone"];
    project = user?["project"];
    building = user?["building"];
    appartment = user?["appartment"];
    location = user?["location"];

    super.init();
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

  bool validateProject() {
    if (project?.isNotEmpty ?? false) {
      return true;
    } else {
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateBuilding() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateAppartment() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      nameShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  bool validateLocation() {
    if (name?.isNotEmpty ?? false) {
      return true;
    } else {
      locationShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  submit() async {
    if (validateName() &&
        validateMobile() &&
        validateProject() &&
        validateBuilding() &&
        validateAppartment() &&
        validateLocation()) {
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
          "location": location,
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
          "location": user?["location"],
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

  update() async {
    if (validateName() &&
        validateMobile() &&
        validateProject() &&
        validateBuilding() &&
        validateAppartment() &&
        validateLocation()) {
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

      DocumentReference docRef =
          FirebaseFirestore.instance.collection("/Users").doc(user!["id"]);
      print("this is docRef $docRef");

      // query to check if the number changed is used in another collection or not except this one
      Query query = FirebaseFirestore.instance
          .collection("/Users")
          .where(FieldPath.documentId, isNotEqualTo: docRef.id);

      print("this is query ${query.count()}");

      QuerySnapshot querySnapshot = await query.get();

      bool isUsed = false;

      if (querySnapshot.docs.isEmpty) {
        isUsed = false;
        notifyListeners();
        print('The number is not used in any documents.');
      } else {
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          // Retrieve the "phone" field value
          var phone = doc.get('phone');
          if (phoneNumber == phone) {
            isUsed = true;
            notifyListeners();
            print('The number is used in ${querySnapshot.docs.length} documents.');

          }
          print('Phone: $phone');
        }
      }

      if(isUsed){
        ToastService.showErrorToast(message: "هذا الرقم موجود بالفعل");
        buttonLoading = false;
        notifyListeners();
      } else if(isUsed == false){
          await FirebaseFirestore.instance.collection("/Users").doc(docRef.id).update({
            "name": name,
            "phone": phoneNumber,
            "project": project,
            "building": building,
            "appartment": appartment,
            "location": location,
            "ticketCount": 0,
            "createdAt": DateTime.now().millisecondsSinceEpoch,
            "updatedAt": DateTime.now().millisecondsSinceEpoch,
          });
          buttonLoading = false;
          notifyListeners();
          onBackPressed();
          ToastService.showSuccessToast(message: "تم التعديل بنجاح");
      }

      // else {
      //   buttonLoading = false;
      //   notifyListeners();
      //   ToastService.showErrorToast(
      //       message: "حدث خطأ ما يرجي المحاولة مرة اخري");
      // }

    } else {
      buttonLoading = false;
      notifyListeners();
      return;
    }
  }

  Future<void> addPhoneNumberForTesting(String phoneNumber) async {
    String accessToken = 'YOUR_ACCESS_TOKEN';
    String projectId = "khadamat-f5821";

    String url =
        'https://firebase.googleapis.com/v1beta1/projects/$projectId/testPhoneNumbers';

    try {
      final dio = Dio();
      dio.options.headers['Authorization'] = 'Bearer $accessToken';
      dio.options.headers['Content-Type'] = 'application/json';

      final response = await dio.post(
        url,
        data: {
          'phoneNumber': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        print('Phone number added for testing');
      } else {
        print('Failed to add phone number for testing');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
