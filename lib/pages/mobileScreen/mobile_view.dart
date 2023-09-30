import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/pmvvm.dart';

import 'mobile_view_model.dart';

class MobileScreen extends StatelessWidget {
  const MobileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MVVM<MobileViewModel>(
      view: () => const _MobileView(),
      viewModel: MobileViewModel(),
    );
  }
}

class _MobileView extends StatelessView<MobileViewModel> {
  const _MobileView();

  @override
  Widget render(BuildContext context, MobileViewModel viewModel) {
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
                    'assets/images/mobile.png',
                    height: 92,
                    width: 72,
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  const Text(
                    "فضلاً أدخل رقم الجوال",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF283143),
                    ),
                  ),
                  const SizedBox(
                    height: 88,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 4,
                    child: ShakeWidget(
                      key: viewModel.shakeKey,
                      shakeOffset: 10,
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: IntlPhoneField(
                          flagsButtonMargin: const EdgeInsets.only(left: 20),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9,
                                maxLengthEnforcement:
                                    MaxLengthEnforcement.enforced),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          showDropdownIcon: false,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            hintText: "555555555",
                            fillColor: const Color(0xDAD2C766).withOpacity(0.4),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(
                                color: const Color(0xDAD2C766).withOpacity(0.4),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(17),
                              borderSide: BorderSide(
                                color: const Color(0xDAD2C766).withOpacity(0.4),
                              ),
                            ),
                          ),
                          initialCountryCode: 'SA',
                          onChanged: (phone) {
                            viewModel.phoneNumber = phone.completeNumber;
                          },
                          disableLengthCheck: true,
                          validator: (phone) {
                            if (RegExp(
                                    r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
                                .hasMatch(phone?.completeNumber ?? "")) {
                              return null;
                            } else {
                              return "برجاء ادخال رقم هاتف صحيح";
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                  InkWell(
                    onTap: viewModel.submitMobile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width / 4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          color: const Color(0xFF43617D)),
                      child: viewModel.buttonLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
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
