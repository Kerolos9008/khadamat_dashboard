import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/addAdmin/add_admin_view.dart';
import 'package:khadamat_dashboard/pages/addUser/add_user_view.dart';
import 'package:khadamat_dashboard/pages/admins/admins_datasource.dart';
import 'package:khadamat_dashboard/pages/users/users_datasource.dart';
import 'package:khadamat_dashboard/pages/users/users_view_model.dart';
import 'package:pmvvm/pmvvm.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<UsersViewModel>(
      view: () => const _UsersView(),
      viewModel: UsersViewModel(),
    );
  }
}

class _UsersView extends StatelessView<UsersViewModel> {
  const _UsersView();

  @override
  Widget render(BuildContext context, UsersViewModel viewModel) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: viewModel.pageController,
      children: [
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "العملاء",
                  style: TextStyle(
                    color: Color(0xFF43617D),
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                InkWell(
                  onTap: () {
                    viewModel.pageController.jumpToPage(1);
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    decoration: BoxDecoration(
                      color: const Color(0xFF43617D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "إضافة",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: viewModel.collectionStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF43617D),
                        ),
                      );
                    }

                    return Theme(
                      data: Theme.of(context).copyWith(
                        shadowColor: Colors.transparent,
                        dividerColor: Colors.transparent,
                      ),
                      child: PaginatedDataTable(
                        columnSpacing: 0,
                        horizontalMargin: 0,
                        dataRowHeight: 80,
                        headingRowHeight: 90,
                        rowsPerPage:
                            (MediaQuery.of(context).size.height - 400 - 90) ~/
                                80,
                        columns: const [
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "الإسم",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "رقم الجوال",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "المشروع",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "العمارة",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "الشقة",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "عدد التذاكر",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                "تعديل",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                        source: UsersDataSource(
                          snapshot.data!.docs,
                          context,
                          modify: viewModel.modifyUser,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        AddUserScreen(
          onBackPressed: () {
            viewModel.pageController.jumpToPage(0);
          },
        ),
        AddUserScreen(
          onBackPressed: () {
            viewModel.pageController.jumpToPage(0);
          },
          user: viewModel.toModify,
        )
      ],
    );
  }
}
