import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:khadamat_dashboard/pages/notRegisteredScreen/not_registered_view_model.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/pmvvm.dart';

class NotRegisteredScreen extends StatelessWidget {
  const NotRegisteredScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<NotRegisteredViewModel>(
      view: () => const _NotRegisteredView(),
      viewModel: NotRegisteredViewModel(),
    );
  }
}

class _NotRegisteredView extends StatelessView<NotRegisteredViewModel> {
  const _NotRegisteredView();

  @override
  Widget render(BuildContext context, NotRegisteredViewModel viewModel) {
    return Scaffold(
      backgroundColor: const Color(0XFFF5F5F5),
      body: Stack(
        children: [
          Positioned(
            right: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 2,
              child: Image.asset(
                'assets/images/intro.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/not_registered.png',
                    height: 136,
                    width: 106,
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  const Text(
                    "عفواً",
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFDE0F0F),
                    ),
                  ),
                  const SizedBox(
                    height: 64,
                  ),
                  const Text(
                    "رقم الجوال الخاص بك غير مسجل في خدمات المجالات",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF283143),
                    ),
                  ),
                  const SizedBox(
                    height: 92,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width / 4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: const Color(0xFF43617D)),
                      child: const Text(
                        "تسجيل الدخول",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 9,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'بإستخدامك خدمات المجالات أنت توافق على ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'الشروط والأحكام',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF31AFAB),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(
                            text: ' و ',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: 'سياسة الخصوصية',
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF31AFAB),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
