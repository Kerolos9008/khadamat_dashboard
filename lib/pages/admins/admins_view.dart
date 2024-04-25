import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/addAdmin/add_admin_view.dart';
import 'package:khadamat_dashboard/pages/admins/admins_datasource.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:khadamat_dashboard/pages/admins/admins_view_model.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AdminsScreen extends StatelessWidget {
  final String searchValue;
  const AdminsScreen(this.searchValue, {super.key});
  @override
  Widget build(BuildContext context) {
    return MVVM<AdminsViewModel>(
      view: () => _AdminsView(searchValue),
      viewModel: AdminsViewModel(),
    );
  }
}

class _AdminsView extends StatelessView<AdminsViewModel> {
  final String searchValue;
  const _AdminsView(this.searchValue);

  @override
  Widget render(BuildContext context, AdminsViewModel viewModel) {
    var isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

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
                  "الإداريين",
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
                width:  isDesktop ? MediaQuery.of(context).size.width * 0.65  : MediaQuery.of(context).size.width * 0.9,
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
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
                    final filteredData = snapshot.data!.docs
                        .where((element) => element['phone']
                            .toString()
                            .toLowerCase()
                            .contains(searchValue.toLowerCase()))
                        .toList();
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
                                "الصلاحيات",
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
                                "حذف",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A9CBC),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                        source: AdminsDataSource(
                          filteredData,
                          context,
                          modify: viewModel.modifyAdmin,
                          delete: viewModel.deleteAdmin,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        AddAdminScreen(
          onBackPressed: () {
            viewModel.pageController.jumpToPage(0);
          },
        ),
        AddAdminScreen(
          onBackPressed: () {
            viewModel.pageController.jumpToPage(0);
          },
          admin: viewModel.toModify,
        )
      ],
    );
  }
}
