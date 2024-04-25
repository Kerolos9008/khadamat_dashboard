import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/view_model.dart';
import 'package:uuid/uuid.dart';

import '../../models/ticket.dart';

class TicketsViewModel extends ViewModel {
  PageController pageController = PageController();

  /// all collection strem
  late Stream<QuerySnapshot> collectionStream = FirebaseFirestore.instance
      .collection('/Tickets')
      .orderBy('createdAt', descending: true)
      .snapshots();

  Map<String, dynamic>? ticket;
  final caseDescriptionShakeKey = GlobalKey<ShakeWidgetState>();

  Uint8List? image;
  String caseDescription = "";
  bool replyLoading = false;
  bool buttonLoading = false;
  bool userCanCloseTicket = false;
  bool userCanOpenTicket = false;
  String userName = "";

  pickImage(void Function(void Function()) setState) async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (file == null) return;
    image = await file.readAsBytes();
    setState(() {});
    notifyListeners();
  }

  bool validateDescription() {
    if (caseDescription.isNotEmpty) {
      return true;
    } else {
      caseDescriptionShakeKey.currentState?.shakeWidget();
      return false;
    }
  }

  submitMessage() async {
    if (validateDescription()) {
      replyLoading = true;
      notifyListeners();
      String? imageUrl;
      if (image != null) {
        final imageRef = FirebaseStorage.instance
            .ref()
            .child('images/${const Uuid().v1()}.png');
        await imageRef.putData(image!);
        imageUrl = await imageRef.getDownloadURL();
      }
      ticket!['messages'].add(
        {
          "createdAt": DateTime.now().millisecondsSinceEpoch,
          "text": caseDescription,
          "image": imageUrl,
          "senderName": userName,
          "isFromAdmin": true,
        },
      );
      await FirebaseFirestore.instance
          .collection('Tickets')
          .doc(ticket!['id'])
          .update({"messages": ticket!['messages']});
      replyLoading = false;
      notifyListeners();
      Navigator.of(context).pop();
    }
  }

  enterTicket(Map<String, dynamic>? ticket) async {
    this.ticket = ticket;
    final users = await FirebaseFirestore.instance
        .collection("/Admins")
        .where(
          "phone",
          isEqualTo: FirebaseAuth.instance.currentUser!.phoneNumber,
        )
        .get();
    userName = users.docs.first.data()["name"];
    userCanOpenTicket = users.docs.first.data()["roles"]["openTicket"];
    userCanCloseTicket = users.docs.first.data()["roles"]["closeTicket"];
    notifyListeners();
    pageController.jumpToPage(2);
  }

  closeTicket() async {
    buttonLoading = true;
    notifyListeners();
    ticket?["status"] = 2;
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticket!['id'])
        .update({"status": ticket!['status']});
    buttonLoading = false;
    notifyListeners();
  }

  openTicket() async {
    buttonLoading = true;
    notifyListeners();
    ticket?["status"] = 0;
    await FirebaseFirestore.instance
        .collection('Tickets')
        .doc(ticket!['id'])
        .update({"status": ticket!['status']});
    buttonLoading = false;
    notifyListeners();
  }

  late Stream<DocumentSnapshot<Object?>> stream = FirebaseFirestore.instance
      .collection('collectionName')
      .doc(ticket!['id'])
      .snapshots();
  late StreamSubscription<DocumentSnapshot<Object?>> subscription =
      stream.listen((DocumentSnapshot<Object?> snapshot) {
    if (snapshot.exists) {
      // Document data is available
      var data = snapshot.data();
      print('Document data: $data');
    } else {
      // Document doesn't exist
      print('Document does not exist.');
    }
  });

  late Stream<DocumentSnapshot<Map<String, dynamic>>> streamSubscription  =FirebaseFirestore.instance
      .collection('/Tickets')
      .doc(ticket?["id"]).snapshots();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  late Stream<QuerySnapshot> openTicketsStream = FirebaseFirestore.instance
      .collection('/Tickets')
      .doc(ticket!['id']).withConverter<Ticket>(
      fromFirestore: (snapshot, _) => Ticket.fromFirestore(snapshot),
      toFirestore: (ticket, _) => {})
      .snapshots() as Stream<QuerySnapshot<Object?>>;
}
//