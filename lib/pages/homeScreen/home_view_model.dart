import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:pmvvm/pmvvm.dart';

class HomeViewModel extends ViewModel {
  SideMenuController sideMenuController = SideMenuController();
  PageController pageController = PageController();

  @override
  void init() {
    sideMenuController.addListener((index) {
      pageController.jumpToPage(index);
    });
    super.init();
  }
}
