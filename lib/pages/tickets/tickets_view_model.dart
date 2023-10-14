import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/view_model.dart';

class TicketsViewModel extends ViewModel {
  PageController pageController = PageController();
  late Stream<QuerySnapshot> collectionStream =
      FirebaseFirestore.instance.collection('/Tickets').snapshots();

  Map<String, dynamic>? toModify;

  modifyUser(Map<String, dynamic>? user) {
    toModify = user;
    notifyListeners();
    pageController.jumpToPage(2);
  }
}
