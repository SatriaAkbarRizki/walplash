import 'package:flutter/material.dart';
import 'package:walplash/model/imagemodel.dart';
import 'package:walplash/presenter/presenter.dart';
import 'package:walplash/view/page/fullimage.dart';

class SearchImage extends StatefulWidget {
  const SearchImage({super.key});

  @override
  State<SearchImage> createState() => _SearchImageState();
}

class _SearchImageState extends State<SearchImage> {
  Presenter presenter = Presenter();
  TextEditingController textSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void search(String text) async {
    await presenter.searchImage(text);
    setState(() {});
  }

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
              onSubmitted: search,
              style: TextStyle(color: Colors.white),
              controller: textSearch,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Color(0xffD1D1D1)),
                hintText: 'Search Image',
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(width: 2, color: Colors.white),
                ),
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Container(

              padding: EdgeInsets.all(10),
              child: FutureBuilder<List<ImageModel>?>(
                future: textSearch.text.isNotEmpty
                    ? presenter.searchImage(textSearch.text)
                    : null,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return isnotsearch();
                  } else {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return imageUn(snapshot, context, index);
                        },
                      );
                    } else {
                      return isnotsearch();
                    }
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget isnotsearch() {
    return Column(
      children: [
        Image.asset('assets/images/searchphotos.png'),
        Text(
          'Nothing image here',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Madurai', fontSize: 16),
        ),
        Text(
          'Try searching fpr something ',
          style: TextStyle(
              color: Colors.white70, fontFamily: 'Madurai', fontSize: 14),
        ),
      ],
    );
  }

  Widget imageUn(AsyncSnapshot<List<ImageModel>?> snapshot,
      BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(5.0), // Atur jarak sesuai kebutuhan
      child: InkWell(
        onTap: () {
          print('index of image: $index');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullImage(
                  list: [snapshot.data![index]],
                ),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(snapshot.data![index].urls.small),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

// Column(
//               children: [
//                 Image.asset('assets/images/searchphotos.png'),
//                 Text(
//                   'Nothing image here',
//                   style: TextStyle(
//                       color: Colors.white, fontFamily: 'Madurai', fontSize: 16),
//                 ),
//                 Text(
//                   'Try searching fpr something ',
//                   style: TextStyle(
//                       color: Colors.white70,
//                       fontFamily: 'Madurai',
//                       fontSize: 14),
//                 ),
//               ],
//             )