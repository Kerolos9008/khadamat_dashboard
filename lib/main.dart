import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:khadamat_dashboard/firebase_options.dart';
import 'package:khadamat_dashboard/pages/homeScreen/home_view.dart';
import 'package:khadamat_dashboard/pages/mobileScreen/mobile_view.dart';
import 'package:khadamat_dashboard/services/custom_scroll_behaviour.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_admin/firebase_admin.dart';
import 'package:firebase_admin/src/credential.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);
  // initializeAdminSdk();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(const MyApp()));
}

// String serviceAccountJson = '''{
//   "type": "service_account",
//   "project_id": "khadamat-f5821",
//   "private_key_id": "d26f4b04d66be2839fde88ac27a8f88cd911e18f",
//   "private_key": "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4kqoK9/ATLuXzggheQT9vHBgq0oqdjuQJ0ANlft6PUwn5kv3HWZqijmcDUQeae37MPOWXDcBPBYYhU66vOdUeH5VuBHHprRZdvptC298iflVnltdYFHCDKQRoEJ5PwiOaCuFIbe1mzL0wFwNa3FzoITPlfFm9XIyDLyRWFuGw5YW8y4Ts7BYV91Bcdhw5dxOu/hSc+Q0fqPm6+n7eJGq7/cJfFY9bIoHwHlMdWQfQo12V7qUgeK0srlS0nsvZZBbGs5VmE0kHwu7HdCo8drJL3nfVDJggnXV6Gc1WNqYIVWomhznjKLMM3ae2qTwSFqLTKHck25aRpN2IMwRSUnjrAgMBAAECggEAQ5vFmbr0P7KgHLB27D+uQr7hw13X1JrwwP9nHxh34bwjHT5Qo2MZF45eAYL+7AFskteDqe8pkEiPt0l15U2j2SLsk54hM91pIfGd4cG0XGg2VHmWa/cgt4qgyJW9x61vaQ+vMd7CZTN94U2stu2dQpJW9iq0nH54Id10y+wZw7fP5BOTEuYoRuZLhIM0yk6EQZmgQki/l5P+PPU3UCc/uSGOwYryBRmtAAVGDcbCRSknfpml/rKW+9pDXAb1CdupBagVxb9A3ueMEFtPwRih8I+/FfHYw0r2y6dXx4WxZtMydM5Yi+0rrFnXSHGyR2P5ukzMw+P8jjHKmi33d2syIQKBgQDl3UFIn5FahdXu9u5rI0nnGg68F2lbdZAJH678vzDlmGxh8pZ7FLSPpo9eIJVM95MRHMPh3yVI7WQVCUSwOSKtX0p5AeSug8q4ZJ/iLoKAbJJVW33W6L9HB0vW72TBddrEjwA1a6BvedtqaDRCalLaEH03/nzaK8LvBargVByz4wKBgQDNjxixwBt2FiDM1qVjRBTrD5fx9NGZTewWy4CG3Mkp+qAzaPWKIhb9uO4qFTgYTt1GcKqTOIhJ1qQ9bUNGjPI7mUN+kN/li7UKTVZWo3WEStCxJCEJNZwrmvE+vKu0tOVmshJ895wlW4owJODSvdCycso5k272N1zLNl0KXQGFWQKBgQDF0hlJ99Fu9zk605Yx7AfA9MLziq5oQI+52mONLrlVDk1QKibpO9N8wRonJqF2wKX3lyrY62K6FVsJY5WSl0lJrXV5GHEG43MGJ8sVK3OyND3nabqtxlY/OX9CNXofqF6ixHKohrxm05dKRu2arsgo1QH+u2wVko3LiLQbJSgigwKBgAWiGkckwJvn11ZFu5qQzxHyB3P2BZhx7jphsVAA1PJ1j9ZY1gHHFWI2ozA8DKF958p6Y/JM5k8/tpiIWgOg8TJ47MSXK8uanId/vxH4wMuzUSzJlK4v7euz/1B80yfMnUzHLIKINps/evX+zLp5wTJiuvAA/lV5Bu36u2oBSn1hAoGAXB6uIf8lmNiJVC5oY2dv27cmctLJxQYNThc9ZLA2FoPGm0twyjG0jEsiWcPy0Qq7hjWcKtFoE+toUBzS0rUnbc05gyUqYi83JGW/Y01ShhrumpiJ0qqAGaaMXmx5/sO3AVIrXzxz/Te0+SwB1g1JIFNRj82qkQzdq5MppzPVeIY=",
//   "client_email": "firebase-adminsdk-l0mf6@khadamat-f5821.iam.gserviceaccount.com",
//   "client_id": "103636840626969016204",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-l0mf6%40khadamat-f5821.iam.gserviceaccount.com",
//   "universe_domain": "googleapis.com"
// }''';
//
// void initializeAdminSdk() async {
//   // var credential = Credentials.cert("assets/images/service-account.json");
//   print("this is step 1");
//   Map<String, dynamic> serviceAccount = jsonDecode(serviceAccountJson);
//   print("this is step 44");
//
//   var credential = Credentials.cert(serviceAccount);
//   print("this is step 2");
//   // credential ??= await Credentials.login();
//   print("this is step 3");
//   var projectId = 'khadamat-f5821';
//   // create an app
//   print("this is cred");
//
//   print(credential);
//   // FirebaseAdmin.instance.initializeApp(
//   //   AppOptions(
//   //     credential: Credential.,
//   //     projectId: 'YOUR_FIREBASE_PROJECT_ID',
//   //   ),
//   // );
//
//   // FirebaseAdmin.instance.initializeApp(AppOptions(
//   //     credential: credential,
//   //     projectId: projectId,
//   //     storageBucket: '$projectId.appspot.com'));
//   // String? accessToken = await FirebaseAdmin.instance.app()?.auth().createCustomToken('uid');
//   print("this is access token");
//   // print(accessToken);
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      // builder: FToastBuilder(),

      builder: (context, child) {
        return ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(start: 0, end: 799, name: MOBILE),
            const Breakpoint(start: 800, end: 1099, name: TABLET),
            const Breakpoint(start: 1100, end: 1920, name: DESKTOP),
          ],
        );
      },
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'SA'),
      ],
      locale: const Locale('ar', 'SA'),
      title: 'لوحة تحكم خدمات',
      theme: ThemeData(
        useMaterial3: false,
        primarySwatch: Colors.blue,
      ),

      home: (FirebaseAuth.instance.currentUser != null)
          ? const HomeScreen()
          : const MobileScreen(),
    );
  }
}
