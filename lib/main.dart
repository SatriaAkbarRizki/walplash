import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinterest_nav_bar/pinterest_nav_bar.dart';
import 'package:walplash/view/page.dart';
import 'package:walplash/view/page/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    return PinterestNavBarController(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Pages(),
    ));
  }
}
