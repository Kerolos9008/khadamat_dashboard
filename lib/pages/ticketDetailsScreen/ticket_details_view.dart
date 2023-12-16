import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:khadamat_dashboard/pages/tickets/tickets_view_model.dart';
import 'package:khadamat_dashboard/widgets/message_widget.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:khadamat_dashboard/widgets/ticket_description_widget.dart';
import 'package:khadamat_dashboard/widgets/ticket_details_widget.dart';
import 'package:pmvvm/pmvvm.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({
    super.key,
    required this.onBackPressed,
  });
  final void Function() onBackPressed;
  @override
  Widget build(BuildContext context) {
    return MVVM<TicketsViewModel>(
      view: () => _TicketDetailsView(
        onBackPressed,
      ),
      viewModel: context.fetch<TicketsViewModel>(listen: true),
      disposeVM: false,
    );
  }
}

class _TicketDetailsView extends StatelessView<TicketsViewModel> {
  const _TicketDetailsView(this.onBackPressed);
  final void Function() onBackPressed;

  @override
  Widget render(BuildContext context, TicketsViewModel viewModel) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
            ),
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "طلب رقم  #${viewModel.ticket?["id"]}",
                    style: const TextStyle(
                      color: Color(0xFF43617D),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: TicketDetailsWidget(viewModel.ticket!),
                    ),
                    Flexible(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "الصلاحيات",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          if (viewModel.userCanCloseTicket &&
                              viewModel.ticket?["status"] == 0)
                            InkWell(
                              onTap: viewModel.closeTicket,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDE0F0F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "إغلاق التذكرة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          if (viewModel.userCanOpenTicket &&
                              viewModel.ticket?["status"] != 0)
                            InkWell(
                              onTap: viewModel.openTicket,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF669B2D),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Text(
                                  "فتح التذكرة",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                TicketDescriptionWidget(viewModel.ticket!),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.ticket?["messages"].length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageWidget(
                        viewModel.ticket!["messages"][index],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    _showDialog(context, viewModel);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF43617D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: MediaQuery.of(context).size.width / 5,
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.add_circle_rounded,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "إضافة رد",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: InkWell(
              onTap: onBackPressed,
              child: CircleAvatar(
                backgroundColor: const Color(0xFF43617D),
                radius: 30,
                child: Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _showDialog(BuildContext context, TicketsViewModel viewModel) {
    showGeneralDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.black38,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, anim1, anim2) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          buttonPadding: const EdgeInsets.all(8),
          actionsPadding: const EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: 16,
          ),
          title: const Text(
            'إضافة رد',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
            color: Color(0xFF1177B8),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShakeWidget(
                  key: viewModel.caseDescriptionShakeKey,
                  shakeOffset: 10,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      textDirection: TextDirection.rtl,
                      maxLines: 6,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value?.isNotEmpty ?? false) {
                          return null;
                        } else {
                          return "يجب ادخال وصف الحالة";
                        }
                      },
                      onChanged: (value) {
                        viewModel.caseDescription = value;
                      },
                      decoration: InputDecoration(
                        hintText: "كتابة وصف واضح عن الحالة...",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1177B8),
                            width: 1,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF1177B8),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "إرفاق صورة / مقطع",
                      style: TextStyle(
                        color: Color(0xFF414042),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    viewModel.image == null
                        ? GestureDetector(
                            onTap: () {
                              viewModel.pickImage(setState);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              width: MediaQuery.of(context).size.width / 5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFE7F2F9),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Text(
                                    "إرفاق ",
                                    style: TextStyle(
                                      color: Color(0xFF1177B8),
                                    ),
                                  ),
                                  Icon(
                                    Icons.add_circle_outlined,
                                    color: Color(0xFF1177B8),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              viewModel.pickImage(setState);
                            },
                            child: Container(
                              height: 72,
                              width: 92,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: const Color(0xFF1177B8),
                                  width: 1,
                                ),
                                image: DecorationImage(
                                  image: MemoryImage(viewModel.image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 2.5 / 10,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1177B8),
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'إرسال',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                viewModel.submitMessage();
              },
            ),
            InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width * 2.5 / 10,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFF1177B8),
                    )),
                alignment: Alignment.center,
                child: const Text(
                  'إلغاء',
                  style: TextStyle(
                    color: Color(0xFF1177B8),
                    fontSize: 20,
                  ),
                ),
              ),
              onTap: () {
                viewModel.image = null;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
        child: FadeTransition(
          opacity: anim1,
          child: child,
        ),
      ),
      context: context,
    );
  }
}
