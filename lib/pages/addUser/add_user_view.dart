import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/pmvvm.dart';
import 'package:khadamat_dashboard/pages/addUser/add_user_view_model.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({
    super.key,
    required this.onBackPressed,
    this.user,
  });
  final void Function() onBackPressed;
  final Map<String, dynamic>? user;
  @override
  Widget build(BuildContext context) {
    return MVVM<AddUserViewModel>(
      view: () => const _AddUserView(),
      viewModel: AddUserViewModel(
        onBackPressed: onBackPressed,
        user: user,
      ),
    );
  }
}

class _AddUserView extends StatelessView<AddUserViewModel> {
  const _AddUserView();

  @override
  Widget render(BuildContext context, AddUserViewModel viewModel) {
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
            padding: const EdgeInsets.all(50),
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "بيانات العميل",
                    style: TextStyle(
                      color: Color(0xFF43617D),
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "اسم العميل",
                            style: TextStyle(
                              color: Color(0xFF43617D),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: ShakeWidget(
                              key: viewModel.nameShakeKey,
                              shakeOffset: 10,
                              child: TextFormField(
                                initialValue: viewModel.user?["name"],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value?.isNotEmpty ?? false) {
                                    return null;
                                  } else {
                                    return "يجب ادخال الاسم";
                                  }
                                },
                                onChanged: (value) {
                                  viewModel.name = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF3F7F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 45),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "رقم الجوال",
                            style: TextStyle(
                              color: Color(0xFF43617D),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: ShakeWidget(
                                key: viewModel.mobileShakeKey,
                                shakeOffset: 10,
                                child: IntlPhoneField(
                                  initialValue: viewModel.user?["phone"],
                                  flagsButtonMargin:
                                      const EdgeInsets.only(left: 20),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(
                                      9,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                    ),
                                  ],
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  showDropdownIcon: false,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(20),
                                    hintText: "555555555",
                                    fillColor: const Color(0xFFF3F7F8),
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF7A9CBC),
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF7A9CBC),
                                      ),
                                    ),
                                  ),
                                  initialCountryCode: 'SA',
                                  onChanged: (phone) {
                                    viewModel.phoneNumber =
                                        phone.completeNumber;
                                  },
                                  disableLengthCheck: true,
                                  validator: (phone) {
                                    if (RegExp(
                                            r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$')
                                        .hasMatch(
                                            phone?.completeNumber ?? "")) {
                                      return null;
                                    } else {
                                      return "برجاء ادخال رقم هاتف صحيح";
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "المشروع",
                            style: TextStyle(
                              color: Color(0xFF43617D),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: ShakeWidget(
                              key: viewModel.projectShakeKey,
                              shakeOffset: 10,
                              child: TextFormField(
                                initialValue: viewModel.user?["project"],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value?.isNotEmpty ?? false) {
                                    return null;
                                  } else {
                                    return "يجب ادخال اسم المشروع";
                                  }
                                },
                                onChanged: (value) {
                                  viewModel.project = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF3F7F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 45,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "رقم العمارة",
                            style: TextStyle(
                              color: Color(0xFF43617D),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: ShakeWidget(
                              key: viewModel.buildingShakeKey,
                              shakeOffset: 10,
                              child: TextFormField(
                                initialValue: viewModel.user?["building"],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value?.isNotEmpty ?? false) {
                                    return null;
                                  } else {
                                    return "يجب ادخال رقم العمارة";
                                  }
                                },
                                onChanged: (value) {
                                  viewModel.building = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF3F7F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 45,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "رقم الشقة",
                            style: TextStyle(
                              color: Color(0xFF43617D),
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.18,
                            child: ShakeWidget(
                              key: viewModel.appartmentShakeKey,
                              shakeOffset: 10,
                              child: TextFormField(
                                initialValue: viewModel.user?["appartment"],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value?.isNotEmpty ?? false) {
                                    return null;
                                  } else {
                                    return "يجب ادخال رقم الشقة";
                                  }
                                },
                                onChanged: (value) {
                                  viewModel.appartment = value;
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: const Color(0xFFF3F7F8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(28),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7A9CBC),
                                      width: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  InkWell(
                    onTap: viewModel.submit,
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
                              "حفظ",
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
          Positioned(
            top: 20,
            right: 20,
            child: InkWell(
              onTap: viewModel.onBackPressed,
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
}
