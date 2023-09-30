import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/view_model.dart';

class UsersViewModel extends ViewModel {
  PageController pageController = PageController();
  late Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('/Users').snapshots();

  Map<String, dynamic>? toModify;

  modifyUser(Map<String, dynamic>? user) {
    toModify = user;
    notifyListeners();
    pageController.jumpToPage(2);
  }
}
