// Place fonts/khadamat_icons.ttf in your fonts/ directory and
// add the following to your pubspec.yaml
// flutter:
//   fonts:
//    - family: khadamat_icons
//      fonts:
//       - asset: fonts/khadamat_icons.ttf
import 'package:flutter/widgets.dart';

class KhadamatIcons {
  KhadamatIcons._();

  static const String _fontFamily = 'khadamat_icons';

  static const IconData homeFilled = IconData(0xe900, fontFamily: _fontFamily);
  static const IconData peopleFilled = IconData(0xe901, fontFamily: _fontFamily);
  static const IconData home = IconData(0xe902, fontFamily: _fontFamily);
  static const IconData receiptFilled = IconData(0xe903, fontFamily: _fontFamily);
  static const IconData profile = IconData(0xe904, fontFamily: _fontFamily);
  static const IconData people = IconData(0xe905, fontFamily: _fontFamily);
  static const IconData receipt = IconData(0xe906, fontFamily: _fontFamily);
  static const IconData profileFilled = IconData(0xe907, fontFamily: _fontFamily);
}
