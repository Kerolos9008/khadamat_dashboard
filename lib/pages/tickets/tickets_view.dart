import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/ticketDetailsScreen/ticket_details_view.dart';
import 'package:khadamat_dashboard/pages/tickets/tickets_datasource.dart';
import 'package:khadamat_dashboard/pages/tickets/tickets_view_model.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:responsive_framework/responsive_framework.dart';

class TicketsScreen extends StatelessWidget {
  final String searchValue;
  const TicketsScreen(
    this.searchValue, {
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return MVVM<TicketsViewModel>(
      view: () => _TicketsView(searchValue),
      viewModel: TicketsViewModel(),
      disposeVM: false,
    );
  }
}

class _TicketsView extends StatelessView<TicketsViewModel> {
  final String searchValue;
  const _TicketsView(this.searchValue);

  @override
  Widget render(BuildContext context, TicketsViewModel viewModel) {
    var isDesktop = ResponsiveBreakpoints.of(context).isDesktop;

    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: viewModel.pageController,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "التذاكر",
              style: TextStyle(
                color: Color(0xFF43617D),
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 25),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
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
                          .where((element) => element.id
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
                                  "التاريخ",
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
                                  "الرقم",
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
                                  "القسم",
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
                                  "الأهمية",
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
                                  "مقدم الطلب",
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
                                  "الحالة",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF7A9CBC),
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          source: TicketsDataSource(
                            filteredData,
                            context,
                            open: viewModel.enterTicket,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        TicketDetailsScreen(
          onBackPressed: () {
            viewModel.pageController.jumpToPage(0);
          },
        ),
      ],
    );
  }
}
