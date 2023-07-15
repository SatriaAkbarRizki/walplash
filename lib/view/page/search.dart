import 'package:flutter/material.dart';

class SearchImage extends StatefulWidget {
  const SearchImage({super.key});

  @override
  State<SearchImage> createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  TextEditingController textSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Walplash',
          style: TextStyle(fontFamily: 'Lobster'),
        ),
      ),
      backgroundColor: Color(0xff0f393646),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
                style: TextStyle(color: Colors.white),
                controller: textSearch,
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Color(0xffD1D1D1)),
                    hintText: 'Search Image',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2, color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.white)))),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Image.asset('assets/images/searchphotos.png'),
                Text(
                  'Nothing image here',
                  style: TextStyle(color: Colors.white, fontFamily: 'Madurai', fontSize: 16),
                ),
                Text(
                  'Try searching fpr something ',
                  style: TextStyle(color: Colors.white70, fontFamily: 'Madurai',fontSize: 14),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
