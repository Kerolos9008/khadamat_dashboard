import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/admins/admins_view.dart';
import 'package:khadamat_dashboard/pages/mobileScreen/mobile_view.dart';
import 'package:khadamat_dashboard/pages/users/users_view.dart';
import 'package:khadamat_dashboard/services/khadamat_icons_icons.dart';
import 'package:pmvvm/pmvvm.dart';

import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<HomeViewModel>(
      view: () => const _HomeView(),
      viewModel: HomeViewModel(),
    );
  }
}

class _HomeView extends StatelessView<HomeViewModel> {
  const _HomeView();
  @override
  Widget render(BuildContext context, viewModel) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 55,
            horizontal: 80,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Row(
            children: [
              SideMenu(
                controller: viewModel.sideMenuController,
                title: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 44, vertical: 40),
                  child: Image.asset("assets/images/logo.png"),
                ),
                footer: GestureDetector(
                  onTap: viewModel.logout,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 50),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFDE0F0F),
                          size: 22,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          "تسجيل الخروج",
                          style: TextStyle(
                            color: Color(0xFFDE0F0F),
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                style: SideMenuStyle(
                  backgroundColor: Colors.white,
                  openSideMenuWidth: 260,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  itemHeight: 64,
                  itemInnerSpacing: 0,
                  displayMode: SideMenuDisplayMode.open,
                  itemOuterPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 20,
                  ),
                  itemBorderRadius: BorderRadius.circular(32),
                  selectedColor: const Color(0xFFB5D3DB),
                  hoverColor: const Color(0xFFB5D3DB).withOpacity(0.4),
                ),
                items: [
                  SideMenuItem(
                    priority: 0,
                    onTap: (index, _) {
                      viewModel.sideMenuController.changePage(index);
                    },
                    builder: (context, displayMode) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            (viewModel.sideMenuController.currentPage == 0)
                                ? KhadamatIcons.homeFilled
                                : KhadamatIcons.home,
                            color: const Color(0xFF43617D),
                            size: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "لوحة التحكم",
                            style: TextStyle(
                              color: const Color(0xFF43617D),
                              fontSize: 20,
                              fontWeight:
                                  (viewModel.sideMenuController.currentPage ==
                                          0)
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SideMenuItem(
                    priority: 1,
                    onTap: (index, _) {
                      viewModel.sideMenuController.changePage(index);
                    },
                    builder: (context, displayMode) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            (viewModel.sideMenuController.currentPage == 1)
                                ? KhadamatIcons.receiptFilled
                                : KhadamatIcons.receipt,
                            color: const Color(0xFF43617D),
                            size: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "التذاكر",
                            style: TextStyle(
                              color: const Color(0xFF43617D),
                              fontSize: 20,
                              fontWeight:
                                  (viewModel.sideMenuController.currentPage ==
                                          1)
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SideMenuItem(
                    priority: 2,
                    onTap: (index, _) {
                      viewModel.sideMenuController.changePage(index);
                    },
                    builder: (context, displayMode) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            (viewModel.sideMenuController.currentPage == 2)
                                ? KhadamatIcons.peopleFilled
                                : KhadamatIcons.people,
                            color: const Color(0xFF43617D),
                            size: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "العملاء",
                            style: TextStyle(
                              color: const Color(0xFF43617D),
                              fontSize: 20,
                              fontWeight:
                                  (viewModel.sideMenuController.currentPage ==
                                          2)
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SideMenuItem(
                    priority: 3,
                    onTap: (index, _) {
                      viewModel.sideMenuController.changePage(index);
                    },
                    builder: (context, displayMode) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            (viewModel.sideMenuController.currentPage == 3)
                                ? KhadamatIcons.profileFilled
                                : KhadamatIcons.profile,
                            color: const Color(0xFF43617D),
                            size: 24,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "الإداريين",
                            style: TextStyle(
                              color: const Color(0xFF43617D),
                              fontSize: 20,
                              fontWeight:
                                  (viewModel.sideMenuController.currentPage ==
                                          3)
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 48,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3,
                            child: CupertinoSearchTextField(
                              prefixInsets:
                                  const EdgeInsetsDirectional.only(start: 15),
                              backgroundColor: const Color(0xFFEBF5F8),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                radius: 26,
                                backgroundColor: Color(0xFFEBF5F8),
                              ),
                              const SizedBox(
                                width: 15,
                              ),
                              const Text(
                                "Kerolos Ashraf",
                                style: TextStyle(
                                  color: Color(0xFF43617D),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                width: 60,
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.notifications_outlined,
                                  color: Color(0xFF43617D),
                                  size: 28,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: PageView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: viewModel.pageController,
                        children: const [
                          SizedBox(),
                          SizedBox(),
                          UsersScreen(),
                          AdminsScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
