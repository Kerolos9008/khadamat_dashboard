import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pmvvm/pmvvm.dart';

import 'otp_view_model.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen(
      {super.key, required this.phone, required this.firebaseAuthPhone});
  final String phone;
  final ConfirmationResult firebaseAuthPhone;

  @override
  Widget build(BuildContext context) {
    return MVVM<OTPViewModel>(
      view: () => const _OTPView(),
      viewModel: OTPViewModel(phone, firebaseAuthPhone),
    );
  }
}

class _OTPView extends StatelessView<OTPViewModel> {
  const _OTPView();

  @override
  Widget render(BuildContext context, OTPViewModel viewModel) {
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
                    'assets/images/otp.png',
                    height: 92,
                    width: 72,
                  ),
                  const SizedBox(
                    height: 52,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "فضلاً أدخل رمز التحقق المرسل على ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF283143),
                        ),
                      ),
                      Text(
                        viewModel.phoneNumber.replaceRange(0, 11, '*******'),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF283143),
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Pinput(
                      onCompleted: (value) {
                        viewModel.otp = value;
                      },
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 64,
                        height: 56,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        textStyle: const TextStyle(
                          color: Color(0xFFA3A3A3),
                          fontSize: 22,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xDAD2C766).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    viewModel.resendTimerText,
                    style: const TextStyle(
                      color: Color(0xFF31AFAB),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GestureDetector(
                    onTap: viewModel.resendOTP,
                    child: Text(
                      "إعادة إرسال رمز التحقق",
                      style: TextStyle(
                        color: (viewModel.allowResend)
                            ? const Color(0xFF31AFAB)
                            : const Color(0xFF31AFAB).withOpacity(0.4),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: viewModel.verifyOTP,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      width: MediaQuery.of(context).size.width / 4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: const Color(0xFF43617D),
                      ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
