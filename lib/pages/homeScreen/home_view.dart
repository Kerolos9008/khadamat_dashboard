import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/admins/admins_view.dart';
import 'package:khadamat_dashboard/pages/tickets/tickets_view.dart';
import 'package:khadamat_dashboard/pages/users/users_view.dart';
import 'package:khadamat_dashboard/services/khadamat_icons_icons.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
  bool isDesktop =   ResponsiveBreakpoints.of(context).isDesktop;
    return Scaffold(
      appBar: !isDesktop ? AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title:  Image.asset("assets/images/logo.png", scale: 2,),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF43617D),
                size: 40,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
      )  : null,
      drawer:!isDesktop ?  Drawer(
        surfaceTintColor: Colors.blue,
        shadowColor: Colors.blue,
        child: sideMenu(viewModel, context),
      ) : const SizedBox.shrink(),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Container(
            padding:  EdgeInsets.symmetric(
              vertical: 55,
              horizontal: isDesktop ? 80 : 20,
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Row(
              children: [
                if(isDesktop)
              sideMenu(viewModel, context),
                const SizedBox(
                  width: 48,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ///search bar
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
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: CupertinoSearchTextField(
                                prefixInsets:
                                    const EdgeInsetsDirectional.only(start: 15),
                                backgroundColor: const Color(0xFFEBF5F8),
                                borderRadius: BorderRadius.circular(24),
                                onChanged: viewModel.search,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Color(0xFFEBF5F8),
                                  child: Image(
                                    image:
                                        AssetImage('assets/images/profile.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  (viewModel.user != null)
                                      ? viewModel.user!["name"]
                                      : "Loading...",
                                  style: const TextStyle(
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
                      //////////
                      const SizedBox(height: 25),
                      Expanded(
                        child: PageView(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: viewModel.pageController,
                          children: [
                            TicketsScreen(viewModel.searchValue),
                            UsersScreen(viewModel.searchValue),
                            AdminsScreen(viewModel.searchValue),
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
      ),
    );
  }

  SideMenu sideMenu(HomeViewModel viewModel, BuildContext context) {
    return SideMenu(
        controller: viewModel.sideMenuController,
        title: Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 44, vertical: 30),
          child: Image.asset("assets/images/logo.png"),
        ),
        alwaysShowFooter: true,
        footer: InkWell(
          onTap: viewModel.logout,
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            width: MediaQuery.of(context).size.width,
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const  Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFDE0F0F),
                  size: 22,
                ),
                if( ResponsiveBreakpoints.of(context).isDesktop  )
                  const Row(
                    children: [
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


              ],
            ),
          ),
        ),
        style: SideMenuStyle(
          backgroundColor: Colors.white,
          openSideMenuWidth: 260,
          compactSideMenuWidth: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          itemHeight: 64,
          itemInnerSpacing: 0,
          displayMode: SideMenuDisplayMode.auto,

          itemOuterPadding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          itemBorderRadius: BorderRadius.circular(32),
          selectedColor: const Color(0xFFB5D3DB),
          hoverColor: const Color(0xFFB5D3DB).withOpacity(0.4),
        ),
        items: [
          SideMenuItem(
            // // priority: 0,
            // onTap: (index, _) {
            //   viewModel.sideMenuController.changePage(index);
            // },
            builder: (context, displayMode) => InkWell(
              onTap: (){
                viewModel.sideMenuController.changePage(0);
                print(displayMode.name);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      (viewModel.sideMenuController.currentPage == 0)
                          ? KhadamatIcons.receiptFilled
                          : KhadamatIcons.receipt,
                      color: const Color(0xFF43617D),
                      size: 24,
                    ),
                    if(displayMode.name == "open")
                      Row(
                        children: [
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
                                  0)
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                  ],
                ),
              ),
            ),
          ),
          SideMenuItem(
            // priority: 1,
            // onTap: (index, _) {
            //   viewModel.sideMenuController.changePage(index);
            // },
            builder: (context, displayMode) => InkWell(
              onTap: (){
                viewModel.sideMenuController.changePage(1);

              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (viewModel.sideMenuController.currentPage == 1)
                        ? const Icon(
                      KhadamatIcons.peopleFilled,
                      color: Color(0xFF43617D),
                      size: 24,
                    )
                        : Image.asset(
                      "assets/images/users.png",
                      width: 24,
                      height: 24,
                    ),
                    if(displayMode.name == "open")
                      Row(
                        children: [
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
                                  1)
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          SideMenuItem(
            // priority: 2,
            // onTap: (index, _) {
            //   viewModel.sideMenuController.changePage(index);
            // },
            builder: (context, displayMode) => InkWell(
              onTap: (){
                viewModel.sideMenuController.changePage(2);

              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    (viewModel.sideMenuController.currentPage == 2)
                        ? const Icon(
                      KhadamatIcons.profileFilled,
                      color: Color(0xFF43617D),
                      size: 24,
                    )
                        : Image.asset(
                      "assets/images/admins.png",
                      width: 24,
                      height: 24,
                    ),
                    if(displayMode.name == "open")

                      Row(
                        children: [
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
                                  2)
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),

                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
  }
}
