import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:khadamat_dashboard/pages/addAdmin/add_admin_view_model.dart';
import 'package:khadamat_dashboard/widgets/shake_widget.dart';
import 'package:pmvvm/pmvvm.dart';

class AddAdminScreen extends StatelessWidget {
  const AddAdminScreen({
    super.key,
    required this.onBackPressed,
    this.admin,
  });
  final void Function() onBackPressed;
  final Map<String, dynamic>? admin;
  @override
  Widget build(BuildContext context) {
    return MVVM<AddAdminViewModel>(
      view: () => const _AddAdminView(),
      viewModel: AddAdminViewModel(
        onBackPressed: onBackPressed,
        admin: admin,
      ),
    );
  }
}

class _AddAdminView extends StatelessView<AddAdminViewModel> {
  const _AddAdminView();

  @override
  Widget render(BuildContext context, AddAdminViewModel viewModel) {
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
                    "بيانات الإداري",
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
                                enabled: viewModel.admin == null,
                                initialValue: viewModel.admin?["name"],
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
                      const SizedBox(width: 52),
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
                                  enabled: viewModel.admin == null,
                                  initialValue: viewModel.admin?["phone"],
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
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "صلاحيات الإداري",
                        style: TextStyle(
                          color: Color(0xFF43617D),
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  ShakeWidget(
                    key: viewModel.checkboxShakeKey,
                    shakeOffset: 10,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: viewModel.checkRole()
                            ? null
                            : Border.all(
                                color: Colors.red,
                              ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: CheckboxListTile(
                                checkColor: const Color(0xFF43617D),
                                activeColor: Colors.white,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                value: viewModel.openTicket,
                                onChanged: viewModel.toggleOpenTicket,
                                title: const Text(
                                  "فتح تذكرة",
                                  style: TextStyle(
                                    color: Color(0xFF43617D),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 170,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: CheckboxListTile(
                                checkColor: const Color(0xFF43617D),
                                activeColor: Colors.white,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                value: viewModel.closeTicket,
                                onChanged: viewModel.toggleCloseTicket,
                                title: const Text(
                                  "إغلاق تذكرة",
                                  style: TextStyle(
                                    color: Color(0xFF43617D),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 290,
                            child: Directionality(
                              textDirection: TextDirection.ltr,
                              child: CheckboxListTile(
                                checkColor: const Color(0xFF43617D),
                                activeColor: Colors.white,
                                checkboxShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                value: viewModel.addAdmins,
                                onChanged: viewModel.toggleAddAdmins,
                                title: const Text(
                                  "تعديل بيانات عميل / اداري",
                                  style: TextStyle(
                                    color: Color(0xFF43617D),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
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
