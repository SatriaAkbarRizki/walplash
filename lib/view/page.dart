import 'package:flutter/material.dart';
import 'package:pinterest_nav_bar/pinterest_nav_bar.dart';
import 'package:walplash/view/page/home.dart';
import 'package:walplash/view/page/search.dart';

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int selectPage = 0;
  final List<Widget> _pages = [HomeView(), SearchImage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff0f393646),
      body: _pages[selectPage],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: PinterestNavBar(
        selectedItemColor: Color(0xff27E1C1),
        backgroundColor: Colors.black,
        currentIndex: selectPage,
        onTap: (i) {
          setState(() {
            selectPage = i;
          });
        },
        items: [Icons.home, Icons.search],
      ),
    );
  }
}
