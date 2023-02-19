import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quik_shop/body_widgets/main_page.dart';
import 'package:quik_shop/constants.dart';

void main() async {
  ErrorWidget.builder = (details) => const Material();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    KwikShop(),
  );
}

class KwikShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
              .copyWith(secondary: accentColor)),
      home: MainPage(),
    );
  }
}